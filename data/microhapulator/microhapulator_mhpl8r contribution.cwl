cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhpl8r
label: microhapulator_mhpl8r contribution
doc: "Microhaplotype analysis tool\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: subcmd
    type:
      type: array
      items: string
    doc: Subcommand to run (choose from 'contain', 'contrib', 'convert', 'diff',
      'dist', 'filter', 'getrefr', 'hetbalance', 'locbalance', 'mappingqc', 
      'mix', 'repetitive', 'pipe', 'prob', 'seq', 'sim', 'type', 'unite')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: microhapulator_mhpl8r contribution.out
