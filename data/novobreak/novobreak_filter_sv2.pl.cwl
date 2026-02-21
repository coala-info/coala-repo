cwlVersion: v1.2
class: CommandLineTool
baseCommand: novobreak_filter_sv2.pl
label: novobreak_filter_sv2.pl
doc: "A tool for filtering structural variants. (Note: The provided text contains
  system error messages regarding container execution and does not include the actual
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/czc/nb_distribution"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novobreak:1.1.3rc--h577a1d6_10
stdout: novobreak_filter_sv2.pl.out
