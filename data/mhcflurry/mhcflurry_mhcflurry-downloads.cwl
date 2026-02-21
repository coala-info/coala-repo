cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-downloads
label: mhcflurry_mhcflurry-downloads
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to download or build the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/hammerlab/mhcflurry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
stdout: mhcflurry_mhcflurry-downloads.out
