cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - compareBLASTP
label: conduit-assembler_conduitUtils_compareBLASTP
doc: "Compares BLASTP output and reference proteome to determine the # of true positives, false positives, and false negatives for a sample\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: reference
    type: File
    doc: "FASTA file describing the reference proteome used in the BLASTP search"
    inputBinding:
      position: 1
      prefix: -r
  - id: infile
    type: File
    doc: "Default output of BLASTP search of translated protein products vs some reference proteome"
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: "TP, FP, FN, precision and recall"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_compareBLASTP.out
