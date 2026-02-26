cwlVersion: v1.2
class: CommandLineTool
baseCommand: scTagger.py
label: sctagger_scTagger.py
doc: "scTagger pipeline!\n\nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs:
  - id: subcommand
    type: string
    doc: 'Available subcommands: extract_lr_bc, extract_sr_bc, extract_sr_bc_from_lr,
      match_trie'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
stdout: sctagger_scTagger.py.out
