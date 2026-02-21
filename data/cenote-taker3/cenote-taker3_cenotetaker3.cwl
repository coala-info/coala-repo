cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenote-taker3
label: cenote-taker3_cenotetaker3
doc: "Cenote-Taker3 (Help text not provided in input)\n\nTool homepage: https://github.com/mtisza1/Cenote-Taker3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenote-taker3:3.4.3--pyhdfd78af_0
stdout: cenote-taker3_cenotetaker3.out
