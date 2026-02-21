cwlVersion: v1.2
class: CommandLineTool
baseCommand: snvphyl-tools_snv_matrix.pl
label: snvphyl-tools_snv_matrix.pl
doc: "The provided text contains container execution errors and does not include usage
  information or a description of the tool's functionality.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9
stdout: snvphyl-tools_snv_matrix.pl.out
