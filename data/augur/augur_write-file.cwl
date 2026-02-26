cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur write-file
label: augur_write-file
doc: "Writes data to a file.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: path
    type: File
    doc: Path to the file to write.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_write-file.out
