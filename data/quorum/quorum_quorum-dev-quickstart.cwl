cwlVersion: v1.2
class: CommandLineTool
baseCommand: quorum
label: quorum_quorum-dev-quickstart
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than the help text for the tool itself.
  No command-line arguments or tool descriptions could be extracted from this input.\n
  \nTool homepage: https://github.com/Consensys/quorum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/quorum:v1.1.1-2-deb_cv1
stdout: quorum_quorum-dev-quickstart.out
