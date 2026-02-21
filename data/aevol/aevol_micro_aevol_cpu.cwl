cwlVersion: v1.2
class: CommandLineTool
baseCommand: aevol_micro_aevol_cpu
label: aevol_micro_aevol_cpu
doc: "Aevol is a digital genetics platform where populations of digital organisms
  are let to evolve under different conditions.\n\nTool homepage: https://github.com/otouat/micro-aevol2-hypervitesse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aevol:v5.0-2b1-deb_cv1
stdout: aevol_micro_aevol_cpu.out
