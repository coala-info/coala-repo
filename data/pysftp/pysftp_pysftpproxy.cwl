cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysftp_pysftpproxy
label: pysftp_pysftpproxy
doc: "The provided text does not contain usage instructions or argument definitions.
  It appears to be a log of a failed container build or execution attempt for the
  pysftp tool.\n\nTool homepage: https://github.com/unbit/pysftpserver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysftp:0.2.9--py27_0
stdout: pysftp_pysftpproxy.out
