cwlVersion: v1.2
class: CommandLineTool
baseCommand: primers create
label: primers_create
doc: "create primers to amplify this sequence\n\nTool homepage: https://github.com/Lattice-Automation/primers"
inputs:
  - id: seq
    type: string
    doc: create primers to amplify this sequence
    inputBinding:
      position: 1
  - id: fwd_primer_len_range
    type:
      - 'null'
      - type: array
        items: int
    doc: space separated min-max range for the length to add from '-f' (5' to 
      3')
    inputBinding:
      position: 102
      prefix: -fl
  - id: fwd_primer_seq
    type:
      - 'null'
      - string
    doc: additional sequence to add to FWD primer (5' to 3')
    inputBinding:
      position: 102
      prefix: -f
  - id: no_json
    type:
      - 'null'
      - boolean
    doc: write the primers to a JSON array
    inputBinding:
      position: 102
      prefix: --no-json
  - id: off_target_seq
    type:
      - 'null'
      - string
    doc: sequence to check for off-target binding sites
    inputBinding:
      position: 102
      prefix: -t
  - id: rev_primer_len_range
    type:
      - 'null'
      - type: array
        items: int
    doc: space separated min-max range for the length to add from '-r' (5' to 
      3')
    inputBinding:
      position: 102
      prefix: -rl
  - id: rev_primer_seq
    type:
      - 'null'
      - string
    doc: additional sequence to add to REV primer (5' to 3')
    inputBinding:
      position: 102
      prefix: -r
  - id: write_json
    type:
      - 'null'
      - boolean
    doc: write the primers to a JSON array
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0
stdout: primers_create.out
