cwlVersion: v1.2
class: CommandLineTool
baseCommand: deblur
label: deblur
doc: "The provided text does not contain help information for the tool 'deblur'. It
  contains error messages related to a container runtime failure (Apptainer/Singularity)
  and a 'no space left on device' error.\n\nTool homepage: https://github.com/biocore/deblur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
stdout: deblur.out
