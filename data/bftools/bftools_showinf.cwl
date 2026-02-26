cwlVersion: v1.2
class: CommandLineTool
baseCommand: showinf
label: bftools_showinf
doc: "To test read a file in any format, run:\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: file
    type: File
    doc: "the image file to read\n              if - is passed, process multiple files\n\
      \              with file names read line-wise from stdin"
    inputBinding:
      position: 1
  - id: autoscale
    type:
      - 'null'
      - boolean
    doc: automatically adjust brightness and contrast (*)
    inputBinding:
      position: 102
      prefix: -autoscale
  - id: cache
    type:
      - 'null'
      - boolean
    doc: cache the initialized reader
    inputBinding:
      position: 102
      prefix: -cache
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: "use the specified directory to store the cached\n              initialized
      reader. If unspecified, the cached reader\n              will be stored under
      the same folder as the image file"
    inputBinding:
      position: 102
      prefix: -cache-dir
  - id: crop
    type:
      - 'null'
      - string
    doc: crop images before displaying; argument is 'x,y,w,h'
    inputBinding:
      position: 102
      prefix: -crop
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn on debugging output
    inputBinding:
      position: 102
      prefix: -debug
  - id: expand
    type:
      - 'null'
      - boolean
    doc: expand indexed color to RGB
    inputBinding:
      position: 102
      prefix: -expand
  - id: fast
    type:
      - 'null'
      - boolean
    doc: paint RGB images as quickly as possible (*)
    inputBinding:
      position: 102
      prefix: -fast
  - id: fill
    type:
      - 'null'
      - int
    doc: byte value to use for undefined pixels (0-255)
    inputBinding:
      position: 102
      prefix: -fill
  - id: format
    type:
      - 'null'
      - string
    doc: read file with a particular reader (e.g., ZeissZVI)
    inputBinding:
      position: 102
      prefix: -format
  - id: map
    type:
      - 'null'
      - string
    doc: specify file on disk to which name should be mapped
    inputBinding:
      position: 102
      prefix: -map
  - id: merge
    type:
      - 'null'
      - boolean
    doc: combine separate channels into RGB image
    inputBinding:
      position: 102
      prefix: -merge
  - id: minmax
    type:
      - 'null'
      - boolean
    doc: compute min/max statistics
    inputBinding:
      position: 102
      prefix: -minmax
  - id: no_sas
    type:
      - 'null'
      - boolean
    doc: do not output OME-XML StructuredAnnotation elements
    inputBinding:
      position: 102
      prefix: -no-sas
  - id: no_upgrade
    type:
      - 'null'
      - boolean
    doc: do not perform the upgrade check
    inputBinding:
      position: 102
      prefix: -no-upgrade
  - id: nocore
    type:
      - 'null'
      - boolean
    doc: do not output core metadata
    inputBinding:
      position: 102
      prefix: -nocore
  - id: nofilter
    type:
      - 'null'
      - boolean
    doc: do not filter metadata fields
    inputBinding:
      position: 102
      prefix: -nofilter
  - id: noflat
    type:
      - 'null'
      - boolean
    doc: do not flatten subresolutions
    inputBinding:
      position: 102
      prefix: -noflat
  - id: nogroup
    type:
      - 'null'
      - boolean
    doc: force multi-file datasets to be read as individual files
    inputBinding:
      position: 102
      prefix: -nogroup
  - id: nometa
    type:
      - 'null'
      - boolean
    doc: do not parse format-specific metadata table
    inputBinding:
      position: 102
      prefix: -nometa
  - id: nopix
    type:
      - 'null'
      - boolean
    doc: read metadata only, not pixels
    inputBinding:
      position: 102
      prefix: -nopix
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: normalize floating point images (*)
    inputBinding:
      position: 102
      prefix: -normalize
  - id: novalid
    type:
      - 'null'
      - boolean
    doc: do not perform validation of OME-XML
    inputBinding:
      position: 102
      prefix: -novalid
  - id: omexml
    type:
      - 'null'
      - boolean
    doc: populate OME-XML metadata
    inputBinding:
      position: 102
      prefix: -omexml
  - id: omexml_only
    type:
      - 'null'
      - boolean
    doc: only output the generated OME-XML
    inputBinding:
      position: 102
      prefix: -omexml-only
  - id: option
    type:
      - 'null'
      - type: array
        items: string
    doc: add the specified key/value pair to the reader's options list
    inputBinding:
      position: 102
      prefix: -option
  - id: preload
    type:
      - 'null'
      - boolean
    doc: "pre-read entire file into a buffer; significantly\n              reduces
      the time required to read the images, but\n              requires more memory"
    inputBinding:
      position: 102
      prefix: -preload
  - id: range
    type:
      - 'null'
      - string
    doc: specify range of planes to read (inclusive)
    inputBinding:
      position: 102
      prefix: -range
  - id: resolution
    type:
      - 'null'
      - int
    doc: "used in combination with -noflat to specify which\n              subresolution
      to read (for images with subresolutions)"
    inputBinding:
      position: 102
      prefix: -resolution
  - id: separate
    type:
      - 'null'
      - boolean
    doc: split RGB image into separate channels
    inputBinding:
      position: 102
      prefix: -separate
  - id: series
    type:
      - 'null'
      - int
    doc: specify which image series to read
    inputBinding:
      position: 102
      prefix: -series
  - id: shuffle
    type:
      - 'null'
      - string
    doc: override the default output dimension order
    inputBinding:
      position: 102
      prefix: -shuffle
  - id: stitch
    type:
      - 'null'
      - boolean
    doc: stitch files with similar names
    inputBinding:
      position: 102
      prefix: -stitch
  - id: swap
    type:
      - 'null'
      - string
    doc: override the default input dimension order
    inputBinding:
      position: 102
      prefix: -swap
  - id: thumbs
    type:
      - 'null'
      - boolean
    doc: read thumbnails instead of normal pixels
    inputBinding:
      position: 102
      prefix: -thumbs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_showinf.out
