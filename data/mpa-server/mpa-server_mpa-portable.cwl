cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa-server
label: mpa-server_mpa-portable
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or command-line argument definitions for
  the tool.\n\nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-server:3.4--hdfd78af_3
stdout: mpa-server_mpa-portable.out
