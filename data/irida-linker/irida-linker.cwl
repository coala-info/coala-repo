cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-linker
label: irida-linker
doc: "The provided text contains system error logs and container runtime information
  rather than the tool's help documentation. As a result, no specific arguments or
  descriptions could be extracted.\n\nTool homepage: https://github.com/phac-nml/irida-linker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-linker:1.1.1--hdfd78af_2
stdout: irida-linker.out
