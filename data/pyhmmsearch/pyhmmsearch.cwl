cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhmmsearch
label: pyhmmsearch
doc: "The provided text does not contain help information for pyhmmsearch. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch or build the container image.\n\nTool homepage: https://github.com/new-atlantis-labs/pyhmmsearch-stable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
stdout: pyhmmsearch.out
