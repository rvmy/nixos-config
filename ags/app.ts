import app from "ags/gtk4/app"
import style from "./style.scss"
import WallPicker from "./widget/wall-picker"

import GLib from "gi://GLib"
// Read Stylix palette
const stylixPath = `${GLib.get_home_dir()}/.config/stylix/palette.json`
const [success, contents] = GLib.file_get_contents(stylixPath)
const data = JSON.parse(new TextDecoder().decode(contents))

// Handle different possible structures
const colors = data.colors || data.palette || data

const css = `
  * {
    --bg: #${colors.base00};
    --fg: #${colors.base05};
    --primary: #${colors.base0D};
    --secondary: #${colors.base0E};
    --error: #${colors.base08};
    --warning: #${colors.base0A};
    --success: #${colors.base0B};

    --base00: #${colors.base00};
    --base01: #${colors.base01};
    --base02: #${colors.base02};
    --base03: #${colors.base03};
    --base04: #${colors.base04};
    --base05: #${colors.base05};
    --base06: #${colors.base06};
    --base07: #${colors.base07};
    --base08: #${colors.base08};
    --base09: #${colors.base09};
    --base0A: #${colors.base0A};
    --base0B: #${colors.base0B};
    --base0C: #${colors.base0C};
    --base0D: #${colors.base0D};
    --base0E: #${colors.base0E};
    --base0F: #${colors.base0F};
  }
`
// Apply the CSS
app.apply_css(css)
app.start({
  css: style,
  main() {
    WallPicker()
  },
})
