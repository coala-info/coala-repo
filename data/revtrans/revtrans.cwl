cwlVersion: v1.2
class: CommandLineTool
baseCommand: revtrans
label: revtrans
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'revtrans' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: http://www.cbs.dtu.dk/services/RevTrans-2.0/web/download.php"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revtrans:1.4--py27_0
stdout: revtrans.out
