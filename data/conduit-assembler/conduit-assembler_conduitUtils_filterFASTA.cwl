cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - filterFASTA
label: conduit-assembler_conduitUtils_filterFASTA
doc: "Filters CONDUIT produced FASTA file based on number of reads supporting each isoform. The documented -n option is not parsed by version 0.1.2 (it stops with 'unknown option'), so it is not wrapped; the minimum is fixed at 5 reads.\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "CONDUIT produced FASTA file to be filtered based on number of reads supporting each isoform"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "Output FASTA file for filtered reads"
    default: "filtered.fa"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: filtered
    type: File
    doc: "isoforms supported by at least 5 reads (FASTA)"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_filterFASTA.out
