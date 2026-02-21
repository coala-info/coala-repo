cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq-gen
label: seq-gen
doc: "Sequence Generator - simulates the evolution of nucleotide or amino acid sequences
  along a phylogeny.\n\nTool homepage: http://tree.bio.ed.ac.uk/software/Seq-Gen/"
inputs:
  - id: treefile
    type:
      - 'null'
      - File
    doc: Name of tree file [default = trees on stdin]
    inputBinding:
      position: 1
  - id: ancestral_sequence_index
    type:
      - 'null'
      - int
    doc: Use sequence k as ancestral (needs alignment) [default = random]
    inputBinding:
      position: 102
      prefix: -k
  - id: branch_length_scaling
    type:
      - 'null'
      - float
    doc: Branch length scaling factor
    default: 1.0
    inputBinding:
      position: 102
      prefix: -s
  - id: codon_position_rates
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Rates for codon position heterogeneity (#1 #2 #3)'
    inputBinding:
      position: 102
      prefix: -c
  - id: datasets_per_tree
    type:
      - 'null'
      - int
    doc: Simulated datasets per tree
    default: 1
    inputBinding:
      position: 102
      prefix: -n
  - id: frequencies
    type:
      - 'null'
      - type: array
        items: string
    doc: Nucleotide or amino acid frequencies (e for equal or specific values)
    inputBinding:
      position: 102
      prefix: -f
  - id: gamma_categories
    type:
      - 'null'
      - int
    doc: Number of gamma rate categories [default = continuous]
    inputBinding:
      position: 102
      prefix: -g
  - id: gamma_shape
    type:
      - 'null'
      - type: array
        items: float
    doc: Shape (alpha) for gamma rate heterogeneity (can be one value or three for
      codon positions)
    inputBinding:
      position: 102
      prefix: -a
  - id: general_rate_matrix
    type:
      - 'null'
      - type: array
        items: float
    doc: General rate matrix (6 values for nucleotides, 190 for amino acids)
    inputBinding:
      position: 102
      prefix: -r
  - id: insert_text_file
    type:
      - 'null'
      - File
    doc: A text file to insert after every dataset
    inputBinding:
      position: 102
      prefix: -x
  - id: invariable_sites_proportion
    type:
      - 'null'
      - float
    doc: Proportion of invariable sites
    default: 0.0
    inputBinding:
      position: 102
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output file format: p (PHYLIP), r (relaxed PHYLIP), n (NEXUS), f (FASTA),
      s (Separate files)'
    inputBinding:
      position: 102
      prefix: -o
  - id: partitions_per_sequence
    type:
      - 'null'
      - int
    doc: Number of partitions (and trees) per sequence
    default: 1
    inputBinding:
      position: 102
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 102
      prefix: -q
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator [default = system generated]
    inputBinding:
      position: 102
      prefix: -z
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: Sequence length
    default: 1000
    inputBinding:
      position: 102
      prefix: -l
  - id: substitution_model
    type:
      - 'null'
      - string
    doc: 'Substitution model: HKY, F84, GTR, JTT, WAG, PAM, BLOSUM, MTREV, CPREV45,
      MTART, LG, GENERAL'
    inputBinding:
      position: 102
      prefix: -m
  - id: total_tree_scale
    type:
      - 'null'
      - float
    doc: Total tree scale [default = use branch lengths]
    inputBinding:
      position: 102
      prefix: -d
  - id: ts_tv_ratio
    type:
      - 'null'
      - type: array
        items: float
    doc: Transition-transversion ratio (can be one value or three for codon positions)
    inputBinding:
      position: 102
      prefix: -t
  - id: write_additional_info
    type:
      - 'null'
      - string
    doc: 'Write additional information: a (ancestral sequences), r (rate for each
      site)'
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Name of output file [default = to stdout, required for FASTA]
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-gen:1.3.5--h7b50bb2_0
