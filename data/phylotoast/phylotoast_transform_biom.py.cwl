cwlVersion: v1.2
class: CommandLineTool
baseCommand: transform_biom.py
label: phylotoast_transform_biom.py
doc: "This script applies varioustransforms to the data in a given BIOM-format table\n\
  and outputs a newBIOM table with the transformed data.\n\nTool homepage: https://github.com/smdabdoub/phylotoast"
inputs:
  - id: biom_table_fp
    type: File
    doc: Path to the input BIOM-format table.
    inputBinding:
      position: 101
      prefix: --biom_table_fp
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Compress the output BIOM table with gzip. HDF5 BIOM\n(v2.x) files are internally
      compressed by default, so\nthis option is not needed when specifying --fmt hdf5."
    inputBinding:
      position: 101
      prefix: --gzip
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Set the output format of the BIOM table. Default is\nHDF5."
    inputBinding:
      position: 101
      prefix: --fmt
  - id: transform
    type:
      - 'null'
      - string
    doc: "The transform to apply to the data. Default: arcsine\nsquare root."
    inputBinding:
      position: 101
      prefix: --transform
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_fp
    type: File
    doc: Output path for the transformed BIOM table.
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
