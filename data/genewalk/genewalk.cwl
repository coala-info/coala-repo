cwlVersion: v1.2
class: CommandLineTool
baseCommand: genewalk
label: genewalk
doc: "GeneWalk: identifying relevant genes in biological networks (Note: The provided
  help text only contained container runtime error messages and no CLI usage information).\n
  \nTool homepage: https://github.com/churchmanlab/genewalk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genewalk:1.6.3--pyh7e72e81_0
stdout: genewalk.out
