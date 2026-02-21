cwlVersion: v1.2
class: CommandLineTool
baseCommand: qorts
label: qorts
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  while attempting to fetch the tool image.\n\nTool homepage: http://hartleys.github.io/QoRTs/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qorts:1.3.6--hdfd78af_1
stdout: qorts.out
