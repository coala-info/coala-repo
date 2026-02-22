cwlVersion: v1.2
class: CommandLineTool
baseCommand: cortexpy
label: cortexpy
doc: "The provided text does not contain help information or usage instructions for
  cortexpy. It appears to be an error log from a container build process (Singularity/Apptainer)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/winni2k/cortexpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cortexpy:0.46.5--py38h9948957_6
stdout: cortexpy.out
