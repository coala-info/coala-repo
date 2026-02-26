cwlVersion: v1.2
class: CommandLineTool
baseCommand: SemiBin2
label: semibin_SemiBin2
doc: "Neural network-based binning of metagenomic contigs\n\nTool homepage: https://github.com/BigDataBiology/SemiBin"
inputs:
  - id: subcommand
    type: string
    doc: SemiBin subcommand to run (e.g., single_easy_bin, multi_easy_bin, bin, 
      etc.)
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output
    default: false
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    default: false
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
stdout: semibin_SemiBin2.out
