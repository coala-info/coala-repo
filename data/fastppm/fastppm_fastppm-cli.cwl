cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastppm
label: fastppm_fastppm-cli
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding disk space
  during a container build process.\n\nTool homepage: https://github.com/elkebir-group/fastppm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastppm:1.1.1--py39h2de1943_0
stdout: fastppm_fastppm-cli.out
