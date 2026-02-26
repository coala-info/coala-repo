cwlVersion: v1.2
class: CommandLineTool
baseCommand: bfconvert
label: bftools_bfconvert
doc: "To convert a file between formats, run:\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: autoscale
    type:
      - 'null'
      - boolean
    doc: automatically adjust brightness and contrast before converting; this 
      may mean that the original pixel values are not preserved
    inputBinding:
      position: 102
      prefix: -autoscale
  - id: bigtiff
    type:
      - 'null'
      - boolean
    doc: force BigTIFF files to be written
    inputBinding:
      position: 102
      prefix: -bigtiff
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
    doc: use the specified directory to store the cached initialized reader. If 
      unspecified, the cached reader will be stored under the same folder as the
      image file
    inputBinding:
      position: 102
      prefix: -cache-dir
  - id: channel
    type:
      - 'null'
      - int
    doc: only convert the specified channel (indexed from 0)
    inputBinding:
      position: 102
      prefix: -channel
  - id: compression
    type:
      - 'null'
      - string
    doc: specify the codec to use when saving images
    inputBinding:
      position: 102
      prefix: -compression
  - id: crop
    type:
      - 'null'
      - string
    doc: crop images before converting; argument is 'x,y,w,h'
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
  - id: fill
    type:
      - 'null'
      - int
    doc: byte value to use for undefined pixels (0-255)
    inputBinding:
      position: 102
      prefix: -fill
  - id: map
    type:
      - 'null'
      - File
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
  - id: no_sas
    type:
      - 'null'
      - boolean
    doc: do not preserve the OME-XML StructuredAnnotation elements
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
  - id: nobigtiff
    type:
      - 'null'
      - boolean
    doc: do not automatically switch to BigTIFF
    inputBinding:
      position: 102
      prefix: -nobigtiff
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
  - id: nolookup
    type:
      - 'null'
      - boolean
    doc: disable the conversion of lookup tables
    inputBinding:
      position: 102
      prefix: -nolookup
  - id: novalid
    type:
      - 'null'
      - boolean
    doc: will not validate the OME-XML for the output file
    inputBinding:
      position: 102
      prefix: -novalid
  - id: option
    type:
      - 'null'
      - type: array
        items: string
    doc: add the specified key/value pair to the options list
    inputBinding:
      position: 102
      prefix: -option
  - id: padded
    type:
      - 'null'
      - boolean
    doc: filename indexes for series, z, c and t will be zero padded
    inputBinding:
      position: 102
      prefix: -padded
  - id: precompressed
    type:
      - 'null'
      - boolean
    doc: transfer compressed bytes from input dataset directly to output. Most 
      input and output formats do not support this option. Do not use -crop, 
      -fill, or -autoscale, or pyramid generation options with this option.
    inputBinding:
      position: 102
      prefix: -precompressed
  - id: pyramid_resolutions
    type:
      - 'null'
      - int
    doc: generates a pyramid image with the given number of resolution levels
    inputBinding:
      position: 102
      prefix: -pyramid-resolutions
  - id: pyramid_scale
    type:
      - 'null'
      - float
    doc: generates a pyramid image with each subsequent resolution level divided
      by scale
    inputBinding:
      position: 102
      prefix: -pyramid-scale
  - id: quality
    type:
      - 'null'
      - float
    doc: double quality value for JPEG compression (0-1)
    inputBinding:
      position: 102
      prefix: -quality
  - id: range
    type:
      - 'null'
      - string
    doc: specify range of planes to convert (inclusive)
    inputBinding:
      position: 102
      prefix: -range
  - id: separate
    type:
      - 'null'
      - boolean
    doc: split RGB images into separate channels
    inputBinding:
      position: 102
      prefix: -separate
  - id: series
    type:
      - 'null'
      - string
    doc: specify which image series to convert
    inputBinding:
      position: 102
      prefix: -series
  - id: stitch
    type:
      - 'null'
      - boolean
    doc: stitch input files with similar names
    inputBinding:
      position: 102
      prefix: -stitch
  - id: swap
    type:
      - 'null'
      - string
    doc: override the default input dimension order; argument is f.i. XYCTZ
    inputBinding:
      position: 102
      prefix: -swap
  - id: tilex
    type:
      - 'null'
      - int
    doc: image will be converted one tile at a time using the given tile width
    inputBinding:
      position: 102
      prefix: -tilex
  - id: tiley
    type:
      - 'null'
      - int
    doc: image will be converted one tile at a time using the given tile height
    inputBinding:
      position: 102
      prefix: -tiley
  - id: timepoint
    type:
      - 'null'
      - int
    doc: only convert the specified timepoint (indexed from 0)
    inputBinding:
      position: 102
      prefix: -timepoint
  - id: validate
    type:
      - 'null'
      - boolean
    doc: will validate the generated OME-XML for the output file
    inputBinding:
      position: 102
      prefix: -validate
  - id: z
    type:
      - 'null'
      - int
    doc: only convert the specified Z section (indexed from 0)
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
