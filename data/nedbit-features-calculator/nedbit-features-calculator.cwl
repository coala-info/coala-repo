cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator
label: nedbit-features-calculator
doc: "Calculate NeDBIT (network diffusion and biology-informed topological) features
  from a file of network links and a gene file, and write them to an output file.\n\nTool
  homepage: https://github.com/AndMastro/NIAPU"
inputs:
  - id: filelink
    type: File
    doc: Input file of links (one link per line, as two gene numbers, made by preprocess.pl)
    inputBinding:
      position: 1
  - id: filegene
    type: File
    doc: Input gene file (one gene per line, as number, name and score, made by preprocess.pl)
    inputBinding:
      position: 2
  - id: fileout
    type: string
    doc: Output file name
    inputBinding:
      position: 3
outputs:
  - id: output_features
    type: File
    doc: Output file with the NeDBIT features
    outputBinding:
      glob: $(inputs.fileout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h031d066_0
