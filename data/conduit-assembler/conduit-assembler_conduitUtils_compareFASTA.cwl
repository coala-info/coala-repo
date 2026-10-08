cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - compareFASTA
label: conduit-assembler_conduitUtils_compareFASTA
doc: "Compares two FASTA files, an input and a reference, to determine the # of true positives, false positives, and false negatives for a sample\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: reference
    type: File
    doc: "Reference FASTA file defining the truth set"
    inputBinding:
      position: 1
      prefix: -r
  - id: infile
    type: File
    doc: "Query FASTA files defining the query set"
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
stdout: conduit-assembler_conduitUtils_compareFASTA.out
