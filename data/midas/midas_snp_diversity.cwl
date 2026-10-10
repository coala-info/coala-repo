cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp_diversity.py
label: midas_snp_diversity
doc: "Compute nucleotide diversity from the output of merge_midas.py snps for one species.\n\nTool homepage:\
  \ https://github.com/snayfach/MIDAS"
inputs:
  - id: out
    type: string
    doc: Path to output file.
    inputBinding:
      position: 101
      prefix: --out
  - id: genomic_type
    type:
      - 'null'
      - string
    doc: 'Compute diversity for individual genes or genome-wide: genome-wide (default) or per-gene.'
    inputBinding:
      position: 101
      prefix: --genomic_type
  - id: sample_type
    type:
      - 'null'
      - string
    doc: 'Compute diversity for individual samples or pooled reads across samples: per-sample (default)
      or pooled-samples.'
    inputBinding:
      position: 101
      prefix: --sample_type
  - id: weight_by_depth
    type:
      - 'null'
      - boolean
    doc: Weight data from samples by sequencing depth when --sample_type=pooled-samples.
    inputBinding:
      position: 101
      prefix: --weight_by_depth
  - id: rand_reads
    type:
      - 'null'
      - int
    doc: Randomly select N reads from each sample for each genomic site.
    inputBinding:
      position: 101
      prefix: --rand_reads
  - id: replace_reads
    type:
      - 'null'
      - boolean
    doc: Reads drawn with replacement.
    inputBinding:
      position: 101
      prefix: --replace_reads
  - id: rand_samples
    type:
      - 'null'
      - int
    doc: Randomly select N samples from each genomic site.
    inputBinding:
      position: 101
      prefix: --rand_samples
  - id: rand_sites
    type:
      - 'null'
      - float
    doc: Randomly select X proportion of high-quality genomic sites.
    inputBinding:
      position: 101
      prefix: --rand_sites
  - id: snp_maf
    type:
      - 'null'
      - float
    doc: Minor allele frequency cutoff for determining if a site is a SNP (0.01).
    inputBinding:
      position: 101
      prefix: --snp_maf
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Call consensus alleles prior to calling SNPs.
    inputBinding:
      position: 101
      prefix: --consensus
  - id: sample_depth
    type:
      - 'null'
      - float
    doc: Minimum average read depth per sample (0.0).
    inputBinding:
      position: 101
      prefix: --sample_depth
  - id: sample_cov
    type:
      - 'null'
      - float
    doc: Fraction of reference sites covered by at least 1 read (0.0).
    inputBinding:
      position: 101
      prefix: --sample_cov
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples to process. Useful for quick tests (use all).
    inputBinding:
      position: 101
      prefix: --max_samples
  - id: keep_samples
    type:
      - 'null'
      - string
    doc: Comma-separated list of samples to include; samples are still subject to other filters.
    inputBinding:
      position: 101
      prefix: --keep_samples
  - id: exclude_samples
    type:
      - 'null'
      - string
    doc: Comma-separated list of samples to exclude; samples are still subject to other filters.
    inputBinding:
      position: 101
      prefix: --exclude_samples
  - id: site_list
    type:
      - 'null'
      - File
    doc: Path to list of sites to include; other filters still apply.
    inputBinding:
      position: 101
      prefix: --site_list
  - id: site_depth
    type:
      - 'null'
      - int
    doc: Minimum number of mapped reads per site (2).
    inputBinding:
      position: 101
      prefix: --site_depth
  - id: site_prev
    type:
      - 'null'
      - float
    doc: Site has at least site_depth coverage in at least this proportion of samples (0.0).
    inputBinding:
      position: 101
      prefix: --site_prev
  - id: site_maf
    type:
      - 'null'
      - float
    doc: Minimum average minor allele frequency of site across samples (0.0).
    inputBinding:
      position: 101
      prefix: --site_maf
  - id: site_ratio
    type:
      - 'null'
      - float
    doc: Maximum ratio of site depth to mean genome depth (None).
    inputBinding:
      position: 101
      prefix: --site_ratio
  - id: allele_support
    type:
      - 'null'
      - float
    doc: Minimum fraction of reads supporting consensus allele.
    inputBinding:
      position: 101
      prefix: --allele_support
  - id: locus_type
    type:
      - 'null'
      - string
    doc: 'Use genomic sites that intersect: CDS, RNA or IGR.'
    inputBinding:
      position: 101
      prefix: --locus_type
  - id: site_type
    type:
      - 'null'
      - string
    doc: 'If locus_type is CDS, use genomic sites with specified degeneracy: 1D, 2D, 3D or 4D.'
    inputBinding:
      position: 101
      prefix: --site_type
  - id: max_sites
    type:
      - 'null'
      - int
    doc: Maximum number of sites to include in output (use all). Useful for quick tests.
    inputBinding:
      position: 101
      prefix: --max_sites
  - id: indir
    type: Directory
    doc: Path to output from merge_midas.py snps for one species (directory named by species_id with snps_*.txt
      files).
    inputBinding:
      position: 201
outputs:
  - id: out_file
    type: File
    doc: Diversity table.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
