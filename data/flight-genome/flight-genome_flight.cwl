cwlVersion: v1.2
class: CommandLineTool
baseCommand: flight
label: flight-genome_flight
doc: "FLIGHT (Fungal Ligand-Inferred Gene Hub Tool) - A tool for predicting fungal
  gene functions and interactions.\n\nTool homepage: https://github.com/rhysnewell/flight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flight-genome:1.6.3--pyh7cba7a3_0
stdout: flight-genome_flight.out
