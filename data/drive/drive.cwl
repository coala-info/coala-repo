cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive
label: drive
doc: "The provided text does not contain help documentation for the tool 'drive'.
  It consists of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or run the OCI image due to insufficient disk space.\n\nTool
  homepage: https://github.com/kamranahmedse/driver.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive.out
