cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismapper_compiled_table.py
label: ismapper_compiled_table.py
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Singularity/Apptainer) error messages regarding a lack of disk
  space.\n\nTool homepage: https://github.com/jhawkey/IS_mapper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper_compiled_table.py.out
