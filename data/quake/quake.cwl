cwlVersion: v1.2
class: CommandLineTool
baseCommand: quake
label: quake
doc: "A tool for correcting substitution errors in next-generation sequencing data
  (Note: The provided text contains only container build logs and error messages,
  no usage information was found).\n\nTool homepage: https://github.com/id-Software/Quake-III-Arena"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quake:0.3.5--boost1.64_0
stdout: quake.out
