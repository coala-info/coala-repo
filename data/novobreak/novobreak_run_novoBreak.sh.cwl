cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_novoBreak.sh
label: novobreak_run_novoBreak.sh
doc: "A tool for discovering structural variations from next-generation sequencing
  data. (Note: The provided text contains runtime error logs rather than help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/czc/nb_distribution"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novobreak:1.1.3rc--h577a1d6_10
stdout: novobreak_run_novoBreak.sh.out
