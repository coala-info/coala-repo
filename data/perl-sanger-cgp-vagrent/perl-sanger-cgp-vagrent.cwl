cwlVersion: v1.2
class: CommandLineTool
baseCommand: vagrent
label: perl-sanger-cgp-vagrent
doc: "Variant Annotation GRaphical REporting Tool (VAGRENT). Note: The provided text
  is a system log indicating a container build failure ('no space left on device')
  and does not contain the tool's help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/cancerit/VAGrENT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-vagrent:3.7.0--pl5321h7b50bb2_3
stdout: perl-sanger-cgp-vagrent.out
