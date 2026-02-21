cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-filedirutil
label: perl-filedirutil
doc: "The provided text does not contain help information for perl-filedirutil; it
  is an error log indicating the executable was not found in the environment.\n\n
  Tool homepage: http://metacpan.org/pod/FileDirUtil"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-filedirutil:v0.04--pl526_0
stdout: perl-filedirutil.out
