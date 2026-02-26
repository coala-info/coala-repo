cwlVersion: v1.2
class: CommandLineTool
baseCommand: kingfisher
label: kingfisher_compressed
doc: "kingfisher: error: argument subparser_name: invalid choice: 'compressed' (choose
  from 'get', 'extract', 'annotate')\n\nTool homepage: https://github.com/wwood/kingfisher-download"
inputs:
  - id: subparser_name
    type: string
    doc: Choose from 'get', 'extract', 'annotate'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
stdout: kingfisher_compressed.out
