cwlVersion: v1.2
class: CommandLineTool
baseCommand: calib_calib_cons
label: calib_calib_cons
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and error messages related to a container build
  failure (No space left on device).\n\nTool homepage: https://github.com/vpc-ccg/calib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calib:0.3.4--hdcf5f25_5
stdout: calib_calib_cons.out
