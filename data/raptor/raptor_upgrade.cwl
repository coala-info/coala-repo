cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raptor
  - upgrade
label: raptor_upgrade
doc: "Upgrades an index made by an older Raptor version to the current index format.\n\
  \nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: input
    type: File
    doc: 'The index to upgrade. Parts: Without suffix _0'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Path to new index.
    inputBinding:
      position: 102
      prefix: --output
  - id: fpr
    type:
      - 'null'
      - float
    doc: 'The false positive rate. Mutually exclusive with --bins. Default: None.
      Value must be in range [0.000000,1.000000].'
    inputBinding:
      position: 101
      prefix: --fpr
  - id: bins
    type:
      - 'null'
      - File
    doc: 'File containing one file per line per bin. Mutually exclusive with --fpr.
      Default: None. The input file must exist and read permissions must be granted.'
    inputBinding:
      position: 101
      prefix: --bins
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (time and memory usage)
  - id: upgraded_index
    type:
      type: array
      items: File
    doc: Upgraded index
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_upgrade.out
