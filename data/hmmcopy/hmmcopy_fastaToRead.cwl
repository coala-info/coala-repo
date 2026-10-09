cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaToRead
label: hmmcopy_fastaToRead
doc: "Cut a FASTA reference into overlapping reads (FASTA) written to standard output, for example to pipe into bowtie.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: fasta_reference
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "FASTA reference"
    inputBinding:
      position: 2
  - id: window
    type:
      - 'null'
      - int
    doc: "Specify the size of the overlapping reads [1000]"
    inputBinding:
      position: 1
      prefix: --window
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List all chromosomes in FASTA reference file"
    inputBinding:
      position: 1
      prefix: --list
  - id: sequence
    type:
      - 'null'
      - string
    doc: "Specify the entries and order of sequences to analyze [ALL], a comma-delimited list (no spaces)"
    inputBinding:
      position: 1
      prefix: --sequence
outputs:
  - id: reads
    type: stdout
    doc: Reads cut from the reference
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_fastaToRead.out
