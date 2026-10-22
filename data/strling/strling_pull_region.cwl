cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strling
  - pull_region
label: strling_pull_region
doc: "Extracts a region from a BAM file.\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
  - id: region
    type: string
    doc: Region to extract (e.g., chr1:1000-2000)
    inputBinding:
      position: 102
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to fasta file, only required for cram
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 1
      prefix: --fasta
  - id: output_bam_path
    type:
      - 'null'
      - string
    doc: path to output bam (default extracted.bam)
    inputBinding:
      position: 1
      prefix: --output-bam
outputs:
  - id: output_bam
    type: File
    doc: path to output bam
    outputBinding:
      glob: $(inputs.output_bam_path || 'extracted.bam')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
