cwlVersion: v1.2
class: CommandLineTool
baseCommand: arborator
label: arborator
doc: "Arborator is a tool for phylogenetic tree analysis and processing (Note: The
  provided text contains system error logs rather than help documentation; arguments
  could not be extracted).\n\nTool homepage: https://pypi.org/project/arborator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arborator:1.2.2--pyhdfd78af_0
stdout: arborator.out
