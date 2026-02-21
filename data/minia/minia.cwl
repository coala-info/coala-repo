cwlVersion: v1.2
class: CommandLineTool
baseCommand: minia
label: minia
doc: "A short-read assembler based on a de Bruijn graph (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/GATB/minia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minia:3.2.6--h22625ea_5
stdout: minia.out
