cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus_git
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a set of system logs and a fatal error message from a container
  runtime (Singularity/Apptainer) attempting to fetch a Docker image.\n\nTool homepage:
  https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_git.out
