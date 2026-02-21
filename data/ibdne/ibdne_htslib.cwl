cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_htslib
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_htslib.out
