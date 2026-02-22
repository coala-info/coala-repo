cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-format
label: perl-text-format
doc: "A Perl-based text formatting tool. (Note: The provided input text contains system
  error messages regarding container execution and does not include the actual help
  documentation for the tool.)\n\nTool homepage: http://www.shlomifish.org/open-source/projects/Text-Format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-format:0.63--pl5321hdfd78af_0
stdout: perl-text-format.out
