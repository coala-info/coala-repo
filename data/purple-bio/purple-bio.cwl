cwlVersion: v1.2
class: CommandLineTool
baseCommand: purple-bio
label: purple-bio
doc: "The provided text appears to be a container runtime log (Singularity/Apptainer)
  indicating a failure to fetch or build the image, rather than the help text for
  the 'purple-bio' tool itself. As a result, no command-line arguments could be extracted.\n
  \nTool homepage: https://gitlab.com/HartkopfF/Purple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purple-bio:0.4.2.5--py_0
stdout: purple-bio.out
