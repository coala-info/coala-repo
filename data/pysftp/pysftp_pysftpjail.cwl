cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysftp_pysftpjail
label: pysftp_pysftpjail
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a container build error log for the pysftp tool.\n\nTool homepage:
  https://github.com/unbit/pysftpserver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysftp:0.2.9--py27_0
stdout: pysftp_pysftpjail.out
