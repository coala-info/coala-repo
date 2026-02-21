cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_date
label: mercat_date
doc: "A tool for k-mer counting and diversity analysis (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_date.out
