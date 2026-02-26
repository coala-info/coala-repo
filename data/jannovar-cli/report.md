# jannovar-cli CWL Generation Report

## jannovar-cli_jannovar annotate-vcf

### Tool Description
Perform annotation of a single VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
- **Homepage**: https://github.com/charite/jannovar
- **Package**: https://anaconda.org/channels/bioconda/packages/jannovar-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jannovar-cli/overview
- **Total Downloads**: 62.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/charite/jannovar
- **Stars**: N/A
### Original Help Text
```text
usage: jannovar-cli annotate-vcf [-h] -i INPUT_VCF -o OUTPUT_VCF
                    -d DATABASE [--interval INTERVAL]
                    [--pedigree-file PEDIGREE_FILE]
                    [--annotate-as-singleton-pedigree]
                    [--ref-fasta REF_FASTA] [--dbsnp-vcf DBSNP_VCF]
                    [--dbsnp-prefix DBSNP_PREFIX] [--exac-vcf EXAC_VCF]
                    [--exac-prefix EXAC_PREFIX]
                    [--gnomad-exomes-vcf GNOMAD_EXOMES_VCF]
                    [--gnomad-exomes-prefix GNOMAD_EXOMES_PREFIX]
                    [--gnomad-genomes-vcf GNOMAD_GENOMES_VCF]
                    [--gnomad-genomes-prefix GNOMAD_GENOMES_PREFIX]
                    [--uk10k-vcf UK10K_VCF] [--uk10k-prefix UK10K_PREFIX]
                    [--g1k-vcf G1K_VCF] [--g1k-prefix G1K_PREFIX]
                    [--clinvar-vcf CLINVAR_VCF]
                    [--clinvar-prefix CLINVAR_PREFIX]
                    [--cosmic-vcf COSMIC_VCF]
                    [--cosmic-prefix COSMIC_PREFIX]
                    [--one-parent-gt-filtered-filters-affected]
                    [--inheritance-anno-use-filters]
                    [--dbnsfp-tsv DBNSFP_TSV]
                    [--dbnsfp-col-contig DBNSFP_COL_CONTIG]
                    [--dbnsfp-col-position DBNSFP_COL_POSITION]
                    [--dbnsfp-prefix DBNSFP_PREFIX]
                    [--dbnsfp-columns DBNSFP_COLUMNS]
                    [--bed-annotation BED_ANNOTATION]
                    [--vcf-annotation VCF_ANNOTATION]
                    [--tsv-annotation TSV_ANNOTATION]
                    [--use-threshold-filters]
                    [--gt-thresh-filt-min-cov-het GT_THRESH_FILT_MIN_COV_HET]
                    [--gt-thresh-filt-min-cov-hom-alt GT_THRESH_FILT_MIN_COV_HOM_ALT]
                    [--gt-thresh-filt-max-cov GT_THRESH_FILT_MAX_COV]
                    [--gt-thresh-filt-min-gq GT_THRESH_FILT_MIN_GQ]
                    [--gt-thresh-filt-min-aaf-het GT_THRESH_FILT_MIN_AAF_HET]
                    [--gt-thresh-filt-max-aaf-het GT_THRESH_FILT_MAX_AAF_HET]
                    [--gt-thresh-filt-min-aaf-hom-alt GT_THRESH_FILT_MIN_AAF_HOM_ALT]
                    [--gt-thresh-filt-max-aaf-hom-ref GT_THRESH_FILT_MAX_AAF_HOM_REF]
                    [--var-thresh-max-allele-freq-ad VAR_THRESH_MAX_ALLELE_FREQ_AD]
                    [--var-thresh-max-allele-freq-ar VAR_THRESH_MAX_ALLELE_FREQ_AR]
                    [--var-thresh-max-hom-alt-exac VAR_THRESH_MAX_HOM_ALT_EXAC]
                    [--var-thresh-max-hom-alt-g1k VAR_THRESH_MAX_HOM_ALT_G1K]
                    [--use-advanced-pedigree-filters]
                    [--de-novo-max-parent-ad2 DE_NOVO_MAX_PARENT_AD2]
                    [--enable-off-target-filter] [--utr-is-off-target]
                    [--intronic-splice-is-off-target]
                    [--no-escape-ann-field] [--show-all]
                    [--no-3-prime-shifting] [--3-letter-amino-acids]
                    [--disable-parent-gt-is-filtered] [--version]
                    [--report-no-progress] [-v] [-vv]
                    [--http-proxy HTTP_PROXY] [--https-proxy HTTPS_PROXY]
                    [--ftp-proxy FTP_PROXY]

Perform annotation of a single VCF file

optional arguments:
  -h, --help             show this help message and exit
  --version              Show Jannovar version

Required arguments:
  -i INPUT_VCF, --input-vcf INPUT_VCF
                         Path to input VCF file
  -o OUTPUT_VCF, --output-vcf OUTPUT_VCF
                         Path to output VCF file
  -d DATABASE, --database DATABASE
                         Path to database .ser file
  --interval INTERVAL    Interval with regions to annotate (optional)

Annotation Arguments (optional):
  --pedigree-file PEDIGREE_FILE
                         Pedigree file  to  use  for  Mendelian inheritance
                         annotation
  --annotate-as-singleton-pedigree
                         Annotate  VCF  file  with   single  individual  as
                         singleton  pedigree  (singleton   assumed   to  be
                         affected)
  --ref-fasta REF_FASTA  Path  to   FAI-indexed   reference   FASTA   file,
                         required for dbSNP/ExAC/UK10K-based annotation
  --dbsnp-vcf DBSNP_VCF  Path to dbSNP VCF file, activates dbSNP annotation
  --dbsnp-prefix DBSNP_PREFIX
                         Prefix for dbSNP annotations
  --exac-vcf EXAC_VCF    Path to ExAC VCF file, activates ExAC annotation
  --exac-prefix EXAC_PREFIX
                         Prefix for ExAC annotations
  --gnomad-exomes-vcf GNOMAD_EXOMES_VCF
                         Path to gnomAD exomes  VCF  file, activates gnomAD
                         exomes annotation
  --gnomad-exomes-prefix GNOMAD_EXOMES_PREFIX
                         Prefix for ExgnomAD exomes AC annotations
  --gnomad-genomes-vcf GNOMAD_GENOMES_VCF
                         Path to gnomAD genomes  VCF file, activates gnomAD
                         genomes annotation
  --gnomad-genomes-prefix GNOMAD_GENOMES_PREFIX
                         Prefix for ExgnomAD genomes AC annotations
  --uk10k-vcf UK10K_VCF  Path to UK10K VCF file, activates UK10K annotation
  --uk10k-prefix UK10K_PREFIX
                         Prefix for UK10K annotations
  --g1k-vcf G1K_VCF      Path  to  thousand  genomes  VCF  file,  activates
                         thousand genomes annotation
  --g1k-prefix G1K_PREFIX
                         Prefix for thousand genomes annotations
  --clinvar-vcf CLINVAR_VCF
                         Path to ClinVar file, activates ClinVar annotation
  --clinvar-prefix CLINVAR_PREFIX
                         Prefix for ClinVar annotations
  --cosmic-vcf COSMIC_VCF
                         Path to COSMIC file, activates COSMIC annotation
  --cosmic-prefix COSMIC_PREFIX
                         Prefix for COSMIC annotations
  --one-parent-gt-filtered-filters-affected
                         If  one  parent's  genotype   is  affected,  apply
                         OneParentGtFiltered filter to child
  --inheritance-anno-use-filters
                         Use filters in inheritance mode annotation

Annotation with dbNSFP (experimental; optional):
  --dbnsfp-tsv DBNSFP_TSV
                         Patht to dbNSFP TSV file
  --dbnsfp-col-contig DBNSFP_COL_CONTIG
                         Column index of contig in dbNSFP
  --dbnsfp-col-position DBNSFP_COL_POSITION
                         Column index of position in dbNSFP
  --dbnsfp-prefix DBNSFP_PREFIX
                         Prefix for dbNSFP annotations
  --dbnsfp-columns DBNSFP_COLUMNS
                         Columns from dbDSFP file to use for annotation

BED-based Annotation (experimental; optional):
  --bed-annotation BED_ANNOTATION
                         Add BED file  to  use  for  annotating.  The value
                         must  be  of   the   format  "pathToBed:infoField:
                         description[:colNo]".

Generic VCF-based Annotation (experimental; optional):
  --vcf-annotation VCF_ANNOTATION
                         Add VCF file  to  use  for  annotating.  The value
                         must be of the format "pathToVfFile:prefix:field1,
                         field2,field3".

TSV-based Annotation (experimental; optional):
  --tsv-annotation TSV_ANNOTATION
                         Add TSV file  to  use  for  annotating.  The value
                         must   be    of    the    format   "pathToTsvFile:
                         oneBasedOffset:colContig:colStart:colEnd:colRef
                         (or=0):colAlt(or=0):isRefAnnotated(R=yes,A=no):
                         colValue:fieldType:fieldName:fieldDescription:
                         accumulationStrategy".

Threshold-filter related arguments:
  --use-threshold-filters
                         Use threshold-based filters
  --gt-thresh-filt-min-cov-het GT_THRESH_FILT_MIN_COV_HET
                         Minimal coverage for het. call
  --gt-thresh-filt-min-cov-hom-alt GT_THRESH_FILT_MIN_COV_HOM_ALT
                         Minimal coverage for hom. alt calls
  --gt-thresh-filt-max-cov GT_THRESH_FILT_MAX_COV
                         Maximal coverage for a sample
  --gt-thresh-filt-min-gq GT_THRESH_FILT_MIN_GQ
                         Minimal genotype call quality
  --gt-thresh-filt-min-aaf-het GT_THRESH_FILT_MIN_AAF_HET
                         Minimal het. call alternate allele fraction
  --gt-thresh-filt-max-aaf-het GT_THRESH_FILT_MAX_AAF_HET
                         Maximal het. call alternate allele fraction
  --gt-thresh-filt-min-aaf-hom-alt GT_THRESH_FILT_MIN_AAF_HOM_ALT
                         Minimal hom. alt call alternate allele fraction
  --gt-thresh-filt-max-aaf-hom-ref GT_THRESH_FILT_MAX_AAF_HOM_REF
                         Maximal hom. ref call alternate allele fraction
  --var-thresh-max-allele-freq-ad VAR_THRESH_MAX_ALLELE_FREQ_AD
                         Maximal allele  fraction  for  autosomal  dominant
                         inheritance mode
  --var-thresh-max-allele-freq-ar VAR_THRESH_MAX_ALLELE_FREQ_AR
                         Maximal allele  fraction  for  autosomal recessive
                         inheritance mode
  --var-thresh-max-hom-alt-exac VAR_THRESH_MAX_HOM_ALT_EXAC
                         Maximal count in homozygous  state  in ExAC before
                         ignoring
  --var-thresh-max-hom-alt-g1k VAR_THRESH_MAX_HOM_ALT_G1K
                         Maximal count in homozygous  state  in ExAC before
                         ignoring
  --use-advanced-pedigree-filters
                         Use  advanced   pedigree-based   filters   (mainly
                         useful for de novo variants)
  --de-novo-max-parent-ad2 DE_NOVO_MAX_PARENT_AD2
                         Maximal support of  alternative  allele  in parent
                         for de novo variants.

Exome on/off target filters:
  --enable-off-target-filter
                         Enable filter for  on/off-target  based  on effect
                         impact
  --utr-is-off-target    Make UTR count as off-target  (default is to count
                         UTR as on-target)
  --intronic-splice-is-off-target
                         Make intronic (non-consensus  site)  splice region
                         count as off-target (default  is  to  count as on-
                         target)

Other, optional Arguments:
  --no-escape-ann-field  Disable escaping of INFO/ANN field in VCF output
  --show-all             Show all effects
  --no-3-prime-shifting  Disable shifting towards 3' of transcript
  --3-letter-amino-acids
                         Enable usage of 3 letter amino acid codes
  --disable-parent-gt-is-filtered

Verbosity Options:
  --report-no-progress   Disable progress report, more quiet mode
  -v, --verbose          Enable verbose mode
  -vv, --very-verbose    Enable very verbose mode

Proxy Options:
  Configuration related to Proxy,  note  that environment variables *_proxy
  and *_PROXY are also interpreted

  --http-proxy HTTP_PROXY
                         Set HTTP proxy to use, if any
  --https-proxy HTTPS_PROXY
                         Set HTTPS proxy to use, if any
  --ftp-proxy FTP_PROXY  Set FTP proxy to use, if any
```

