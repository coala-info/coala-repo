cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-k128
label: abyss-k128
doc: "A de novo, parallel, paired-end sequence assembler (Note: The provided help
  text contains only system logs and an error message regarding a failed container
  build; no specific command-line arguments were found in the input).\n\nTool homepage:
  http://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2
stdout: abyss-k128.out
