cwlVersion: v1.2
class: CommandLineTool
baseCommand: plantcv-workflow.py
label: plantcv_plantcv-workflow.py
doc: "Parallel imaging processing with PlantCV.\n\nTool homepage: https://plantcv.danforthcenter.org"
inputs:
  - id: adaptor
    type:
      - 'null'
      - string
    doc: 'Image metadata reader adaptor. PhenoFront metadata is stored in a CSV file
      and the image file name. For the filename option, all metadata is stored in
      the image file name. Current adaptors: phenofront, filename'
    default: phenofront
    inputBinding:
      position: 101
      prefix: --adaptor
  - id: coprocess
    type:
      - 'null'
      - string
    doc: Coprocess the specified imgtype with the imgtype specified in --match 
      (e.g. coprocess NIR images with VIS).
    default: None
    inputBinding:
      position: 101
      prefix: --coprocess
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPU processes to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: create_db
    type:
      - 'null'
      - boolean
    doc: 'will overwrite an existing databaseWarning: activating this option will
      delete an existing database!'
    default: false
    inputBinding:
      position: 101
      prefix: --create
  - id: dates
    type:
      - 'null'
      - string
    doc: 'Date range. Format: YYYY-MM-DD-hh-mm-ss_YYYY-MM-DD-hh-mm-ss. If the second
      date is excluded then the current date is assumed.'
    default: None
    inputBinding:
      position: 101
      prefix: --dates
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Image file name metadata delimiter character.Alternatively, a regular 
      expression for parsing filename metadata.
    default: _
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: image_type
    type:
      - 'null'
      - string
    doc: Image format type (extension).
    default: png
    inputBinding:
      position: 101
      prefix: --type
  - id: input_dir
    type: Directory
    doc: Input directory containing images or snapshots.
    inputBinding:
      position: 101
      prefix: --dir
  - id: json_output
    type: File
    doc: Output database file name.
    inputBinding:
      position: 101
      prefix: --json
  - id: match_metadata
    type:
      - 'null'
      - string
    doc: Restrict analysis to images with metadata matching input criteria. 
      Input a metadata:value comma-separated list. This is an exact match 
      search. E.g. imgtype:VIS,camera:SV,zoom:z500
    default: None
    inputBinding:
      position: 101
      prefix: --match
  - id: meta_structure
    type: string
    doc: 'Image filename metadata structure. Comma-separated list of valid metadata
      terms. Valid metadata fields are: camera, imgtype, zoom, exposure, gain, frame,
      lifter, timestamp, id, plantbarcode, treatment, cartag, measurementlabel, other'
    inputBinding:
      position: 101
      prefix: --meta
  - id: other_args
    type:
      - 'null'
      - string
    doc: Other arguments to pass to the workflow script.
    default: None
    inputBinding:
      position: 101
      prefix: --other_args
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for images. Not required by all workflows.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: timestamp_format
    type:
      - 'null'
      - string
    doc: a date format code compatible with strptime C library, e.g. "%Y-%m-%d 
      %H_%M_%S", except "%" symbols must be escaped on Windows with "%" e.g. 
      "%%Y-%%m-%%d %%H_%%M_%%S"default format code is "%Y-%m-%d %H:%M:%S.%f"
    default: '%Y-%m-%d %H:%M:%S.%f'
    inputBinding:
      position: 101
      prefix: --timestampformat
  - id: workflow
    type: File
    doc: Workflow script file.
    inputBinding:
      position: 101
      prefix: --workflow
  - id: write_images
    type:
      - 'null'
      - boolean
    doc: Include analysis images in output.
    default: false
    inputBinding:
      position: 101
      prefix: --writeimg
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plantcv:3.8.0--py_0
stdout: plantcv_plantcv-workflow.py.out
