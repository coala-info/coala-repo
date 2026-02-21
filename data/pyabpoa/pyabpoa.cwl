cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyabpoa
label: pyabpoa
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime (Singularity/Apptainer) error logs indicating a failure to
  fetch or build the OCI image.\n\nTool homepage: https://github.com/yangao07/abPOA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyabpoa:1.5.5--py311h384fd50_0
stdout: pyabpoa.out
