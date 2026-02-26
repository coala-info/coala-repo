cwlVersion: v1.2
class: CommandLineTool
baseCommand: probabilistic2020 tsg
label: probabilistic2020_tsg
doc: "Find statistically significant Tumor Suppressor-like genes. Evaluates for a
  higher proportion of inactivating mutations than expected.\n\nTool homepage: https://github.com/KarchinLab/probabilistic2020"
inputs:
  - id: bed
    type: File
    doc: BED file annotation of genes
    inputBinding:
      position: 101
      prefix: --bed
  - id: context
    type:
      - 'null'
      - float
    doc: 'Number of DNA bases to use as context. 0 indicates no context. 1 indicates
      only use the mutated base. 1.5 indicates using the base context used in CHASM
      (http:/ /wiki.chasmsoftware.org/index.php/CHASM_Overview). 2 indicates using
      the mutated base and the upstream base. 3 indicates using the mutated base and
      both the upstream and downstream bases. (Default: 1.5)'
    default: 1.5
    inputBinding:
      position: 101
      prefix: --context
  - id: deleterious
    type:
      - 'null'
      - int
    doc: 'Perform tsg randomization-based test if gene has at least a user specified
      number of deleterious mutations (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --deleterious
  - id: genome
    type:
      - 'null'
      - File
    doc: 'Path to the genome fasta file. Required if --use- unmapped flag is used.
      (Default: None)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: input
    type: File
    doc: gene FASTA file from extract_gene_seq.py script
    inputBinding:
      position: 101
      prefix: --input
  - id: mutations
    type: File
    doc: DNA mutations file (MAF file). Columns can be in any order, but should 
      contain the correct column header names.
    inputBinding:
      position: 101
      prefix: --mutations
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: 'Number of iterations for null model. p-value precision increases with more
      iterations, however this will also increase the run time (Default: 100,000).'
    default: 100000
    inputBinding:
      position: 101
      prefix: --num-iterations
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use for parallelization. 0 indicates using a single
      process without using a multiprocessing pool (more means Faster, default: 0).'
    default: 0
    inputBinding:
      position: 101
      prefix: --processes
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Specify the seed for the pseudo random number generator. By default, the
      seed is randomly chosen. The seed will be used for the monte carlo simulations
      (Default: 101).'
    default: 101
    inputBinding:
      position: 101
      prefix: --seed
  - id: stop_criteria
    type:
      - 'null'
      - int
    doc: 'Number of iterations more significant then the observed statistic to stop
      further computations. This decreases compute time spent in resolving p-values
      for non-significant genes. (Default: 1000).'
    default: 1000
    inputBinding:
      position: 101
      prefix: --stop-criteria
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Only keep unique mutations for each tumor sample. Mutations reported 
      from heterogeneous sources may contain duplicates, e.g. a tumor sample was
      sequenced twice.
    inputBinding:
      position: 101
      prefix: --unique
  - id: use_unmapped
    type:
      - 'null'
      - boolean
    doc: Use mutations that are not mapped to the the single reference 
      transcript for a gene specified in the bed file indicated by the -b 
      option.
    inputBinding:
      position: 101
      prefix: --use-unmapped
outputs:
  - id: output
    type: File
    doc: Output text file of probabilistic 20/20 results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probabilistic2020:1.2.3--py37h9c5868f_4
