cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-copy-recursive-reduced
label: perl-file-copy-recursive-reduced
doc: "The provided text is an error log indicating a failure to pull or convert a
  container image due to lack of disk space; it does not contain CLI help information
  or argument definitions.\n\nTool homepage: http://thenceforward.net/perl/modules/File-Copy-Recursive-Reduced/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-file-copy-recursive-reduced:0.008--pl5321hdfd78af_0
stdout: perl-file-copy-recursive-reduced.out
