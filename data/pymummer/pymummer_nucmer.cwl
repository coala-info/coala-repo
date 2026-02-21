cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymummer_nucmer
label: pymummer_nucmer
doc: "A wrapper for the nucmer alignment tool within the pymummer package.\n\nTool
  homepage: https://github.com/sanger-pathogens/pymummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_nucmer.out
