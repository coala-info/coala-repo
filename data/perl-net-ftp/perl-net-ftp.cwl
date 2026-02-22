cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-net-ftp
label: perl-net-ftp
doc: "A Perl module/tool for FTP (File Transfer Protocol) operations. Note: The provided
  text contains system error logs regarding container image retrieval and disk space
  issues rather than command-line help documentation.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-net-ftp:2.79--pl5321hdfd78af_2
stdout: perl-net-ftp.out
