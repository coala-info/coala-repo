cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_run_bambu
label: isorefiner_run_bambu
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space while attempting to pull the isorefiner image.\n
  \nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_run_bambu.out
