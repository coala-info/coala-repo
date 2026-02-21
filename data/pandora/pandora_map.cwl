cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - map
label: pandora_map
doc: "Quasi-map reads to an indexed PRG, infer the sequence of present loci in the
  sample, and optionally genotype variants.\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: target
    type: File
    doc: An indexed PRG file (in fasta format)
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Fast{a,q} file containing reads to quasi-map
    inputBinding:
      position: 2
  - id: binomial_model
    type:
      - 'null'
      - boolean
    doc: 'Use binomial model for kmer coverages [default: negative binomial]'
    inputBinding:
      position: 103
      prefix: --bin
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Add a step to clean and detangle the pangraph
    inputBinding:
      position: 103
      prefix: --clean
  - id: comparison_paths
    type:
      - 'null'
      - boolean
    doc: Save a fasta file for a random selection of paths through loci
    inputBinding:
      position: 103
      prefix: --comparison-paths
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Estimated error rate for reads
    default: 0.11
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated length of the genome - used for coverage estimation. Can pass string
      such as 4.4m, 100k etc.
    default: '5000000'
    inputBinding:
      position: 103
      prefix: --genome-size
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: Add extra step to carefully genotype sites.
    inputBinding:
      position: 103
      prefix: --genotype
  - id: gt_conf
    type:
      - 'null'
      - int
    doc: Minimum genotype confidence (GT_CONF) required to make a call
    default: 1
    inputBinding:
      position: 103
      prefix: --gt-conf
  - id: gt_error_rate
    type:
      - 'null'
      - float
    doc: When genotyping, assume that coverage on alternative alleles arises as a
      result of an error process with rate -E.
    default: 0.01
    inputBinding:
      position: 103
      prefix: --gt-error-rate
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: Reads are from Illumina. Alters error rate used and adjusts for shorter reads
    inputBinding:
      position: 103
      prefix: --illumina
  - id: kmer_avg
    type:
      - 'null'
      - int
    doc: Maximum number of kmers to average over when selecting the maximum likelihood
      path
    default: 100
    inputBinding:
      position: 103
      prefix: --kmer-avg
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    default: 15
    inputBinding:
      position: 103
      prefix: -k
  - id: local_genotyping
    type:
      - 'null'
      - boolean
    doc: Use coverage-oriented (local) genotyping instead of the default ML path-oriented
      (global) approach.
    inputBinding:
      position: 103
      prefix: --local
  - id: loci_vcf
    type:
      - 'null'
      - boolean
    doc: Save a VCF file for each found loci
    inputBinding:
      position: 103
      prefix: --loci-vcf
  - id: mapped_reads
    type:
      - 'null'
      - boolean
    doc: Save a fasta file for each loci containing read parts which overlapped it
    inputBinding:
      position: 103
      prefix: --mapped-reads
  - id: max_covg
    type:
      - 'null'
      - int
    doc: Maximum coverage of reads to accept
    default: 300
    inputBinding:
      position: 103
      prefix: --max-covg
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Maximum distance (bp) between consecutive hits within a cluster
    default: 250
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: min_allele_covg
    type:
      - 'null'
      - int
    doc: Hard threshold for the minimum allele coverage allowed when genotyping
    default: 0
    inputBinding:
      position: 103
      prefix: -a
  - id: min_allele_fraction
    type:
      - 'null'
      - int
    doc: Minimum allele coverage, as a fraction of the expected coverage, allowed
      when genotyping
    default: 0
    inputBinding:
      position: 103
      prefix: -F
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum size of a cluster of hits between a read and a loci to consider the
      loci present
    default: 10
    inputBinding:
      position: 103
      prefix: --min-cluster-size
  - id: min_diff_covg
    type:
      - 'null'
      - int
    doc: Minimum difference in coverage on a site required between the first and second
      maximum likelihood path
    default: 0
    inputBinding:
      position: 103
      prefix: -D
  - id: min_total_covg
    type:
      - 'null'
      - int
    doc: The minimum required total coverage for a site when genotyping
    default: 0
    inputBinding:
      position: 103
      prefix: -s
  - id: save_kmer_graphs
    type:
      - 'null'
      - boolean
    doc: Save kmer graphs with forward and reverse coverage annotations for found
      loci
    inputBinding:
      position: 103
      prefix: --kg
  - id: snps_only
    type:
      - 'null'
      - boolean
    doc: When genotyping, only include SNP sites
    inputBinding:
      position: 103
      prefix: --snps
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: vcf_refs
    type:
      - 'null'
      - File
    doc: Fasta file with a reference sequence to use for each loci. The sequence MUST
      have a perfect match in <TARGET> and the same name
    inputBinding:
      position: 103
      prefix: --vcf-refs
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 103
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for (w,k)-minimizers (must be <=k)
    default: 14
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output files to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
