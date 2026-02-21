cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin-plusmpi
label: relion-bin-plusmpi
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi.out
