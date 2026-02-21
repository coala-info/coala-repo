cwlVersion: v1.2
class: CommandLineTool
baseCommand: leeHom
label: leehom_leeHomMulti
doc: "The provided text is a system error log and does not contain help information
  or usage instructions for the tool.\n\nTool homepage: https://grenaud.github.io/leeHom/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leehom:1.2.15--hdc46a4b_6
stdout: leehom_leeHomMulti.out
