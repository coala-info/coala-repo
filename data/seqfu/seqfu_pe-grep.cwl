cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - pe-grep
label: seqfu_pe-grep
doc: "The provided text does not contain help information for seqfu pe-grep; it is
  an error log indicating a failure to build a Singularity/Apptainer container due
  to insufficient disk space.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_pe-grep.out
