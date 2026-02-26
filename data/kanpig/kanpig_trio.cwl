cwlVersion: v1.2
class: CommandLineTool
baseCommand: kanpig trio
label: kanpig_trio
doc: "Trio SV Genotyping\n\nTool homepage: https://github.com/ACEnglish/kanpig"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: father_reads
    type: File
    doc: Paternal reads to genotype (indexed .bam, .cram, or .plup.gz)
    inputBinding:
      position: 101
      prefix: --father
  - id: father_sample_name
    type:
      - 'null'
      - string
    doc: Output VCF paternal sample name
    default: PAT
    inputBinding:
      position: 101
      prefix: --father-sample
  - id: fn_penalty
    type:
      - 'null'
      - float
    doc: Scoring penalty for FNs
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fpenalty
  - id: gap_penalty
    type:
      - 'null'
      - float
    doc: Scoring penalty for gaps
    default: 0.02
    inputBinding:
      position: 101
      prefix: --gpenalty
  - id: gq_config
    type:
      - 'null'
      - string
    doc: GQ Config
    inputBinding:
      position: 101
      prefix: --gqconfig
  - id: haplotagged_reads_weight
    type:
      - 'null'
      - float
    doc: Clustering weight for haplotagged reads (off=0.0, full=1.0)
    default: 0.25
    inputBinding:
      position: 101
      prefix: --hps-weight
  - id: haplotype_lengths_weight
    type:
      - 'null'
      - float
    doc: Clustering weight for haplotype lengths (off=0.0, full=1.0)
    default: 0.25
    inputBinding:
      position: 101
      prefix: --len-weight
  - id: ignore_map_flag
    type:
      - 'null'
      - int
    doc: Ignore alignments matching flag
    default: 3840
    inputBinding:
      position: 101
      prefix: --mapflag
  - id: input_vcf
    type: File
    doc: VCF to genotype
    inputBinding:
      position: 101
      prefix: --input
  - id: karyotype
    type:
      - 'null'
      - string
    doc: Proband karyotype
    inputBinding:
      position: 101
      prefix: --karyotype
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size for featurization
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: Max clusters
    default: 5
    inputBinding:
      position: 101
      prefix: --maxclust
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage of a region to analyze
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-coverage
  - id: max_fn_in_path
    type:
      - 'null'
      - int
    doc: Maximum FNs allowed in a path
    default: 3
    inputBinding:
      position: 101
      prefix: --fnmax
  - id: max_graph_nodes
    type:
      - 'null'
      - int
    doc: Maximum graph size to search; otherwise perform 1-to-1
    default: 5000
    inputBinding:
      position: 101
      prefix: --maxnodes
  - id: max_haplotype_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage to attempt building haplotypes
    default: 1000
    inputBinding:
      position: 101
      prefix: --maxcoverage
  - id: max_partial_pileups
    type:
      - 'null'
      - int
    doc: Maximum pileups allowed for partials matching
    default: 100
    inputBinding:
      position: 101
      prefix: --pileupmax
  - id: max_paths_per_graph
    type:
      - 'null'
      - int
    doc: Maximum paths to traverse per graph
    default: 5000
    inputBinding:
      position: 101
      prefix: --maxpaths
  - id: max_variant_distance
    type:
      - 'null'
      - int
    doc: Maximum variant distance within graphs
    default: 1000
    inputBinding:
      position: 101
      prefix: --neighdist
  - id: max_variant_size
    type:
      - 'null'
      - int
    doc: Maximum size of variant to analyze
    default: 10000
    inputBinding:
      position: 101
      prefix: --sizemax
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage of a region to analyze
    default: 1
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_haplotype_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage to attempt building haplotypes
    default: 1
    inputBinding:
      position: 101
      prefix: --mincoverage
  - id: min_kmer_frequency
    type:
      - 'null'
      - int
    doc: Minimum frequency of kmers
    default: 2
    inputBinding:
      position: 101
      prefix: --minkfreq
  - id: min_mapq_score
    type:
      - 'null'
      - int
    doc: Minimum mapq score for reads
    default: 5
    inputBinding:
      position: 101
      prefix: --mapq
  - id: min_reads_in_cluster
    type:
      - 'null'
      - int
    doc: Minimum number of reads in a cluster
    default: 5
    inputBinding:
      position: 101
      prefix: --msmin
  - id: min_sequence_similarity
    type:
      - 'null'
      - float
    doc: Minimum sequence similarity for paths
    default: 0.9
    inputBinding:
      position: 101
      prefix: --seqsim
  - id: min_size_similarity
    type:
      - 'null'
      - float
    doc: Minimum size similarity for paths
    default: 0.9
    inputBinding:
      position: 101
      prefix: --sizesim
  - id: min_variant_size
    type:
      - 'null'
      - int
    doc: Minimum size of variant to analyze
    default: 50
    inputBinding:
      position: 101
      prefix: --sizemin
  - id: mother_reads
    type: File
    doc: Maternal reads to genotype (indexed .bam, .cram, or .plup.gz)
    inputBinding:
      position: 101
      prefix: --mother
  - id: mother_sample_name
    type:
      - 'null'
      - string
    doc: Output VCF maternal sample name
    default: MAT
    inputBinding:
      position: 101
      prefix: --mother-sample
  - id: one_to_one_matching
    type:
      - 'null'
      - boolean
    doc: Restrict to 1-to-1 haplotype/node matching
    inputBinding:
      position: 101
      prefix: --one-to-one
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only analyze variants with PASS FILTER
    inputBinding:
      position: 101
      prefix: --passonly
  - id: proband_reads
    type: File
    doc: Proband reads to genotype (indexed .bam, .cram, or .plup.gz)
    inputBinding:
      position: 101
      prefix: --proband
  - id: proband_sample_name
    type:
      - 'null'
      - string
    doc: Output VCF proband sample name
    default: PRO
    inputBinding:
      position: 101
      prefix: --proband-sample
  - id: reference_genome
    type: File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions_to_analyze
    type:
      - 'null'
      - File
    doc: Regions to analyze
    inputBinding:
      position: 101
      prefix: --bed
  - id: rnames_file
    type:
      - 'null'
      - File
    doc: Output RNAMES file
    inputBinding:
      position: 101
      prefix: --rnames
  - id: squish_paths
    type:
      - 'null'
      - boolean
    doc: Prefer simpler paths during scoring
    inputBinding:
      position: 101
      prefix: --squish
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: xxploidy_bed
    type:
      - 'null'
      - File
    doc: Bed file of XX karyotype
    inputBinding:
      position: 101
      prefix: --XXploidy-bed
  - id: xyploidy_bed
    type:
      - 'null'
      - File
    doc: Bed file of XY karyotype
    inputBinding:
      position: 101
      prefix: --XYploidy-bed
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF (unsorted, uncompressed)
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
