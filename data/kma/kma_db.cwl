cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - db
label: kma_db
doc: "KMA db gives statistics on a KMA database\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_db.txt
