cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtgrasp
label: mtgrasp
doc: "Mitochondrial Genome Assembly from RNA-Seq Data (Note: The provided text is
  an error log and does not contain usage information or argument definitions).\n\n
  Tool homepage: https://github.com/bcgsc/mtGrasp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
stdout: mtgrasp.out
