cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-remultiplex
label: metaplex_Metaplex-remultiplex
doc: "Remultiplexes a BAM file.\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs:
  - id: input_bam
    type: File
    doc: Path to the input BAM file.
    inputBinding:
      position: 1
outputs:
  - id: output_bam
    type: File
    doc: Path to the output BAM file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
