cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-crypt-openssl-guess
label: perl-crypt-openssl-guess
doc: "A Perl module/tool used to guess OpenSSL include and library paths. (Note: The
  provided text contains system error messages regarding disk space and container
  conversion rather than functional help text.)\n\nTool homepage: https://github.com/akiym/Crypt-OpenSSL-Guess"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-crypt-openssl-guess:0.15--pl5321hdfd78af_0
stdout: perl-crypt-openssl-guess.out
