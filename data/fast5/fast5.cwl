cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5
label: fast5
doc: "The provided text does not contain help information for the 'fast5' tool; it
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/mateidavid/fast5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5:0.6.5--0
stdout: fast5.out
