cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - aggregate
label: pastrami_aggregate
doc: "Aggregate results and estimate ancestries\n\nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: pastrami_output
    type:
      - 'null'
      - File
    doc: "Output file generated from Pastrami's query subcommand"
    inputBinding:
      position: 101
      prefix: --pastrami-output
  - id: pop_group
    type:
      - 'null'
      - File
    doc: "File containing population to group (e.g., tribes to region) mapping"
    inputBinding:
      position: 101
      prefix: --pop-group
  - id: pastrami_fam
    type:
      - 'null'
      - File
    doc: "File containing individual and population mapping in FAM format"
    inputBinding:
      position: 101
      prefix: --pastrami-fam
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "File containing log information (default: run.log)"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads (default: 4)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print program progress information on screen"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_prefix
    type: string
    doc: "Output prefix for ancestry estimates files (default: pastrami). Four files are created: <prefix>_fractions.Q, <prefix>_paintings.Q, <prefix>_estimates.Q, <prefix>_fine_grain_estimates.Q"
    inputBinding:
      position: 103
      prefix: --out-prefix
outputs:
  - id: out_files
    type: File[]
    doc: "Ancestry estimate files with the given prefix"
    outputBinding:
      glob: $(inputs.out_prefix)*
  - id: log_file
    type:
      - 'null'
      - File
    doc: "File containing log information"
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
