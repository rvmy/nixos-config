import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import GLib from "gi://GLib"
import Gio from "gi://Gio"
import { onCleanup } from "ags"
const wallpaperPath = `${GLib.get_home_dir()}/pictures/wallpapers`

function getWallpaperList(): string[] {
  try {
    const dir = Gio.File.new_for_path(wallpaperPath)
    const e = dir.enumerate_children(
      "standard::name,standard::type",
      Gio.FileQueryInfoFlags.NONE,
      null,
    )

    const files: string[] = []
    let info

    while ((info = e.next_file(null)) !== null) {
      if (info.get_file_type() !== Gio.FileType.REGULAR) continue

      const name = info.get_name()
      if (/\.(jpg|jpeg|png|webp)$/i.test(name)) {
        const path = dir.get_child(name).get_path()
        if (path) files.push(path)
      }
    }

    e.close(null)
    return files.sort()
  } catch (e) {
    logError(e)
    return []
  }
}

const onKey = (
  _e: Gtk.EventControllerKey,
  keyval: number,
  _: number,
  mod: number,
) => {
  if (keyval === Gdk.KEY_Escape) {
    app.toggle_window("wall-picker")
    return
  }
}
export default function WallPicker() {
  const { TOP, BOTTOM, LEFT } = Astal.WindowAnchor
  const { VERTICAL } = Gtk.Orientation
  const wallpaperList = getWallpaperList()
  return (
    <window
      visible
      name="wall-picker"
      cssClasses={["wall-picker"]}
      application={app}
      keymode={Astal.Keymode.ON_DEMAND}
      anchor={TOP | BOTTOM | LEFT}
      $={(self) => onCleanup(() => self.destroy())}
    >
      <Gtk.EventControllerKey onKeyPressed={onKey} />

      <scrolledwindow>
        <box orientation={VERTICAL} spacing={20}>
          {wallpaperList.map((wall) => (
            <box cssClasses={["wall-picker-bg"]}>
              <button
                cssClasses={["button"]}
                cursor={Gdk.Cursor.new_from_name("pointer", null)}
                onClicked={() =>
                  execAsync([
                    "swww",
                    "img",
                    wall,
                    "--transition-type",
                    "wipe",
                    "--transition-angle",
                    "30",
                    "--transition-duration",
                    "2",
                    "--transition-fps",
                    "60",
                  ])
                }
              >
                <Gtk.Picture
                  file={Gio.file_new_for_path(wall)}
                  heightRequest={200}
                  widthRequest={200}
                  hexpand
                  vexpand
                  cssClasses={["wallpaper-picture"]}
                  contentFit={Gtk.ContentFit.COVER}
                />
              </button>
            </box>
          ))}
        </box>
      </scrolledwindow>
    </window>
  )
}
