cwlVersion: v1.2
class: CommandLineTool
baseCommand: vk
label: vcfkit_vk
doc: "A toolkit for variant calling and analysis.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., calc, call, filter, etc.)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk.out
