cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_coverage
label: sequana_sequana_coverage
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequana_coverage.out
