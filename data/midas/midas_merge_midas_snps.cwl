cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merge_midas.py
  - snps
label: midas_merge_midas_snps
doc: "Perform multi-sample core-genome SNP calling and write SNP matrices.\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: input_dirs
    type:
      type: array
      items: Directory
    doc: Sample directories output by run_midas.py (given to -i as a comma-separated list, -t list).
    inputBinding:
      position: 101
      prefix: -i
      itemSeparator: ','
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to reference database. By default, the MIDAS_DB environmental variable is used.
    inputBinding:
      position: 101
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (1).
    inputBinding:
      position: 101
      prefix: --threads
  - id: core_snps
    type:
      - 'null'
      - boolean
    doc: 'Same as: --snp_type bi --site_depth 1 --site_ratio 2.0 --site_prev 0.95 (default).'
    inputBinding:
      position: 101
      prefix: --core_snps
  - id: core_sites
    type:
      - 'null'
      - boolean
    doc: 'Same as: --snp_type any --site_depth 1 --site_ratio 2.0 --site_prev 0.95.'
    inputBinding:
      position: 101
      prefix: --core_sites
  - id: all_snps
    type:
      - 'null'
      - boolean
    doc: 'Same as: --snp_type bi --site_prev 0.0.'
    inputBinding:
      position: 101
      prefix: --all_snps
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: 'Same as: --snp_type any --site_prev 0.0.'
    inputBinding:
      position: 101
      prefix: --all_sites
  - id: min_samples
    type:
      - 'null'
      - int
    doc: All species with >= MIN_SAMPLES (1).
    inputBinding:
      position: 101
      prefix: --min_samples
  - id: species_id
    type:
      - 'null'
      - string
    doc: Comma-separated list of species ids.
    inputBinding:
      position: 101
      prefix: --species_id
  - id: max_species
    type:
      - 'null'
      - int
    doc: Maximum number of species to call SNPs for (all with >= 1 sample).
    inputBinding:
      position: 101
      prefix: --max_species
  - id: sample_depth
    type:
      - 'null'
      - float
    doc: Minimum average read depth per sample (5.0).
    inputBinding:
      position: 101
      prefix: --sample_depth
  - id: fract_cov
    type:
      - 'null'
      - float
    doc: Fraction of reference sites covered by at least 1 read (0.4).
    inputBinding:
      position: 101
      prefix: --fract_cov
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples to process. Useful for quick tests (use all).
    inputBinding:
      position: 101
      prefix: --max_samples
  - id: all_samples
    type:
      - 'null'
      - boolean
    doc: Include all samples in output.
    inputBinding:
      position: 101
      prefix: --all_samples
  - id: snp_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'One or more of: mono, bi (default), tri, quad, any.'
    inputBinding:
      position: 101
      prefix: --snp_type
  - id: allele_freq
    type:
      - 'null'
      - float
    doc: Minimum frequency for calling an allele present (0.01). Values > 0.0 and < 0.5 are accepted.
    inputBinding:
      position: 101
      prefix: --allele_freq
  - id: site_depth
    type:
      - 'null'
      - int
    doc: Minimum number of reads mapped to genomic site (1).
    inputBinding:
      position: 101
      prefix: --site_depth
  - id: site_ratio
    type:
      - 'null'
      - float
    doc: Maximum ratio of site depth to genome depth (2.0).
    inputBinding:
      position: 101
      prefix: --site_ratio
  - id: site_prev
    type:
      - 'null'
      - float
    doc: Minimum fraction of samples where genomic site is >= SITE_DEPTH and <= SITE_RATIO (0.95).
    inputBinding:
      position: 101
      prefix: --site_prev
  - id: max_sites
    type:
      - 'null'
      - int
    doc: Maximum number of sites to include in output (use all). Useful for quick tests.
    inputBinding:
      position: 101
      prefix: --max_sites
  - id: outdir
    type: string
    doc: Directory for output files. A subdirectory will be created for each species_id.
    inputBinding:
      position: 201
arguments:
  - prefix: -t
    valueFrom: list
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory with the results.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
