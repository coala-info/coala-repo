cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-tools_recon_ismrmrd_dataset.py
label: ismrmrd-tools_recon_ismrmrd_dataset.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/ismrmrd/ismrmrd-python-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1
stdout: ismrmrd-tools_recon_ismrmrd_dataset.py.out
