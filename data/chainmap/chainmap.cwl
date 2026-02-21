cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainmap
label: chainmap
doc: "A tool for coordinate transformation using chain files (description not provided
  in help text).\n\nTool homepage: https://bitbucket.org/jeunice/chainmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chainmap:1.0.3--py_0
stdout: chainmap.out
