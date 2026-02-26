cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle_polish
label: rattle_polish
doc: "RATTLE Polish\n\nTool homepage: https://github.com/comprna/RATTLE"
inputs:
  - id: input_file
    type: File
    doc: input RATTLE consensi fasta/fastq file (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: label
    type:
      - 'null'
      - string
    doc: labels for the files in order of entry
    inputBinding:
      position: 101
      prefix: --label
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder for fastx files (default: .)'
    default: .
    inputBinding:
      position: 101
      prefix: --output-folder
  - id: rna
    type:
      - 'null'
      - boolean
    doc: use this mode if data is direct RNA (disables checking both strands)
    inputBinding:
      position: 101
      prefix: --rna
  - id: summary
    type:
      - 'null'
      - boolean
    doc: use this flag to print a summary of transcript/gene clusters used to 
      genearte the transcriptome
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: use this flag if need to print the progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle_polish.out
