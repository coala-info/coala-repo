cwlVersion: v1.2
class: CommandLineTool
baseCommand: fai
label: lsabgc_fai
doc: "Find additional instances of gene clusters in a genome database (made with prepTG) using flexible alignment and synteny criteria.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: target_genomes_db
    type: Directory
    doc: "Result directory from running prepTG for target genomesof interest."
    inputBinding:
      position: 1
      prefix: --target-genomes-db
  - id: query_inputs
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Paths to locus-specific GenBank(s)  to use as queries for searching for homologous/orthologous instances in target genomes. Files must end with \".gbk\", \".gbff\", or \".genbank\"."
    inputBinding:
      position: 1
      prefix: --query-inputs
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: "Path to reference genome in FASTA or GenBank format on which to define query gene cluster coordinates."
    inputBinding:
      position: 1
      prefix: --reference-genome
  - id: reference_contig
    type:
      - 'null'
      - string
    doc: "Scaffold name (up to first space) in refernece genome which features the query gene cluster."
    inputBinding:
      position: 1
      prefix: --reference-contig
  - id: reference_start
    type:
      - 'null'
      - int
    doc: "Start position of query gene cluster on scaffold in reference genome."
    inputBinding:
      position: 1
      prefix: --reference-start
  - id: reference_end
    type:
      - 'null'
      - int
    doc: "End position of query gene cluster on scaffold in reference genome."
    inputBinding:
      position: 1
      prefix: --reference-end
  - id: protein_queries
    type:
      - 'null'
      - File
    doc: "Path to protein multi-FASTA file to use as query."
    inputBinding:
      position: 1
      prefix: --protein-queries
  - id: single_query
    type:
      - 'null'
      - File
    doc: "Path to protein FASTA file containing a single protein to use as a query."
    inputBinding:
      position: 1
      prefix: --single-query
  - id: output_dir
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: draft_mode
    type:
      - 'null'
      - boolean
    doc: "Run in draft-mode to also report segments on scaffold edges which in aggregate (with other such segments) they meet criteria for reporting."
    inputBinding:
      position: 1
      prefix: --draft-mode
  - id: filter_paralogs
    type:
      - 'null'
      - boolean
    doc: "Filter paralogous instances of gene-cluster identified in a single target genome."
    inputBinding:
      position: 1
      prefix: --filter-paralogs
  - id: use_prodigal_gv_for_reference
    type:
      - 'null'
      - boolean
    doc: "If the --reference-genome option is used to define gene cluster coordinates, use prodigal-gv instead of pyrodigal to call genes in the region."
    inputBinding:
      position: 1
      prefix: --use-prodigal-gv-for-reference
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: "E-value cutoff for DIAMOND blastp to consider a gene in a target genome a hit to a query protein. [Default is 1e-5]."
    inputBinding:
      position: 1
      prefix: --evalue-cutoff
  - id: min_prop
    type:
      - 'null'
      - float
    doc: "The minimum proportion of distinct proteins/ortholog groups needed to report discrete segments of the gene-cluster. Note, that a minimum of 3 distinct query proteins/homolog groups are needed per segment reported [Default is 0.5]."
    inputBinding:
      position: 1
      prefix: --min-prop
  - id: key_protein_queries
    type:
      - 'null'
      - File
    doc: "Path to protein multi-FASTA file containing key query sequences which some proportion of are required to be present in a gene cluster at a specific E-value cutoff. Note, these genes must be sub-contained in the set of total query proteins. Otherwise, they will be ignored."
    inputBinding:
      position: 1
      prefix: --key-protein-queries
  - id: skip_key_protein_validation
    type:
      - 'null'
      - boolean
    doc: "Skip validation of key protein queries against query proteins. This is useful if the key protein queries are already validated against the query proteins."
    inputBinding:
      position: 1
      prefix: --skip-key-protein-validation
  - id: key_protein_evalue_cutoff
    type:
      - 'null'
      - float
    doc: "E-value cutoff for finding key query sequences in putative gene cluster homolog segments. [Default is 1e-5]. Disregarded if less strict than the general --evalue-cutoff."
    inputBinding:
      position: 1
      prefix: --key-protein-evalue-cutoff
  - id: key_protein_min_prop
    type:
      - 'null'
      - float
    doc: "The minimum proportion of distinct ortholog groups matching key proteins needed to report a homologous gene-cluster. [Default is 0.0]."
    inputBinding:
      position: 1
      prefix: --key-protein-min-prop
  - id: syntenic_correlation_threshold
    type:
      - 'null'
      - float
    doc: "The minimum syntenic correlation needed to at least one known GCF instance to report segment. [Default is 0.0; no syntenic assessment performed]."
    inputBinding:
      position: 1
      prefix: --syntenic-correlation-threshold
  - id: gc_delineation_mode
    type:
      - 'null'
      - string
    doc: "Method/mode for delineation of gene-cluster boundaries. Options are \"Gene-Clumper\" or \"HMM\" [Default is Gene-Clumper]."
    inputBinding:
      position: 1
      prefix: --gc-delineation-mode
  - id: flanking_context
    type:
      - 'null'
      - int
    doc: "Number of bases to append to the beginning/end of the gene-cluster segments identified [Default is 1000]."
    inputBinding:
      position: 1
      prefix: --flanking-context
  - id: max_genes_disconnect
    type:
      - 'null'
      - int
    doc: "Maximum number of genes between gene cluster segments detected by HMM to merge segments together. Alternatively the number of genes separating hits if Gene-Clumper mode is used. Allows for more inclusivity of novel auxiliary genes. [Default is 5]."
    inputBinding:
      position: 1
      prefix: --max-genes-disconnect
  - id: min_distinct_genes
    type:
      - 'null'
      - int
    doc: "Minimum number of distinct genes per scaffold/genome to consider it further for gene-cluster containment if not using -sq mode. [Default and minimum is 3]."
    inputBinding:
      position: 1
      prefix: --min-distinct-genes
  - id: gc_transition
    type:
      - 'null'
      - float
    doc: "Probability for gene-cluster to gene cluster transition in HMM. Should be between 0.0 and 1.0. [Default is 0.9]."
    inputBinding:
      position: 1
      prefix: --gc-transition
  - id: bg_transition
    type:
      - 'null'
      - float
    doc: "Probability for background to background transition in HMM. Should be between 0.0 and 1.0. [Default is 0.9]."
    inputBinding:
      position: 1
      prefix: --bg-transition
  - id: gc_emission
    type:
      - 'null'
      - float
    doc: "Emission probability of gene being in gene cluster state assuming a orthologis found at the e-value cutoff. [Default is 0.95]."
    inputBinding:
      position: 1
      prefix: --gc-emission
  - id: bg_emission
    type:
      - 'null'
      - float
    doc: "Emission probability of gene being in gene cluster state assuming no homolog is found at the e-value cutoff. [Default is 0.2]."
    inputBinding:
      position: 1
      prefix: --bg-emission
  - id: generate_plots
    type:
      - 'null'
      - boolean
    doc: "Generate red barplots for assessing gene cluster segments identified."
    inputBinding:
      position: 1
      prefix: --generate-plots
  - id: diamond_sensitivity
    type:
      - 'null'
      - string
    doc: "DIAMOND alignment sensitivity. Options include: default, fast, mid-sensitive, sensitive, more-sensitive, very-sensitive, and ultra-sensitive [Default is very-sensitive]."
    inputBinding:
      position: 1
      prefix: --diamond-sensitivity
  - id: diamond_block_size
    type:
      - 'null'
      - int
    doc: "DIAMOND block size - increased value will result in increased memory usage but faster execution. Check out the DIAMOND wiki for more details. [Default is None, use whatever the DIAMOND default is for the sensitivity mode selected.]."
    inputBinding:
      position: 1
      prefix: --diamond-block-size
  - id: species_tree
    type:
      - 'null'
      - File
    doc: "Phylogeny in Newick format - with names matching target genomes db [Optional]. Will be used for creating an extra visual."
    inputBinding:
      position: 1
      prefix: --species-tree
  - id: phyloheatmap_length
    type:
      - 'null'
      - float
    doc: "Specify the height/length of the phylo-heatmap plot [Default is 7]."
    inputBinding:
      position: 1
      prefix: --phyloheatmap-length
  - id: phyloheatmap_width
    type:
      - 'null'
      - float
    doc: "Specify the width of the phylo-heatmap plot [Default is 10]."
    inputBinding:
      position: 1
      prefix: --phyloheatmap-width
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
  - id: clean_up
    type:
      - 'null'
      - boolean
    doc: "Clean up disk-heavy files/folders."
    inputBinding:
      position: 1
      prefix: --clean-up
  - id: max_memory
    type:
      - 'null'
      - int
    doc: "Uses resource module to set soft memory limit. Provide in Giga-bytes. Configured in the shell environment [Default is None; experimental]."
    inputBinding:
      position: 1
      prefix: --max-memory
outputs:
  - id: output_dir_dir
    type: Directory
    doc: Results directory written with --output-dir.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
