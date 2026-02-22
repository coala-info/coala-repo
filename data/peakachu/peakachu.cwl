cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakachu
label: peakachu
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failing to pull the peakachu image due to insufficient disk space.\n\nTool homepage:
  https://github.com/tbischler/PEAKachu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
stdout: peakachu.out
