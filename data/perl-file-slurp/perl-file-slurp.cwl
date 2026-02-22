cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-slurp
label: perl-file-slurp
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build process and does not contain help documentation
  or argument definitions for the tool.\n\nTool homepage: http://metacpan.org/pod/File::Slurp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-slurp:9999.32--pl5321hdfd78af_0
stdout: perl-file-slurp.out
