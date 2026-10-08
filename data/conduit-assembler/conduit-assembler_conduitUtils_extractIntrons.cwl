cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - extractIntrons
label: conduit-assembler_conduitUtils_extractIntrons
doc: "Extracts out intronic sequences from BED12 formatted input and outputs as BED6\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "Transcripts in BED12 format to extract introns from"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "BED6 output of extracted introns"
    default: "introns.bed"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: introns
    type: File
    doc: "BED6 introns"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_extractIntrons.out
