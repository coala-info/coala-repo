cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota-js-voromqa
label: voronota_voronota-js-voromqa
doc: "Voronota-JS VoroMQA (Note: The provided text is a container execution error
  log and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_voronota-js-voromqa.out
