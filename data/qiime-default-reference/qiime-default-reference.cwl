cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiime-default-reference
label: qiime-default-reference
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system logs and a fatal error message related to a container
  build process.\n\nTool homepage: https://github.com/biocore/qiime-default-reference"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qiime-default-reference:0.1.3--py36_0
stdout: qiime-default-reference.out
