cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysftp
label: pysftp
doc: "A Python library that provides a high-level interface to SFTP. (Note: The provided
  text is a container build error log and does not contain CLI help documentation
  or argument definitions).\n\nTool homepage: https://github.com/unbit/pysftpserver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysftp:0.2.9--py27_0
stdout: pysftp.out
