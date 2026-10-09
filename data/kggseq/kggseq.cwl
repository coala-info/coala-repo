cwlVersion: v1.2
class: CommandLineTool
baseCommand: kggseq
label: kggseq
doc: "KGGSeq: a tool for annotating and prioritizing genetic variants from sequencing data.\n\nTool homepage: http://grass.cgs.hku.hk/limx/kggseq/"
inputs:
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: 'Input variant file in VCF format (plain or gzipped).'
    inputBinding:
      position: 1
      prefix: --vcf-file
  - id: annovar_file
    type:
      - 'null'
      - File
    doc: 'Input variant file in ANNOVAR format.'
    inputBinding:
      position: 1
      prefix: --annovar-file
  - id: ped_file
    type:
      - 'null'
      - File
    doc: 'Pedigree and phenotype file in PLINK PED format.'
    inputBinding:
      position: 1
      prefix: --ped-file
  - id: phe_file
    type:
      - 'null'
      - File
    doc: 'Phenotype file.'
    inputBinding:
      position: 1
      prefix: --phe
  - id: buildver
    type:
      - 'null'
      - string
    doc: 'Reference genome version, for example hg19 (the default) or hg38.'
    inputBinding:
      position: 1
      prefix: --buildver
  - id: buildver_in
    type:
      - 'null'
      - string
    doc: 'Genome version of the input variants (lift over source).'
    inputBinding:
      position: 1
      prefix: --buildver-in
  - id: buildver_out
    type:
      - 'null'
      - string
    doc: 'Genome version of the output variants (lift over target).'
    inputBinding:
      position: 1
      prefix: --buildver-out
  - id: nt
    type:
      - 'null'
      - int
    doc: 'Number of threads.'
    inputBinding:
      position: 1
      prefix: --nt
  - id: resource
    type:
      - 'null'
      - string
    doc: 'Directory with the KGGSeq resource files.'
    inputBinding:
      position: 1
      prefix: --resource
  - id: no_web
    type:
      - 'null'
      - boolean
    doc: 'Disable the internet check.'
    inputBinding:
      position: 1
      prefix: --no-web
  - id: no_lib_check
    type:
      - 'null'
      - boolean
    doc: 'Do not check the library files.'
    inputBinding:
      position: 1
      prefix: --no-lib-check
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: 'Disable the log file.'
    inputBinding:
      position: 1
      prefix: --no-log
  - id: no_gz
    type:
      - 'null'
      - boolean
    doc: 'Do not compress the output files.'
    inputBinding:
      position: 1
      prefix: --no-gz
  - id: lib_update
    type:
      - 'null'
      - boolean
    doc: 'Update the library automatically.'
    inputBinding:
      position: 1
      prefix: --lib-update
  - id: resource_update
    type:
      - 'null'
      - boolean
    doc: 'Update the resource files automatically.'
    inputBinding:
      position: 1
      prefix: --resource-update
  - id: genome_annot
    type:
      - 'null'
      - boolean
    doc: 'Annotate with genome features (pseudogene, TFBS, enhancers, dispensable genes).'
    inputBinding:
      position: 1
      prefix: --genome-annot
  - id: db_filter
    type:
      - 'null'
      - string
    doc: 'Database filter, for example ref,dbsnp138,1kg201305.'
    inputBinding:
      position: 1
      prefix: --db-filter
  - id: db_filter_hard
    type:
      - 'null'
      - boolean
    doc: 'Apply the database filter strictly.'
    inputBinding:
      position: 1
      prefix: --db-filter-hard
  - id: db_score
    type:
      - 'null'
      - string
    doc: 'Databases of pathogenicity scores, for example dbnsfp.'
    inputBinding:
      position: 1
      prefix: --db-score
  - id: db_merge
    type:
      - 'null'
      - string
    doc: 'Databases to merge.'
    inputBinding:
      position: 1
      prefix: --db-merge
  - id: genotype_filter
    type:
      - 'null'
      - string
    doc: 'Genotype filter, a comma separated list of filter codes.'
    inputBinding:
      position: 1
      prefix: --genotype-filter
  - id: gty_qual
    type:
      - 'null'
      - float
    doc: 'Minimum genotype quality.'
    inputBinding:
      position: 1
      prefix: --gty-qual
  - id: gty_dp
    type:
      - 'null'
      - int
    doc: 'Minimum genotype depth.'
    inputBinding:
      position: 1
      prefix: --gty-dp
  - id: gty_af_ref
    type:
      - 'null'
      - float
    doc: 'Maximum alternative allele fraction for homozygous reference genotypes.'
    inputBinding:
      position: 1
      prefix: --gty-af-ref
  - id: gty_af_het
    type:
      - 'null'
      - float
    doc: 'Allele fraction range for heterozygous genotypes.'
    inputBinding:
      position: 1
      prefix: --gty-af-het
  - id: gty_af_alt
    type:
      - 'null'
      - float
    doc: 'Minimum alternative allele fraction for homozygous alternative genotypes.'
    inputBinding:
      position: 1
      prefix: --gty-af-alt
  - id: gty_sec_pl
    type:
      - 'null'
      - int
    doc: 'Minimum second smallest genotype likelihood.'
    inputBinding:
      position: 1
      prefix: --gty-sec-pl
  - id: hwe_case
    type:
      - 'null'
      - float
    doc: 'Hardy-Weinberg equilibrium p-value cutoff in cases.'
    inputBinding:
      position: 1
      prefix: --hwe-case
  - id: hwe_control
    type:
      - 'null'
      - float
    doc: 'Hardy-Weinberg equilibrium p-value cutoff in controls.'
    inputBinding:
      position: 1
      prefix: --hwe-control
  - id: min_obs_rate
    type:
      - 'null'
      - float
    doc: 'Minimum observation rate of a variant.'
    inputBinding:
      position: 1
      prefix: --min-obs-rate
  - id: ignore_indel
    type:
      - 'null'
      - boolean
    doc: 'Ignore insertions and deletions.'
    inputBinding:
      position: 1
      prefix: --ignore-indel
  - id: ignore_snv
    type:
      - 'null'
      - boolean
    doc: 'Ignore single nucleotide variants.'
    inputBinding:
      position: 1
      prefix: --ignore-snv
  - id: ignore_homo
    type:
      - 'null'
      - boolean
    doc: 'Ignore homozygous variants.'
    inputBinding:
      position: 1
      prefix: --ignore-homo
  - id: ignore_cnv
    type:
      - 'null'
      - boolean
    doc: 'Ignore copy number variants.'
    inputBinding:
      position: 1
      prefix: --ignore-cnv
  - id: regions_in
    type:
      - 'null'
      - string
    doc: 'Keep only variants in these regions.'
    inputBinding:
      position: 1
      prefix: --regions-in
  - id: regions_out
    type:
      - 'null'
      - string
    doc: 'Remove variants in these regions.'
    inputBinding:
      position: 1
      prefix: --regions-out
  - id: genes_in
    type:
      - 'null'
      - string
    doc: 'Keep only variants in these genes.'
    inputBinding:
      position: 1
      prefix: --genes-in
  - id: genes_out
    type:
      - 'null'
      - string
    doc: 'Remove variants in these genes.'
    inputBinding:
      position: 1
      prefix: --genes-out
  - id: rare_allele_freq
    type:
      - 'null'
      - string
    doc: 'Maximum allele frequency of rare variants (one or more values).'
    inputBinding:
      position: 1
      prefix: --rare-allele-freq
  - id: allele_freq
    type:
      - 'null'
      - string
    doc: 'Allele frequency filter.'
    inputBinding:
      position: 1
      prefix: --allele-freq
  - id: seq_qual
    type:
      - 'null'
      - float
    doc: 'Minimum sequencing quality of a variant.'
    inputBinding:
      position: 1
      prefix: --seq-qual
  - id: seq_mq
    type:
      - 'null'
      - float
    doc: 'Minimum mapping quality of a variant.'
    inputBinding:
      position: 1
      prefix: --seq-mq
  - id: seq_sb
    type:
      - 'null'
      - float
    doc: 'Maximum strand bias of a variant.'
    inputBinding:
      position: 1
      prefix: --seq-sb
  - id: seq_fs
    type:
      - 'null'
      - float
    doc: 'Maximum Fisher strand bias of a variant.'
    inputBinding:
      position: 1
      prefix: --seq-fs
  - id: vcf_filter_in
    type:
      - 'null'
      - string
    doc: 'Keep variants with these FILTER values in the VCF.'
    inputBinding:
      position: 1
      prefix: --vcf-filter-in
  - id: no_qc
    type:
      - 'null'
      - boolean
    doc: 'Skip quality control.'
    inputBinding:
      position: 1
      prefix: --no-qc
  - id: filter_nondisease_variant
    type:
      - 'null'
      - boolean
    doc: 'Filter variants that are unlikely to be disease causing.'
    inputBinding:
      position: 1
      prefix: --filter-nondisease-variant
  - id: local_filter
    type:
      - 'null'
      - string
    doc: 'Local file with variants used as a filter.'
    inputBinding:
      position: 1
      prefix: --local-filter
  - id: o_vcf
    type:
      - 'null'
      - boolean
    doc: 'Write the output also in VCF format.'
    inputBinding:
      position: 1
      prefix: --o-vcf
  - id: o_vcf_filtered
    type:
      - 'null'
      - boolean
    doc: 'Write the filtered variants in VCF format.'
    inputBinding:
      position: 1
      prefix: --o-vcf-filtered
  - id: o_plink_ped
    type:
      - 'null'
      - boolean
    doc: 'Write the output in PLINK PED format.'
    inputBinding:
      position: 1
      prefix: --o-plink-ped
  - id: o_plink_bed
    type:
      - 'null'
      - boolean
    doc: 'Write the output in PLINK binary format.'
    inputBinding:
      position: 1
      prefix: --o-plink-bed
  - id: out
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result, log and summary files written with the output prefix.
    outputBinding:
      glob: $(inputs.out).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kggseq:1.1--0
