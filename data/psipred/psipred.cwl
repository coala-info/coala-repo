cwlVersion: v1.2
class: CommandLineTool
baseCommand: psipred
label: psipred
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container image retrieval (Singularity/Apptainer error).\n\n
  Tool homepage: https://bioinf.cs.ucl.ac.uk/psipred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psipred:4.0--h7b50bb2_0
stdout: psipred.out
