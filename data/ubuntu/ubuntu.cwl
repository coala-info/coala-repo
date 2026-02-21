cwlVersion: v1.2
class: CommandLineTool
baseCommand: ubuntu
label: ubuntu
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) attempting to fetch and extract an Ubuntu OCI image, rather
  than CLI help text. No command-line arguments, flags, or usage instructions were
  found in the text.\n\nTool homepage: https://github.com/Nyr/openvpn-install"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ubuntu:24.04
stdout: ubuntu.out
