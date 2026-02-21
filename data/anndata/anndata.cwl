cwlVersion: v1.2
class: CommandLineTool
baseCommand: anndata
label: anndata
doc: "The provided text does not contain help information for the tool 'anndata'.
  It appears to be a system error log indicating that the executable was not found
  in the environment.\n\nTool homepage: http://github.com/theislab/anndata"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anndata:0.6.22.post1--py_0
stdout: anndata.out
