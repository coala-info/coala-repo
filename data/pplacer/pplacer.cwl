cwlVersion: v1.2
class: CommandLineTool
baseCommand: pplacer
label: pplacer
doc: "The provided text does not contain help information for pplacer; it is a fatal
  error log from a container runtime (Apptainer/Singularity) attempting to fetch the
  pplacer image.\n\nTool homepage: http://matsen.fredhutch.org/pplacer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pplacer:1.1.alpha17--0
stdout: pplacer.out
