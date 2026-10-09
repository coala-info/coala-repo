# igv-reports CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| igv-reports | PASS | fixed baseCommand (real command is create_report) and added all options; report for the nf-core SARS-CoV-2 VCF with a BAM track lists all 9 variants with DP and MQ columns |

## igv-reports

### Tool Description
Generate self-contained HTML reports for viewing genomic data in IGV.

### Metadata
- **Docker Image**: quay.io/biocontainers/igv-reports:1.16.0--pyh7e72e81_0
- **Homepage**: https://github.com/igvteam/igv-reports
- **Package**: https://anaconda.org/channels/bioconda/packages/igv-reports/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igv-reports/overview
- **Total Downloads**: 186.3K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/igvteam/igv-reports
- **Stars**: N/A
### Original Help Text
```text
usage: create_report [-h] [--fasta [FASTA]] [--twobit [TWOBIT]]
                     [--genome GENOME] [--type TYPE] [--ideogram IDEOGRAM]
                     [--tracks TRACKS [TRACKS ...]]
                     [--track-config TRACK_CONFIG [TRACK_CONFIG ...]]
                     [--roi ROI [ROI ...]] [--sort SORT] [--template TEMPLATE]
                     [--output OUTPUT]
                     [--info-columns INFO_COLUMNS [INFO_COLUMNS ...]]
                     [--info-columns-prefixes INFO_COLUMNS_PREFIXES [INFO_COLUMNS_PREFIXES ...]]
                     [--sampleinfo SAMPLEINFO [SAMPLEINFO ...]]
                     [--samples SAMPLES [SAMPLES ...]]
                     [--sample-columns SAMPLE_COLUMNS [SAMPLE_COLUMNS ...]]
                     [--flanking FLANKING] [--window WINDOW] [--standalone]
                     [--title TITLE] [--header HEADER] [--footer FOOTER]
                     [--sequence SEQUENCE] [--begin BEGIN] [--end END]
                     [--zero_based ZERO_BASED] [--idlink IDLINK]
                     [--exclude-flags EXCLUDE_FLAGS] [--no-embed]
                     [--subsample SUBSAMPLE] [--maxlen MAXLEN]
                     [--translate-sequence-track] [--tabulator]
                     [--filter-config FILTER_CONFIG] [--merge-overlaps]
                     sites [fasta_]

positional arguments:
  sites                 vcf file defining variants, required
  fasta_                reference fasta file. Deprecated positional argument,
                        use --fasta

options:
  -h, --help            show this help message and exit
  --fasta [FASTA]       reference fasta file. One of either --fasta, --twobit,
                        or --genome is required.
  --twobit [TWOBIT]     reference twobit file. One of either --fasta,
                        --twobit, or --genome is required.
  --genome GENOME       igv.js genome id (e.g. hg38)
  --type TYPE           Report type. Possible values are mutation, junction,
                        and fusion. Default is mutation
  --ideogram IDEOGRAM   ideogram file in UCSC cytoIdeo format
  --tracks TRACKS [TRACKS ...]
                        list of track files
  --track-config TRACK_CONFIG [TRACK_CONFIG ...]
                        track json file
  --roi ROI [ROI ...]   list of region-of-interest files
  --sort SORT           initial sort option for alignment tracks. Supported
                        values include BASE, STRAND, INSERT_SIZE, and
                        MATE_CHR. Default value is BASE for single nucleotide
                        variants, no sorting otherwise. See the igv.js
                        documentation for more information.
  --template TEMPLATE   html template file
  --output OUTPUT       output file name
  --info-columns INFO_COLUMNS [INFO_COLUMNS ...]
                        list of VCF info field names to include in variant
                        table
  --info-columns-prefixes INFO_COLUMNS_PREFIXES [INFO_COLUMNS_PREFIXES ...]
                        list of prefixes of VCF info field names to include in
                        variant table
  --sampleinfo SAMPLEINFO [SAMPLEINFO ...]
                        list of sample information files
  --samples SAMPLES [SAMPLES ...]
                        Space delimited list of sample (i.e. genotypes) names.
                        Used in conjunction with --sample-columns
  --sample-columns SAMPLE_COLUMNS [SAMPLE_COLUMNS ...]
                        list of VCF sample (genomtype) FORMAT field names to
                        include in variant table
  --flanking FLANKING   genomic region to include either side of variant
  --window WINDOW       initial visible window size (genomic region) in bp. If
                        not supplied igv.js default applies (41 bp).
  --standalone          embed javascript as well as data in output html
  --title TITLE         optional title string. Inserted into the html title
                        tag
  --header HEADER       optional header html string. Inserted into the
                        document before the variant table
  --footer FOOTER       optional footer html string. Inserted into the
                        document below the igv.js viewer
  --sequence SEQUENCE   Column of sequence (chromosome) name. For tab-
                        delimited sites file.
  --begin BEGIN         Column of start position. For tab-delimited sites
                        file.
  --end END             column of end position. For tab-delimited sites file.
  --zero_based ZERO_BASED
                        Specify that the position in the data file is 0-based
                        (e.g. UCSC files) rather than 1-based.
  --idlink IDLINK       url link template for the VCF ID column
  --exclude-flags EXCLUDE_FLAGS
                        Passed to samtools to filter alignments. For BAM and
                        CRAM files.
  --no-embed            Do not embed fasta or track data. This is not common
  --subsample SUBSAMPLE
                        Subsample bam files, keeping fraction of input
                        alignments as indicated by input value in the range of
                        0.0 - 1.0
  --maxlen MAXLEN       Maximum length of variant for single view. Variants
                        exceeding this lenght will be presented in split-
                        screen (multilocus) view
  --translate-sequence-track
                        Three-frame Translate sequence track
  --tabulator           Enable Tabulator table with advanced filtering
  --filter-config FILTER_CONFIG
                        YAML configuration file for column-specific filtering
  --merge-overlaps      Merge overlapping regions for multi-locus features
                        (e.g. bedpe)
```

## Metadata
- **Skill**: generated

