cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - long_fastx
label: pomoxis_long_fastx
doc: "Extract the longest reads from a fastq.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: input
    type: File
    doc: Input .fasta/q file.
    inputBinding:
      position: 1
  - id: output
    type: string
    default: longest.fasta
    doc: Output .fasta file.
    inputBinding:
      position: 2
  - id: longest
    type:
      - 'null'
      - float
    doc: Percentage of longest reads to partition. Give either --longest or --bases.
    inputBinding:
      position: 102
      prefix: --longest
  - id: bases
    type:
      - 'null'
      - long
    doc: Maximum number of bases (subject to at least one read). Give either --longest or --bases.
    inputBinding:
      position: 102
      prefix: --bases
  - id: others
    type:
      - 'null'
      - string
    doc: Write all other reads to this file.
    inputBinding:
      position: 102
      prefix: --others
outputs:
  - id: longest_reads
    type: File
    doc: Longest reads in fasta format.
    outputBinding:
      glob: $(inputs.output)
  - id: other_reads
    type:
      - 'null'
      - File
    doc: The remaining reads.
    outputBinding:
      glob: $(inputs.others)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
