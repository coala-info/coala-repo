cwlVersion: v1.2
class: CommandLineTool
baseCommand: imsindel
label: imsindel
doc: "A tool for detecting intermediate-size insertions and deletions (Note: The provided
  text is a container execution error log and does not contain help or usage information).\n
  \nTool homepage: https://github.com/NCGG-MGC/IMSindel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imsindel:1.0.2--hdfd78af_1
stdout: imsindel.out
