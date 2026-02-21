cwlVersion: v1.2
class: CommandLineTool
baseCommand: sepp-refsilva128
label: sepp-refsilva128
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a Singularity/Apptainer container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/smirarab/sepp-refs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sepp-refsilva128:4.5.1--hdfd78af_1
stdout: sepp-refsilva128.out
