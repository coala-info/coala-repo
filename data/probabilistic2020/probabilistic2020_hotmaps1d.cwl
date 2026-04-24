cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - probabilistic2020
  - hotmaps1d
label: probabilistic2020_hotmaps1d
doc: "Find codons with significant clustering of missense mutations in sequence. Evaluates
  for a higher ammount of clustering of missense mutations.\n\nTool homepage: https://github.com/KarchinLab/probabilistic2020"
inputs:
  - id: bed_file
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
    inputBinding:
      position: 101
      prefix: --context
  - id: genome_file
    type:
      - 'null'
      - File
    doc: 'Path to the genome fasta file. Required if --use- unmapped flag is used.
      (Default: None)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
    type: File
    doc: gene FASTA file from extract_gene_seq.py script
    inputBinding:
      position: 101
      prefix: --input
  - id: mutations_file
    type: File
    doc: DNA mutations file (MAF file). Columns can be in any order, but should 
      contain the correct column header names.
    inputBinding:
      position: 101
      prefix: --mutations
  - id: null_distr_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory to save empirical null distribution
    inputBinding:
      position: 101
      prefix: --null-distr-dir
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: 'Number of iterations for null model. p-value precision increases with more
      iterations, however this will also increase the run time (Default: 100,000).'
    inputBinding:
      position: 101
      prefix: --num-iterations
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use for parallelization. 0 indicates using a single
      process without using a multiprocessing pool (more means Faster, default: 0).'
    inputBinding:
      position: 101
      prefix: --processes
  - id: report_index
    type:
      - 'null'
      - boolean
    doc: Flag for reporting index (row number, starts at zero) in associated 
      mutation file
    inputBinding:
      position: 101
      prefix: --report-index
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Specify the seed for the pseudo random number generator. By default, the
      seed is randomly chosen. The seed will be used for the monte carlo simulations
      (Default: 101).'
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
    inputBinding:
      position: 101
      prefix: --stop-criteria
  - id: unique_mutations
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
  - id: window
    type:
      - 'null'
      - int
    doc: 'Sequence window size for HotMAPS 1D algorithm by number of codons (Default:
      3)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output_file
    type: File
    doc: Output text file of probabilistic 20/20 results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probabilistic2020:1.2.3--py37h9c5868f_4
