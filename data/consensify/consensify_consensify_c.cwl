cwlVersion: v1.2
class: CommandLineTool
baseCommand: consensify_c
label: consensify_consensify_c
doc: "Generate a consensus fasta from counts and positions files using a random read
  sampling approach.\n\nTool homepage: https://github.com/jlapaijmans/Consensify"
inputs:
  - id: counts_file
    type: File
    doc: filename(with path) of the counts file
    inputBinding:
      position: 101
      prefix: -c
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: maximum coverage for which positions should be called
    inputBinding:
      position: 101
      prefix: -max
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage for which positions should be called
    inputBinding:
      position: 101
      prefix: -min
  - id: n_matches
    type:
      - 'null'
      - int
    doc: number of matches required to call a position
    inputBinding:
      position: 101
      prefix: -n_matches
  - id: n_random_reads
    type:
      - 'null'
      - int
    doc: number of random reads used; note that fewer reads might be used if a position
      has depth<n_random_reads
    inputBinding:
      position: 101
      prefix: -n_random_reads
  - id: no_empty_scaffold
    type:
      - 'null'
      - boolean
    doc: if set, empty scaffolds in the counts file are NOT printed in the fasta output
    inputBinding:
      position: 101
      prefix: -no_empty_scaffold
  - id: positions_file
    type: File
    doc: filename(with path) of the positions file
    inputBinding:
      position: 101
      prefix: -p
  - id: scaffold_file
    type: File
    doc: filename(with path) of the scaffold file
    inputBinding:
      position: 101
      prefix: -s
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for the random number generator (if not set, random device is used to
      initialise the Marsenne-Twister)
    inputBinding:
      position: 101
      prefix: -seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: if set, verbose output to stout
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_fasta
    type: File
    doc: filename(with path) of the output fasta
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consensify:2.4.0--h077b44d_2
