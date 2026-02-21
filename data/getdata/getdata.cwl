cwlVersion: v1.2
class: CommandLineTool
baseCommand: getdata
label: getdata
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/Sak32009/GetDataFromSteam-SteamDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/getdata:v0.2-3-deb_cv1
stdout: getdata.out
