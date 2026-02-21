cwlVersion: v1.2
class: CommandLineTool
baseCommand: findrule
label: perl-file-find-rule_findrule
doc: "A command-line interface to File::Find::Rule for finding files and directories.\n
  \nTool homepage: https://metacpan.org/pod/File::Find::Rule"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-find-rule:0.35--pl5321hdfd78af_0
stdout: perl-file-find-rule_findrule.out
