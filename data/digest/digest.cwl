cwlVersion: v1.2
class: CommandLineTool
baseCommand: digest
label: digest
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container image building.\n
  \nTool homepage: https://github.com/VeryAmazed/digest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/digest:0.3.0--py312hf731ba3_0
stdout: digest.out
