cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-font-afm
label: perl-font-afm
doc: "Interface to Adobe Font Metrics files. (Note: The provided help text indicates
  a execution failure: 'executable file not found in $PATH')\n\nTool homepage: https://github.com/pld-linux/perl-Font-AFM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-font-afm:1.20--pl526_2
stdout: perl-font-afm.out
