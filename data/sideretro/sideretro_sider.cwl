cwlVersion: v1.2
class: CommandLineTool
baseCommand: sider
label: sideretro_sider
doc: "A pipeline for detecting Somatic Insertion of DE novo RETROcopies\n\nTool homepage:
  https://github.com/galantelab/sideRETRO"
inputs:
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Show citation in BibTeX
    inputBinding:
      position: 101
      prefix: --cite
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro_sider.out
