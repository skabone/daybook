// Renders Daybook.iconset (notebook mark on a slate rounded tile) with Core Graphics.
// Required Notice: Copyright (c) 2026 Mintay Misgano (https://github.com/skabone)
import Cocoa

func color(_ hex: UInt32) -> CGColor {
    CGColor(red: CGFloat((hex >> 16) & 0xff)/255, green: CGFloat((hex >> 8) & 0xff)/255,
            blue: CGFloat(hex & 0xff)/255, alpha: 1)
}
let slate = color(0x565165), paper = color(0xfbfaf5), terra = color(0xc9724a), line = color(0xe2ddd1)

func roundedPath(_ r: CGRect, _ radius: CGFloat) -> CGPath {
    CGPath(roundedRect: r, cornerWidth: radius, cornerHeight: radius, transform: nil)
}

func drawIcon(size S: CGFloat) -> CGImage? {
    let cs = CGColorSpace(name: CGColorSpace.sRGB)!
    guard let ctx = CGContext(data: nil, width: Int(S), height: Int(S), bitsPerComponent: 8,
                              bytesPerRow: 0, space: cs,
                              bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return nil }
    // tile (leave transparent margin so it matches macOS rounded-icon sizing)
    let inset = S * 0.085
    let tile = CGRect(x: inset, y: inset, width: S - 2*inset, height: S - 2*inset)
    let W = tile.width
    func x(_ f: CGFloat) -> CGFloat { tile.minX + W*f }
    // NOTE: CG origin is bottom-left; SVG fractions are top-down, so flip y.
    func y(_ f: CGFloat) -> CGFloat { tile.minY + W*(1-f) }

    ctx.addPath(roundedPath(tile, W*0.225)); ctx.setFillColor(slate); ctx.fillPath()

    // page card
    let card = CGRect(x: x(0.231), y: y(0.246 + 0.570), width: W*0.539, height: W*0.570)
    let cardPath = roundedPath(card, W*0.055)
    ctx.saveGState()
    ctx.addPath(cardPath); ctx.setFillColor(paper); ctx.fillPath()
    // clip to card, draw terra spine on the left edge
    ctx.addPath(cardPath); ctx.clip()
    ctx.setFillColor(terra)
    ctx.fill(CGRect(x: card.minX, y: card.minY, width: W*0.105, height: card.height))
    ctx.restoreGState()

    // three dots on the spine
    ctx.setFillColor(paper)
    for f in [0.355, 0.5, 0.645] as [CGFloat] {
        let d = W*0.035
        ctx.fillEllipse(in: CGRect(x: x(0.283) - d/2, y: y(f) - d/2, width: d, height: d))
    }
    // three text lines (middle one terra)
    func lineRect(_ yf: CGFloat, _ wf: CGFloat) -> CGRect {
        CGRect(x: x(0.402), y: y(yf) - W*0.0176, width: W*wf, height: W*0.035)
    }
    ctx.setFillColor(line);  ctx.addPath(roundedPath(lineRect(0.371, 0.293), W*0.017)); ctx.fillPath()
    ctx.setFillColor(terra); ctx.setAlpha(0.55); ctx.addPath(roundedPath(lineRect(0.484, 0.293), W*0.017)); ctx.fillPath(); ctx.setAlpha(1)
    ctx.setFillColor(line);  ctx.addPath(roundedPath(lineRect(0.598, 0.203), W*0.017)); ctx.fillPath()

    return ctx.makeImage()
}

func writePNG(_ img: CGImage, _ path: String) {
    let rep = NSBitmapImageRep(cgImage: img)
    if let data = rep.representation(using: .png, properties: [:]) {
        try? data.write(to: URL(fileURLWithPath: path))
    }
}

let dir = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "Daybook.iconset"
try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
let sizes: [(String, CGFloat)] = [
    ("icon_16x16", 16), ("icon_16x16@2x", 32), ("icon_32x32", 32), ("icon_32x32@2x", 64),
    ("icon_128x128", 128), ("icon_128x128@2x", 256), ("icon_256x256", 256),
    ("icon_256x256@2x", 512), ("icon_512x512", 512), ("icon_512x512@2x", 1024)
]
for (name, s) in sizes {
    if let img = drawIcon(size: s) { writePNG(img, "\(dir)/\(name).png") }
}
print("iconset written to \(dir)")
