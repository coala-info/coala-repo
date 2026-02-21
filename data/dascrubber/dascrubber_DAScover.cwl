cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAScover
label: dascrubber_DAScover
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to extract the image due to lack of disk space.\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DAScover.out
