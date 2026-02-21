cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-lockfile-simple
label: perl-lockfile-simple
doc: "A tool for simple file locking (Note: The provided help text contains only system
  logs and an error indicating the executable was not found; no usage information
  or arguments were available to parse).\n\nTool homepage: http://metacpan.org/pod/LockFile::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-lockfile-simple:0.208--0
stdout: perl-lockfile-simple.out
