cwlVersion: v1.2
class: CommandLineTool
baseCommand: adptSim
label: gargammel_adptSim
doc: "A tool within the gargammel package (likely for adapter simulation), however,
  the provided text contains only system error messages and no help documentation.\n
  \nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel:1.1.4--hb66fcc3_0
stdout: gargammel_adptSim.out
