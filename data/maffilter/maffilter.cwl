cwlVersion: v1.2
class: CommandLineTool
baseCommand: maffilter
label: maffilter
doc: "MAF Filter\n\nTool homepage: https://github.com/jydu/maffilter"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.staged_files)
inputs:
  - id: option_file
    type:
      - 'null'
      - File
    doc: param=option_file
    inputBinding:
      position: 1
      prefix: param=
      separate: false
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: name=value options, for example input.file=aln.maf (one name=value per item)
    inputBinding:
      position: 2
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: files named in the option file (for example the input MAF), staged in the working directory so relative names resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - '*.log'
        - '*.csv'
        - '*.dnd'
        - '*.maf'
        - '*.fasta'
        - '*.txt'
        - '*.tsv'
    doc: files written by the filters (logs, statistics, trees, alignments)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maffilter:v1.3.1dfsg-1b1-deb_cv1
stdout: maffilter.out
