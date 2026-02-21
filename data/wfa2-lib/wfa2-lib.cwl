cwlVersion: v1.2
class: CommandLineTool
baseCommand: wfa2-lib
label: wfa2-lib
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to build or fetch an image.\n\nTool homepage: https://github.com/smarco/WFA2-lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wfa2-lib:2.3.5--h9948957_3
stdout: wfa2-lib.out
