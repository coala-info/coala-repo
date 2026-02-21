cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypro
label: hypro_nextflow
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Singularity/Apptainer) indicating a failure to build a SIF
  image due to insufficient disk space.\n\nTool homepage: https://github.com/hoelzer-lab/hypro.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hypro:0.1--py_0
stdout: hypro_nextflow.out
