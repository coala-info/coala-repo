cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophyle
  - compress
label: prophyle_compress
doc: "Compresses a prophyle index directory into a tar.gz archive.\n\nTool homepage:
  https://github.com/karel-brinda/prophyle"
inputs:
  - id: index_dir
    type: Directory
    doc: index directory
    inputBinding:
      position: 1
  - id: archive
    type:
      - 'null'
      - string
    doc: output archive [<index.dir basename>.tar.gz in the output directory]
    inputBinding:
      position: 2
      valueFrom: "$(self ? self : inputs.index_dir.basename + '.tar.gz')"
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
    type: File
    doc: output archive
    outputBinding:
      glob: "$(inputs.archive ? inputs.archive : inputs.index_dir.basename + '.tar.gz')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
