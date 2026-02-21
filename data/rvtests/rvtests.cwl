cwlVersion: v1.2
class: CommandLineTool
baseCommand: rvtests
label: rvtests
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: rvtests.out
