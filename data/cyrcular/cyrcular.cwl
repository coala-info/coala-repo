cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyrcular
label: cyrcular
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/tedil/cyrcular"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyrcular:0.3.0--ha8ac579_1
stdout: cyrcular.out
