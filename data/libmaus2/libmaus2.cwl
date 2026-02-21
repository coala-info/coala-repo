cwlVersion: v1.2
class: CommandLineTool
baseCommand: libmaus2
label: libmaus2
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or command-line arguments for the tool.\n\n
  Tool homepage: https://gitlab.com/german.tischler/libmaus2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libmaus2:2.0.813--ha7e2851_1
stdout: libmaus2.out
