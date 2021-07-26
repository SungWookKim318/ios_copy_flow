#if os(OSX)
    typealias Image = NSImage
    typealias ImageName = NSImage.Name
#elseif os(iOS)
    import UIKit

    typealias Image = UIImage
    typealias ImageName = String
#endif

extension Image {
    static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
    static var assetsExamplelyrics: Image { return Image(named: ImageName("exampleLyrics"))! }
    static var assetsExampleplayer: Image { return Image(named: ImageName("examplePlayer"))! }
    static var assetsSfAirplayaudio: Image { return Image(named: ImageName("SF_airplayaudio"))! }
    static var assetsSfAirplayaudioD: Image { return Image(named: ImageName("SF_airplayaudio_d"))! }
    static var assetsSfBackwardEndFill: Image { return Image(named: ImageName("SF_backward_end_fill"))! }
    static var assetsSfBackwardEndFillD: Image { return Image(named: ImageName("SF_backward_end_fill_d"))! }
    static var assetsSfBackwardFill: Image { return Image(named: ImageName("SF_backward_fill"))! }
    static var assetsSfBackwardFill1: Image { return Image(named: ImageName("SF_backward_fill-1"))! }
    static var assetsSfChevronDownSquareFill: Image { return Image(named: ImageName("SF_chevron_down_square_fill"))! }
    static var assetsSfChevronDownSquareFillD: Image { return Image(named: ImageName("SF_chevron_down_square_fill-d"))! }
    static var assetsSfEllipsisCircleFill: Image { return Image(named: ImageName("SF_ellipsis_circle_fill"))! }
    static var assetsSfEllipsisCircleFillD: Image { return Image(named: ImageName("SF_ellipsis_circle_fill_d"))! }
    static var assetsSfForwardEndFill: Image { return Image(named: ImageName("SF_forward_end_fill"))! }
    static var assetsSfForwardEndFill1: Image { return Image(named: ImageName("SF_forward_end_fill-1"))! }
    static var assetsSfForwardFill: Image { return Image(named: ImageName("SF_forward_fill"))! }
    static var assetsSfForwardFillD: Image { return Image(named: ImageName("SF_forward_fill_d"))! }
    static var assetsSfPauseCircleFill: Image { return Image(named: ImageName("SF_pause_circle_fill"))! }
    static var assetsSfPauseCircleFillD: Image { return Image(named: ImageName("SF_pause_circle_fill_d"))! }
    static var assetsSfPlayCircleFill: Image { return Image(named: ImageName("SF_play_circle_fill"))! }
    static var assetsSfPlayCircleFillD: Image { return Image(named: ImageName("SF_play_circle_fill_d"))! }
    static var assetsSplash: Image { return Image(named: ImageName("Splash"))! }
}
