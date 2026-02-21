cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopper
label: nanopack_chopper
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or run a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_chopper.out
