cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtgrasp_mtgrasp.py
label: mtgrasp_mtgrasp.py
doc: "Mitochondrial Genome Reconstruction and Analysis from Short-read sequences (Note:
  The provided text is a container execution error log and does not contain help information
  or argument definitions).\n\nTool homepage: https://github.com/bcgsc/mtGrasp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
stdout: mtgrasp_mtgrasp.py.out
