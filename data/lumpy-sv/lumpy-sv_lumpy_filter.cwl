cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy_filter
label: lumpy-sv_lumpy_filter
doc: "Extract split-read and discordant-pair alignments from a BAM file for LUMPY.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs:
  - id: reference
    type:
      - 'null'
      - File
    doc: Optional reference FASTA (for CRAM input)
    inputBinding:
      position: 1
      prefix: -f
  - id: bam
    type: File
    doc: Input BAM or CRAM file
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 2
  - id: split_out
    type: string
    doc: Name of the output BAM with split-read alignments
    inputBinding:
      position: 3
  - id: discord_out
    type: string
    doc: Name of the output BAM with discordant-pair alignments
    inputBinding:
      position: 4
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 5
outputs:
  - id: split_bam
    type: File
    doc: Split-read alignments
    outputBinding:
      glob: $(inputs.split_out)
  - id: discordant_bam
    type: File
    doc: Discordant-pair alignments
    outputBinding:
      glob: $(inputs.discord_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
