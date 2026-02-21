cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagore_rfmix2tagore
label: tagore_rfmix2tagore
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) failure. No arguments could be parsed
  from the input.\n\nTool homepage: https://github.com/jordanlab/tagore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagore:1.1.2--pyhdfd78af_0
stdout: tagore_rfmix2tagore.out
