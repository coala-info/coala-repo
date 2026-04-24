cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - aggregate
label: pastrami_aggregate
doc: "Aggregate Pastrami ancestry estimates based on population groupings\n\nTool
  homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: pastrami_fam
    type: File
    doc: File containing individual and population mapping in FAM format
    inputBinding:
      position: 101
      prefix: --pastrami-fam
  - id: pastrami_output
    type: File
    doc: Output file generated from Pastrami's query subcommand
    inputBinding:
      position: 101
      prefix: --pastrami-output
  - id: pop_group
    type: File
    doc: File containing population to group (e.g., tribes to region) mapping
    inputBinding:
      position: 101
      prefix: --pop-group
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File
    doc: 'Output prefix for ancestry estimates files. Four files are created: <prefix>_fractions.Q,
      <prefix>_paintings.Q, <prefix>_estimates.Q, <prefix>_fine_grain_estimates.Q'
    outputBinding:
      glob: $(inputs.out_prefix)
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
