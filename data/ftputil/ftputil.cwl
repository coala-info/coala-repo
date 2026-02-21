cwlVersion: v1.2
class: CommandLineTool
baseCommand: ftputil
label: ftputil
doc: "High-level FTP client library for Python (Note: The provided text contains container
  execution errors rather than tool help text).\n\nTool homepage: https://github.com/mmzsblog/springboot-FtpUtil"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ftputil:3.2--py36_0
stdout: ftputil.out
