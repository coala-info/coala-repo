cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling_pull_region
label: strling_pull_region
doc: "Extracts a region from a BAM file.\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: region
    type: string
    doc: Region to extract (e.g., chr1:1000-2000)
    inputBinding:
      position: 2
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to fasta file, only required for cram
    inputBinding:
      position: 103
      prefix: --fasta
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: path to output bam
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
