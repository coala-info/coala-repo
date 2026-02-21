cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota-lt
label: voronota_voronota-lt
doc: "Voronota-LT is a version of Voronota for fast processing of macromolecular structures
  using the Voronoi-Delaunay tessellation.\n\nTool homepage: https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_voronota-lt.out
