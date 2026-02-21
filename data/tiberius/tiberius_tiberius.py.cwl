cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiberius_tiberius.py
label: tiberius_tiberius.py
doc: "Tiberius: A deep learning-based tool for eukaryotic gene prediction.\n\nTool
  homepage: https://github.com/Gaius-Augustus/Tiberius"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiberius:1.1.8--pyhdfd78af_0
stdout: tiberius_tiberius.py.out
