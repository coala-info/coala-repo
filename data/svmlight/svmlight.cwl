cwlVersion: v1.2
class: CommandLineTool
baseCommand: svmlight
label: svmlight
doc: "The provided text does not contain help information for svmlight; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch the svmlight
  image.\n\nTool homepage: http://svmlight.joachims.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
stdout: svmlight.out
