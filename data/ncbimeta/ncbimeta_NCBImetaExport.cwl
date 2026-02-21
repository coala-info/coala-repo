cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbimeta_NCBImetaExport
label: ncbimeta_NCBImetaExport
doc: "Export NCBImeta database to various formats. (Note: The provided text contains
  system error messages regarding container execution and does not include the standard
  help documentation or argument list.)\n\nTool homepage: https://github.com/ktmeaton/NCBImeta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbimeta:0.8.3--pyhdfd78af_0
stdout: ncbimeta_NCBImetaExport.out
