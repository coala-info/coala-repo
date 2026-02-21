cwlVersion: v1.2
class: CommandLineTool
baseCommand: strangepg
label: strangepg
doc: "The provided text does not contain help information or usage instructions; it
  appears to be an error log from a container build process.\n\nTool homepage: https://github.com/qwx9/strangepg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strangepg:0.9.4--h0ac75b0_0
stdout: strangepg.out
