cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-installpaths
label: perl-extutils-installpaths
doc: "A tool for determining installation paths for Perl modules (ExtUtils::InstallPaths).\n
  \nTool homepage: http://metacpan.org/pod/ExtUtils::InstallPaths"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-installpaths:0.012--pl526_0
stdout: perl-extutils-installpaths.out
