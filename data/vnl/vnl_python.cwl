cwlVersion: v1.2
class: CommandLineTool
baseCommand: vnl_python
label: vnl_python
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/YvanYin/VNL_Monocular_Depth_Prediction"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vnl:1.17.0--0
stdout: vnl_python.out
