cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho_sam2pro
label: mlrho_sam2pro
doc: "A tool for Maximum Likelihood estimation of population genetic parameters (specifically
  the sam2pro utility for converting SAM files to profile format). Note: The provided
  help text contains only system error messages regarding container image building
  and does not list specific command-line arguments.\n\nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_sam2pro.out
