cwlVersion: v1.2
class: CommandLineTool
baseCommand: OptiTypePipeline.py
label: optitype_OptiTypePipeline.py
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log related to a Singularity/Apptainer container
  execution failure (no space left on device).\n\nTool homepage: https://github.com/FRED-2/OptiType"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype_OptiTypePipeline.py.out
