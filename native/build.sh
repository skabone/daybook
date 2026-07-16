#!/bin/bash
# Build Daybook.app — a native macOS wrapper for the Daybook planner.
# Requires only Xcode Command Line Tools (swiftc, iconutil) — no downloads, no money.
# Usage:  cd native && ./build.sh   →   produces Daybook.app (drag it to /Applications)
set -e
cd "$(dirname "$0")"

APP="Daybook.app"
BIN="Contents/MacOS/Daybook"

echo "› Cleaning old build…"
rm -rf "$APP" Daybook.iconset Daybook.icns

echo "› Compiling native binary (Swift + WebKit)…"
swiftc -O Daybook.swift -o daybook-bin -framework Cocoa -framework WebKit

echo "› Assembling app bundle…"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
mv daybook-bin "$APP/$BIN"

echo "› Generating app icon…"
if swiftc -O makeicon.swift -o makeicon-bin 2>/dev/null; then
  ./makeicon-bin Daybook.iconset >/dev/null
  iconutil -c icns Daybook.iconset -o "$APP/Contents/Resources/Daybook.icns"
  rm -rf Daybook.iconset makeicon-bin
  ICON_LINE="<key>CFBundleIconFile</key><string>Daybook</string>"
else
  echo "  (icon generation skipped — app will use the default icon)"
  ICON_LINE=""
fi

cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key><string>Daybook</string>
  <key>CFBundleDisplayName</key><string>Daybook</string>
  <key>CFBundleExecutable</key><string>Daybook</string>
  <key>CFBundleIdentifier</key><string>com.mintaymisgano.daybook</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>LSMinimumSystemVersion</key><string>11.0</string>
  <key>NSHighResolutionCapable</key><true/>
  <key>NSHumanReadableCopyright</key><string>© 2026 Mintay Misgano · PolyForm Noncommercial</string>
  ${ICON_LINE}
</dict>
</plist>
PLIST

# Ad-hoc sign so macOS runs a locally built, unsigned app cleanly.
codesign --force --deep --sign - "$APP" 2>/dev/null || true

echo ""
echo "✓ Built $APP"
echo "  Move it to Applications:   mv \"$APP\" /Applications/"
echo "  Then open it from Launchpad or Spotlight like any other app."
