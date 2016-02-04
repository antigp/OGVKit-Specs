Pod::Spec.new do |s|
  s.name         = "OGVKit"
  s.version      = "0.6pre"
  s.summary      = "Ogg Vorbis/Theora and WebM media playback widget for iOS."

  s.description  = <<-DESC
                   Ogg Vorbis/Theora and WebM media playback widget for iOS.
                   Packages Xiph.org's libogg, libvorbis, and libtheora, and
                   uses Google's VPX library, along with a UIView subclass
                   to play a video or audio file from a URL.
                   DESC

  s.homepage     = "https://github.com/antigp/OGVKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Brion Vibber" => "brion@pobox.com" }
  s.social_media_url   = "https://brionv.com/"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/brion/OGVKit.git",
                     :submodules => true }

  s.source_files = "Classes/OGVKit.{h,m}",
                   "Classes/OGVQueue.{h,m}",
                   "Classes/OGVMediaType.{h,m}",
                   "Classes/OGVAudioFormat.{h,m}",
                   "Classes/OGVAudioBuffer.{h,m}",
                   "Classes/OGVVideoFormat.{h,m}",
                   "Classes/OGVVideoPlane.{h,m}",
                   "Classes/OGVVideoBuffer.{h,m}",
                   "Classes/OGVHTTPContentRange.{h,m}",
                   "Classes/OGVInputStream.{h,m}",
                   "Classes/OGVDecoder.{h,m}",
                   "Classes/OGVFrameView.{h,m}",
                   "Classes/OGVAudioFeeder.{h,m}",
                   "Classes/OGVPlayerState.{h,m}",
                   "Classes/OGVPlayerView.{h,m}",
                   "Classes/OGVDecoderOgg.h",
                   "Classes/OGVDecoderOggPacket.h",
                   "Classes/OGVDecoderWebM.h",
                   "Classes/OGVDecoderWebMPacket.h",
                   "libskeleton/includes/skeleton/skeleton.h",
                   "libskeleton/includes/skeleton/skeleton_constants.h",
                   "libskeleton/includes/skeleton/skeleton_query.h"

  s.public_header_files = "Classes/OGVKit.h",
                          "Classes/OGVQueue.h",
                          "Classes/OGVMediaType.h",
                          "Classes/OGVAudioFormat.h",
                          "Classes/OGVAudioBuffer.h",
                          "Classes/OGVVideoFormat.h",
                          "Classes/OGVVideoPlane.h",
                          "Classes/OGVVideoBuffer.h",
                          "Classes/OGVInputStream.h",
                          "Classes/OGVDecoder.h",
                          "Classes/OGVFrameView.h",
                          "Classes/OGVAudioFeeder.h",
                          "Classes/OGVPlayerState.h",
                          "Classes/OGVPlayerView.h"

  s.header_dir = 'OGVKit'

  s.resource_bundle = {
    'OGVKitResources' => [
      'Resources/OGVFrameView.fsh',
      'Resources/OGVFrameView.vsh',
      'Resources/OGVPlayerView.xib',
      'Resources/ogvkit-iconfont.ttf'
    ]
  }

  s.module_name = 'OGVKit'
  s.module_map = 'OGVKit.modulemap'

  # File format convenience subspecs
  s.subspec "Ogg" do |sogg|
    sogg.subspec "Theora" do |soggtheora|
      soggtheora.dependency 'OGVKit/OggDemuxer'
      soggtheora.dependency 'OGVKit/TheoraDecoder'
      soggtheora.dependency 'OGVKit/VorbisDecoder'
    end
    sogg.subspec "Vorbis" do |soggvorbis|
      soggvorbis.dependency 'OGVKit/OggDemuxer'
      soggvorbis.dependency 'OGVKit/VorbisDecoder'
    end
  end
  s.subspec "WebM" do |swebm|
    swebm.subspec "VP8" do |swebmvp8|
      swebmvp8.dependency 'OGVKit/WebMDemuxer'
      swebmvp8.dependency 'OGVKit/VP8Decoder'
      swebmvp8.dependency 'OGVKit/VorbisDecoder'
    end
    swebm.subspec "Vorbis" do |swebmvorbis|
      swebmvorbis.dependency 'OGVKit/WebMDemuxer'
      swebmvorbis.dependency 'OGVKit/VorbisDecoder'
    end
  end

  # Demuxer module subspecs
  s.subspec "OggDemuxer" do |soggdemuxer|
    soggdemuxer.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_OGG_DEMUXER' }
    soggdemuxer.source_files = "Classes/OGVDecoderOgg.{h,m}",
                               "Classes/OGVDecoderOggPacket.{h,m}"
    soggdemuxer.dependency 'liboggz'
    soggdemuxer.dependency 'OGVKit/libskeleton', '~>0.4'
  end
  s.subspec "WebMDemuxer" do |swebmdemuxer|
    swebmdemuxer.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_WEBM_DEMUXER' }
    swebmdemuxer.source_files = "Classes/OGVDecoderWebM.{h,m}",
                                "Classes/OGVDecoderWebMPacket.{h,m}"
    swebmdemuxer.dependency 'libnestegg'
  end

  # Video decoder module subspecs
  s.subspec "TheoraDecoder" do |stheoradecoder|
    stheoradecoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_THEORA_DECODER' }
    stheoradecoder.dependency 'libtheora'
  end
  s.subspec "VP8Decoder" do |svp8decoder|
    svp8decoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VP8_DECODER' }
    svp8decoder.dependency 'libvpx', '~>1.4.0-snapshot-20151029-shared-xcode71c'
  end

  # Audio decoder module subspecs
  s.subspec "VorbisDecoder" do |svorbisdecoder|
    svorbisdecoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VORBIS_DECODER' }
    svorbisdecoder.dependency 'libvorbis'
  end

  # Additional libraries not ready to package separately
  s.subspec "libskeleton" do |sskel|
    sskel.source_files = "libskeleton/include/skeleton/skeleton.h",
                         "libskeleton/include/skeleton/skeleton_constants.h",
                         "libskeleton/include/skeleton/skeleton_query.h",
                         "libskeleton/src/skeleton.c",
                         "libskeleton/src/skeleton_macros.h",
                         "libskeleton/src/skeleton_private.h",
                         "libskeleton/src/skeleton_query.c",
                         "libskeleton/src/skeleton_vector.h",
                         "libskeleton/src/skeleton_vector.c"
    sskel.compiler_flags = "-Wno-conversion",
                           "-Wno-unused-function"

    sskel.public_header_files = "libskeleton/include/skeleton/skeleton.h",
                                "libskeleton/include/skeleton/skeleton_constants.h",
                                "libskeleton/include/skeleton/skeleton_query.h"
    sskel.header_dir = 'skeleton'

    sskel.dependency 'libogg'
  end

end
