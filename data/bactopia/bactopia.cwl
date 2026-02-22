cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia
label: bactopia
doc: "Bactopia is a flexible pipeline for complete analysis of bacterial genomes.
  (Note: The provided text contains system error messages and does not include help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/bactopia/bactopia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
stdout: bactopia.out
