cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - subset-table
label: biom-format_subset_table
doc: "Subset a BIOM table, over either observations or samples, without fully parsing it.\n\
  \nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_hdf5_fp
    type:
      - 'null'
      - File
    doc: the input hdf5 BIOM table filepath to subset
    inputBinding:
      position: 101
      prefix: --input-hdf5-fp
  - id: input_json_fp
    type:
      - 'null'
      - File
    doc: the input json BIOM table filepath to subset
    inputBinding:
      position: 101
      prefix: --input-json-fp
  - id: axis
    type: string
    doc: the axis to subset over, either sample or observation
    inputBinding:
      position: 101
      prefix: --axis
  - id: ids
    type: File
    doc: a file containing a single column of IDs to retain (either sample IDs or observation
      IDs, depending on the axis)
    inputBinding:
      position: 101
      prefix: --ids
  - id: output_fp
    type: string
    doc: the output BIOM table filepath
    inputBinding:
      position: 101
      prefix: --output-fp
outputs:
  - id: output_table
    type: File
    doc: The subset BIOM table
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
