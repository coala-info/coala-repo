cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim-h
label: nanosim-h
doc: "NanoSim-H - a simulator of Oxford Nanopore reads.\n\nTool homepage: https://github.com/karel-brinda/NanoSim-H"
inputs:
  - id: reference
    type: File
    doc: Reference genome in FASTA format (- for standard input).
    inputBinding:
      position: 101
  - id: profile
    type:
      - 'null'
      - string
    doc: "Error profile - one of the precomputed profiles ('ecoli_R9_1D', 'ecoli_UCSC1b', 'ecoli_R9_2D', 'ecoli_R7.3', 'yeast', 'ecoli_R7') or own directory with an error profile [ecoli_R9_2D]."
    inputBinding:
      position: 1
      prefix: --profile
  - id: out_pref
    type:
      - 'null'
      - string
    doc: Prefix of output files [simulated].
    inputBinding:
      position: 1
      prefix: --out-pref
  - id: number
    type:
      - 'null'
      - int
    doc: Number of generated reads [10000].
    inputBinding:
      position: 1
      prefix: --number
  - id: unalign_rate
    type:
      - 'null'
      - float
    doc: Rate of unaligned reads [detect from the error profile].
    inputBinding:
      position: 1
      prefix: --unalign-rate
  - id: mis_rate
    type:
      - 'null'
      - float
    doc: Mismatch rate (weight tuning) [1.0].
    inputBinding:
      position: 1
      prefix: --mis-rate
  - id: ins_rate
    type:
      - 'null'
      - float
    doc: Insertion rate (weight tuning) [1.0].
    inputBinding:
      position: 1
      prefix: --ins-rate
  - id: del_rate
    type:
      - 'null'
      - float
    doc: Deletion rate (weight tuning) [1.0].
    inputBinding:
      position: 1
      prefix: --del-rate
  - id: seed
    type:
      - 'null'
      - int
    doc: Initial seed for the pseudorandom number generator (0 for random) [42].
    inputBinding:
      position: 1
      prefix: --seed
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Circular simulation (linear otherwise).
    inputBinding:
      position: 1
      prefix: --circular
  - id: perfect
    type:
      - 'null'
      - boolean
    doc: Output perfect reads, no mutations.
    inputBinding:
      position: 1
      prefix: --perfect
  - id: merge_contigs
    type:
      - 'null'
      - boolean
    doc: Merge contigs from the reference.
    inputBinding:
      position: 1
      prefix: --merge-contigs
  - id: rnf
    type:
      - 'null'
      - boolean
    doc: Use RNF format for read names.
    inputBinding:
      position: 1
      prefix: --rnf
  - id: rnf_add_cigar
    type:
      - 'null'
      - boolean
    doc: Add cigar to RNF names (not fully debugged, yet).
    inputBinding:
      position: 1
      prefix: --rnf-add-cigar
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum read length [inf].
    inputBinding:
      position: 1
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length [50].
    inputBinding:
      position: 1
      prefix: --min-len
  - id: kmer_bias
    type:
      - 'null'
      - int
    doc: Prohibits homopolymers with length >= n bases in output reads [6].
    inputBinding:
      position: 1
      prefix: --kmer-bias
outputs:
  - id: simulated_files
    type:
      type: array
      items: File
    doc: Simulated reads and error files, named with the output prefix.
    outputBinding:
      glob: "$((inputs.out_pref ? inputs.out_pref : 'simulated') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0
