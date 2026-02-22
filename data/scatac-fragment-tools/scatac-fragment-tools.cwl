cwlVersion: v1.2
class: CommandLineTool
baseCommand: scatac-fragment-tools
label: scatac-fragment-tools
doc: "A tool for processing ATAC-seq fragment files. (Note: The provided text contains
  system error messages rather than help documentation, so specific arguments could
  not be parsed.)\n\nTool homepage: https://github.com/aertslab/scatac_fragment_tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/scatac-fragment-tools:0.1.4--py39hf1f7959_0
stdout: scatac-fragment-tools.out
