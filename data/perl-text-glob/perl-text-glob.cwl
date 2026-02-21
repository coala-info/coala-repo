cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-glob
label: perl-text-glob
doc: "The provided text is an error log indicating that the executable 'perl-text-glob'
  was not found in the system PATH; no help documentation or usage information was
  available to parse.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-glob:0.11--pl5.22.0_0
stdout: perl-text-glob.out
