cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcCounter
label: hmmcopy_gcCounter
doc: "Calculate the GC content of non-overlapping windows of a FASTA reference and write it in WIG (or SEG) format to standard output.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: fasta_reference
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "FASTA reference"
    inputBinding:
      position: 2
  - id: seg
    type:
      - 'null'
      - boolean
    doc: "Outputs in SEG format"
    inputBinding:
      position: 1
      prefix: --seg
  - id: window
    type:
      - 'null'
      - int
    doc: "Specify the size of non-overlapping windows [1000]"
    inputBinding:
      position: 1
      prefix: --window
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List all chromosomes in the input file"
    inputBinding:
      position: 1
      prefix: --list
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Specify the entries and order of sequences to analyze [ALL], a comma-delimited list (no spaces)"
    inputBinding:
      position: 1
      prefix: --chromosome
outputs:
  - id: gc_wig
    type: stdout
    doc: GC content per window (WIG, or SEG with --seg)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_gcCounter.wig
