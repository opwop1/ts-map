Add-Type -AssemblyName System.Drawing
$w = 900; $h = 320
$bmp = New-Object System.Drawing.Bitmap($w, $h)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.TextRenderingHint = 'AntiAlias'

# map background (same as SimpleMapPalette: 72,78,102)
$bg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(72,78,102))
$g.FillRectangle($bg, 0, 0, $w, $h)

# fake white roads for context
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
$g.DrawLine($pen, 30, 250, 870, 250)
$g.DrawLine($pen, 160, 20, 160, 300)
$g.DrawLine($pen, 700, 20, 700, 300)
$g.DrawLine($pen, 30, 120, 870, 120)

$font = New-Object System.Drawing.Font('Arial', 30, [System.Drawing.FontStyle]::Bold)

# ---- old style: LightCoral text + hard shadow ----
$shadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210,0,0,0))
$g.DrawString('Berlin', $font, $shadow, 122, 52)
$g.DrawString('Berlin', $font, [System.Drawing.Brushes]::LightCoral, 120, 50)

# ---- new style: white text + slight semi-transparent black background ----
$name = 'Praha'
$size = $g.MeasureString($name, $font)
$pad = $size.Height * 0.1
$labelBg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(110,0,0,0))
$g.FillRectangle($labelBg, (480 - $pad), (180 - $pad), ($size.Width + 2*$pad), ($size.Height + 2*$pad))
$g.DrawString($name, $font, [System.Drawing.Brushes]::White, 480, 180)

# labels for the comparison
$smallFont = New-Object System.Drawing.Font('Arial', 12)
$g.DrawString('OLD (LightCoral)', $smallFont, [System.Drawing.Brushes]::White, 120, 20)
$g.DrawString('NEW (White + black bg)', $smallFont, [System.Drawing.Brushes]::White, 480, 150)

$bmp.Save('f:\code\ts-map\_preview_city_label.png', [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Output 'saved f:\code\ts-map\_preview_city_label.png'
