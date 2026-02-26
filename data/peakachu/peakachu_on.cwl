cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakachu
label: peakachu_on
doc: "peakachu: error: invalid choice: 'on' (choose from 'window', 'adaptive', 'coverage',
  'consensus_peak')\n\nTool homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand for peakachu (choose from 'window', 'adaptive', 'coverage', 
      'consensus_peak')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
stdout: peakachu_on.out
