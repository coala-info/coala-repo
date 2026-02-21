cwlVersion: v1.2
class: CommandLineTool
baseCommand: celltypist
label: celltypist
doc: "CellTypist is a tool for semi-automatic cell type annotation (Note: The provided
  text is a container execution error log and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/Teichlab/celltypist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/celltypist:1.7.1--pyhdfd78af_0
stdout: celltypist.out
