cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcm2niix
label: dcm2niix
doc: "DICOM to NIfTI converter\n\nTool homepage: https://github.com/rordenlab/dcm2niix"
inputs:
  - id: input_directory
    type: Directory
    doc: Folder containing DICOM files
    inputBinding:
      position: 1
  - id: adjacent_dicoms
    type:
      - 'null'
      - string
    doc: Adjacent DICOMs (y/n, default n)
    default: n
    inputBinding:
      position: 102
      prefix: -a
  - id: bids_sidecar
    type:
      - 'null'
      - string
    doc: 'BIDS sidecar (y/n/o [only: no NIfTI], default y)'
    default: y
    inputBinding:
      position: 102
      prefix: -b
  - id: compression_level
    type:
      - 'null'
      - int
    doc: GZ compression level (1=fastest, 9=smallest, default 6)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: filename
    type:
      - 'null'
      - string
    doc: Filename format (e.g. %p=protocol, %t=time)
    default: '%f_%p_%t_%s'
    inputBinding:
      position: 102
      prefix: -f
  - id: gz_compress
    type:
      - 'null'
      - string
    doc: GZ compress images (y/n/i [i=internal], default n)
    default: n
    inputBinding:
      position: 102
      prefix: -z
  - id: merge_2d
    type:
      - 'null'
      - string
    doc: Merge 2D slices from same series (y/n, default n)
    default: n
    inputBinding:
      position: 102
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory (log default is input directory)
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dcm2niix:v1.0.20181125-1-deb_cv1
