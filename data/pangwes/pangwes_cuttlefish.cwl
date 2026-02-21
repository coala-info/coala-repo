cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cuttlefish
  - build
label: pangwes_cuttlefish
doc: "Cuttlefish is a tool for building the compacted de Bruijn graph from sequencing
  reads or genomes.\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
stdout: pangwes_cuttlefish.out
