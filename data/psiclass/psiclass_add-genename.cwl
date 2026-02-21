cwlVersion: v1.2
class: CommandLineTool
baseCommand: psiclass_add-genename
label: psiclass_add-genename
doc: "Add gene names to PSI-CLASS output. (Note: The provided help text contains container
  execution errors and does not list specific arguments.)\n\nTool homepage: https://github.com/splicebox/PsiCLASS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
stdout: psiclass_add-genename.out
