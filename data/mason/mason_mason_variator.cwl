cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_mason_variator
label: mason_mason_variator
doc: "Mason Variator is a tool for simulating genomic variations (SNVs, indels, etc.)
  and producing a modified reference genome along with a VCF file. (Note: The provided
  help text contained only system error messages regarding container execution and
  did not list specific CLI arguments.)\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.12--haf24da9_1
stdout: mason_mason_variator.out
