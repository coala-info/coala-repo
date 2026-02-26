cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame_counts
label: phlame_counts
doc: "Calculate phlame counts from BAM file.\n\nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: input_bam
    type: File
    doc: Path to input bam file (required).
    inputBinding:
      position: 101
      prefix: -i
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Path to reference genome.
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_counts
    type: File
    doc: Path to output counts file.
    outputBinding:
      glob: $(inputs.output_counts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
