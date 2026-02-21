cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvkit
label: cnvkit
doc: "The provided text does not contain help information or usage instructions for
  cnvkit. It contains system log messages and a fatal error regarding container image
  acquisition (no space left on device).\n\nTool homepage: https://github.com/etal/cnvkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
stdout: cnvkit.out
