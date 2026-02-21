cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqfu
label: seqfu
doc: "The provided text is a system error log (Apptainer/Singularity build failure)
  and does not contain the help text or usage information for the 'seqfu' command.
  Consequently, no arguments could be extracted.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu.out
