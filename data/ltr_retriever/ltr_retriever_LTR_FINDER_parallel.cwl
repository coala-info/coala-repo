cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_retriever_LTR_FINDER_parallel
label: ltr_retriever_LTR_FINDER_parallel
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/oushujun/LTR_retriever"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_retriever_LTR_FINDER_parallel.out
