cwlVersion: v1.2
class: CommandLineTool
baseCommand: FEELnc_classifier.pl
label: feelnc_FEELnc_classifier.pl
doc: "Classifies lncRNAs based on their genomic context and overlap with protein-coding
  genes.\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs:
  - id: biotype
    type:
      - 'null'
      - boolean
    doc: Print the biotype of each transcripts in the output
    inputBinding:
      position: 101
      prefix: --biotype
  - id: lncrna_gtf
    type: File
    doc: Specify the lncRNA GTF file
    inputBinding:
      position: 101
      prefix: --lncrna
  - id: log_file
    type:
      - 'null'
      - File
    doc: Specify the name for the log file
    inputBinding:
      position: 101
      prefix: --log
  - id: max_window
    type:
      - 'null'
      - int
    doc: Size of the window around the lncRNA to compute 
      interactions/classification
    default: 100000
    inputBinding:
      position: 101
      prefix: --maxwindow
  - id: mrna_gtf
    type: File
    doc: Specify the annotation GTF file (file of protein coding annotation)
    inputBinding:
      position: 101
      prefix: --mrna
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Level of verbosity
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: window
    type:
      - 'null'
      - int
    doc: Size of the window during the expansion process
    default: 10000
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_classifier.pl.out
