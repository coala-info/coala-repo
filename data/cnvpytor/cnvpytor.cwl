cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvpytor
label: cnvpytor
doc: "Lite version of the CNVnator written in Python. A tool for CNV discovery from
  depth of read mapping.\n\nTool homepage: https://github.com/abyzovlab/CNVpytor"
inputs:
  - id: ad_tag
    type:
      - 'null'
      - string
    doc: 'counts tag (default: AD)'
    inputBinding:
      position: 101
      prefix: --ad_tag
  - id: all
    type:
      - 'null'
      - boolean
    doc: Genotype with all columns
    inputBinding:
      position: 101
      prefix: --all
  - id: alt_corr
    type:
      - 'null'
      - boolean
    doc: Remove alt/ref bias
    inputBinding:
      position: 101
      prefix: --alt_corr
  - id: animation
    type:
      - 'null'
      - string
    doc: animation folder/prefix
    inputBinding:
      position: 101
      prefix: --animation
  - id: baf
    type:
      - 'null'
      - type: array
        items: int
    doc: create BAF histograms for specified bin size (multiple bin sizes 
      separate by space)
    inputBinding:
      position: 101
      prefix: --baf
  - id: baf_likelihood_width
    type:
      - 'null'
      - float
    doc: likelihood width used in processing SNP data (default=0.8)
    inputBinding:
      position: 101
      prefix: --baf_likelihood_width
  - id: baf_resolution
    type:
      - 'null'
      - float
    doc: Resolution for unphased BAF likelihood
    inputBinding:
      position: 101
      prefix: --baf_resolution
  - id: baf_threshold
    type:
      - 'null'
      - float
    doc: threshold for change in BAF level
    inputBinding:
      position: 101
      prefix: --baf_threshold
  - id: call
    type:
      - 'null'
      - type: array
        items: string
    doc: 'CNV caller: [baf] bin_size [bin_size2 ...] (multiple bin sizes separate
      by space)'
    inputBinding:
      position: 101
      prefix: --call
  - id: callset
    type:
      - 'null'
      - string
    doc: name for somatic VCF signal
    inputBinding:
      position: 101
      prefix: --callset
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
    doc: list of chromosomes to apply calculation
    inputBinding:
      position: 101
      prefix: --chrom
  - id: compare
    type:
      - 'null'
      - type: array
        items: string
    doc: 'compere two regions: -comp reg1 reg2 [n_bins]'
    inputBinding:
      position: 101
      prefix: --compare
  - id: copy_gc
    type:
      - 'null'
      - File
    doc: copy GC/AT content from another cnvnator file
    inputBinding:
      position: 101
      prefix: --copy_gc
  - id: download_resources
    type:
      - 'null'
      - boolean
    doc: download resource files
    inputBinding:
      position: 101
      prefix: --download_resources
  - id: dp_tag
    type:
      - 'null'
      - string
    doc: 'read depth tag (default: DP)'
    inputBinding:
      position: 101
      prefix: --dp_tag
  - id: export
    type:
      - 'null'
      - type: array
        items: string
    doc: Export to jbrowse and cnvnator
    inputBinding:
      position: 101
      prefix: --export
  - id: filter_nan
    type:
      - 'null'
      - boolean
    doc: filter nan values in rd/partition
    inputBinding:
      position: 101
      prefix: --filter_nan
  - id: force_agg
    type:
      - 'null'
      - boolean
    doc: Force Agg matplotlib backend
    inputBinding:
      position: 101
      prefix: --force_agg
  - id: gc
    type:
      - 'null'
      - File
    doc: read fasta file and store GC/AT content
    inputBinding:
      position: 101
      prefix: --gc
  - id: gc_auto
    type:
      - 'null'
      - boolean
    doc: use autosomal GC correction for X, Y and MT
    inputBinding:
      position: 101
      prefix: --gc_auto
  - id: gc_corr_rm_ol
    type:
      - 'null'
      - boolean
    doc: use only rd bins between 75% and 125% of mean value for gc correction 
      curve
    inputBinding:
      position: 101
      prefix: --gc_corr_rm_ol
  - id: gc_info
    type:
      - 'null'
      - boolean
    doc: list pytor file(s) gc content stat
    inputBinding:
      position: 101
      prefix: --gc_info
  - id: genome_norm_pct
    type:
      - 'null'
      - float
    doc: minimal percentage of genome used for normalisation
    inputBinding:
      position: 101
      prefix: --genome_norm_pct
  - id: genotype
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype regions
    inputBinding:
      position: 101
      prefix: --genotype
  - id: genotype_genes
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype genes
    inputBinding:
      position: 101
      prefix: --genotype_genes
  - id: gt_tag
    type:
      - 'null'
      - string
    doc: 'genotype tag (default: GT)'
    inputBinding:
      position: 101
      prefix: --gt_tag
  - id: his
    type:
      - 'null'
      - type: array
        items: int
    doc: create histograms for specified bin size (multiple bin sizes separate 
      by space)
    inputBinding:
      position: 101
      prefix: --his
  - id: his_from_snp
    type:
      - 'null'
      - type: array
        items: int
    doc: create histograms for specified bin size (multiple bin sizes separate 
      by space)
    inputBinding:
      position: 101
      prefix: --his_from_snp
  - id: idvar
    type:
      - 'null'
      - File
    doc: read vcf file and flag SNPs that exist in database file
    inputBinding:
      position: 101
      prefix: --idvar
  - id: info
    type:
      - 'null'
      - type: array
        items: File
    doc: print statistics for pythor file(s)
    inputBinding:
      position: 101
      prefix: --info
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file
    inputBinding:
      position: 101
      prefix: --log_file
  - id: ls
    type:
      - 'null'
      - boolean
    doc: list pytor file(s) content
    inputBinding:
      position: 101
      prefix: --ls
  - id: make_gc_genome_file
    type:
      - 'null'
      - boolean
    doc: used with -gc will create genome gc file
    inputBinding:
      position: 101
      prefix: --make_gc_genome_file
  - id: make_mask_genome_file
    type:
      - 'null'
      - boolean
    doc: used with -mask will create genome mask file
    inputBinding:
      position: 101
      prefix: --make_mask_genome_file
  - id: mask
    type:
      - 'null'
      - File
    doc: read fasta mask file and flag SNPs in P region
    inputBinding:
      position: 101
      prefix: --mask
  - id: mask_snps
    type:
      - 'null'
      - boolean
    doc: flag SNPs in P region
    inputBinding:
      position: 101
      prefix: --mask_snps
  - id: mask_snvs
    type:
      - 'null'
      - string
    doc: flag SNVs in P region
    inputBinding:
      position: 101
      prefix: --mask_snvs
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: maximal copy number
    inputBinding:
      position: 101
      prefix: --max_copy_number
  - id: max_cores
    type:
      - 'null'
      - int
    doc: maximal number of cores to use in calculation
    inputBinding:
      position: 101
      prefix: --max_cores
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: list Metadata
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_cell_fraction
    type:
      - 'null'
      - float
    doc: minimal cell fraction
    inputBinding:
      position: 101
      prefix: --min_cell_fraction
  - id: min_count
    type:
      - 'null'
      - int
    doc: minimal count of haterozygous SNPs
    inputBinding:
      position: 101
      prefix: --min_count
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: read all variants (not only PASS)
    inputBinding:
      position: 101
      prefix: --no_filter
  - id: no_gc_corr
    type:
      - 'null'
      - boolean
    doc: do not use GC correction in RD histograms
    inputBinding:
      position: 101
      prefix: --no_gc_corr
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: do not use P mask in BAF histograms
    inputBinding:
      position: 101
      prefix: --no_mask
  - id: no_save_likelihood
    type:
      - 'null'
      - boolean
    doc: do not save likelihood histograms (reduce size of pytor file)
    inputBinding:
      position: 101
      prefix: --no_save_likelihood
  - id: no_snp_counts
    type:
      - 'null'
      - boolean
    doc: read positions of variants, not counts (AD tag)
    inputBinding:
      position: 101
      prefix: --no_snp_counts
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: likelihood overlap threshold
    inputBinding:
      position: 101
      prefix: --overlap_threshold
  - id: panels
    type:
      - 'null'
      - type: array
        items: string
    doc: plot panels (with -plot regions)
    inputBinding:
      position: 101
      prefix: --panels
  - id: partition
    type:
      - 'null'
      - type: array
        items: int
    doc: calculate segmentation for specified bin size (multiple bin sizes 
      separate by space)
    inputBinding:
      position: 101
      prefix: --partition
  - id: phase_parents
    type:
      - 'null'
      - boolean
    doc: Phase parents
    inputBinding:
      position: 101
      prefix: --phase_parents
  - id: pileup_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: calculate SNP counts from bam files
    inputBinding:
      position: 101
      prefix: --pileup_bam
  - id: plot
    type:
      - 'null'
      - type: array
        items: string
    doc: plotting
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_style
    type:
      - 'null'
      - string
    doc: available plot styles
    inputBinding:
      position: 101
      prefix: --plot_style
  - id: qc
    type:
      - 'null'
      - type: array
        items: string
    doc: print quality control statistics
    inputBinding:
      position: 101
      prefix: --qc
  - id: random_phase
    type:
      - 'null'
      - boolean
    doc: randomly phase SNPs
    inputBinding:
      position: 101
      prefix: --random_phase
  - id: rd
    type:
      - 'null'
      - type: array
        items: File
    doc: read bam/sam/cram and store read depth information
    inputBinding:
      position: 101
      prefix: --rd
  - id: rd_from_snp
    type:
      - 'null'
      - boolean
    doc: calculate RD from SNP counts
    inputBinding:
      position: 101
      prefix: --rd_from_snp
  - id: rd_from_vcf
    type:
      - 'null'
      - File
    doc: read SNP data from vcf files
    inputBinding:
      position: 101
      prefix: --rd_from_vcf
  - id: rd_qc
    type:
      - 'null'
      - type: array
        items: string
    doc: print quality control statistics without SNP data
    inputBinding:
      position: 101
      prefix: --rd_qc
  - id: reduce_noise
    type:
      - 'null'
      - boolean
    doc: reduce noise in processing SNP data
    inputBinding:
      position: 101
      prefix: --reduce_noise
  - id: reference_filename
    type:
      - 'null'
      - File
    doc: reference fasta for CRAM
    inputBinding:
      position: 101
      prefix: --reference_filename
  - id: reference_genome
    type:
      - 'null'
      - string
    doc: Manually set reference genome
    inputBinding:
      position: 101
      prefix: --reference_genome
  - id: reference_genome_template
    type:
      - 'null'
      - File
    doc: create template for reference genome using chromosome lengths from 
      fasta file
    inputBinding:
      position: 101
      prefix: --reference_genome_template
  - id: reference_genomes_conf
    type:
      - 'null'
      - File
    doc: Configuration with reference genomes
    inputBinding:
      position: 101
      prefix: --reference_genomes_conf
  - id: rg_info
    type:
      - 'null'
      - boolean
    doc: list loaded reference gnomes
    inputBinding:
      position: 101
      prefix: --rg_info
  - id: root
    type:
      - 'null'
      - type: array
        items: File
    doc: 'CNVnator hd5 file: data storage for all calculations'
    inputBinding:
      position: 101
      prefix: --root
  - id: s_bin_size
    type:
      - 'null'
      - int
    doc: Super bin size (use with -snp2rd)
    inputBinding:
      position: 101
      prefix: --s_bin_size
  - id: somatic_snv
    type:
      - 'null'
      - type: array
        items: File
    doc: read SNP data from vcf files
    inputBinding:
      position: 101
      prefix: --somatic_snv
  - id: stat
    type:
      - 'null'
      - type: array
        items: int
    doc: calculate statistics for specified bin size (multiple bin sizes 
      separate by space)
    inputBinding:
      position: 101
      prefix: --stat
  - id: stdin2snp
    type:
      - 'null'
      - boolean
    doc: read SNP data from stdin
    inputBinding:
      position: 101
      prefix: --stdin2snp
  - id: trio_phase
    type:
      - 'null'
      - boolean
    doc: Phase trio
    inputBinding:
      position: 101
      prefix: --trio_phase
  - id: use_hom
    type:
      - 'null'
      - boolean
    doc: use hom
    inputBinding:
      position: 101
      prefix: --use_hom
  - id: use_id
    type:
      - 'null'
      - boolean
    doc: use id flag filtering in SNP histograms
    inputBinding:
      position: 101
      prefix: --use_id
  - id: use_mask_with_rd
    type:
      - 'null'
      - boolean
    doc: used P mask in RD histograms
    inputBinding:
      position: 101
      prefix: --use_mask_with_rd
  - id: use_phase
    type:
      - 'null'
      - boolean
    doc: use information about phase while processing SNP data
    inputBinding:
      position: 101
      prefix: --use_phase
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: read SNP data from vcf files
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_sample
    type:
      - 'null'
      - string
    doc: Sample name in vcf file
    inputBinding:
      position: 101
      prefix: --vcf_sample
  - id: verbose
    type:
      - 'null'
      - string
    doc: 'verbose level: debug, info (default), warning, error'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: view
    type:
      - 'null'
      - string
    doc: Enters interactive ploting mode
    inputBinding:
      position: 101
      prefix: --view
outputs:
  - id: plot_output_file
    type:
      - 'null'
      - File
    doc: output filename prefix and extension
    outputBinding:
      glob: $(inputs.plot_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvpytor:1.3.2--pyhdfd78af_0
