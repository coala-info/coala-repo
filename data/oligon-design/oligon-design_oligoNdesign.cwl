cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligoNdesign
label: oligon-design_oligoNdesign
doc: "This script is a wrapper to run a basic pipeline and select the best oligonucleotides
  from a target and a excluding file.\n\nTool homepage: https://github.com/MiguelMSandin/oligoN-design"
inputs:
  - id: excluding_file
    type: File
    doc: The fasta file containing the excluding group.
    inputBinding:
      position: 101
      prefix: -e
  - id: gc_content
    type:
      - 'null'
      - string
    doc: A minimum (and maximum) GC content (in between quotes).
    default: '0'
    inputBinding:
      position: 101
      prefix: -c
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: It will keep intermediate relevant files.
    inputBinding:
      position: 101
      prefix: -k
  - id: max_presence_excluding
    type:
      - 'null'
      - float
    doc: The maximum presence in the excluding file.
    default: 0.01
    inputBinding:
      position: 101
      prefix: -s
  - id: min_presence_target
    type:
      - 'null'
      - float
    doc: The minimum presence in the target file.
    default: 0.8
    inputBinding:
      position: 101
      prefix: -m
  - id: num_best_oligonucleotides
    type:
      - 'null'
      - int
    doc: The number of best oligonucleotides to select.
    default: 4
    inputBinding:
      position: 101
      prefix: -n
  - id: oligonucleotide_lengths
    type:
      - 'null'
      - string
    doc: The lengths of the desired oligonucleotides (in between quotes).
    default: "'18 20'"
    inputBinding:
      position: 101
      prefix: -l
  - id: output_prefix
    type: string
    doc: The prefix for the output files.
    inputBinding:
      position: 101
      prefix: -o
  - id: print_commands
    type:
      - 'null'
      - boolean
    doc: It will print the exact commands to the console without running them.
    inputBinding:
      position: 101
      prefix: -r
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: If selected, will not print information to the console.
    inputBinding:
      position: 101
      prefix: -v
  - id: skip_accessibility_testing
    type:
      - 'null'
      - boolean
    doc: It will not test accessibility of the oligonucleotides. Recommended for
      very large target files.
    inputBinding:
      position: 101
      prefix: -a
  - id: skip_indel_testing
    type:
      - 'null'
      - boolean
    doc: It will not test for indels when searching for 1 and 2 mismatches, 
      speeding up completion.
    inputBinding:
      position: 101
      prefix: -f
  - id: ssu_rDNA
    type:
      - 'null'
      - string
    doc: "The Small SubUnit of the rDNA: Either '18S' (default) or '16S'."
    default: 18S
    inputBinding:
      position: 101
      prefix: -g
  - id: target_file
    type: File
    doc: The fasta file containing the target group.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligon-design:1.1.0--py314hdfd78af_0
stdout: oligon-design_oligoNdesign.out
