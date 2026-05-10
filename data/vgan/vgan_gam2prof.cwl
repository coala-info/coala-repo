cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgan
  - gam2prof
label: vgan_gam2prof
doc: "Convert gam file to profile file.\n\nTool homepage: https://github.com/grenaud/vgan"
inputs:
  - id: input_gam_file
    type: File
    doc: Input gam file
    inputBinding:
      position: 101
      prefix: -g
  - id: substitution_matrix_length
    type:
      - 'null'
      - int
    doc: Set length for substitution matrix
    inputBinding:
      position: 101
      prefix: -l
  - id: output_prof_file_path
    type: string
    doc: Output or path parameter `output_prof_file_path`
    inputBinding:
      position: 102
      prefix: --output-prof-file
outputs:
  - id: output_prof_file
    type:
      - 'null'
      - File
    doc: Path for output prof-file
    outputBinding:
      glob: $(inputs.output_prof_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
