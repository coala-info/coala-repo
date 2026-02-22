cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-atlas-modules
label: perl-atlas-modules
doc: "A collection of Perl modules used by the Expression Atlas project. (Note: The
  provided text contains system error messages regarding container execution and does
  not include specific command-line usage or argument definitions.)\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/perl-atlas-modules"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-atlas-modules:0.3.1--pl5262hdbdd923_5
stdout: perl-atlas-modules.out
