cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwt2sa
label: bwa-aln-interactive_bwt2sa
doc: "Generate suffix array (SA) from BWT\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: input_bwt
    type: File
    doc: Input BWT file
    inputBinding:
      position: 1
  - id: interval
    type:
      - 'null'
      - int
    doc: Sampling interval
    default: 32
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_sa
    type: File
    doc: Output suffix array file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
