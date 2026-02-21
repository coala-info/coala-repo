cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat-mutations
label: ctat-mutations_ctat_mutations
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/NCIP/ctat-mutations"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-mutations:2.0.1--py27_1
stdout: ctat-mutations_ctat_mutations.out
