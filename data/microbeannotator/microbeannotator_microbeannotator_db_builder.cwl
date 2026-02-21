cwlVersion: v1.2
class: CommandLineTool
baseCommand: microbeannotator_db_builder
label: microbeannotator_microbeannotator_db_builder
doc: "A tool to build the database for MicrobeAnnotator. Note: The provided help text
  appears to be a container runtime error log and does not contain specific command-line
  argument definitions.\n\nTool homepage: https://github.com/cruizperez/MicrobeAnnotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microbeannotator:2.0.5--pyhdfd78af_0
stdout: microbeannotator_microbeannotator_db_builder.out
