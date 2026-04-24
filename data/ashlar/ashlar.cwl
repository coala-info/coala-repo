cwlVersion: v1.2
class: CommandLineTool
baseCommand: ashlar
label: ashlar
doc: "Stitch and align multi-tile cyclic microscope images\n\nTool homepage: https://github.com/sorgerlab/ashlar"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Image file(s) to be processed, one per cycle
    inputBinding:
      position: 1
  - id: align_channel
    type:
      - 'null'
      - int
    doc: Reference channel number for image alignment. Numbering starts at 0.
    inputBinding:
      position: 102
      prefix: --align-channel
  - id: dark_field_profiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Perform dark field illumination correction using the given profile 
      image. Specify one common file for all cycles or one file for every cycle.
      Channel counts must match input files.
    inputBinding:
      position: 102
      prefix: --dfp
  - id: filter_sigma
    type:
      - 'null'
      - float
    doc: Filter images before alignment using a Gaussian kernel with s.d. of 
      SIGMA pixels
    inputBinding:
      position: 102
      prefix: --filter-sigma
  - id: flat_field_profiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Perform flat field illumination correction using the given profile 
      image. Specify one common file for all cycles or one file for every cycle.
      Channel counts must match input files.
    inputBinding:
      position: 102
      prefix: --ffp
  - id: flip_mosaic_x
    type:
      - 'null'
      - boolean
    doc: Flip output image left-to-right
    inputBinding:
      position: 102
      prefix: --flip-mosaic-x
  - id: flip_mosaic_y
    type:
      - 'null'
      - boolean
    doc: Flip output image top-to-bottom
    inputBinding:
      position: 102
      prefix: --flip-mosaic-y
  - id: flip_x
    type:
      - 'null'
      - boolean
    doc: Flip tile positions left-to-right
    inputBinding:
      position: 102
      prefix: --flip-x
  - id: flip_y
    type:
      - 'null'
      - boolean
    doc: Flip tile positions top-to-bottom
    inputBinding:
      position: 102
      prefix: --flip-y
  - id: maximum_shift
    type:
      - 'null'
      - float
    doc: Maximum allowed per-tile corrective shift in microns
    inputBinding:
      position: 102
      prefix: --maximum-shift
  - id: output_channels
    type:
      - 'null'
      - type: array
        items: int
    doc: Output only specified channels for each cycle. Numbering starts at 0.
    inputBinding:
      position: 102
      prefix: --output-channels
  - id: plates
    type:
      - 'null'
      - boolean
    doc: Enable plate mode for HTS data
    inputBinding:
      position: 102
      prefix: --plates
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress display
    inputBinding:
      position: 102
      prefix: --quiet
  - id: stitch_alpha
    type:
      - 'null'
      - float
    doc: Significance level for permutation testing during alignment error 
      quantification. Larger values include more tile pairs in the spanning tree
      at the cost of increased false positives.
    inputBinding:
      position: 102
      prefix: --stitch-alpha
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Pyramid tile size for OME-TIFF output
    inputBinding:
      position: 102
      prefix: --tile-size
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Output file. If PATH ends in .ome.tif a pyramidal OME-TIFF will be 
      written. If PATH ends in just .tif and includes {cycle} and {channel} 
      placeholders, a series of single-channel plain TIFF files will be written.
      If PATH starts with a relative or absolute path to another directory, that
      directory must already exist.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ashlar:1.19.0--pyhdfd78af_0
