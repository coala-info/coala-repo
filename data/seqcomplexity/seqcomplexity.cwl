cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqcomplexity
label: seqcomplexity
doc: "A tool for calculating sequence complexity (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/stevenweaver/seqcomplexity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqcomplexity:0.1.2--he734ae2_2
stdout: seqcomplexity.out
