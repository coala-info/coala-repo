cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abismal
  - sim
label: abismal_sim
doc: "Simulate reads from a reference genome with optional bisulfite conversion and
  mutations.\n\nTool homepage: https://github.com/smithlabcode/abismal"
inputs:
  - id: reference_genome_fasta
    type: File
    doc: Reference genome fasta file
    inputBinding:
      position: 1
  - id: bisulfite_conversion_rate
    type:
      - 'null'
      - float
    doc: bisulfite conversion rate
    default: 1.0
    inputBinding:
      position: 102
      prefix: -bis
  - id: change_types
    type:
      - 'null'
      - string
    doc: change types (comma sep relative vals)
    inputBinding:
      position: 102
      prefix: -changes
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: output fasta format (no quality scores)
    inputBinding:
      position: 102
      prefix: -fasta
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: max fragment length
    default: 250
    inputBinding:
      position: 102
      prefix: -max-fraglen
  - id: max_mutations
    type:
      - 'null'
      - string
    doc: max mutations
    default: infty
    inputBinding:
      position: 102
      prefix: -max-mut
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: min fragment length
    default: 100
    inputBinding:
      position: 102
      prefix: -min-fraglen
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: mutation rate
    default: 0.0
    inputBinding:
      position: 102
      prefix: -mut
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: number of reads
    default: 100
    inputBinding:
      position: 102
      prefix: -n-reads
  - id: pbat
    type:
      - 'null'
      - boolean
    doc: pbat
    inputBinding:
      position: 102
      prefix: -pbat
  - id: random_pbat
    type:
      - 'null'
      - boolean
    doc: random pbat
    inputBinding:
      position: 102
      prefix: -random-pbat
  - id: read_length
    type:
      - 'null'
      - int
    doc: read length
    default: 100
    inputBinding:
      position: 102
      prefix: -read-len
  - id: require_valid
    type:
      - 'null'
      - boolean
    doc: require valid bases in fragments
    inputBinding:
      position: 102
      prefix: -require-valid
  - id: seed
    type:
      - 'null'
      - string
    doc: 'rng seed (default: from system)'
    inputBinding:
      position: 102
      prefix: -seed
  - id: show_matches
    type:
      - 'null'
      - boolean
    doc: show match symbols in cigar
    inputBinding:
      position: 102
      prefix: -show-matches
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: output single end
    inputBinding:
      position: 102
      prefix: -single
  - id: strand
    type:
      - 'null'
      - string
    doc: strand {f, r, b}
    default: b
    inputBinding:
      position: 102
      prefix: -strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_prefix
    type: File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: write_locations
    type:
      - 'null'
      - File
    doc: write locations here
    outputBinding:
      glob: $(inputs.write_locations)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
