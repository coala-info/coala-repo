cwlVersion: v1.2
class: CommandLineTool
baseCommand: conipher
label: conipher
doc: "CONIPHER (Clonal Origin and Non-negative Iterative PHylogenetic Reconstruction)
  is a tool for tumor phylogenetic reconstruction. Note: The provided text contains
  system error messages regarding container execution and does not include the tool's
  help documentation or argument list.\n\nTool homepage: https://github.com/McGranahanLab/CONIPHER/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conipher:2.2.0--r40hdfd78af_0
stdout: conipher.out
