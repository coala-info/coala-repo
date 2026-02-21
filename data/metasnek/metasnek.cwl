cwlVersion: v1.2
class: CommandLineTool
baseCommand: metasnek
label: metasnek
doc: "A tool for metagenomic pipeline generation (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/beardymcjohnface/metasnek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasnek:0.0.8--pyhdfd78af_0
stdout: metasnek.out
