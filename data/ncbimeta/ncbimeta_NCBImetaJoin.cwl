cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbimeta
  - NCBImetaJoin
label: ncbimeta_NCBImetaJoin
doc: "A tool within the NCBImeta suite for joining metadata tables. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/ktmeaton/NCBImeta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbimeta:0.8.3--pyhdfd78af_0
stdout: ncbimeta_NCBImetaJoin.out
