cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_BamStats01
label: jvarkit_BamStats01
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_BamStats01.out
