cwlVersion: v1.2
class: CommandLineTool
baseCommand: gefast
label: gefast
doc: "The provided text does not contain help information for the tool 'gefast'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/romueller/gefast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gefast:2.0.1--h4ac6f70_3
stdout: gefast.out
