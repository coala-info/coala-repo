cwlVersion: v1.2
class: CommandLineTool
baseCommand: mugsy
label: mugsy
doc: "Mugsy is a system for multiple whole-genome alignment. (Note: The provided help
  text contains only system error messages and no usage information; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/margyle/MugsyDev"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mugsy:1.2.3--pl5.22.0_0
stdout: mugsy.out
