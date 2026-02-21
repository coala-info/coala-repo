cwlVersion: v1.2
class: CommandLineTool
baseCommand: proda
label: proda
doc: "The provided text does not contain help information for the tool 'proda'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image.\n\nTool homepage: http://proda.stanford.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/proda:v1.0-12-deb_cv1
stdout: proda.out
