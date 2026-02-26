cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_utest
label: transit_utest
doc: "Performs differential analysis of transcription-associated sequencing data.\n\
  \nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: control_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig control files
    inputBinding:
      position: 1
  - id: experimental_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig experimental files
    inputBinding:
      position: 2
  - id: annotation_file
    type: File
    doc: Annotation .prot_table or GFF3 file
    inputBinding:
      position: 3
  - id: ignore_c_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given fraction (as integer) of the C terminus
    default: 0.0
    inputBinding:
      position: 104
      prefix: -iC
  - id: ignore_n_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given fraction (as integer) of the N terminus
    default: 0.0
    inputBinding:
      position: 104
      prefix: -iN
  - id: include_zero_rows
    type:
      - 'null'
      - boolean
    doc: Include rows with zero accross conditions
    inputBinding:
      position: 104
      prefix: -iz
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method
    default: TTR
    inputBinding:
      position: 104
      prefix: -n
  - id: perform_loess_correction
    type:
      - 'null'
      - boolean
    doc: Perform LOESS Correction; Helps remove possible genomic position bias
    default: false
    inputBinding:
      position: 104
      prefix: -l
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
