cwlVersion: v1.2
class: CommandLineTool
baseCommand: Oligowalk
label: rnastructure_Oligowalk
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build or fetch the OCI image.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_Oligowalk.out
