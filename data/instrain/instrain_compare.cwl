cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - compare
label: instrain_compare
doc: "Compare multiple inStrain profiles (popANI, coverage_overlap, etc.)\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: input
    type:
      type: array
      items: Directory
    doc: 'A list of inStrain objects, all mapped to the same .fasta file'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: instrainComparer)'
    default: instrainComparer
    inputBinding:
      position: 101
      prefix: --output
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: stb
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Scaffold to bin. A file with each line listing a scaffold and a bin name, tab-separated, or a list of .fasta files with one genome per .fasta file. If nothing is provided, all scaffolds are treated as belonging to the same genome'
    inputBinding:
      position: 101
      prefix: --stb
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'Minimum coverage to call an variant (default: 5)'
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_freq
    type:
      - 'null'
      - float
    doc: 'Minimum SNP frequency to confirm a SNV (both this AND the FDR snp count cutoff must be true to call a SNP) (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: fdr
    type:
      - 'null'
      - float
    doc: 'SNP false discovery rate, based on simulation data with a 0.1 percent error rate (Q30) (default: 1e-06)'
    inputBinding:
      position: 101
      prefix: --fdr
  - id: database_mode
    type:
      - 'null'
      - boolean
    doc: 'Automatically determine which genomes are present in each Profile and only compare scaffolds from those genomes. All profiles must have run Profile with the same .stb (default: False)'
    inputBinding:
      position: 101
      prefix: --database_mode
  - id: breadth
    type:
      - 'null'
      - float
    doc: 'Minimum breadth_minCov required to count a genome present (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --breadth
  - id: scaffolds
    type:
      - 'null'
      - File
    doc: A list of scaffolds to compare. You can also make this a .fasta file and it will load the scaffold names
    inputBinding:
      position: 101
      prefix: --scaffolds
  - id: genome
    type:
      - 'null'
      - string
    doc: Run scaffolds belonging to this single genome only. Must provide an .stb file
    inputBinding:
      position: 101
      prefix: --genome
  - id: store_coverage_overlap
    type:
      - 'null'
      - boolean
    doc: 'Also store coverage overlap on an mm level (default: False)'
    inputBinding:
      position: 101
      prefix: --store_coverage_overlap
  - id: store_mismatch_locations
    type:
      - 'null'
      - boolean
    doc: 'Store the locations of SNPs (default: False)'
    inputBinding:
      position: 101
      prefix: --store_mismatch_locations
  - id: include_self_comparisons
    type:
      - 'null'
      - boolean
    doc: 'Also compare IS profiles against themself (default: False)'
    inputBinding:
      position: 101
      prefix: --include_self_comparisons
  - id: skip_plot_generation
    type:
      - 'null'
      - boolean
    doc: 'Dont create plots at the end of the run (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_plot_generation
  - id: group_length
    type:
      - 'null'
      - int
    doc: 'How many bp to compare simultaneously (higher will use more RAM and run more quickly) (default: 10000000)'
    inputBinding:
      position: 101
      prefix: --group_length
  - id: force_compress
    type:
      - 'null'
      - boolean
    doc: 'Force compression of all output files (default: False)'
    inputBinding:
      position: 101
      prefix: --force_compress
  - id: ani_threshold
    type:
      - 'null'
      - float
    doc: 'popANI threshold to cluster genomes at. Must provide .stb file to do so (default: 0.99999)'
    inputBinding:
      position: 101
      prefix: --ani_threshold
  - id: coverage_treshold
    type:
      - 'null'
      - float
    doc: 'Minimum percent_genome_compared for a genome comparison to count; if below the popANI will be set to 0 (default: 0.1)'
    inputBinding:
      position: 101
      prefix: --coverage_treshold
  - id: cluster_alg
    type:
      - 'null'
      - type: enum
        symbols:
          - median
          - ward
          - weighted
          - single
          - average
          - complete
          - centroid
    doc: 'Algorithm used to cluster genomes (passed to scipy.cluster.hierarchy.linkage) (default: average)'
    inputBinding:
      position: 101
      prefix: --clusterAlg
  - id: bams
    type:
      - 'null'
      - type: array
        items: File
    doc: Location of .bam files used during inStrain profile commands; needed to pull low-frequency SNVs. MUST BE IN SAME ORDER AS THE INPUT FILES
    inputBinding:
      position: 101
      prefix: --bams
  - id: skip_popani
    type:
      - 'null'
      - boolean
    doc: 'Only run SNV Pooling; skip other compare operations (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_popANI
outputs:
  - id: compare_dir
    type: Directory
    doc: inStrain compare output directory (named by the output prefix)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
