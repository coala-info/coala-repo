cwlVersion: v1.2
class: CommandLineTool
baseCommand: query_phenomizer
label: query_phenomizer
doc: "The provided text does not contain help information for the tool; it contains
  error logs from a container runtime (Apptainer/Singularity) failing to fetch the
  image.\n\nTool homepage: https://www.github.com/moonso/query_phenomizer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/query_phenomizer:1.2.1--pyh7cba7a3_0
stdout: query_phenomizer.out
