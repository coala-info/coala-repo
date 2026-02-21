cwlVersion: v1.2
class: CommandLineTool
baseCommand: magicblast
label: magicblast
doc: "Magic-BLAST is a tool for mapping next-generation RNA or DNA sequencing runs
  against a genome or transcriptome. (Note: The provided help text contains only system
  error messages and no argument definitions).\n\nTool homepage: https://ncbi.github.io/magicblast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magicblast:1.7.0--hf1761c0_0
stdout: magicblast.out
