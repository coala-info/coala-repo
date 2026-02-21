cwlVersion: v1.2
class: CommandLineTool
baseCommand: aevol_micro_aevol_gpu
label: aevol_micro_aevol_gpu
doc: "Aevol is a digital genetics platform. (Note: The provided text contains system
  error logs regarding a container build failure and does not include the tool's help
  documentation or usage instructions.)\n\nTool homepage: https://github.com/otouat/micro-aevol2-hypervitesse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aevol:v5.0-2b1-deb_cv1
stdout: aevol_micro_aevol_gpu.out
