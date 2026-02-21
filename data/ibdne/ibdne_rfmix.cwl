cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_rfmix
label: ibdne_rfmix
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Singularity/Apptainer)
  failing to pull or build an image due to insufficient disk space.\n\nTool homepage:
  https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_rfmix.out
