cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicertools
label: juicertools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure.\n\nTool homepage: https://github.com/aidenlab/Juicebox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicertools:2.20.00--hdfd78af_0
stdout: juicertools.out
