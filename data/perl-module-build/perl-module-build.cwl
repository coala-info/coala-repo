cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-build
label: perl-module-build
doc: "A system for building, testing, and installing Perl modules (Module::Build).
  Note: The provided text contains system error messages regarding disk space and
  container conversion rather than command-line help documentation.\n\nTool homepage:
  http://metacpan.org/pod/Module-Build"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-build:0.4231--pl5321hdfd78af_0
stdout: perl-module-build.out
