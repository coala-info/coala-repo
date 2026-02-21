cwlVersion: v1.2
class: CommandLineTool
baseCommand: tablet_samtools
label: tablet_samtools
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a set of system logs and a fatal error message from a container
  runtime (Apptainer/Singularity) failing to fetch a Docker image.\n\nTool homepage:
  https://ics.hutton.ac.uk/tablet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tablet:1.17.08.17--0
stdout: tablet_samtools.out
