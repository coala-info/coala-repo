cwlVersion: v1.2
class: CommandLineTool
baseCommand: vk
label: vcfkit_vk
doc: "The provided text does not contain help information for vcfkit_vk; it contains
  container runtime error logs.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk.out
