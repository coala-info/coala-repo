cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-core
label: nf-core_nextflow
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  http://nf-co.re/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
stdout: nf-core_nextflow.out
