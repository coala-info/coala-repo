cwlVersion: v1.2
class: CommandLineTool
baseCommand: dxpy
label: dxpy
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/dnanexus/dx-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy.out
