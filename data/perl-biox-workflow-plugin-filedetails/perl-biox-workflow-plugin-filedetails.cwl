cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biox-workflow-plugin-filedetails
label: perl-biox-workflow-plugin-filedetails
doc: "A plugin for the BioX::Workflow system. (Note: The provided text contains system
  logs and an execution error rather than help documentation, so no arguments could
  be extracted.)\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-workflow-plugin-filedetails:0.11--0
stdout: perl-biox-workflow-plugin-filedetails.out
