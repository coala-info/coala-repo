cwlVersion: v1.2
class: CommandLineTool
baseCommand: flip_pbat_strands.sh
label: biscuit_flip_pbat_strands.sh
doc: "Flip PBAT strands in a BAM file, optionally for a specific region.\n\nTool homepage:
  https://github.com/huishenlab/biscuit"
inputs:
  - id: in_bam
    type: File
    doc: input BAM to flip strands
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: region to flip, give as chr:start-end
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: out_bam
    type: File
    doc: output BAM to write flipped reads to
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
