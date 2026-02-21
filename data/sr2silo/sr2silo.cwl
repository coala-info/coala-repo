cwlVersion: v1.2
class: CommandLineTool
baseCommand: sr2silo
label: sr2silo
doc: "The provided text does not contain help information or usage instructions for
  sr2silo; it appears to be a log output from a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/cbg-ethz/sr2silo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sr2silo:1.8.0--pyhdfd78af_0
stdout: sr2silo.out
