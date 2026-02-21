cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss
label: abyss
doc: "A de novo, parallel, paired-end sequence assembler\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss.out
