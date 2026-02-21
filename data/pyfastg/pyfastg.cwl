cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastg
label: pyfastg
doc: "The provided text does not contain help information or usage instructions for
  pyfastg. It appears to be a log of a failed container build/fetch process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/fedarko/pyfastg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastg:0.2.0--pyhdfd78af_0
stdout: pyfastg.out
