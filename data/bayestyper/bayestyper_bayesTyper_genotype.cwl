cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyper, genotype]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.kmer_files)
label: bayestyper_bayesTyper_genotype
doc: "BayesTyper genotype: genotype variant clusters\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_clusters_file
    type: File
    doc: variant_clusters.bin file (BayesTyper cluster output)
    inputBinding:
      position: 1
      prefix: -v
  - id: cluster_data_dir
    type: Directory
    doc: cluster data directory containing intercluster_regions.txt.gz, multigroup_kmers.bloom[Meta|Data]
      and parameter_kmers.fa.gz (BayesTyper cluster output)
    inputBinding:
      position: 1
      prefix: -c
  - id: samples_file
    type: File
    doc: samples file (<sample_id> <sex> <kmc_output_prefix> per line, no header)
    inputBinding:
      position: 1
      prefix: -s
  - id: kmer_files
    type:
      - 'null'
      - File[]
    doc: KMC3 tables and bloom filters (<prefix>.kmc_pre, .kmc_suf, .bloomMeta, .bloomData) named in the
      samples file; staged in the working directory so the samples file can name them by basename
  - id: genome_file
    type: File
    doc: reference genome file (fasta format)
    inputBinding:
      position: 1
      prefix: -g
  - id: decoy_file
    type:
      - 'null'
      - File
    doc: decoy sequences file (fasta format)
    inputBinding:
      position: 1
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: compress output file(s) using gzip
    inputBinding:
      position: 1
      prefix: -z
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'seed for pseudo-random number generator (default: unix time)'
    inputBinding:
      position: 1
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads used (+= 2 I/O threads) (default: 1)'
    inputBinding:
      position: 1
      prefix: -p
  - id: chromosome_ploidy_file
    type:
      - 'null'
      - File
    doc: chromosome gender ploidy file (<chromosome> <female_ploidy> <male_ploidy>); human ploidy is assumed
      if not given
    inputBinding:
      position: 1
      prefix: -y
  - id: gibbs_burn_in
    type:
      - 'null'
      - int
    doc: 'number of burn-in iterations (default: 100)'
    inputBinding:
      position: 1
      prefix: --gibbs-burn-in
  - id: gibbs_samples
    type:
      - 'null'
      - int
    doc: 'number of Gibbs iterations (default: 250)'
    inputBinding:
      position: 1
      prefix: --gibbs-samples
  - id: number_of_gibbs_chains
    type:
      - 'null'
      - int
    doc: 'number of independent Gibbs sampling chains (default: 20)'
    inputBinding:
      position: 1
      prefix: --number-of-gibbs-chains
  - id: kmer_subsampling_rate
    type:
      - 'null'
      - float
    doc: 'subsampling rate for subsetting kmers used for genotype inference (default: 0.1)'
    inputBinding:
      position: 1
      prefix: --kmer-subsampling-rate
  - id: max_haplotype_variant_kmers
    type:
      - 'null'
      - int
    doc: 'maximum number of kmers used for genotype inference after subsampling across a haplotype candidate
      for each variant (default: 500)'
    inputBinding:
      position: 1
      prefix: --max-haplotype-variant-kmers
  - id: noise_genotyping
    type:
      - 'null'
      - boolean
    doc: estimate noise model parameters and genotypes jointly (generally slower and uses more memory)
    inputBinding:
      position: 1
      prefix: --noise-genotyping
  - id: noise_rate_prior
    type:
      - 'null'
      - string
    doc: 'parameters for Poisson noise rate gamma prior (<shape>,<scale>) (default: 1,0.01)'
    inputBinding:
      position: 1
      prefix: --noise-rate-prior
  - id: min_genotype_posterior
    type:
      - 'null'
      - float
    doc: 'filter genotypes with a posterior probability (GPP) below <value> (default: 0.99)'
    inputBinding:
      position: 1
      prefix: --min-genotype-posterior
  - id: min_number_of_kmers
    type:
      - 'null'
      - int
    doc: 'filter sampled alleles with less than <value> kmers (NAK) (default: 1)'
    inputBinding:
      position: 1
      prefix: --min-number-of-kmers
  - id: disable_observed_kmers
    type:
      - 'null'
      - boolean
    doc: disable filtering of sampled alleles with a low fraction of observed kmers (FAK)
    inputBinding:
      position: 1
      prefix: --disable-observed-kmers
outputs:
  - id: output_vcf
    type: File
    doc: Output variant file (vcf or vcf.gz)
    outputBinding:
      glob:
        - $(inputs.output_prefix || 'bayestyper').vcf
        - $(inputs.output_prefix || 'bayestyper').vcf.gz
  - id: genomic_parameters
    type:
      - 'null'
      - File
    doc: Estimated genomic parameters (kmer coverage per sample)
    outputBinding:
      glob: $(inputs.output_prefix || 'bayestyper')_genomic_parameters.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
