cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-datasets-pyclient
label: ncbi-datasets-pyclient
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or build the container image due to insufficient disk
  space ('no space left on device'). It does not contain CLI help information or argument
  definitions.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/datasets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-pyclient:18.15.0--pyh7e72e81_0
stdout: ncbi-datasets-pyclient.out
