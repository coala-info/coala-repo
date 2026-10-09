cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - merge
label: kma_merge
doc: "kma merge merges two indexed kma databases.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: "Files of the indexed template database (*.comp.b, *.length.b, *.name, *.seq.b, and *.index.b when present), staged in the working directory so that the prefix can name them (both databases)"
  - id: output_prefix
    type: string
    doc: "Output prefix"
    inputBinding:
      position: 1
      prefix: -o
  - id: template_db
    type: string
    doc: "Add to DB (prefix of the staged db_files)"
    inputBinding:
      position: 1
      prefix: -t_db
  - id: second_db
    type: string
    doc: "DB to merge (prefix of the staged db_files)"
    inputBinding:
      position: 1
      prefix: -s_db
  - id: temp_dir
    type: ['null', string]
    doc: "Set directory for temporary files"
    inputBinding:
      position: 2
      prefix: -tmp
outputs:
  - id: db_files_out
    type:
      type: array
      items: File
    doc: "Merged database files"
    outputBinding:
      glob: $(inputs.output_prefix).*
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
stdout: kma_merge.txt
