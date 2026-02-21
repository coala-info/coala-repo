cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-tools_generate_cartesian_shepp_logan_dataset.py
label: ismrmrd-tools_generate_cartesian_shepp_logan_dataset.py
doc: "Generate Cartesian Shepp-Logan dataset (Note: The provided help text contains
  system error messages and does not list command-line arguments).\n\nTool homepage:
  https://github.com/ismrmrd/ismrmrd-python-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1
stdout: ismrmrd-tools_generate_cartesian_shepp_logan_dataset.py.out
