cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv-notebook
label: igv-notebook
doc: "IGV-notebook (Note: The provided text is a container execution error log and
  does not contain help information or argument definitions).\n\nTool homepage: https://github.com/igvteam/igv-notebook"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv-notebook:0.6.2--pyhdfd78af_0
stdout: igv-notebook.out
