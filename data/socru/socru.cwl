cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru
label: socru
doc: "A tool for characterizing large-scale genomic rearrangements (Note: The provided
  text appears to be a container execution log rather than help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru.out
