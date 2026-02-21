cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota
label: voronota
doc: "Voronota is a tool for the analysis of macromolecular structures. (Note: The
  provided text contains container build logs and error messages rather than the tool's
  help documentation, so no arguments could be extracted.)\n\nTool homepage: https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota.out
