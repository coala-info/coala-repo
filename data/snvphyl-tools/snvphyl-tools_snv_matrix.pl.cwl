cwlVersion: v1.2
class: CommandLineTool
baseCommand: snv_matrix.pl
label: snvphyl-tools_snv_matrix.pl
doc: "Constructs a snv matrix from the snv_alignment file of the pipeline\n\nTool
  homepage: https://github.com/phac-nml/snvphyl-tools"
inputs:
  - id: snv_align_phy
    type:
      - 'null'
      - File
    doc: snv_align.phy
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more information (to stderr)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Prints matrix to passed file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9
