cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-crypt-openssl-rsa
label: perl-crypt-openssl-rsa
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains system error messages related to a failed container build
  (no space left on device).\n\nTool homepage: http://github.com/toddr/Crypt-OpenSSL-RSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-crypt-openssl-rsa:0.37--pl5321hc234bb7_0
stdout: perl-crypt-openssl-rsa.out
