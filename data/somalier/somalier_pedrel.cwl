cwlVersion: v1.2
class: CommandLineTool
baseCommand: somalier_pedrel
label: somalier_pedrel
doc: "report pairwise relationships from pedigree file\n\nTool homepage: https://github.com/brentp/somalier"
inputs:
  - id: pedfile
    type: File
    doc: pedigry (fam) file path
    inputBinding:
      position: 1
  - id: min_relatedness
    type:
      - 'null'
      - float
    doc: minimum relatedness to report
    default: 0.01
    inputBinding:
      position: 102
      prefix: --min-relatedness
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
