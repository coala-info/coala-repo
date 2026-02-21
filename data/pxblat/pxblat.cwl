cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxblat
label: pxblat
doc: "The provided text does not contain help information for the tool 'pxblat'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to fetch an image.\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py310h275bdba_0
stdout: pxblat.out
