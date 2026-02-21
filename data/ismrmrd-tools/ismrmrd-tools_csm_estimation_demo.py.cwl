cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismrmrd-tools_csm_estimation_demo.py
label: ismrmrd-tools_csm_estimation_demo.py
doc: "Coil Sensitivity Map (CSM) estimation demo tool. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  command-line arguments.)\n\nTool homepage: https://github.com/ismrmrd/ismrmrd-python-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ismrmrd-tools:v1.4.0-1-deb_cv1
stdout: ismrmrd-tools_csm_estimation_demo.py.out
