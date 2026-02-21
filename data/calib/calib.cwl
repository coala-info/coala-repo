cwlVersion: v1.2
class: CommandLineTool
baseCommand: calib
label: calib
doc: "The provided text does not contain help information or a description for the
  tool 'calib'. It consists of error logs from a container runtime (Apptainer/Singularity)
  attempting to fetch and build the tool's image.\n\nTool homepage: https://github.com/vpc-ccg/calib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calib:0.3.4--hdcf5f25_5
stdout: calib.out
