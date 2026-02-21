cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtgrasp_runmitos.py
label: mtgrasp_runmitos.py
doc: "A tool for running MITOS mitochondrial genome annotation as part of the mtGRASP
  pipeline. (Note: The provided input text contains system error messages regarding
  container execution and does not include help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/bcgsc/mtGrasp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
stdout: mtgrasp_runmitos.py.out
