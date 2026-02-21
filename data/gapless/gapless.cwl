cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapless
label: gapless
doc: "A tool for closing gaps in genome assemblies (Note: The provided text contains
  only container runtime error messages and no help documentation. No arguments could
  be extracted.)\n\nTool homepage: https://github.com/schmeing/gapless"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
stdout: gapless.out
