cwlVersion: v1.2
class: CommandLineTool
baseCommand: aevol
label: aevol
doc: "Aevol is a digital genetics platform for simulating the evolution of populations
  of digital organisms.\n\nTool homepage: https://github.com/otouat/micro-aevol2-hypervitesse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aevol:v5.0-2b1-deb_cv1
stdout: aevol.out
