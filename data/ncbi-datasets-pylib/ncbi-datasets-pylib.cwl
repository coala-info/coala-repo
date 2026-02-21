cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-datasets-pylib
label: ncbi-datasets-pylib
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) and does not include help documentation or usage instructions
  for the tool.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/datasets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-pylib:16.6.1--pyhdfd78af_0
stdout: ncbi-datasets-pylib.out
