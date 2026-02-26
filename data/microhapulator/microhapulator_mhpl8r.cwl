cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhpl8r
label: microhapulator_mhpl8r
doc: "Invoke `mhpl8r <subcmd> --help` and replace `<subcmd>` with one of the subcommands
  listed below to see instructions for that operation.\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: subcmd
    type:
      type: array
      items: string
    doc: 'Subcommands: contain, contrib, convert, diff, dist, filter, getrefr, hetbalance,
      locbalance, mappingqc, mix, pipe, prob, repetitive, seq, sim, type, unite'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: microhapulator_mhpl8r.out
