cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol
label: zol
doc: "zol is a lightweight software that can generate reports on conservation, annotation,
  and evolutionary statistics for defined orthologous/homologous gene clusters (e.g.
  BGCs, phages, MGEs, or any genomic island / operon!).\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: allow_edge_cds
    type:
      - 'null'
      - boolean
    doc: Include CDS features within gene-cluster GenBanks with the attribute 
      "near_scaffold_edge = True", which is set by fai for features within 2kb 
      of contig edges.
    inputBinding:
      position: 101
      prefix: --allow-edge-cds
  - id: betard_analysis
    type:
      - 'null'
      - boolean
    doc: Compute Beta-RD-gc statsitics - off by default because it requires a 
      lot of memory for large gene cluster sets.
    inputBinding:
      position: 101
      prefix: --betard-analysis
  - id: ccds_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of chopped CDS (cCDS) features to keep. Relavent to 
      'domain-mode'.
    default: 50
    inputBinding:
      position: 101
      prefix: --ccds-min-length
  - id: clustering_inflation
    type:
      - 'null'
      - float
    doc: Inflation parameter for MCL clustering of ortholog groups. Can be set 
      to -1 for single-linkage clustering
    default: 1.5
    inputBinding:
      position: 101
      prefix: --clustering-inflation
  - id: comparator_genbanks
    type:
      - 'null'
      - File
    doc: Optional file with comparator gene clusters listed. Default is to use 
      remaining GenBanks as comparators to focal listing.
    inputBinding:
      position: 101
      prefix: --comparator-genbanks
  - id: comprehensive_evo_stats
    type:
      - 'null'
      - boolean
    doc: Compute evolutionary statistics for non-single-copy ortholog groups.
    inputBinding:
      position: 101
      prefix: --comprehensive-evo-stats
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: Minimum query coverage for an alignment between protein pairs from two 
      gene-clusters to consider in search for orthologs.
    default: 50.0
    inputBinding:
      position: 101
      prefix: --coverage-threshold
  - id: custom_database
    type:
      - 'null'
      - File
    doc: Path to FASTA file of protein sequences corresponding to a custom 
      annotation database.
    inputBinding:
      position: 101
      prefix: --custom-database
  - id: dc_orthogroup
    type:
      - 'null'
      - boolean
    doc: Cluster proteins using diamond cluster instead of using the standard 
      InParanoid-like ortholog group prediction approach. This approach is 
      faster and can use less memory, but is less accurate. Memory can be 
      controlled via the --max-memory option.
    inputBinding:
      position: 101
      prefix: --dc-orthogroup
  - id: dc_params
    type:
      - 'null'
      - string
    doc: Parameters for performing diamond cluster based ortholog group 
      clustering if requested via --dco-orthogroup.
    default: --approx-id 50 --mutual-cover 25
    inputBinding:
      position: 101
      prefix: --dc-params
  - id: derep_coverage
    type:
      - 'null'
      - float
    doc: skani aligned fraction threshold to use for dereplication.
    default: 95.0
    inputBinding:
      position: 101
      prefix: --derep-coverage
  - id: derep_identity
    type:
      - 'null'
      - float
    doc: skani ANI threshold to use for dereplication.
    default: 99.0
    inputBinding:
      position: 101
      prefix: --derep-identity
  - id: derep_inflation
    type:
      - 'null'
      - float
    doc: Inflation parameter for MCL to use for dereplication of gene clusters. 
      If not specified single-linkage clustering will be used instead.
    inputBinding:
      position: 101
      prefix: --derep-inflation
  - id: derep_small_genomes
    type:
      - 'null'
      - boolean
    doc: Run skani with the --small-genomes preset for dereplication - 
      recommended if dealing with lots of gene cluster instances that are < 20 
      kb in length (requires skani version > 0.2.2).
    inputBinding:
      position: 101
      prefix: --derep-small-genomes
  - id: dereplicate
    type:
      - 'null'
      - boolean
    doc: Perform dereplication of input GenBanks using skani and single-linkage 
      clustering or MCL.
    inputBinding:
      position: 101
      prefix: --dereplicate
  - id: domain_mode
    type:
      - 'null'
      - boolean
    doc: Run zol in domain mode instead of standard full protein/CDS mode.
    inputBinding:
      position: 101
      prefix: --domain-mode
  - id: eukaryotic_gene_cluster
    type:
      - 'null'
      - boolean
    doc: Specify if input are eukaryotic gene clusters. Tells zol to avoid 
      converting V or L residues to M when translating cCDS nucleotides in 
      domain mode.
    inputBinding:
      position: 101
      prefix: --eukaryotic-gene-cluster
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: Maximum E-value for an alignment between protein pairs from two 
      gene-clusters to consider in search for orthologs.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue-threshold
  - id: filter_draft_quality
    type:
      - 'null'
      - boolean
    doc: Filter records of gene-clusters which feature CDS features on the edge 
      of contigs (those marked with attribute near_contig_edge = True by fai) or
      which are multi-record.
    inputBinding:
      position: 101
      prefix: --filter-draft-quality
  - id: filter_low_quality
    type:
      - 'null'
      - boolean
    doc: Filter gene-clusters which feature alot of missing bases ( > 10 
      percent).
    inputBinding:
      position: 101
      prefix: --filter-low-quality
  - id: focal_genbanks
    type:
      - 'null'
      - File
    doc: File with focal gene clusters listed by GenBank file name (one per 
      line).
    inputBinding:
      position: 101
      prefix: --focal-genbanks
  - id: full_genbank_labels
    type:
      - 'null'
      - boolean
    doc: Use full GenBank labels instead of just the first 20 characters for 
      heatmap plot.
    inputBinding:
      position: 101
      prefix: --full-genbank-labels
  - id: gard_timeout
    type:
      - 'null'
      - int
    doc: Minutes to allow GARD to run before timing out and using the initial 
      alilgnment for downstream selection analyses instead
    default: 60
    inputBinding:
      position: 101
      prefix: --gard-timeout
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: Minimum identity coverage for an alignment between protein pairs from 
      two gene-clusters to consider in search for orthologs.
    default: 30.0
    inputBinding:
      position: 101
      prefix: --identity-threshold
  - id: impute_broad_conservation
    type:
      - 'null'
      - boolean
    doc: Impute weighted conservation stats based on cluster size associated 
      with dereplicated representatives.
    inputBinding:
      position: 101
      prefix: --impute-broad-conservation
  - id: input
    type:
      type: array
      items: File
    doc: Either a directory or set of files with orthologous/ homologous 
      locus-specific GenBanks. Files must end with '.gbk', '.gbff', or 
      '.genbank'.
    inputBinding:
      position: 101
      prefix: --input
  - id: length
    type:
      - 'null'
      - int
    doc: Specify the height/length of the heatmap plot
    default: 7
    inputBinding:
      position: 101
      prefix: --length
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Uses resource module to set soft memory limit. Provide in Giga-bytes. 
      Configured in the shell environment
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: only_orthogroups
    type:
      - 'null'
      - boolean
    doc: Only compute ortholog groups and stop (runs up to step 2).
    inputBinding:
      position: 101
      prefix: --only-orthogroups
  - id: pfam_params
    type:
      - 'null'
      - string
    doc: 'Parameters for controlling Pfam domain annotation with PyHMMER. String with
      three space-separated parts: 1) Domain filtering mode (Domain or Full) 2) Score
      cutoff (Gathering, Trusted, Noise, or None) 3) E-value threshold (float)'
    default: Domain Gathering 10.0
    inputBinding:
      position: 101
      prefix: --pfam-params
  - id: precomputed_orthogroups
    type:
      - 'null'
      - File
    doc: Path to two-column tab delimited file where the first column 
      corresponds to locus_tags and the second column to corresponding 
      orthogroup identifiers. Requires locus tags to be non-overlapping across 
      input gene cluster GenBank files and ortholog designations for all CDS 
      locus tags.
    inputBinding:
      position: 101
      prefix: --precomputed-orthogroups
  - id: quality_align
    type:
      - 'null'
      - boolean
    doc: Use MUSCLE align instead of super5 for alignments - slower but more 
      accurate.
    inputBinding:
      position: 101
      prefix: --quality-align
  - id: reinflate
    type:
      - 'null'
      - boolean
    doc: Perform ortholog group re-inflation to incorporate CDS from 
      non-representative gene-clusters following dereplication.
    inputBinding:
      position: 101
      prefix: --reinflate
  - id: reinflate_params
    type:
      - 'null'
      - string
    doc: Parameters for running DIAMOND blastp-based re-inflation, please 
      surround argument input with double quotes. First value should be the 
      DIAMOND blastp search mode, second should be identity threshold to match 
      non-rep proteins to rep proteins, and third should be the non-rep protein 
      coverage threshold to the rep
    default: fast 98.0 95.0
    inputBinding:
      position: 101
      prefix: --reinflate-params
  - id: rename_lt
    type:
      - 'null'
      - boolean
    doc: Rename locus-tags for CDS features in GenBanks.
    inputBinding:
      position: 101
      prefix: --rename-lt
  - id: select_fai_params_mode
    type:
      - 'null'
      - boolean
    doc: Mode for determining recommeded parameters for running fai to find more
      instances of the focal gene cluster.
    inputBinding:
      position: 101
      prefix: --select-fai-params-mode
  - id: selection_analysis
    type:
      - 'null'
      - boolean
    doc: Run selection analysis using HyPhy's GARD BUSTED, and FUBAR methods. 
      Warning, can take a while to run.
    inputBinding:
      position: 101
      prefix: --selection-analysis
  - id: skip_annotations
    type:
      - 'null'
      - boolean
    doc: Whether to skip performing functional annotations.
    inputBinding:
      position: 101
      prefix: --skip-annotations
  - id: skip_busted
    type:
      - 'null'
      - boolean
    doc: Skip BUSTED selection analysis.
    inputBinding:
      position: 101
      prefix: --skip-busted
  - id: skip_cleanup
    type:
      - 'null'
      - boolean
    doc: Whether to skip cleanup of temporary files in the 
      'Determine_Orthogroups/' subdirectory.
    inputBinding:
      position: 101
      prefix: --skip-cleanup
  - id: skip_gard
    type:
      - 'null'
      - boolean
    doc: Skip GARD detection of recombination breakpoints prior to running FUBAR
      selection analysis. Less accurate than running with GARD preliminary 
      analysis, but much faster.
    inputBinding:
      position: 101
      prefix: --skip-gard
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: width
    type:
      - 'null'
      - int
    doc: Specify the width of the heatmap plot
    default: 14
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
