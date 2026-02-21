cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrphase
label: lrphase
doc: "The provided text does not contain help information or usage instructions for
  the tool 'lrphase'. It contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to build an image due to lack of disk space.\n\n
  Tool homepage: https://github.com/Boyle-Lab/LRphase.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrphase:1.1.2--pyhdfd78af_0
stdout: lrphase.out
