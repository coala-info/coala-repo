cwlVersion: v1.2
class: CommandLineTool
baseCommand: micropita
label: micropita
doc: "MicroPITA (Microbiome Pick-In-The-Analysis) is a tool for picking samples for
  downstream processing in microbiome studies.\n\nTool homepage: http://huttenhower.sph.harvard.edu/micropita"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micropita:1.1.0--0
stdout: micropita.out
