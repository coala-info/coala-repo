cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-remove
label: perl-file-remove
doc: "The tool 'perl-file-remove' was not found in the system path, and no help text
  was provided to parse.\n\nTool homepage: http://metacpan.org/pod/File::Remove"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-remove:1.57--0
stdout: perl-file-remove.out
