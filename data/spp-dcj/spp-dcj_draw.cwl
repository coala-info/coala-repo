cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj draw
label: spp-dcj_draw
doc: "Draws candidate adjacencies of the genomes in the phylogeny.\n\nTool homepage:
  https://github.com/codialab/spp-dcj"
inputs:
  - id: candidate_adjacencies
    type: string
    doc: candidate adjacencies of the genomes in the phylogeny
    inputBinding:
      position: 1
  - id: highlight
    type:
      - 'null'
      - string
    doc: highlight adjacencies in visualization
    inputBinding:
      position: 102
      prefix: --highlight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj_draw.out
