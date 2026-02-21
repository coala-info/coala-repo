cwlVersion: v1.2
class: CommandLineTool
baseCommand: RsaCtfTool
label: rsa_RsaCtfTool
doc: "A tool for RSA CTF challenges to perform various attacks against RSA public
  keys and try to recover the private key.\n\nTool homepage: https://github.com/RsaCtfTool/RsaCtfTool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsa:3.1.4--py35_0
stdout: rsa_RsaCtfTool.out
