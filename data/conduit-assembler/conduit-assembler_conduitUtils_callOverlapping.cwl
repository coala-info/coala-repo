cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - callOverlapping
label: conduit-assembler_conduitUtils_callOverlapping
doc: "Compares two files of readIDs specifying introns in the format produced by `bedtools getfasta -name`, and reports the introns that are shared between the two files (not stranded)\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: reference
    type: File
    doc: "Read IDs specifying introns in the format produced by `bedtools getfasta -name` (first file)"
    inputBinding:
      position: 1
      prefix: -r
  - id: infile
    type: File
    doc: "Read IDs specifying introns in the format produced by `bedtools getfasta -name` (second file)"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "The introns in common between the two files"
    default: "shared_introns.txt"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: shared
    type: File
    doc: "introns in common between the two files"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "counts of non-overlapping and overlapping introns"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_callOverlapping.out
