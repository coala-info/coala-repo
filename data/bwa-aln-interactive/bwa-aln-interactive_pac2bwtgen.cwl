cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwtgen
label: bwa-aln-interactive_pac2bwtgen
doc: "Generate a BWT (Burrows-Wheeler Transform) from a PAC file.\n\nTool homepage:
  https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: input_pac
    type: File
    doc: Input PAC file
    inputBinding:
      position: 1
outputs:
  - id: output_bwt
    type: File
    doc: Output BWT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
