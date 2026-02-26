cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar-cli
  - annotate-vcf
label: jannovar-cli_jannovar annotate-vcf
doc: "Perform annotation of a single VCF file\n\nTool homepage: https://github.com/charite/jannovar"
inputs:
  - id: annotate_as_singleton_pedigree
    type:
      - 'null'
      - boolean
    doc: Annotate VCF file with single individual as singleton pedigree 
      (singleton assumed to be affected)
    inputBinding:
      position: 101
      prefix: --annotate-as-singleton-pedigree
  - id: bed_annotation
    type:
      - 'null'
      - string
    doc: 'Add BED file to use for annotating. The value must be of the format "pathToBed:infoField:
      description[:colNo]".'
    inputBinding:
      position: 101
      prefix: --bed-annotation
  - id: clinvar_prefix
    type:
      - 'null'
      - string
    doc: Prefix for ClinVar annotations
    inputBinding:
      position: 101
      prefix: --clinvar-prefix
  - id: clinvar_vcf
    type:
      - 'null'
      - File
    doc: Path to ClinVar file, activates ClinVar annotation
    inputBinding:
      position: 101
      prefix: --clinvar-vcf
  - id: cosmic_prefix
    type:
      - 'null'
      - string
    doc: Prefix for COSMIC annotations
    inputBinding:
      position: 101
      prefix: --cosmic-prefix
  - id: cosmic_vcf
    type:
      - 'null'
      - File
    doc: Path to COSMIC file, activates COSMIC annotation
    inputBinding:
      position: 101
      prefix: --cosmic-vcf
  - id: database
    type: File
    doc: Path to database .ser file
    inputBinding:
      position: 101
      prefix: --database
  - id: dbnsfp_col_contig
    type:
      - 'null'
      - int
    doc: Column index of contig in dbNSFP
    inputBinding:
      position: 101
      prefix: --dbnsfp-col-contig
  - id: dbnsfp_col_position
    type:
      - 'null'
      - int
    doc: Column index of position in dbNSFP
    inputBinding:
      position: 101
      prefix: --dbnsfp-col-position
  - id: dbnsfp_columns
    type:
      - 'null'
      - string
    doc: Columns from dbDSFP file to use for annotation
    inputBinding:
      position: 101
      prefix: --dbnsfp-columns
  - id: dbnsfp_prefix
    type:
      - 'null'
      - string
    doc: Prefix for dbNSFP annotations
    inputBinding:
      position: 101
      prefix: --dbnsfp-prefix
  - id: dbnsfp_tsv
    type:
      - 'null'
      - File
    doc: Patht to dbNSFP TSV file
    inputBinding:
      position: 101
      prefix: --dbnsfp-tsv
  - id: dbsnp_prefix
    type:
      - 'null'
      - string
    doc: Prefix for dbSNP annotations
    inputBinding:
      position: 101
      prefix: --dbsnp-prefix
  - id: dbsnp_vcf
    type:
      - 'null'
      - File
    doc: Path to dbSNP VCF file, activates dbSNP annotation
    inputBinding:
      position: 101
      prefix: --dbsnp-vcf
  - id: de_novo_max_parent_ad2
    type:
      - 'null'
      - int
    doc: Maximal support of alternative allele in parent for de novo variants.
    inputBinding:
      position: 101
      prefix: --de-novo-max-parent-ad2
  - id: disable_parent_gt_is_filtered
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-parent-gt-is-filtered
  - id: enable_off_target_filter
    type:
      - 'null'
      - boolean
    doc: Enable filter for on/off-target based on effect impact
    inputBinding:
      position: 101
      prefix: --enable-off-target-filter
  - id: exac_prefix
    type:
      - 'null'
      - string
    doc: Prefix for ExAC annotations
    inputBinding:
      position: 101
      prefix: --exac-prefix
  - id: exac_vcf
    type:
      - 'null'
      - File
    doc: Path to ExAC VCF file, activates ExAC annotation
    inputBinding:
      position: 101
      prefix: --exac-vcf
  - id: ftp_proxy
    type:
      - 'null'
      - string
    doc: Set FTP proxy to use, if any
    inputBinding:
      position: 101
      prefix: --ftp-proxy
  - id: g1k_prefix
    type:
      - 'null'
      - string
    doc: Prefix for thousand genomes annotations
    inputBinding:
      position: 101
      prefix: --g1k-prefix
  - id: g1k_vcf
    type:
      - 'null'
      - File
    doc: Path to thousand genomes VCF file, activates thousand genomes 
      annotation
    inputBinding:
      position: 101
      prefix: --g1k-vcf
  - id: gnomad_exomes_prefix
    type:
      - 'null'
      - string
    doc: Prefix for gnomAD exomes AC annotations
    inputBinding:
      position: 101
      prefix: --gnomad-exomes-prefix
  - id: gnomad_exomes_vcf
    type:
      - 'null'
      - File
    doc: Path to gnomAD exomes VCF file, activates gnomAD exomes annotation
    inputBinding:
      position: 101
      prefix: --gnomad-exomes-vcf
  - id: gnomad_genomes_prefix
    type:
      - 'null'
      - string
    doc: Prefix for gnomAD genomes AC annotations
    inputBinding:
      position: 101
      prefix: --gnomad-genomes-prefix
  - id: gnomad_genomes_vcf
    type:
      - 'null'
      - File
    doc: Path to gnomAD genomes VCF file, activates gnomAD genomes annotation
    inputBinding:
      position: 101
      prefix: --gnomad-genomes-vcf
  - id: gt_thresh_filt_max_aaf_het
    type:
      - 'null'
      - float
    doc: Maximal het. call alternate allele fraction
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-max-aaf-het
  - id: gt_thresh_filt_max_aaf_hom_ref
    type:
      - 'null'
      - float
    doc: Maximal hom. ref call alternate allele fraction
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-max-aaf-hom-ref
  - id: gt_thresh_filt_max_cov
    type:
      - 'null'
      - int
    doc: Maximal coverage for a sample
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-max-cov
  - id: gt_thresh_filt_min_aaf_het
    type:
      - 'null'
      - float
    doc: Minimal het. call alternate allele fraction
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-min-aaf-het
  - id: gt_thresh_filt_min_aaf_hom_alt
    type:
      - 'null'
      - float
    doc: Minimal hom. alt call alternate allele fraction
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-min-aaf-hom-alt
  - id: gt_thresh_filt_min_cov_het
    type:
      - 'null'
      - int
    doc: Minimal coverage for het. call
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-min-cov-het
  - id: gt_thresh_filt_min_cov_hom_alt
    type:
      - 'null'
      - int
    doc: Minimal coverage for hom. alt calls
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-min-cov-hom-alt
  - id: gt_thresh_filt_min_gq
    type:
      - 'null'
      - int
    doc: Minimal genotype call quality
    inputBinding:
      position: 101
      prefix: --gt-thresh-filt-min-gq
  - id: http_proxy
    type:
      - 'null'
      - string
    doc: Set HTTP proxy to use, if any
    inputBinding:
      position: 101
      prefix: --http-proxy
  - id: https_proxy
    type:
      - 'null'
      - string
    doc: Set HTTPS proxy to use, if any
    inputBinding:
      position: 101
      prefix: --https-proxy
  - id: inheritance_anno_use_filters
    type:
      - 'null'
      - boolean
    doc: Use filters in inheritance mode annotation
    inputBinding:
      position: 101
      prefix: --inheritance-anno-use-filters
  - id: input_vcf
    type: File
    doc: Path to input VCF file
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: interval
    type:
      - 'null'
      - string
    doc: Interval with regions to annotate (optional)
    inputBinding:
      position: 101
      prefix: --interval
  - id: intronic_splice_is_off_target
    type:
      - 'null'
      - boolean
    doc: Make intronic (non-consensus site) splice region count as off-target 
      (default is to count as on-target)
    inputBinding:
      position: 101
      prefix: --intronic-splice-is-off-target
  - id: no_3_prime_shifting
    type:
      - 'null'
      - boolean
    doc: Disable shifting towards 3' of transcript
    inputBinding:
      position: 101
      prefix: --no-3-prime-shifting
  - id: no_escape_ann_field
    type:
      - 'null'
      - boolean
    doc: Disable escaping of INFO/ANN field in VCF output
    inputBinding:
      position: 101
      prefix: --no-escape-ann-field
  - id: one_parent_gt_filtered_filters_affected
    type:
      - 'null'
      - boolean
    doc: If one parent's genotype is affected, apply OneParentGtFiltered filter 
      to child
    inputBinding:
      position: 101
      prefix: --one-parent-gt-filtered-filters-affected
  - id: pedigree_file
    type:
      - 'null'
      - File
    doc: Pedigree file to use for Mendelian inheritance annotation
    inputBinding:
      position: 101
      prefix: --pedigree-file
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Path to FAI-indexed reference FASTA file, required for 
      dbSNP/ExAC/UK10K-based annotation
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: report_no_progress
    type:
      - 'null'
      - boolean
    doc: Disable progress report, more quiet mode
    inputBinding:
      position: 101
      prefix: --report-no-progress
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Show all effects
    inputBinding:
      position: 101
      prefix: --show-all
  - id: three_letter_amino_acids
    type:
      - 'null'
      - boolean
    doc: Enable usage of 3 letter amino acid codes
    inputBinding:
      position: 101
      prefix: --3-letter-amino-acids
  - id: tsv_annotation
    type:
      - 'null'
      - string
    doc: 'Add TSV file to use for annotating. The value must be of the format "pathToTsvFile:
      oneBasedOffset:colContig:colStart:colEnd:colRef (or=0):colAlt(or=0):isRefAnnotated(R=yes,A=no):
      colValue:fieldType:fieldName:fieldDescription: accumulationStrategy".'
    inputBinding:
      position: 101
      prefix: --tsv-annotation
  - id: uk10k_prefix
    type:
      - 'null'
      - string
    doc: Prefix for UK10K annotations
    inputBinding:
      position: 101
      prefix: --uk10k-prefix
  - id: uk10k_vcf
    type:
      - 'null'
      - File
    doc: Path to UK10K VCF file, activates UK10K annotation
    inputBinding:
      position: 101
      prefix: --uk10k-vcf
  - id: use_advanced_pedigree_filters
    type:
      - 'null'
      - boolean
    doc: Use advanced pedigree-based filters (mainly useful for de novo 
      variants)
    inputBinding:
      position: 101
      prefix: --use-advanced-pedigree-filters
  - id: use_threshold_filters
    type:
      - 'null'
      - boolean
    doc: Use threshold-based filters
    inputBinding:
      position: 101
      prefix: --use-threshold-filters
  - id: utr_is_off_target
    type:
      - 'null'
      - boolean
    doc: Make UTR count as off-target (default is to count UTR as on-target)
    inputBinding:
      position: 101
      prefix: --utr-is-off-target
  - id: var_thresh_max_allele_freq_ad
    type:
      - 'null'
      - float
    doc: Maximal allele fraction for autosomal dominant inheritance mode
    inputBinding:
      position: 101
      prefix: --var-thresh-max-allele-freq-ad
  - id: var_thresh_max_allele_freq_ar
    type:
      - 'null'
      - float
    doc: Maximal allele fraction for autosomal recessive inheritance mode
    inputBinding:
      position: 101
      prefix: --var-thresh-max-allele-freq-ar
  - id: var_thresh_max_hom_alt_exac
    type:
      - 'null'
      - int
    doc: Maximal count in homozygous state in ExAC before ignoring
    inputBinding:
      position: 101
      prefix: --var-thresh-max-hom-alt-exac
  - id: var_thresh_max_hom_alt_g1k
    type:
      - 'null'
      - int
    doc: Maximal count in homozygous state in ExAC before ignoring
    inputBinding:
      position: 101
      prefix: --var-thresh-max-hom-alt-g1k
  - id: vcf_annotation
    type:
      - 'null'
      - string
    doc: Add VCF file to use for annotating. The value must be of the format 
      "pathToVfFile:prefix:field1, field2,field3".
    inputBinding:
      position: 101
      prefix: --vcf-annotation
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Enable very verbose mode
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: output_vcf
    type: File
    doc: Path to output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
