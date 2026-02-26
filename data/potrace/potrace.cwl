cwlVersion: v1.2
class: CommandLineTool
baseCommand: potrace
label: potrace
doc: "Transforms bitmaps into vector graphics.\n\nTool homepage: https://github.com/kilobtye/potrace"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: an input file
    inputBinding:
      position: 1
  - id: alphamax
    type:
      - 'null'
      - float
    doc: corner threshold parameter
    default: 1
    inputBinding:
      position: 102
      prefix: --alphamax
  - id: backend
    type:
      - 'null'
      - string
    doc: select backend by name
    inputBinding:
      position: 102
      prefix: --backend
  - id: blacklevel
    type:
      - 'null'
      - float
    doc: black/white cutoff in input file
    default: 0.5
    inputBinding:
      position: 102
      prefix: --blacklevel
  - id: bottommargin
    type:
      - 'null'
      - string
    doc: bottom margin
    inputBinding:
      position: 102
      prefix: --bottommargin
  - id: cleartext
    type:
      - 'null'
      - boolean
    doc: do not compress the output
    inputBinding:
      position: 102
      prefix: --cleartext
  - id: color
    type:
      - 'null'
      - string
    doc: set foreground color
    default: black
    inputBinding:
      position: 102
      prefix: --color
  - id: debug
    type:
      - 'null'
      - int
    doc: produce debugging output of type n (n=1,2,3)
    inputBinding:
      position: 102
      prefix: --debug
  - id: dxf
    type:
      - 'null'
      - boolean
    doc: DXF backend (drawing interchange format)
    inputBinding:
      position: 102
  - id: eps
    type:
      - 'null'
      - boolean
    doc: EPS backend (encapsulated PostScript)
    inputBinding:
      position: 102
      prefix: --eps
  - id: fillcolor
    type:
      - 'null'
      - string
    doc: set fill color
    default: transparent
    inputBinding:
      position: 102
      prefix: --fillcolor
  - id: flat
    type:
      - 'null'
      - boolean
    doc: whole image as a single path
    inputBinding:
      position: 102
      prefix: --flat
  - id: gamma
    type:
      - 'null'
      - float
    doc: gamma value for anti-aliasing
    default: 2.2
    inputBinding:
      position: 102
      prefix: --gamma
  - id: geojson
    type:
      - 'null'
      - boolean
    doc: GeoJSON backend
    inputBinding:
      position: 102
  - id: gimppath
    type:
      - 'null'
      - boolean
    doc: Gimppath backend (GNU Gimp)
    inputBinding:
      position: 102
  - id: group
    type:
      - 'null'
      - boolean
    doc: group related paths together
    inputBinding:
      position: 102
      prefix: --group
  - id: height
    type:
      - 'null'
      - string
    doc: height of output image
    inputBinding:
      position: 102
      prefix: --height
  - id: invert
    type:
      - 'null'
      - boolean
    doc: invert bitmap
    inputBinding:
      position: 102
      prefix: --invert
  - id: leftmargin
    type:
      - 'null'
      - string
    doc: left margin
    inputBinding:
      position: 102
      prefix: --leftmargin
  - id: level2
    type:
      - 'null'
      - boolean
    doc: use postscript level 2 compression
    default: true
    inputBinding:
      position: 102
      prefix: --level2
  - id: level3
    type:
      - 'null'
      - boolean
    doc: use postscript level 3 compression
    inputBinding:
      position: 102
      prefix: --level3
  - id: longcoding
    type:
      - 'null'
      - boolean
    doc: do not optimize for file size
    inputBinding:
      position: 102
      prefix: --longcoding
  - id: longcurve
    type:
      - 'null'
      - boolean
    doc: turn off curve optimization
    inputBinding:
      position: 102
      prefix: --longcurve
  - id: margin
    type:
      - 'null'
      - string
    doc: margin
    inputBinding:
      position: 102
      prefix: --margin
  - id: opaque
    type:
      - 'null'
      - boolean
    doc: make white shapes opaque
    inputBinding:
      position: 102
      prefix: --opaque
  - id: opttolerance
    type:
      - 'null'
      - float
    doc: curve optimization tolerance
    default: 0.2
    inputBinding:
      position: 102
      prefix: --opttolerance
  - id: pagesize
    type:
      - 'null'
      - string
    doc: page size
    default: letter
    inputBinding:
      position: 102
      prefix: --pagesize
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: PDF backend (portable document format)
    inputBinding:
      position: 102
  - id: pdfpage
    type:
      - 'null'
      - boolean
    doc: fixed page-size PDF backend
    inputBinding:
      position: 102
  - id: pgm
    type:
      - 'null'
      - boolean
    doc: PGM backend (portable greymap)
    inputBinding:
      position: 102
      prefix: --pgm
  - id: postscript
    type:
      - 'null'
      - boolean
    doc: PostScript backend
    inputBinding:
      position: 102
      prefix: --postscript
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress bar
    inputBinding:
      position: 102
      prefix: --progress
  - id: resolution
    type:
      - 'null'
      - string
    doc: resolution (in dpi) (dimension-based backends)
    inputBinding:
      position: 102
      prefix: --resolution
  - id: rightmargin
    type:
      - 'null'
      - string
    doc: right margin
    inputBinding:
      position: 102
      prefix: --rightmargin
  - id: rotate
    type:
      - 'null'
      - string
    doc: rotate counterclockwise by angle
    inputBinding:
      position: 102
      prefix: --rotate
  - id: scale
    type:
      - 'null'
      - string
    doc: scaling factor (pixel-based backends)
    inputBinding:
      position: 102
      prefix: --scale
  - id: stretch
    type:
      - 'null'
      - string
    doc: yresolution/xresolution
    inputBinding:
      position: 102
      prefix: --stretch
  - id: svg
    type:
      - 'null'
      - boolean
    doc: SVG backend (scalable vector graphics)
    inputBinding:
      position: 102
      prefix: --svg
  - id: tight
    type:
      - 'null'
      - boolean
    doc: remove whitespace around the input image
    inputBinding:
      position: 102
      prefix: --tight
  - id: topmargin
    type:
      - 'null'
      - string
    doc: top margin
    inputBinding:
      position: 102
      prefix: --topmargin
  - id: tty
    type:
      - 'null'
      - string
    doc: 'progress bar rendering: vt100 or dumb'
    inputBinding:
      position: 102
      prefix: --tty
  - id: turdsize
    type:
      - 'null'
      - int
    doc: suppress speckles of up to this size
    default: 2
    inputBinding:
      position: 102
      prefix: --turdsize
  - id: turnpolicy
    type:
      - 'null'
      - string
    doc: how to resolve ambiguities in path decomposition
    inputBinding:
      position: 102
      prefix: --turnpolicy
  - id: unit
    type:
      - 'null'
      - int
    doc: quantize output to 1/unit pixels
    default: 1
    inputBinding:
      position: 102
      prefix: --unit
  - id: width
    type:
      - 'null'
      - string
    doc: width of output image
    inputBinding:
      position: 102
      prefix: --width
  - id: xfig
    type:
      - 'null'
      - boolean
    doc: XFig backend
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write all output to this file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/potrace:1.11--h577a1d6_7
