cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota-js-global-cadscore
label: voronota_voronota-js-global-cadscore
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure.\n\nTool homepage: https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_voronota-js-global-cadscore.out
