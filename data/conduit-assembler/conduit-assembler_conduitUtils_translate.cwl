cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - translate
label: conduit-assembler_conduitUtils_translate
doc: "Translates FASTA/Q nucleotide sequences into protein based on their longest ORF\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "FASTA/Q infile containing putative transcripts to be translated"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "FASTA outfile containing in silico translated ORFs from the transcripts"
    default: "predicted_protein.fa"
    inputBinding:
      position: 1
      prefix: -o
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Input file is in FASTA format (default)"
    inputBinding:
      position: 1
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Input file is in FASTQ format"
    inputBinding:
      position: 1
      prefix: --fastq
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: "Input reads are forward stranded"
    inputBinding:
      position: 1
      prefix: --stranded
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length in Amino Acids necessary for a putative ORF to be reported (default 75)"
    inputBinding:
      position: 1
      prefix: --min-length
outputs:
  - id: proteins
    type: File
    doc: "in silico translated ORFs (FASTA)"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_translate.out
