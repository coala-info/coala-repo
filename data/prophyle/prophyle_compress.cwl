cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle compress
label: prophyle_compress
doc: "Compresses a prophyle index directory into a tar.gz archive.\n\nTool homepage:
  https://github.com/karel-brinda/prophyle"
inputs:
  - id: index_dir
    type: Directory
    doc: index directory
    inputBinding:
      position: 1
  - id: advanced_configuration
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: archive_tar_gz
    type:
      - 'null'
      - File
    doc: output archive [<index.dir>.tar.gz]
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
