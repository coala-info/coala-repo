cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2
label: glam2
doc: "Alphabets: p = proteins, n = nucleotides, other = alphabet file\n\nTool homepage:
  https://github.com/LELEGOBOO/Glam2"
inputs:
  - id: alphabet
    type: string
    doc: Alphabet type (p, n, or alphabet file)
    inputBinding:
      position: 1
  - id: my_seqs
    type: File
    doc: Input sequence file
    inputBinding:
      position: 2
  - id: column_sampling_moves
    type:
      - 'null'
      - float
    doc: column-sampling moves per site-sampling move
    default: 1.0
    inputBinding:
      position: 103
      prefix: -m
  - id: cooling_factor
    type:
      - 'null'
      - float
    doc: cooling factor per n iterations
    default: 1.44
    inputBinding:
      position: 103
      prefix: -c
  - id: deletion_pseudocount
    type:
      - 'null'
      - float
    doc: deletion pseudocount
    default: 0.1
    inputBinding:
      position: 103
      prefix: -D
  - id: dirichlet_mixture_file
    type:
      - 'null'
      - File
    doc: Dirichlet mixture file
    inputBinding:
      position: 103
      prefix: -d
  - id: examine_both_strands
    type:
      - 'null'
      - boolean
    doc: examine both strands - forward and reverse complement
    inputBinding:
      position: 103
      prefix: '-2'
  - id: initial_aligned_columns
    type:
      - 'null'
      - int
    doc: initial number of aligned columns
    default: 20
    inputBinding:
      position: 103
      prefix: -w
  - id: initial_temperature
    type:
      - 'null'
      - float
    doc: initial temperature
    default: 1.2
    inputBinding:
      position: 103
      prefix: -t
  - id: insertion_pseudocount
    type:
      - 'null'
      - float
    doc: insertion pseudocount
    default: 0.02
    inputBinding:
      position: 103
      prefix: -I
  - id: max_aligned_columns
    type:
      - 'null'
      - int
    doc: maximum number of aligned columns
    default: 50
    inputBinding:
      position: 103
      prefix: -b
  - id: max_iter_no_improvement
    type:
      - 'null'
      - int
    doc: end each run after this many iterations without improvement
    default: 10000
    inputBinding:
      position: 103
      prefix: -n
  - id: min_aligned_columns
    type:
      - 'null'
      - int
    doc: minimum number of aligned columns
    default: 2
    inputBinding:
      position: 103
      prefix: -a
  - id: min_sequences
    type:
      - 'null'
      - int
    doc: minimum number of sequences in the alignment
    default: 2
    inputBinding:
      position: 103
      prefix: -z
  - id: no_deletion_pseudocount
    type:
      - 'null'
      - float
    doc: no-deletion pseudocount
    default: 2.0
    inputBinding:
      position: 103
      prefix: -E
  - id: no_insertion_pseudocount
    type:
      - 'null'
      - float
    doc: no-insertion pseudocount
    default: 1.0
    inputBinding:
      position: 103
      prefix: -J
  - id: num_runs
    type:
      - 'null'
      - int
    doc: number of alignment runs
    default: 10
    inputBinding:
      position: 103
      prefix: -r
  - id: print_progress
    type:
      - 'null'
      - boolean
    doc: print progress information at each iteration
    inputBinding:
      position: 103
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for pseudo-random numbers
    default: 1
    inputBinding:
      position: 103
      prefix: -s
  - id: site_sampling_algorithm
    type:
      - 'null'
      - int
    doc: 'site sampling algorithm: 0=FAST 1=SLOW 2=FFT'
    default: 0
    inputBinding:
      position: 103
      prefix: -x
  - id: temperature_lower_bound
    type:
      - 'null'
      - float
    doc: temperature lower bound
    default: 0.1
    inputBinding:
      position: 103
      prefix: -u
  - id: weight_generic_vs_set_specific
    type:
      - 'null'
      - float
    doc: weight for generic versus sequence-set-specific residue abundances
    default: '1e+99'
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
