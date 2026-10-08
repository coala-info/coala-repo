cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - parseBLASTP
label: conduit-assembler_conduitUtils_parseBLASTP
doc: "Parses BLASTP output and outputs closest match for each query transcript as determined by BLASTP\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "Default output of BLASTP search of translated protein products vs some reference proteome"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "Tab separated file of putative ortholog matches, in format: <Query ID> <Reference proteome top match ID> <E value>"
    default: "putative_orthologs.tsv"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: orthologs
    type: File
    doc: "putative ortholog matches (TSV)"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_parseBLASTP.out
