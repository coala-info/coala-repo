cwlVersion: v1.2
class: CommandLineTool
baseCommand: go_env
label: go_env
doc: "Prints Go runtime environment information.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: cc
    type:
      - 'null'
      - string
    doc: C compiler path.
    inputBinding:
      position: 101
      prefix: CC
  - id: cgo_cflags
    type:
      - 'null'
      - string
    doc: C compiler flags for Cgo.
    inputBinding:
      position: 101
      prefix: CGO_CFLAGS
  - id: cgo_cppflags
    type:
      - 'null'
      - string
    doc: C preprocessor flags for Cgo.
    inputBinding:
      position: 101
      prefix: CGO_CPPFLAGS
  - id: cgo_cxxflags
    type:
      - 'null'
      - string
    doc: C++ compiler flags for Cgo.
    inputBinding:
      position: 101
      prefix: CGO_CXXFLAGS
  - id: cgo_enabled
    type:
      - 'null'
      - string
    doc: Enable Cgo.
    inputBinding:
      position: 101
      prefix: CGO_ENABLED
  - id: cgo_fflags
    type:
      - 'null'
      - string
    doc: Fortran compiler flags for Cgo.
    inputBinding:
      position: 101
      prefix: CGO_FFLAGS
  - id: cgo_ldflags
    type:
      - 'null'
      - string
    doc: Linker flags for Cgo.
    inputBinding:
      position: 101
      prefix: CGO_LDFLAGS
  - id: cxx
    type:
      - 'null'
      - string
    doc: C++ compiler path.
    inputBinding:
      position: 101
      prefix: CXX
  - id: gccgo
    type:
      - 'null'
      - string
    doc: GCC Go compiler path.
    inputBinding:
      position: 101
      prefix: GCCGO
  - id: goarch
    type:
      - 'null'
      - string
    doc: Target architecture for Go programs.
    inputBinding:
      position: 101
      prefix: GOARCH
  - id: gobin
    type:
      - 'null'
      - string
    doc: Directory for installing commands.
    inputBinding:
      position: 101
      prefix: GOBIN
  - id: gocache
    type:
      - 'null'
      - string
    doc: Build cache directory.
    inputBinding:
      position: 101
      prefix: GOCACHE
  - id: goexe
    type:
      - 'null'
      - string
    doc: Executable file name suffix.
    inputBinding:
      position: 101
      prefix: GOEXE
  - id: goflags
    type:
      - 'null'
      - string
    doc: Flags to pass to go build.
    inputBinding:
      position: 101
      prefix: GOFLAGS
  - id: gogccflags
    type:
      - 'null'
      - string
    doc: GCC flags for Go compilation.
    inputBinding:
      position: 101
      prefix: GOGCCFLAGS
  - id: gohostarch
    type:
      - 'null'
      - string
    doc: Host architecture.
    inputBinding:
      position: 101
      prefix: GOHOSTARCH
  - id: gohostos
    type:
      - 'null'
      - string
    doc: Host operating system.
    inputBinding:
      position: 101
      prefix: GOHOSTOS
  - id: gomod
    type:
      - 'null'
      - string
    doc: Go module cache directory.
    inputBinding:
      position: 101
      prefix: GOMOD
  - id: goos
    type:
      - 'null'
      - string
    doc: Target operating system.
    inputBinding:
      position: 101
      prefix: GOOS
  - id: gopath
    type:
      - 'null'
      - string
    doc: Go workspace directory.
    inputBinding:
      position: 101
      prefix: GOPATH
  - id: goproxy
    type:
      - 'null'
      - string
    doc: Go module proxy.
    inputBinding:
      position: 101
      prefix: GOPROXY
  - id: gorace
    type:
      - 'null'
      - string
    doc: Race detector settings.
    inputBinding:
      position: 101
      prefix: GORACE
  - id: goroot
    type:
      - 'null'
      - string
    doc: Go installation directory.
    inputBinding:
      position: 101
      prefix: GOROOT
  - id: gotmpdir
    type:
      - 'null'
      - string
    doc: Temporary directory for Go build.
    inputBinding:
      position: 101
      prefix: GOTMPDIR
  - id: gotooldir
    type:
      - 'null'
      - string
    doc: Directory for Go tools.
    inputBinding:
      position: 101
      prefix: GOTOOLDIR
  - id: pkg_config
    type:
      - 'null'
      - string
    doc: pkg-config command path.
    inputBinding:
      position: 101
      prefix: PKG_CONFIG
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_env.out
