cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtea
label: xtea
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/parklab/xTea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtea:0.1.9--hdfd78af_0
stdout: xtea.out
