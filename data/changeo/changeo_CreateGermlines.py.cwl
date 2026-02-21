cwlVersion: v1.2
class: CommandLineTool
baseCommand: changeo_CreateGermlines.py
label: changeo_CreateGermlines.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a failed container build (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: http://changeo.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0
stdout: changeo_CreateGermlines.py.out
