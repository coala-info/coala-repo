cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - get_subunits
label: mgnify-pipelines-toolkit_get_subunits
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
stdout: mgnify-pipelines-toolkit_get_subunits.out
