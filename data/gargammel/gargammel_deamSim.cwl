cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deamSim
label: gargammel_deamSim
doc: "A tool for simulating deamination in ancient DNA sequences. (Note: The provided
  help text contained only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel:1.1.4--hb66fcc3_0
stdout: gargammel_deamSim.out
