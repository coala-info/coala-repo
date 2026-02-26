cwlVersion: v1.2
class: CommandLineTool
baseCommand: JolyTree.sh
label: jolytree_JolyTree.sh
doc: "A fast alignment-free bioinformatics procedure to infer accurate distance-based
  phylogenetic trees from genome assemblies.\n\nTool homepage: https://research.pasteur.fr/fr/software/jolytree/"
inputs:
  - id: distance_cutoff
    type:
      - 'null'
      - float
    doc: if at least one of the estimated p-distances is above this specified 
      cutoff, then a F81/EI correction is performed
    default: 0.1
    inputBinding:
      position: 101
      prefix: -c
  - id: f81_ei_gamma_shape
    type:
      - 'null'
      - float
    doc: F81/EI transformation gamma shape parameter
    default: 1.5
    inputBinding:
      position: 101
      prefix: -a
  - id: input_directory
    type: Directory
    doc: directory name containing FASTA-formatted contig files; only files 
      ending with .fa, .fna, .fas or .fasta will be considered
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size (default: estimated from the largest genome size with the probability
      set by option -q)'
    inputBinding:
      position: 101
      prefix: -k
  - id: no_bme_tree_inference
    type:
      - 'null'
      - boolean
    doc: no BME tree inference (only pairwise distance estimates)
    inputBinding:
      position: 101
      prefix: -n
  - id: no_branch_support
    type:
      - 'null'
      - boolean
    doc: no branch support
    inputBinding:
      position: 101
      prefix: -x
  - id: output_basename
    type: string
    doc: basename of every written output file
    inputBinding:
      position: 101
      prefix: -b
  - id: random_kmer_probability
    type:
      - 'null'
      - float
    doc: probability of observing a random k-mer
    default: 1e-09
    inputBinding:
      position: 101
      prefix: -q
  - id: ratchet_steps
    type:
      - 'null'
      - int
    doc: number of steps when performing the ratchet-based BME tree search
    default: 100
    inputBinding:
      position: 101
      prefix: -r
  - id: sketch_size
    type:
      - 'null'
      - float
    doc: sketch size estimated as the proportion (up to 1.00) of the average 
      genome size; the sketch size (integer > 2) can also be directly set using 
      this option
    default: 0.25
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 2
    inputBinding:
      position: 101
      prefix: -t
  - id: use_four_nucleotide_frequencies
    type:
      - 'null'
      - boolean
    doc: 'using the four nucleotide frequencies in F81/EI transformations (default:
      to deal with multiple contig files, only the two frequencies A+T and C+G are
      used)'
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jolytree:2.1--hdfd78af_0
stdout: jolytree_JolyTree.sh.out
