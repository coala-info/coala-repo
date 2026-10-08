cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - callNonCanonical
label: conduit-assembler_conduitUtils_callNonCanonical
doc: "Reads in a FASTA file and reports the readIDs of sequences that dont begin with GT and end with AG. Version 0.1.2 also demands a -r value it never reads, so the wrapper passes a placeholder.\n\nTool homepage: https://github.com/NatPRoach/conduit"
arguments:
  - position: 1
    prefix: -r
    valueFrom: unused
inputs:
  - id: infile
    type: File
    doc: "FASTA describing the stranded sequence of introns extracted from `extractIntrons` (obtained using `bedtools getfasta -name -s`)"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "Read IDs of the sequences that didn't begin with GT and end with AG"
    default: "noncanonical.txt"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: noncanonical
    type: File
    doc: "read IDs of non-canonical introns"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_callNonCanonical.out
