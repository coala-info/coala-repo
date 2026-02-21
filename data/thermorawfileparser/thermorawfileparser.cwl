cwlVersion: v1.2
class: CommandLineTool
baseCommand: thermorawfileparser
label: thermorawfileparser
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container runtime error log (Singularity/Apptainer)
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/compomics/ThermoRawFileParser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:1.4.5--h05cac1d_1
stdout: thermorawfileparser.out
