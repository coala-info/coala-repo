cwlVersion: v1.2
class: CommandLineTool
baseCommand: wise-data
label: wise-data
doc: "The provided text does not contain help information or usage instructions for
  'wise-data'; it is an error log from a container build process (Apptainer/Singularity)
  failing to fetch a Docker image. Consequently, no arguments could be extracted.\n
  \nTool homepage: https://www.gnu.org/software/sed/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/wise-data:v2.4.1-21-deb_cv1
stdout: wise-data.out
