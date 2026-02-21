cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicycler-data
label: unicycler-data
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the container image.\n\nTool homepage: https://github.com/rrwick/Unicycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/unicycler-data:v0.4.7dfsg-2-deb_cv1
stdout: unicycler-data.out
