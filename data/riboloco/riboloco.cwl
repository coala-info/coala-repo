cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboloco
label: riboloco
doc: "The provided text does not contain help information for the tool 'riboloco'.
  It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the riboloco image.\n\nTool homepage: https://github.com/Delayed-Gitification/riboloco.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboloco:0.3.10--pyhdfd78af_0
stdout: riboloco.out
