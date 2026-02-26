cwlVersion: v1.2
class: CommandLineTool
baseCommand: marbel
label: marbel
doc: "Create a metatranscriptome in silico dataset.\n\nTool homepage: https://github.com/jlab/marbel"
inputs:
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress the output fastq files
    default: true
    inputBinding:
      position: 101
      prefix: --compressed
  - id: deseq_dispersion_gene_mean
    type:
      - 'null'
      - float
    doc: 'For generating sampling: Gene mean dependent dispersion of DESeq2. Only
      set when you have knowledge of DESeq2 dispersion.'
    default: 0.3325853
    inputBinding:
      position: 101
      prefix: --deseq-dispersion-gene-mean
  - id: deseq_dispersion_general
    type:
      - 'null'
      - float
    doc: 'For generating sampling: General dispersion estimation of DESeq2. Only set
      when you have knowledge of DESeq2 dispersion.'
    default: 12.9105102
    inputBinding:
      position: 101
      prefix: --deseq-dispersion-general
  - id: dge_ratio
    type:
      - 'null'
      - float
    doc: Ratio of up and down regulated genes. Must be between 0 and 1.This is a
      random drawing process from normal distribution, so the actual ratio might
      vary.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --dge-ratio
  - id: error_model
    type:
      - 'null'
      - string
    doc: Sequencer model for the reads, use basic or perfect (no errors) for 
      custom read length. Note that read lenght must be set when using basic or 
      perfect.
    default: HiSeq
    inputBinding:
      position: 101
      prefix: --error-model
  - id: force_creation
    type:
      - 'null'
      - boolean
    doc: Force the creation of the dataset, even if available orthogroups do not
      suffice for specified number of orthogroups.
    default: false
    inputBinding:
      position: 101
      prefix: --force-creation
  - id: group_orthologs
    type:
      - 'null'
      - string
    doc: Determines the level of orthology in groups. If you use this, use it 
      with a lot of threads. Takes a long time.
    default: normal
    inputBinding:
      position: 101
      prefix: --group-orthologs
  - id: install_completion
    type:
      - 'null'
      - boolean
    doc: Install completion for the current shell.
    inputBinding:
      position: 101
      prefix: --install-completion
  - id: library_size
    type:
      - 'null'
      - int
    doc: Library size for the reads.
    default: 100000
    inputBinding:
      position: 101
      prefix: --library-size
  - id: library_size_distribution
    type:
      - 'null'
      - string
    doc: "Distribution for the library size. Select from: ['poisson', 'uniform', 'negative_binomial']"
    default: uniform
    inputBinding:
      position: 101
      prefix: --library-size-distribution
  - id: max_phylo_dist
    type:
      - 'null'
      - string
    doc: Maximimum mean phylogenetic distance for orthologous groups.specify 
      stricter limit, if you want to avoid orthologous groupswith a more diverse
      phylogenetic distance.
    default: None
    inputBinding:
      position: 101
      prefix: --max-phylo-dist
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum mean sequence identity score for an orthologous groups.Specify 
      for more
    default: None
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap for the blocks. Use this to evaluate overlap blocks, 
      i.e. uninterrupted parts covered with reads that overlap on the genome. 
      Accounts for kmer size.
    default: 16
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: min_sparsity
    type:
      - 'null'
      - float
    doc: Will archive the minimum specified sparsity by zeroing count values 
      randomly.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-sparsity
  - id: n_orthogroups
    type:
      - 'null'
      - int
    doc: 'Number of orthologous groups to be drawn for the metatranscriptome in silico
      dataset. Maximum value: 365813.'
    default: 1000
    inputBinding:
      position: 101
      prefix: --n-orthogroups
  - id: n_samples
    type:
      - 'null'
      - type: array
        items: int
    doc: Number of samples to be created for the metatranscriptome in silico 
      datasetthe first number is the number of samples for group 1 andthe second
      number is the number of samples for group 2
    default:
      - 10
      - 10
    inputBinding:
      position: 101
      prefix: --n-samples
  - id: n_species
    type:
      - 'null'
      - int
    doc: 'Number of species to be drawn for the metatranscriptome in silico dataset.
      Maximum value: 614.'
    default: 20
    inputBinding:
      position: 101
      prefix: --n-species
  - id: no_compressed
    type:
      - 'null'
      - boolean
    doc: Compress the output fastq files
    default: false
    inputBinding:
      position: 101
      prefix: --no-compressed
  - id: no_force_creation
    type:
      - 'null'
      - boolean
    doc: Force the creation of the dataset, even if available orthogroups do not
      suffice for specified number of orthogroups.
    default: true
    inputBinding:
      position: 101
      prefix: --no-force-creation
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output directory for the metatranscriptome in silico dataset
    default: simulated_reads
    inputBinding:
      position: 101
      prefix: --outdir
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length for the reads. Only available when using error_model basic 
      or perfect
    default: None
    inputBinding:
      position: 101
      prefix: --read-length
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the sampling. Set for reproducibility
    default: None
    inputBinding:
      position: 101
      prefix: --seed
  - id: show_completion
    type:
      - 'null'
      - boolean
    doc: Show completion for the current shell, to copy it or customize the 
      installation.
    inputBinding:
      position: 101
      prefix: --show-completion
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to be used. Use 0 or -1 for auto detection. Uppler limit:
      128.'
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marbel:0.2.4--pyh7e72e81_0
stdout: marbel.out
