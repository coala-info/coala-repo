cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_caller
label: genometester4_gmer_caller
doc: "A tool from the GenomeTester4 package (Note: The provided help text contains
  only system error messages regarding container execution and does not list command-line
  arguments).\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--h7b50bb2_7
stdout: genometester4_gmer_caller.out
