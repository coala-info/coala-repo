cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf2bed
label: gvcf2bed
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space.\n\n
  Tool homepage: https://github.com/sndrtj/gvcf2bed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf2bed:0.3.1--py_0
stdout: gvcf2bed.out
