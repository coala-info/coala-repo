cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/pandora
  - compare
label: pandora_compare
doc: "Quasi-map reads from multiple samples to an indexed PRG, infer the sequence
  of present loci in each sample, and call variants between the samples.\n\nTool homepage:
  https://github.com/rmcolq/pandora"
inputs:
  - id: target
    type: File
    doc: An indexed PRG file (in fasta format)
    inputBinding:
      position: 1
  - id: query_idx
    type: File
    doc: A tab-delimited file where each line is a sample identifier followed by the
      path to the fast{a,q} of reads for that sample
    inputBinding:
      position: 2
  - id: bin
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
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Estimated error rate for reads
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated length of the genome - used for coverage estimation. Can pass string
      such as 4.4m, 100k etc.
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
    inputBinding:
      position: 103
      prefix: --gt-conf
  - id: gt_error_rate
    type:
      - 'null'
      - float
    doc: When genotyping, assume that coverage on alternative alleles arises as a
      result of an error process with rate -E.
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
    inputBinding:
      position: 103
      prefix: --kmer-avg
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    inputBinding:
      position: 103
      prefix: -k
  - id: local
    type:
      - 'null'
      - boolean
    doc: (Intended for developers) Use coverage-oriented (local) genotyping instead
      of the default ML path-oriented (global) approach.
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
  - id: max_covg
    type:
      - 'null'
      - int
    doc: Maximum coverage of reads to accept
    inputBinding:
      position: 103
      prefix: --max-covg
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Maximum distance (bp) between consecutive hits within a cluster
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: min_allele_covg
    type:
      - 'null'
      - int
    doc: Hard threshold for the minimum allele coverage allowed when genotyping
    inputBinding:
      position: 103
      prefix: -a
  - id: min_allele_fraction
    type:
      - 'null'
      - int
    doc: Minimum allele coverage, as a fraction of the expected coverage, allowed
      when genotyping
    inputBinding:
      position: 103
      prefix: -F
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum size of a cluster of hits between a read and a loci to consider the
      loci present
    inputBinding:
      position: 103
      prefix: --min-cluster-size
  - id: min_diff_covg
    type:
      - 'null'
      - int
    doc: Minimum difference in coverage on a site required between the first and second
      maximum likelihood path
    inputBinding:
      position: 103
      prefix: -D
  - id: min_total_covg
    type:
      - 'null'
      - int
    doc: The minimum required total coverage for a site when genotyping
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
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
