cwlVersion: v1.2
class: CommandLineTool
baseCommand: skbio
label: skbio
doc: "The provided text does not contain help documentation for the tool. It appears
  to be a system log showing a fatal error during a container build process (Apptainer/Singularity)
  while attempting to fetch the skbio image.\n\nTool homepage: https://github.com/nachoborello/SKBio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/skbio:v0.5.1-2-deb-py3_cv1
stdout: skbio.out
