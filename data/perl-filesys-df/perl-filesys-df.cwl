cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-filesys-df
label: perl-filesys-df
doc: "A tool for retrieving file system disk space information (Note: The provided
  text contains only system error messages and no help documentation).\n\nTool homepage:
  https://github.com/pld-linux/perl-Filesys-DiskSpace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-filesys-df:0.92--pl5321h7b50bb2_9
stdout: perl-filesys-df.out
