cwlVersion: v1.2
class: CommandLineTool
baseCommand: cameo
label: cameo
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: http://cameo.bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0
stdout: cameo.out
