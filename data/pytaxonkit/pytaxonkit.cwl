cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytaxonkit
label: pytaxonkit
doc: "The provided text does not contain help information or usage instructions; it
  consists of container runtime error logs (Apptainer/Singularity) indicating a failure
  to fetch the OCI image.\n\nTool homepage: https://github.com/bioforensics/pytaxonkit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytaxonkit:0.10.1--pyhdfd78af_0
stdout: pytaxonkit.out
