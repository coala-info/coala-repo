cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - splitFASTA
label: conduit-assembler_conduitUtils_splitFASTA
doc: "Splits CONDUIT produced FASTA file based on the number of reads supporting each isoform (bins 1, 2-4, 5-9, 10-19, 20-39, 40-79, 80-159, 160-319, 320-639, 640+)\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "CONDUIT produced FASTA file to be split based on number of reads supporting each isoform"
    inputBinding:
      position: 1
      prefix: -i
  - id: outprefix
    type: string
    doc: "Prefix for the fasta files to be output, suffix will describe the bin being reported"
    default: "split"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: split_fastas
    type: File[]
    doc: "one FASTA file per read-support bin (<outprefix>_<bin>.fa)"
    outputBinding:
      glob: $(inputs.outprefix)_*.fa
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_splitFASTA.out
