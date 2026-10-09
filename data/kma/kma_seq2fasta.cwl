cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - seq2fasta
label: kma_seq2fasta
doc: "kma seq2fasta prints the fasta sequence of a given kma index to stdout.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
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
  - id: seqs
    type: ['null', string]
    doc: "Comma separated list of template numbers, counted from 1 (default: print the entire index)"
    inputBinding:
      position: 2
      prefix: -seqs
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
stdout: kma_seq2fasta.fasta
