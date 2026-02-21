cwlVersion: v1.2
class: CommandLineTool
baseCommand: mysqlclient
label: mysqlclient
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/PyMySQL/mysqlclient-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mysqlclient:1.3.10--py36_0
stdout: mysqlclient.out
