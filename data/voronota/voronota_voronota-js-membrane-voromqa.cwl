cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota-js-membrane-voromqa
label: voronota_voronota-js-membrane-voromqa
doc: "Voronota-JS membrane VoroMQA (Note: The provided text contains container runtime
  logs and error messages rather than tool help text; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_voronota-js-membrane-voromqa.out
