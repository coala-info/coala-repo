cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - cmp
label: kma_cmp
doc: "kma cmp compare two indexed kma databases.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: "Files of the indexed template database (*.comp.b, *.length.b, *.name, *.seq.b, and *.index.b when present), staged in the working directory so that the prefix can name them (both databases)"
  - id: template_db
    type: string
    doc: "DB to compare to (prefix of the staged db_files)"
    inputBinding:
      position: 1
      prefix: -t_db
  - id: second_db
    type: string
    doc: "DB to compare with (prefix of the staged db_files)"
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
  - id: comparison
    type: stderr
    doc: Comparison report (kma cmp writes it to standard error)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stderr: kma_cmp.txt
