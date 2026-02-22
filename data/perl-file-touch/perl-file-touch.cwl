cwlVersion: v1.2
class: CommandLineTool
baseCommand: touch
label: perl-file-touch
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to pull or run the container due to insufficient disk space.
  Based on the tool name hint, this utility is likely a Perl implementation of the
  standard 'touch' command used to update file access and modification times.\n\n\
  Tool homepage: https://github.com/neilb/File-Touch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-touch:0.12--pl5321hdfd78af_0
stdout: perl-file-touch.out
