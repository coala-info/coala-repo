cwlVersion: v1.2
class: CommandLineTool
baseCommand: physiofit_data_manager
label: physiofit_data_manager
doc: "A tool for managing data within the PhysioFit framework. (Note: The provided
  text contains system error messages regarding container execution and disk space
  rather than command-line help documentation; therefore, no arguments could be extracted.)\n\
  \nTool homepage: https://github.com/llegregam/PhysioFit_Data_Manager"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit:3.4.0--pyhdfd78af_0
stdout: physiofit_data_manager.out
