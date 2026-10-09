cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - update
label: kma_update
doc: "KMA_update synchronises kma-indexes to the needed version.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: "Files of the indexed template database (*.comp.b, *.length.b, *.name, *.seq.b, and *.index.b when present), staged in the working directory so that the prefix can name them"
  - id: template_db
    type: string
    doc: "Template DB (prefix of the staged db_files)"
    inputBinding:
      position: 1
      prefix: -t_db
  - id: version
    type: string
    doc: "[XXYY], from version major version XX to major version YY. Use minor version, if major version is 0."
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: updated_db_files
    type:
      type: array
      items: File
    doc: "Updated database files"
    outputBinding:
      glob: $(inputs.template_db).*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_update.txt
