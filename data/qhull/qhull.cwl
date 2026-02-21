cwlVersion: v1.2
class: CommandLineTool
baseCommand: qhull
label: qhull
doc: "The provided text does not contain help information for the 'qhull' command.
  It appears to be a fatal error log from a container build process (Apptainer/Singularity)
  while attempting to fetch the qhull image.\n\nTool homepage: https://github.com/qhull/qhull"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull.out
