cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - split_fastx
label: pomoxis_split_fastx
doc: "Split records in a fasta/q file into chunks of a maximum size.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: input
    type: File
    doc: Input fasta/q file.
    inputBinding:
      position: 1
  - id: output
    type: string
    default: split.fasta
    doc: Output fasta/q file.
    inputBinding:
      position: 2
  - id: chunksize
    type: int
    doc: Maximum size of output sequences.
    inputBinding:
      position: 3
outputs:
  - id: split_reads
    type: File
    doc: Split sequences.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
