cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwapy
label: bwapy
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failure and does not contain help documentation for the
  tool 'bwapy'.\n\nTool homepage: https://github.com/nanoporetech/bwapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwapy:0.1.4--py311h384fd50_10
stdout: bwapy.out
