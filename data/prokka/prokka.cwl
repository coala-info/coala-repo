cwlVersion: v1.2
class: CommandLineTool
baseCommand: prokka
label: prokka
doc: "Rapid prokaryotic genome annotation\n\nTool homepage: https://github.com/tseemann/prokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prokka:1.15.6--pl5321hdfd78af_0
stdout: prokka.out
