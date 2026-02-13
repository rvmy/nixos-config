import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import GLib from "gi://GLib"
import Gio from "gi://Gio"
import GdkPixbuf from "gi://GdkPixbuf"
import Pango from "gi://Pango"
import { execAsync } from "ags/process"
import { createState, createComputed } from "ags"
import { With } from "ags"

const WALL_DIR = `${GLib.get_home_dir()}/pictures/wallpapers`
const THUMB_SIZE = 20
const PREVIEW_SIZE = 300

const stylixColors = (() => {
  try {
    const configPath = `${GLib.get_home_dir()}/.config/stylix/palette.json`
    const file = Gio.File.new_for_path(configPath)
    const [success, contents] = file.load_contents(null)
    if (success) {
      return JSON.parse(new TextDecoder().decode(contents))
    }
  } catch (e) {
    print("Failed to load stylix colors:", e)
  }

  return {
    base00: "#1e1e2e",
    base01: "#313244",
    base02: "#45475a",
    base03: "#585b70",
    base04: "#cdd6f4",
    base05: "#cdd6f4",
    base06: "#f5e0dc",
    base07: "#b4befe",
    base08: "#f38ba8",
    base09: "#fab387",
    base0A: "#f9e2af",
    base0B: "#a6e3a1",
    base0C: "#94e2d5",
    base0D: "#89b4fa",
    base0E: "#cba6f7",
    base0F: "#f2cdcd",
  }
})()

const textureCache = new Map<string, Gdk.Texture | null>()

function generateThumbnail(
  path: string,
  size = THUMB_SIZE,
): Gdk.Texture | null {
  const key = `${path}_${size}`
  if (textureCache.has(key)) return textureCache.get(key)!

  try {
    const pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(
      path,
      size,
      size,
      true,
    )
    const texture = Gdk.Texture.new_for_pixbuf(pixbuf)
    textureCache.set(key, texture)
    return texture
  } catch {
    textureCache.set(key, null)
    return null
  }
}

function getWallpapers(): string[] {
  const dir = Gio.File.new_for_path(WALL_DIR)
  try {
    const e = dir.enumerate_children(
      "standard::name",
      Gio.FileQueryInfoFlags.NONE,
      null,
    )

    const files: string[] = []
    let info
    while ((info = e.next_file(null))) {
      const name = info.get_name()
      if (/\.(jpg|jpeg|png|webp)$/i.test(name))
        files.push(`${WALL_DIR}/${name}`)
    }
    return files.sort()
  } catch {
    return []
  }
}

export default function WallPicker() {
  const [query, setQuery] = createState("")
  const [walls] = createState(getWallpapers())
  const [selectedWall, setSelectedWall] = createState<string | null>(null)

  const filtered = createComputed([query, walls], (q, list) => {
    const result = list.filter((w) => w.toLowerCase().includes(q.toLowerCase()))

    if (result.length > 0 && !selectedWall.get()) {
      setSelectedWall(result[0])
    }

    return result
  })

  return (
    <window
      name="wallpaper-switcher"
      application={app}
      focusable
      keymode={Astal.Keymode.EXCLUSIVE}
      exclusivity={Astal.Exclusivity.NORMAL}
      widthRequest={650}
      heightRequest={400}
      onRealize={(self) => {
        const controller = Gtk.EventControllerKey.new()
        controller.connect("key-pressed", (_ctrl: any, keyval: number) => {
          const currentWall = selectedWall.get()

          if (keyval === Gdk.KEY_Return || keyval === Gdk.KEY_space) {
            if (currentWall) {
              execAsync(["swww", "img", currentWall])
              self.hide()
            }
            return true
          } else if (keyval === Gdk.KEY_Escape) {
            self.hide()
            return true
          }
          return false
        })
        self.add_controller(controller)

        // Animation عند الفتح
        self.set_opacity(0)
        GLib.timeout_add(GLib.PRIORITY_DEFAULT, 10, () => {
          self.set_opacity(1)
          return GLib.SOURCE_REMOVE
        })
      }}
      css={`
        window {
          background: ${stylixColors.base00}dd;
          border-radius: 12px;
          border: 1px solid ${stylixColors.base02}33;
          transition: opacity 200ms cubic-bezier(0.16, 1, 0.3, 1);
        }

        entry {
          background-color: ${stylixColors.base01};
          border: 1px solid ${stylixColors.base02};
          border-radius: 6px;
          padding: 6px 10px;
          color: ${stylixColors.base05};
          font-size: 11px;
          min-height: 28px;
        }

        entry:focus {
          background-color: ${stylixColors.base02};
          border-color: ${stylixColors.base0D};
          box-shadow: 0 0 0 2px ${stylixColors.base0D}33;
        }

        entry placeholder {
          color: ${stylixColors.base04}99;
          font-size: 11px;
        }

        button {
          background: transparent;
          border: none;
          border-radius: 4px;
          padding: 5px 6px;
          transition: all 200ms ease;
        }

        button:focus {
          background: ${stylixColors.base0D}33;
          border-left: 2px solid ${stylixColors.base0D};
        }

        label {
          color: ${stylixColors.base05};
          font-weight: normal;
        }

        .wall-name {
          margin-left: 8px;
          font-size: 10px;
          font-weight: normal;
        }

        .preview-name {
          font-size: 9px;
          opacity: 0.7;
          font-weight: normal;
        }

        scrolledwindow {
          border: none;
        }
      `}
    >
      <box
        spacing={10}
        marginTop={10}
        marginBottom={10}
        marginStart={10}
        marginEnd={10}
      >
        <box
          orientation={Gtk.Orientation.VERTICAL}
          spacing={8}
          widthRequest={300}
        >
          <entry
            placeholderText="Search..."
            onNotifyText={({ text }) => setQuery(text)}
            onActivate={() => {
              const currentWall = selectedWall.get()
              if (currentWall) {
                execAsync(["swww", "img", currentWall])
              }
            }}
          />

          <scrolledwindow vexpand canFocus>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={2}>
              <With value={filtered}>
                {(wallpapers) => (
                  <box orientation={Gtk.Orientation.VERTICAL} spacing={1}>
                    {wallpapers.map((wall) => {
                      const texture = generateThumbnail(wall)

                      return (
                        <button
                          focusable
                          canFocus
                          onNotifyHasFocus={({ hasFocus }) => {
                            if (hasFocus) setSelectedWall(wall)
                          }}
                          onRealize={(self) => {
                            const btnController = Gtk.EventControllerKey.new()
                            btnController.connect(
                              "key-pressed",
                              (_: any, keyval: number) => {
                                if (
                                  keyval === Gdk.KEY_Return ||
                                  keyval === Gdk.KEY_space
                                ) {
                                  execAsync([
                                    "swww",
                                    "img",
                                    "--transition-type",
                                    "wipe",
                                    "--transition-angle",
                                    "30",
                                    "--transition-duration",
                                    "2",
                                    "--transition-fps",
                                    "60",
                                    wall,
                                  ])
                                  app.get_window("wallpaper-switcher")?.hide()
                                  return true
                                }
                                return false
                              },
                            )
                            self.add_controller(btnController)
                          }}
                        >
                          <box spacing={8}>
                            {texture ? (
                              <image
                                paintable={texture}
                                pixelSize={THUMB_SIZE}
                              />
                            ) : (
                              <box
                                widthRequest={THUMB_SIZE}
                                heightRequest={THUMB_SIZE}
                              />
                            )}
                            <label
                              cssName="wall-name"
                              label={wall.split("/").pop()!}
                              ellipsize={Pango.EllipsizeMode.END}
                              maxWidthChars={20}
                              halign={Gtk.Align.START}
                            />
                          </box>
                        </button>
                      )
                    })}
                  </box>
                )}
              </With>
            </box>
          </scrolledwindow>
        </box>

        <box
          hexpand
          vexpand
          halign={Gtk.Align.CENTER}
          valign={Gtk.Align.CENTER}
        >
          <With value={selectedWall}>
            {(wall) => {
              if (!wall) return

              const preview = generateThumbnail(wall, PREVIEW_SIZE)

              return (
                <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                  {preview && (
                    <image paintable={preview} pixelSize={PREVIEW_SIZE} />
                  )}
                  <label
                    cssName="preview-name"
                    label={wall.split("/").pop()!}
                  />
                </box>
              )
            }}
          </With>
        </box>
      </box>
    </window>
  )
}
