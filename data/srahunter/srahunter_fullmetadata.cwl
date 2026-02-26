cwlVersion: v1.2
class: CommandLineTool
baseCommand: srahunter fullmetadata
label: srahunter_fullmetadata
doc: "Accession list from SRA (file path)\n\nTool homepage: https://github.com/GitEnricoNeko/srahunter"
inputs:
  - id: list
    type: File
    doc: Accession list from SRA (file path)
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
stdout: srahunter_fullmetadata.out
