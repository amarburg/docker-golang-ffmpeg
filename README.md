Extends the [canonical Go language Docker images](https://hub.docker.com/_/golang/)
with a compiled version of FFMpeg and associated libraries:
AAC, LAME, OGG, Opus, Theora, Vorbis, VPX, XVid, X264, X265

I need this image for testing of [goav](https://github.com/amarburg/goav)
and my various projects that depends on it.
It also installs gcc, pkg-config, etc. for cgo.

The `*-ci` tags include tools which are CI-specific:

  * [golangci-lint](https://github.com/golangci/golangci-lint)
