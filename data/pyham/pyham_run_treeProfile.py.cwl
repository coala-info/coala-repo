cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyham_run_treeProfile.py
label: pyham_run_treeProfile.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) attempting
  to fetch the pyham image.\n\nTool homepage: https://github.com/DessimozLab/pyham"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyham:1.1.11--pyh7cba7a3_0
stdout: pyham_run_treeProfile.py.out
