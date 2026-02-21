cwlVersion: v1.2
class: CommandLineTool
baseCommand: pash
label: pash
doc: "Parallel Shell (PaSh). Note: The provided text is a system error log indicating
  the executable was not found and does not contain usage instructions or argument
  definitions.\n\nTool homepage: https://github.com/binpash/pash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pash:3.0.6.2--0
stdout: pash.out
