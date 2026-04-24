cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-Pan
label: lsabgc_lsaBGC-Pan
doc: "Workflow to run a pan-genome analysis of biosynthetic gene clusters for a single
  genus or species.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: alignment_timeout
    type:
      - 'null'
      - int
    doc: "The timeout in seconds for constructing proteins alignments using\n    \
      \                    MUSCLE during lsaBGC-Reconcile and lsaBGC-Sociate - to
      prevent long\n                        runs due to stragglers/abnormally large
      orthogroups [Default is\n                        1800 (30 minutes)]."
    inputBinding:
      position: 101
      prefix: --alignment-timeout
  - id: antismash_results_directory
    type:
      - 'null'
      - Directory
    doc: "A directory with subdirectories corresponding to antiSMASH results\n   \
      \                     per sample/genome [Optional]."
    inputBinding:
      position: 101
      prefix: --antismash-results-directory
  - id: cluster_containment
    type:
      - 'null'
      - float
    doc: "Cutoff for percentage of OGs for a gene cluster near a contig edge\n   \
      \                     to be found within the comparing gene cluster for the
      pair to be\n                        considered in MCL (a minimum of 3 OGs shared
      are still required) [Default\n                        is 70.0]"
    inputBinding:
      position: 101
      prefix: --cluster-containment
  - id: cluster_inflation
    type:
      - 'null'
      - float
    doc: "The MCL inflation parameter for clustering BGCs into GCFs [Default\n   \
      \                     is 0.8]."
    inputBinding:
      position: 101
      prefix: --cluster-inflation
  - id: cluster_jaccard
    type:
      - 'null'
      - float
    doc: "Cutoff for Jaccard similarity of homolog groups shared between two\n   \
      \                     BGCs [Default is 50.0]."
    inputBinding:
      position: 101
      prefix: --cluster-jaccard
  - id: cluster_syntenic_correlation
    type:
      - 'null'
      - float
    doc: "The minimal correlation coefficient needed between for considering them\n\
      \                        as a pair prior to MCL [Default is 0.4]."
    inputBinding:
      position: 101
      prefix: --cluster-syntenic-correlation
  - id: core_proportion
    type:
      - 'null'
      - float
    doc: "What proportion of genomes single-copy orthogroups need to be\n        \
      \                found in to be used for species tree construction [Default
      is 0.9]."
    inputBinding:
      position: 101
      prefix: --core-proportion
  - id: edge_distance
    type:
      - 'null'
      - int
    doc: "Distance in bp to scaffold/contig edge to be considered potentially\n  \
      \                      fragmented. Used in GCF clustering (related to --cluster-containment\n\
      \                        parameter) and zol conservation computations [Default
      is 5000]."
    inputBinding:
      position: 101
      prefix: --edge-distance
  - id: fungal
    type:
      - 'null'
      - boolean
    doc: "Specify if input are from fungal genomes. Only possible\n              \
      \          if antiSMASH results are provided."
    inputBinding:
      position: 101
      prefix: --fungal
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Paths to genomes or directories with genomes in FASTA format.\n        \
      \                Will run GECCO for BGC-predictions [Optional]."
    inputBinding:
      position: 101
      prefix: --genomes
  - id: high_quality_phylogeny
    type:
      - 'null'
      - boolean
    doc: Prioritize quality over speed for phylogeny construction.
    inputBinding:
      position: 101
      prefix: --high-quality-phylogeny
  - id: high_quality_reconcile
    type:
      - 'null'
      - boolean
    doc: Perform high-quality alignment for reconcile analysis.
    inputBinding:
      position: 101
      prefix: --high-quality-reconcile
  - id: keep_locus_tags
    type:
      - 'null'
      - boolean
    doc: "Attempt to keep original locus tags in antiSMASH GenBank\n             \
      \           files - if locus tag is missing for one or more CDS\n          \
      \              features new ones will be generated for the sample (experimental)."
    inputBinding:
      position: 101
      prefix: --keep-locus-tags
  - id: manual_populations_file
    type:
      - 'null'
      - File
    doc: "Tab delimited file for manual mapping of samples to different\n        \
      \                populations/clades."
    inputBinding:
      position: 101
      prefix: --manual-populations-file
  - id: max_core_genes
    type:
      - 'null'
      - int
    doc: "The maximum number of single copy (near-)core orthogroups to\n         \
      \               use [Default is 500]."
    inputBinding:
      position: 101
      prefix: --max-core-genes
  - id: no_break
    type:
      - 'null'
      - boolean
    doc: "No break after step 5 to assess GCF clustering and population\n        \
      \                stratification and adapt parameters."
    inputBinding:
      position: 101
      prefix: --no-break
  - id: output_directory
    type: Directory
    doc: Parent output/workspace directory.
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: population_identity_cutoff
    type:
      - 'null'
      - float
    doc: "The core-genome identity cutoff used to define pairs of genomes as\n   \
      \                     belonging to the same group/population [Default is 99.0]."
    inputBinding:
      position: 101
      prefix: --population-identity-cutoff
  - id: report_all_sociate_hits
    type:
      - 'null'
      - boolean
    doc: "Report all signficant pyseer hits with 'notes' - usually\n             \
      \           indicate some general issue - should be examined with caution:\n\
      \                        https://pyseer.readthedocs.io/en/master/usage.html#notes-field."
    inputBinding:
      position: 101
      prefix: --report-all-sociate-hits
  - id: run_coarse_orthofinder
    type:
      - 'null'
      - boolean
    doc: "Use coarse clustering for orthogroups in OrthoFinder instead\n         \
      \               of the more resolute hierarchical determined homolog groups.\n\
      \                        There are some advantages to coarse OGs, including
      their\n                        construction being deterministic."
    inputBinding:
      position: 101
      prefix: --run-coarse-orthofinder
  - id: run_gecco
    type:
      - 'null'
      - boolean
    doc: "If antiSMASH results are provided also run GECCO for\n                 \
      \       annotation of BGCs."
    inputBinding:
      position: 101
      prefix: --run-gecco
  - id: run_msa_orthofinder
    type:
      - 'null'
      - boolean
    doc: "Run OrthoFinder using multiple sequence alignments instead of\n        \
      \                DendroBlast to determine hierarchical ortholog groups."
    inputBinding:
      position: 101
      prefix: --run-msa-orthofinder
  - id: threads
    type:
      - 'null'
      - int
    doc: "Total number of threads/processes to use. Recommend inreasing as much\n\
      \                        as possible. [Default is 4]."
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_panaroo
    type:
      - 'null'
      - boolean
    doc: "Use Panaroo instead of OrthoFinder for orthology inference.\n          \
      \              Recommended if investigating a single bacterial species."
    inputBinding:
      position: 101
      prefix: --use-panaroo
  - id: use_prodigal
    type:
      - 'null'
      - boolean
    doc: "Use prodigal instead of pyrodigal (only if genomes are provided - not\n\
      \                        relevant if antiSMASH results provided)."
    inputBinding:
      position: 101
      prefix: --use-prodigal
  - id: zol_high_quality_preset
    type:
      - 'null'
      - boolean
    doc: "Use preset of options for performing high-quality and comprehensive zol\n\
      \                        analyses instead of prioritizing speed."
    inputBinding:
      position: 101
      prefix: --zol-high-quality-preset
  - id: zol_keep_multi_copy
    type:
      - 'null'
      - boolean
    doc: "Include all GCF instances in zol analysis, not just the most\n         \
      \               representative instance from each sample/genome."
    inputBinding:
      position: 101
      prefix: --zol-keep-multi-copy
  - id: zol_parameters
    type:
      - 'null'
      - string
    doc: "The parameters to run zol analyses with - please surround by quotes\n  \
      \                      [Defaut is \"\"]."
    inputBinding:
      position: 101
      prefix: --zol-parameters
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
stdout: lsabgc_lsaBGC-Pan.out
