# grenedalf CWL Generation Report

## grenedalf_cathedral-plot

### Tool Description
Create a cathedral plot, using the pre-computated cathedral data.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lczech/grenedalf
- **Stars**: N/A
### Original Help Text
```text
Create a cathedral plot, using the pre-computated cathedral data.
Usage: grenedalf cathedral-plot [OPTIONS]

Input:
  --json-path TEXT:PATH(existing)=[] ... Excludes: --csv-path
                              List of json files or directories to process. For directories, only files with the extension `.json` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --csv-path TEXT:PATH(existing)=[] ... Excludes: --json-path
                              List of csv files or directories to process. For directories, only files with the extension `.csv` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Color:
  --color-list TEXT=inferno   List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list        If set, the order of colors of the `--color-list` is reversed.
  --under-color TEXT=#00ffff  Color used to indicate values below the min value. Color can be specified in the format `#rrggbb` using hex values, or by web color names.
  --clip-under                Clip (i.e., clamp) values less than min to be inside `[ min, max ]`, by setting values that are too low to the specified min value. If set, `--under-color` is not used to indicate values out of range.
  --over-color TEXT=#ff00ff   Color used to indicate values above the max value. Color can be specified in the format `#rrggbb` using hex values, or by web color names.
  --clip-over                 Clip (i.e., clamp) values greater than max to be inside `[ min, max ]`, by setting values that are too high to the specified max value. If set, `--over-color` is not used to indicate values out of range.
  --clip                      Clip (i.e., clamp) values to be inside `[ min, max ]`, by setting values outside of that interval to the nearest boundary of it. This option is a shortcut to set `--clip-under` and `--clip-over` at once.
  --color-normalization TEXT:{linear,logarithmic}=linear
                              To create the cathedral plot, the value of each pixel needs to be translated into a color, by mapping from the range of values into the range of the color map. This translation can be done as a simple linear transform, or logarithmic, so that low values can be distinguished with more detail.
  --min-value FLOAT=nan       As an alternative to determining the range of values automatically, the range limits can be set explicitly. This allows for instance to cap the visualization in cases of outliers that would otherwise hide detail in the lower values. Any value that is below the min specified here will then be mapped to the `under` color, or clipped to the lowest value in the color map.
  --max-value FLOAT=nan       See `--min-value`; this is the equivalent upper limit of values.Any value that is above the max specified here will then be mapped to the `over` color, or be clipped to the highest value in the color map.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_diversity

### Tool Description
Compute pool-sequencing corrected diversity measures Theta Pi, Theta Watterson, and Tajima's D.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Compute pool-sequencing corrected diversity measures Theta Pi, Theta Watterson, and Tajima's D.
Usage: grenedalf diversity [OPTIONS]

Input SAM/BAM/CRAM:
  --sam-path TEXT:PATH(existing)=[] ...
                              List of sam/bam/cram files or directories to process. For directories, only files with the extension `.sam[.gz]|.bam|.cram` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --sam-min-map-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled mapping quality score [0-90] for a read in sam/bam/cram files to be considered. Any read that is below the given value of mapping quality will be completely discarded, and its bases not taken into account. Default is 0, meaning no filtering by base quality.
  --sam-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by base quality.
  --sam-split-by-rg Needs: --sam-path
                              Instead of considering the whole sam/bam/cram file as one large colletion of reads, use the `@RG` read group tag to split reads. Each read group is then considered a sample. Reads with an invalid (not in the header) read group tag or without a tag are ignored.
  --sam-flags-include-all TEXT Needs: --sam-path
                              Only use reads with all bits in the given value present in the FLAG field of the read. This is equivalent to the `-f` / `--require-flags` setting in `samtools view`, and uses the same flag names and their corresponding binary values. The value can be specified in hex by beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names as specified by samtools. We are more lenient in parsing flag names than `samtools`, and allow different capitalization and delimiteres such as dashes and underscores in the flag names as well.
  --sam-flags-include-any TEXT Needs: --sam-path
                              Only use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `--rf` / `--incl-flags` / `--include-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-all TEXT Needs: --sam-path
                              Do not use reads with all bits set in the given value present in the FLAG field of the read. This is equivalent to the `-G` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-any TEXT Needs: --sam-path
                              Do not use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / `--exclude-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.


Input (m)pileup:
  --pileup-path TEXT:PATH(existing)=[] ...
                              List of (m)pileup files or directories to process. For directories, only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --pileup-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --pileup-path
                              Minimum phred quality score [0-90] for a base in (m)pileup files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by phred quality score.
  --pileup-quality-encoding TEXT:{sanger,illumina-1.3,illumina-1.5,illumina-1.8,solexa}=sanger Needs: --pileup-path
                              Encoding of the quality scores of the bases in (m)pileup files, when using `--pileup-min-base-qual`. Default is `"sanger"`, which seems to be the most common these days. Both `"sanger"` and `"illumina-1.8"` are identical and use an ASCII offset of 33, while `"illumina-1.3"` and `"illumina-1.5"` are identical with an ASCII offset of 64 (we provide different names for completeness). Lastly, `"solexa"` has an offset of 64, but uses a different equation (not phred score) for the encoding.


Input sync:
  --sync-path TEXT:PATH(existing)=[] ...
                              List of sync (as specified by PoPoolation2) files or directories to process. For directories, only files with the extension `.sync[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Input VCF/BCF:
  --vcf-path TEXT:PATH(existing)=[] ...
                              List of vcf/bcf files or directories to process. For directories, only files with the extension `.vcf[.gz]|.bcf` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times. This expects that the input file has the per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the counts of the reference and alternative base. This assumes that the data that was used to create the VCF file was actually a pool of individuals (e.g., from pool sequencing) for each sample (column) of the VCF file. We then interpret the `AD` field as the allele counts of each pool of individuals. Note that only SNP positions are used; positions that contain indels and other non-SNP variants are skipped.


Input frequency table:
  --frequency-table-path TEXT:PATH(existing)=[] ...
                              List of frequency table files or directories to process. For directories, only files with the extension `.(csv|tsv)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --frequency-table-separator-char TEXT:{comma,tab,space,semicolon}=comma Needs: --frequency-table-path
                              Separator char between fields of the frequency table input.
  --frequency-table-missing-value TEXT Needs: --frequency-table-path
                              Marker for denoting missing values in the table. By default, we use `.`, `nan`, and `na`.
  --frequency-table-depth-factor FLOAT:POSITIVE=0 Needs: --frequency-table-path
                              For frequency table input that only contains allele frequencies, without any information on read depth, we need to transform those frequencies into counts for our internal processing. This number is multiplied by the frequency to obtain these pseudo-counts. By default, we use 1000000, to get a reasonable interger approximation of the floating point frequency. This is of course above any typical read depth, but allows for more accurate counts when using for instance haplotype-corrected frequencies such as those from HAF-pipe.
  --frequency-table-freq-is-ref Needs: --frequency-table-path
                              For frequency table input that contains allele frequencies, we need to decide whether those frequencies represent the reference or the alternative allele. By default, we assume the latter, i.e., values are interpreted as alternative allele frequencies. Use this flag to instead interpret them as reference allele frequencies.
  --frequency-table-chr-column TEXT Needs: --frequency-table-path
                              Specify the name of the chromosome column in the header, case sensitive. By default, we look for columns named "chromosome", "chrom", "chr", or "contig", case insensitive.
  --frequency-table-pos-column TEXT Needs: --frequency-table-path
                              Specify the name of the position column in the header, case sensitive. By default, we look for columns named "position" or "pos", case insensitive.
  --frequency-table-ref-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the reference base column in the header, case sensitive. By default, we look for columns named "reference", "referencebase", "ref", or "refbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-alt-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the alternative base column in the header, case sensitive. By default, we look for columns named "alternative", "alternativebase", "alt", or "altbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-sample-ref-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample reference count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "reference", "referencebase", "ref", or "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.ref_cnt" indicates the reference count column for sample "S1".
  --frequency-table-sample-alt-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample alternative count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "alternative", "alternativebase", "alt", or "altbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.alt_cnt" indicates the alternative count column for sample "S1".
  --frequency-table-sample-freq-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample frequency columns in the header, case sensitive. By default, we look for column names having "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.freq" indicates the frequency column for sample "S1". Note that when the input data contains frequencies, but no reference or alternative base columns, such as HAF-pipe output tables, we cannot know the bases, and will hence guess. To properly set the reference bases, consider providing the `--reference-genome-fasta` option.
  --frequency-table-sample-depth-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample read depth columns in the header, case sensitive. By default, we look for column names having "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.read-depth" indicates the read depth column for sample "S1".


Input Settings:
  --multi-file-locus-set TEXT:{union,intersection}=union
                              When multiple input files are provided, select whether the union of all their loci is used (outer join), or their intersection (inner join). For their union, input files that do not have data at a particular locus are considered as missing at that locus. Note that we allow to use multiple input files even with different file types.
  --make-gapless              By default, we only operate on the positions for which there is data. In particular, positions that are absent in the input are completely ignored; they do not even show up in the `missing` column of output tables. This is because for the statistics, data being absent or (marked as) missing is merely a sementic distinction, but it does not change the results. However, it might make processing with downstream tools easier if the output contains all positions, for instance when using `single` windows. With this option, all absent positions are filled in as missing data, so that they show up in the `missing` column and as entries in single windows. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Note that this can lead to large ouput tables when processing single positions.
  --reference-genome-fasta TEXT:FILE Excludes: --reference-genome-dict --reference-genome-fai
                              Provide a reference genome in `.fasta[.gz]` format. This allows to correctly assign the reference bases in file formats that do not store them, and serves as an integrity check in those that do. It further is used as a sequence dictionary to determine the chromosome order and length, on behalf of a dict or fai file.
  --reference-genome-dict TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-fai
                              Provide a reference genome sequence dictionary in `.dict` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.
  --reference-genome-fai TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-dict
                              Provide a reference genome sequence dictionary in `.fai` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.


Sample Names, Groups, and Filters:
  --rename-samples-list TEXT:FILE
                              Allows to rename samples, by providing a file that lists the original and new sample names, one per line, separating original and new names by a comma or tab.
                              By default, we use sample names as provided in the input files. Some file types however do not contain sample names, such as (m)pileup or sync files (unless the non-standard sync header line is provided). For such file types, sample names are automatically assigned by using their input file base name (without path and extension), followed by a dot and numbers 1..n for all samples in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`, `sample.2`, etc.
                              Using this option, those names can be renamed as needed. Use verbose output (`--verbose`) to show a list of all sample names. We then use these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude` options.
  --filter-samples-include TEXT Excludes: --filter-samples-exclude
                              Sample names to include (all other samples are excluded); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --filter-samples-exclude TEXT Excludes: --filter-samples-include
                              Sample names to exclude (all other samples are included); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --sample-group-merge-table TEXT:FILE
                              When the input contains multiple samples (either within a single input file, or by providing multiple input files), these can be merged into new samples, by summing up their nucleotide base counts at each position. This has essentially the same effect as having merged the raw fastq files or the mapped sam/bam files of the samples, that is, all reads from those samples are treated as if they were a single sample. For this grouping, the option takes a simple table file (comma- or tab-separated), with the sample names (after the above renaming, if provided) in the first column, and their assigned group names in the second column. All samples in the same group are then merged into a grouped sample, and the group names are used as the new sample names for the output. Note that the `--pool-sizes` option then need to contain the summed up pool sizes for each group, using the group names.


Region Filters:
  --filter-region TEXT=[] ... Genomic region to filter for, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-list TEXT:FILE=[] ...
                              Genomic regions to filter for, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-bed TEXT:FILE=[] ...
                              Genomic regions to filter for, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-gff TEXT:FILE=[] ...
                              Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-map-bim TEXT:FILE=[] ...
                              Genomic positions to filter for, as a MAP or BIM file as used in PLINK. This only uses the chromosome and coordinate per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-vcf TEXT:FILE=[] ...
                              Genomic positions to filter for, as a VCF/BCF file (such as a known-variants file). This only uses the chromosome and position per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-fasta TEXT:FILE=[] ...
                              Genomic positions to filter for, as a FASTA-like mask file (such as used by vcftools). The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be filtered out or not. Any positions with digits above the `--filter-region-fasta-min` value are removed. Note that this conceptually differs from a mask file, and merely uses the same format.
  --filter-region-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, set the cutoff threshold for the filtered digits. Only positions with that value or lower will be kept. The default is 0, meaning that all positions with digits greater than 0 will be removed.
  --filter-region-fasta-invert :INT in [0 - 9] Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.
  --filter-region-set TEXT:{union,intersection}=union
                              It is possible to provide multiple of the above region filter options, even of different types. In that case, decide on how to combine the loci of these filters.


Masking Filters:
  --filter-mask-samples-bed-list TEXT:FILE Excludes: --filter-mask-samples-fasta-list
                              For each sample, genomic positions to mask (mark as missing), as a set of BED files.
                              See the below `--filter-mask-total-bed` for details. Here, individual BED files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and BED file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-bed-invert Needs: --filter-mask-samples-bed-list
                              When using `--filter-mask-samples-bed-list`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-samples-fasta-list TEXT:FILE Excludes: --filter-mask-samples-bed-list
                              For each sample, genomic positions to mask, as a FASTA-like mask file.
                              See the below `--filter-mask-total-fasta` for details. Here, individual FASTA files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and FASTA file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-samples-fasta-invert Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, invert the mask. When this flag is set, the mask specified above is inverted.
  --filter-mask-total-bed TEXT:FILE Excludes: --filter-mask-total-fasta
                              Genomic positions to mask (mark as missing), as a BED file.
                              The regions listed in the BED file are masked; this is in line with, e.g., smcpp, but is the inverse of the above usage of a BED file for selection regions, where instead the listed regions are kept. Note that this also conceptually differs from the region BED above. We here do not remove the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --filter-mask-total-bed-invert Needs: --filter-mask-total-bed
                              When using `--filter-mask-total-bed`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-total-fasta TEXT:FILE Excludes: --filter-mask-total-bed
                              Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be masked or not. Any positions with digits above the `--filter-mask-total-fasta-min` value are tagged as being masked. Note that this conceptually differs from the region fasta above. We here do not remove the the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
  --filter-mask-total-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-total-fasta-invert Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.


Numerical Filters:
  --filter-sample-min-count UINT:POSITIVE=0 REQUIRED
                              Minimum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts below that are set to zero, and hence ignored as an allele/variant. For example, singleton read sequencing errors can be filtered out this way.
  --filter-sample-max-count UINT=0
                              Maximum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts above that are set to zero, and hence ignored as an allele/variant. For example, spuriously high read counts can be filtered out this way.
  --filter-sample-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the sample is filtered out.
  --filter-sample-min-read-depth UINT=0
                              Minimum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is less than the provided value, the sample is ignored at this position.
  --filter-sample-max-read-depth UINT=0
                              Maximum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is greater than the provided value, the sample is ignored at this position. This can for example be used to filter spuriously high read depth positions.
  --filter-total-min-read-depth UINT=0
                              Minimum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is less than the provided value, the position is ignored.
  --filter-total-max-read-depth UINT=0
                              Maximum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is greater than the provided value, the position is ignored. This can for example be used to filter spuriously high read depth positions.
  --filter-total-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out, summed across all samples. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the position is filtered out.
  --filter-total-only-biallelic-snps
                              Filter out any positions that do not have exactly two alleles across all samples. That is, after applying all previous filters, if not exactly two counts (in `ACGT`) are non-zero in total across all samples, the position is not considered a biallelic SNP, and ignored.
  --filter-total-snp-min-count UINT=0
                              When filtering for positions that are SNPs, use this minimum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are below this are filtered out.
  --filter-total-snp-max-count UINT=0
                              When filtering for positions that are SNPs, use this maximum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are above this are filtered out; probably not relevant in practice, but offered for completeness.
  --filter-total-snp-min-frequency FLOAT=0
                              Minimum allele frequency that needs to be reached for a position to be used. Positions where the allele frequency `af` across all samples, or `1 - af`, is below this value, are ignored. If both the reference and alternative base are known, allele frequencies are computed based on those; if only the reference base is known, the most frequent non-reference base is used as the alternative; if neither is known, the first and second most frequent bases are used to compute the frequency.


Sample Subsampling:
  --subsample-max-read-depth UINT=0
                              If provided, the nucleotide counts of each sample are subsampled so that they do not exceed this given maximum total read depth (sum of the four nucleotide counts `ACGT`, as well as the any `N` and deleted `D` counts). If they are below this value anyway, they are not changed. This transformation is useful to limit the maximum read depth. For instance, the diversity estimators for Theta Pi and Theta Watterson have terms that depend on read depth. In particular when merging samples such as with `--sample-group-merge-table`, having an upper limit can hence avoid long compute times. Furthermore, a very low Tajima's D, usually indicative of a selective sweep, may be found as an artifact in highly covered regions, as such regions have just more sequencing errors. To avoid these kinds of biases we recommend to subsample to an uniform read depth. This transformation is applied after the numerical filters, so that, e.g., filters for high read depth are able to remove any unwanted positions first. See `--subsample-method` for the subsampling method.
  --subsample-method TEXT:{subscale,subsample-with-replacement,subsample-without-replacement}=subscale Needs: --subsample-max-read-depth
                              When using `--subsample-max-read-depth`, decide which method to use. The default `subscale` simply re-scales the base counts to the given max read depth, and hence maintains the allele frequencies (within integer precision). We recommend to use this to subsample to, e.g., a max read depth of 10,000, which is a good compromise in most cases. The two alternative options re-sample instead, with and without replacement, by drawing from a multinomial or multivariate hypergeometric distribution, respectively, based on the original counts of the sample.


Window:
  --window-type TEXT:{interval,queue,single,regions,chromosomes,genome}=interval REQUIRED
                              Type of window to use. Depending on the type, additional options might need to be provided. 
                              (1) `interval`: Typical sliding window over intervals of fixed length (in bases) along the genome. 
                              (2) `queue`: Sliding window, but instead of using a fixed length of bases along the genome, it uses a fixed number of positions of the input data. Typically used for windowing over variant positions such as (biallelic) SNPs, and useful for example when SNPs are sparse in the genome. 
                              (3) `single`: Treat each position of the input data as an individual window of size 1. This is typically used to process single SNPs, and equivalent to `interval` or `queue` with a width/count of 1, except that positions that are removed by some filter are skipped. 
                              (4) `regions`: Windows corresponding to some regions of interest, such as genes. The regions need to be provided, and can be overlapping or nested as needed. 
                              (5) `chromosomes`: Each window covers a whole chromosome. 
                              (6) `genome`: The whole genome is treated as a single window.
  --window-interval-width UINT=0
                              Required when using `--window-type interval`: Width of each window along the chromosome, in bases.
  --window-interval-stride UINT=0
                              When using `--window-type interval`: Stride between windows along the chromosome, that is how far to move to get to the next window. If set to 0 (default), this is set to the same value as the `--window-interval-width`, in which case windows do not overlap.
  --window-queue-count UINT=0 Required when using `--window-type queue`: Number of positions in the genome in each window. This is most commonly used when also filtering for variant positions such as (biallelic) SNPs (which most commands do implicitly), so that each window of the analysis conists of a fixed number of SNPs, instead of a fixed length along the genome.
  --window-queue-stride UINT=0
                              When using `--window-type queue`: Stride of positions between windows along the chromosome, that is how many positions does the window move forward each time. If set to 0 (default), this is set to the same value as the `--window-queue-count`, meaning that each new window consists of new positions.
  --window-region TEXT=[] ... When using `--window-type regions`: Genomic region to process as windows, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). Multiple region options can be provided to add region windows to be processed.
  --window-region-list TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). Multiple region options can be provided to add region windows to be processed.
  --window-region-bed TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. Multiple region options can be provided to add region windows to be processed.
  --window-region-gff TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Multiple region options can be provided to add region windows to be processed.
  --window-region-skip-empty  When using `--window-type regions`: In cases where there is no data in the input files for a region window, by default, we produce some "empty" or NaN output. With this option however, regions without data are skipped in the output.


Window Averaging:
  --window-average-policy TEXT:{window-length,available-loci,valid-loci,valid-snps,sum,provided-loci} REQUIRED
                              Denominator to use when computing the average of a metric in a window: 
                              (1) `window-length`: Simply use the window length, which likely underestimates the metric, in particular in regions with low coverage and high missing data.
                              (2) `available-loci`: Use the number of positions for which there was data at all (that is, absent or missing data is excluded), independent of all other filter settings.
                              (3) `valid-loci`: Use the number of positions that passed all quality and numerical filters (that is, excluding the SNP-related filters). This uses all positions of high quality, and is the recommended policy when the input contains data for all positions.
                              (4) `valid-snps`: Use the number of SNPs only. This might overestimate the metric, but can be useful when the data only consists of SNPs.
                              (5) `sum`: Simply report the sum of the per-site values, with no averaging applied to it. This can be used to apply custom averaging later.
                              (6) `provided-loci`: Use the exact loci provided via `--window-average-loci-bed` or `--window-average-loci-fasta` to determine the denominator for the window averaging, by counting all positions set in this mask in the given window.
  --window-average-loci-bed TEXT:FILE Needs: --window-average-policy Excludes: --window-average-loci-fasta
                              Genomic positions to use for `--window-average-policy provided-loci`, as a BED file. The regions listed in the BED file are counted towards the window average denominator.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --window-average-loci-bed-invert Needs: --window-average-loci-bed
                              When using `--window-average-loci-bed`, invert the set of loci. When this flag is set, the loci that are not set are used for the denominator. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --window-average-loci-fasta TEXT:FILE Needs: --window-average-policy Excludes: --window-average-loci-bed
                              Genomic positions to use for `--window-average-policy provided-loci`, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be counted towards the window denominator. Any positions with digits above the `--window-average-loci-fasta-min` value are used.
  --window-average-loci-fasta-min UINT:INT in [0 - 9]=0 Needs: --window-average-loci-fasta
                              When using `--window-average-loci-fasta`, set the cutoff threshold for the counted digits. All positions above that value are counted. The default is 0, meaning that only exactly the positons with value 0 will not be counted.
  --window-average-loci-fasta-invert Needs: --window-average-loci-fasta
                              When using `--window-average-loci-fasta`, invert the set of loci. When it is set, all positions in the FASTA-like file below or equal to the threshold are counted towards the window average denominator.


Settings:
  --pool-sizes TEXT REQUIRED  Pool sizes for all samples that are used (not filtered out). These are the number of haploids, so 100 diploid individuals correspond to a pool size of 200. Either 
                              (1) a single pool size that is used for all samples, specified on the command line, or 
                              (2) a path to a file that contains a comma- or tab-separated list of sample names and pool sizes, with one name/size pair per line, in any order of lines.
  --tajima-d-denominator-policy TEXT:{empirical-min-read-depth,provided-min-read-depth,popoolation-bugs,pool-size,uncorrected}=empirical-min-read-depth
                              Estimator for the expected number of distinct individuals sequenced in the denominator of the Achaz (2008) correction of Tajima's D, following its adaptation by PoPoolation. With pool seq data, there is no simple way to obtain a statistic that is numerically comparable to the classic Tajima's D with individual data. Hence, all of the below are simplicications that introduce some bias.
                              (1) `empirical-min-read-depth`: Use the lowest empirical read depth found in each window, and the pool size, to compute the expected number of individuals sequenced. This is a conservative estimator that we recommend by default.
                              (2) `provided-min-read-depth`: Same as (1), but use the user-provided `--filter-sample-min-read-depth` instead of the empirical minum read depth. This is what PoPoolation uses.
                              (3) `popoolation-bugs`: Same as (2), but additionally re-introduce their bugs. We offer this for comparability with PoPoolation.
                              (4) `pool-size`: Directly use the pool size as an estimate of the number of individuals, instead of computing the expected value. This assumes the number of individuals sequenced to be equal to the pool size, and is good under high read depths.
                              (5) `uncorrected`: The Achaz correction is not applied, so that the result is simply Theta Pi minus Theta Watterson. Hence, magnitudes of values are not comparable to classic Tajima's D. Still, using their sign, and comparing them across windows can be useful.
  --no-theta-pi               Do not compute or output Theta Pi. Note that if Tajima's D is computed, we also need to compute the two thetas, but will then not print them in the output.
  --no-theta-watterson        Do not compute or output Theta Watterson. Note that if Tajima's D is computed, we also need to compute the two thetas, but will then not print them in the output.
  --no-tajima-d               Do not compute Tajmias' D.
  --no-extra-columns          Do not output the extra columns containing counts for each position and sample pair that summarize the effects of the filtering. Only the window coordinates and the fst values are printed in that case.


Formatting:
  --separator-char TEXT:{comma,tab,space,semicolon}=comma Excludes: --popoolation-format
                              Separator char between fields of output tabular data.
  --na-entry TEXT=nan Excludes: --popoolation-format
                              Set the text to use in the output for n/a and NaN entries (e.g., resulting from positions with no counts, or windows with no variants). This is useful to match formatting expectations of downstream software.
  --popoolation-format Excludes: --separator-char --na-entry
                              If set, instead of writing one output table for all measures and all samples, write the results in separate files for each sample and for each measure of Theta Pi, Theta Watterson, and Tajima's D, following the format of PoPoolation.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress                  If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_frequency

### Tool Description
Create a table with per-sample and/or total base counts and/or frequencies at positions in the genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Create a table with per-sample and/or total base counts and/or frequencies at positions in the genome.
Usage: grenedalf frequency [OPTIONS]

Input SAM/BAM/CRAM:
  --sam-path TEXT:PATH(existing)=[] ...
                              List of sam/bam/cram files or directories to process. For directories, only files with the extension `.sam[.gz]|.bam|.cram` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --sam-min-map-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled mapping quality score [0-90] for a read in sam/bam/cram files to be considered. Any read that is below the given value of mapping quality will be completely discarded, and its bases not taken into account. Default is 0, meaning no filtering by base quality.
  --sam-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by base quality.
  --sam-split-by-rg Needs: --sam-path
                              Instead of considering the whole sam/bam/cram file as one large colletion of reads, use the `@RG` read group tag to split reads. Each read group is then considered a sample. Reads with an invalid (not in the header) read group tag or without a tag are ignored.
  --sam-flags-include-all TEXT Needs: --sam-path
                              Only use reads with all bits in the given value present in the FLAG field of the read. This is equivalent to the `-f` / `--require-flags` setting in `samtools view`, and uses the same flag names and their corresponding binary values. The value can be specified in hex by beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names as specified by samtools. We are more lenient in parsing flag names than `samtools`, and allow different capitalization and delimiteres such as dashes and underscores in the flag names as well.
  --sam-flags-include-any TEXT Needs: --sam-path
                              Only use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `--rf` / `--incl-flags` / `--include-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-all TEXT Needs: --sam-path
                              Do not use reads with all bits set in the given value present in the FLAG field of the read. This is equivalent to the `-G` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-any TEXT Needs: --sam-path
                              Do not use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / `--exclude-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.


Input (m)pileup:
  --pileup-path TEXT:PATH(existing)=[] ...
                              List of (m)pileup files or directories to process. For directories, only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --pileup-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --pileup-path
                              Minimum phred quality score [0-90] for a base in (m)pileup files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by phred quality score.
  --pileup-quality-encoding TEXT:{sanger,illumina-1.3,illumina-1.5,illumina-1.8,solexa}=sanger Needs: --pileup-path
                              Encoding of the quality scores of the bases in (m)pileup files, when using `--pileup-min-base-qual`. Default is `"sanger"`, which seems to be the most common these days. Both `"sanger"` and `"illumina-1.8"` are identical and use an ASCII offset of 33, while `"illumina-1.3"` and `"illumina-1.5"` are identical with an ASCII offset of 64 (we provide different names for completeness). Lastly, `"solexa"` has an offset of 64, but uses a different equation (not phred score) for the encoding.


Input sync:
  --sync-path TEXT:PATH(existing)=[] ...
                              List of sync (as specified by PoPoolation2) files or directories to process. For directories, only files with the extension `.sync[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Input VCF/BCF:
  --vcf-path TEXT:PATH(existing)=[] ...
                              List of vcf/bcf files or directories to process. For directories, only files with the extension `.vcf[.gz]|.bcf` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times. This expects that the input file has the per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the counts of the reference and alternative base. This assumes that the data that was used to create the VCF file was actually a pool of individuals (e.g., from pool sequencing) for each sample (column) of the VCF file. We then interpret the `AD` field as the allele counts of each pool of individuals. Note that only SNP positions are used; positions that contain indels and other non-SNP variants are skipped.


Input frequency table:
  --frequency-table-path TEXT:PATH(existing)=[] ...
                              List of frequency table files or directories to process. For directories, only files with the extension `.(csv|tsv)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --frequency-table-separator-char TEXT:{comma,tab,space,semicolon}=comma Needs: --frequency-table-path
                              Separator char between fields of the frequency table input.
  --frequency-table-missing-value TEXT Needs: --frequency-table-path
                              Marker for denoting missing values in the table. By default, we use `.`, `nan`, and `na`.
  --frequency-table-depth-factor FLOAT:POSITIVE=0 Needs: --frequency-table-path
                              For frequency table input that only contains allele frequencies, without any information on read depth, we need to transform those frequencies into counts for our internal processing. This number is multiplied by the frequency to obtain these pseudo-counts. By default, we use 1000000, to get a reasonable interger approximation of the floating point frequency. This is of course above any typical read depth, but allows for more accurate counts when using for instance haplotype-corrected frequencies such as those from HAF-pipe.
  --frequency-table-freq-is-ref Needs: --frequency-table-path
                              For frequency table input that contains allele frequencies, we need to decide whether those frequencies represent the reference or the alternative allele. By default, we assume the latter, i.e., values are interpreted as alternative allele frequencies. Use this flag to instead interpret them as reference allele frequencies.
  --frequency-table-chr-column TEXT Needs: --frequency-table-path
                              Specify the name of the chromosome column in the header, case sensitive. By default, we look for columns named "chromosome", "chrom", "chr", or "contig", case insensitive.
  --frequency-table-pos-column TEXT Needs: --frequency-table-path
                              Specify the name of the position column in the header, case sensitive. By default, we look for columns named "position" or "pos", case insensitive.
  --frequency-table-ref-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the reference base column in the header, case sensitive. By default, we look for columns named "reference", "referencebase", "ref", or "refbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-alt-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the alternative base column in the header, case sensitive. By default, we look for columns named "alternative", "alternativebase", "alt", or "altbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-sample-ref-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample reference count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "reference", "referencebase", "ref", or "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.ref_cnt" indicates the reference count column for sample "S1".
  --frequency-table-sample-alt-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample alternative count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "alternative", "alternativebase", "alt", or "altbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.alt_cnt" indicates the alternative count column for sample "S1".
  --frequency-table-sample-freq-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample frequency columns in the header, case sensitive. By default, we look for column names having "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.freq" indicates the frequency column for sample "S1". Note that when the input data contains frequencies, but no reference or alternative base columns, such as HAF-pipe output tables, we cannot know the bases, and will hence guess. To properly set the reference bases, consider providing the `--reference-genome-fasta` option.
  --frequency-table-sample-depth-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample read depth columns in the header, case sensitive. By default, we look for column names having "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.read-depth" indicates the read depth column for sample "S1".


Input Settings:
  --multi-file-locus-set TEXT:{union,intersection}=union
                              When multiple input files are provided, select whether the union of all their loci is used (outer join), or their intersection (inner join). For their union, input files that do not have data at a particular locus are considered as missing at that locus. Note that we allow to use multiple input files even with different file types.
  --make-gapless              By default, we only operate on the positions for which there is data. In particular, positions that are absent in the input are completely ignored; they do not even show up in the `missing` column of output tables. This is because for the statistics, data being absent or (marked as) missing is merely a sementic distinction, but it does not change the results. However, it might make processing with downstream tools easier if the output contains all positions, for instance when using `single` windows. With this option, all absent positions are filled in as missing data, so that they show up in the `missing` column and as entries in single windows. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Note that this can lead to large ouput tables when processing single positions.
  --reference-genome-fasta TEXT:FILE Excludes: --reference-genome-dict --reference-genome-fai
                              Provide a reference genome in `.fasta[.gz]` format. This allows to correctly assign the reference bases in file formats that do not store them, and serves as an integrity check in those that do. It further is used as a sequence dictionary to determine the chromosome order and length, on behalf of a dict or fai file.
  --reference-genome-dict TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-fai
                              Provide a reference genome sequence dictionary in `.dict` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.
  --reference-genome-fai TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-dict
                              Provide a reference genome sequence dictionary in `.fai` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.


Sample Names, Groups, and Filters:
  --rename-samples-list TEXT:FILE
                              Allows to rename samples, by providing a file that lists the original and new sample names, one per line, separating original and new names by a comma or tab.
                              By default, we use sample names as provided in the input files. Some file types however do not contain sample names, such as (m)pileup or sync files (unless the non-standard sync header line is provided). For such file types, sample names are automatically assigned by using their input file base name (without path and extension), followed by a dot and numbers 1..n for all samples in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`, `sample.2`, etc.
                              Using this option, those names can be renamed as needed. Use verbose output (`--verbose`) to show a list of all sample names. We then use these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude` options.
  --filter-samples-include TEXT Excludes: --filter-samples-exclude
                              Sample names to include (all other samples are excluded); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --filter-samples-exclude TEXT Excludes: --filter-samples-include
                              Sample names to exclude (all other samples are included); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --sample-group-merge-table TEXT:FILE
                              When the input contains multiple samples (either within a single input file, or by providing multiple input files), these can be merged into new samples, by summing up their nucleotide base counts at each position. This has essentially the same effect as having merged the raw fastq files or the mapped sam/bam files of the samples, that is, all reads from those samples are treated as if they were a single sample. For this grouping, the option takes a simple table file (comma- or tab-separated), with the sample names (after the above renaming, if provided) in the first column, and their assigned group names in the second column. All samples in the same group are then merged into a grouped sample, and the group names are used as the new sample names for the output. Note that the `--pool-sizes` option then need to contain the summed up pool sizes for each group, using the group names.


Region Filters:
  --filter-region TEXT=[] ... Genomic region to filter for, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-list TEXT:FILE=[] ...
                              Genomic regions to filter for, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-bed TEXT:FILE=[] ...
                              Genomic regions to filter for, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-gff TEXT:FILE=[] ...
                              Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-map-bim TEXT:FILE=[] ...
                              Genomic positions to filter for, as a MAP or BIM file as used in PLINK. This only uses the chromosome and coordinate per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-vcf TEXT:FILE=[] ...
                              Genomic positions to filter for, as a VCF/BCF file (such as a known-variants file). This only uses the chromosome and position per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-fasta TEXT:FILE=[] ...
                              Genomic positions to filter for, as a FASTA-like mask file (such as used by vcftools). The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be filtered out or not. Any positions with digits above the `--filter-region-fasta-min` value are removed. Note that this conceptually differs from a mask file, and merely uses the same format.
  --filter-region-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, set the cutoff threshold for the filtered digits. Only positions with that value or lower will be kept. The default is 0, meaning that all positions with digits greater than 0 will be removed.
  --filter-region-fasta-invert :INT in [0 - 9] Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.
  --filter-region-set TEXT:{union,intersection}=union
                              It is possible to provide multiple of the above region filter options, even of different types. In that case, decide on how to combine the loci of these filters.


Masking Filters:
  --filter-mask-samples-bed-list TEXT:FILE Excludes: --filter-mask-samples-fasta-list
                              For each sample, genomic positions to mask (mark as missing), as a set of BED files.
                              See the below `--filter-mask-total-bed` for details. Here, individual BED files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and BED file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-bed-invert Needs: --filter-mask-samples-bed-list
                              When using `--filter-mask-samples-bed-list`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-samples-fasta-list TEXT:FILE Excludes: --filter-mask-samples-bed-list
                              For each sample, genomic positions to mask, as a FASTA-like mask file.
                              See the below `--filter-mask-total-fasta` for details. Here, individual FASTA files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and FASTA file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-samples-fasta-invert Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, invert the mask. When this flag is set, the mask specified above is inverted.
  --filter-mask-total-bed TEXT:FILE Excludes: --filter-mask-total-fasta
                              Genomic positions to mask (mark as missing), as a BED file.
                              The regions listed in the BED file are masked; this is in line with, e.g., smcpp, but is the inverse of the above usage of a BED file for selection regions, where instead the listed regions are kept. Note that this also conceptually differs from the region BED above. We here do not remove the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --filter-mask-total-bed-invert Needs: --filter-mask-total-bed
                              When using `--filter-mask-total-bed`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-total-fasta TEXT:FILE Excludes: --filter-mask-total-bed
                              Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be masked or not. Any positions with digits above the `--filter-mask-total-fasta-min` value are tagged as being masked. Note that this conceptually differs from the region fasta above. We here do not remove the the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
  --filter-mask-total-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-total-fasta-invert Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.


Settings:
  --write-sample-counts       If set, write 'REF_CNT' and 'ALT_CNT' columns per sample, containing the REF and ALT base counts at the position for each sample.
  --write-sample-read-depth   If set, write a 'DEPTH' column per sample, containing the read depth (sum of REF and ALT) counts of each sample.
  --write-sample-ref-freq Excludes: --write-sample-alt-freq
                              If set, write a 'FREQ' column per sample, containing the reference allele frequency, computed as REF/(REF+ALT) of the counts of each sample.
  --write-sample-alt-freq Excludes: --write-sample-ref-freq
                              If set, write a 'FREQ' column per sample, containing the alternative allele frequency, computed as ALT/(REF+ALT) of the counts of each sample.
  --write-total-counts        If set, write the 'REF_CNT' and 'ALT_CNT' columns for the total, which contain the REF and ALT base counts at the position across all samples.
  --write-total-read-depth    If set, write the 'DEPTH' column for the total, containing the read_depth (sum of REF and ALT) counts across all samples.
  --write-total-frequency     If set, write the 'FREQ' column for the total, containing the frequency, computed as REF/(REF+ALT) of the counts across all samples.
  --write-invariants          If set, write rows that have no alternative (ALT) counts. By default, we omit these positions, which is useful to keep the output small. For example sam/bam/cream or (m)pileup files otherwise produce an output row for each position in the input.
  --omit-ref-and-alt-bases Excludes: --omit-alt-bases
                              If set, do not write the columns containing the reference and alternative bases. This can be useful when the input is obtained from a source that does not contain those anyway. In that case, we internally assign them to 'A' and 'G', respectively, which usually is not correct, and hence should be omitted from the output.
  --omit-alt-bases Excludes: --omit-ref-and-alt-bases
                              If set, do not write the column containing the alternative bases. This can be useful when the input is obtained from a source that does not contain them anyway. In that case, we internally assign the alternative base to be the transition base of the reference ('A' <-> 'G' and 'C' <-> 'T'), which usually is not correct, and hence should be omitted from the output. Note: To at least set the reference bases, consider providing the `--reference-genome-fasta` option.


Formatting:
  --separator-char TEXT:{comma,tab,space,semicolon}=comma
                              Separator char between fields of output tabular data.
  --na-entry TEXT=nan         Set the text to use in the output for n/a and NaN entries (e.g., resulting from positions with no counts, or windows with no variants). This is useful to match formatting expectations of downstream software.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress                  If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_fst

### Tool Description
Compute pool-sequencing corrected measures of FST.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Compute pool-sequencing corrected measures of FST.
Usage: grenedalf fst [OPTIONS]

Input SAM/BAM/CRAM:
  --sam-path TEXT:PATH(existing)=[] ...
                              List of sam/bam/cram files or directories to process. For directories, only files with the extension `.sam[.gz]|.bam|.cram` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --sam-min-map-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled mapping quality score [0-90] for a read in sam/bam/cram files to be considered. Any read that is below the given value of mapping quality will be completely discarded, and its bases not taken into account. Default is 0, meaning no filtering by base quality.
  --sam-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by base quality.
  --sam-split-by-rg Needs: --sam-path
                              Instead of considering the whole sam/bam/cram file as one large colletion of reads, use the `@RG` read group tag to split reads. Each read group is then considered a sample. Reads with an invalid (not in the header) read group tag or without a tag are ignored.
  --sam-flags-include-all TEXT Needs: --sam-path
                              Only use reads with all bits in the given value present in the FLAG field of the read. This is equivalent to the `-f` / `--require-flags` setting in `samtools view`, and uses the same flag names and their corresponding binary values. The value can be specified in hex by beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names as specified by samtools. We are more lenient in parsing flag names than `samtools`, and allow different capitalization and delimiteres such as dashes and underscores in the flag names as well.
  --sam-flags-include-any TEXT Needs: --sam-path
                              Only use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `--rf` / `--incl-flags` / `--include-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-all TEXT Needs: --sam-path
                              Do not use reads with all bits set in the given value present in the FLAG field of the read. This is equivalent to the `-G` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-any TEXT Needs: --sam-path
                              Do not use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / `--exclude-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.


Input (m)pileup:
  --pileup-path TEXT:PATH(existing)=[] ...
                              List of (m)pileup files or directories to process. For directories, only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --pileup-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --pileup-path
                              Minimum phred quality score [0-90] for a base in (m)pileup files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by phred quality score.
  --pileup-quality-encoding TEXT:{sanger,illumina-1.3,illumina-1.5,illumina-1.8,solexa}=sanger Needs: --pileup-path
                              Encoding of the quality scores of the bases in (m)pileup files, when using `--pileup-min-base-qual`. Default is `"sanger"`, which seems to be the most common these days. Both `"sanger"` and `"illumina-1.8"` are identical and use an ASCII offset of 33, while `"illumina-1.3"` and `"illumina-1.5"` are identical with an ASCII offset of 64 (we provide different names for completeness). Lastly, `"solexa"` has an offset of 64, but uses a different equation (not phred score) for the encoding.


Input sync:
  --sync-path TEXT:PATH(existing)=[] ...
                              List of sync (as specified by PoPoolation2) files or directories to process. For directories, only files with the extension `.sync[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Input VCF/BCF:
  --vcf-path TEXT:PATH(existing)=[] ...
                              List of vcf/bcf files or directories to process. For directories, only files with the extension `.vcf[.gz]|.bcf` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times. This expects that the input file has the per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the counts of the reference and alternative base. This assumes that the data that was used to create the VCF file was actually a pool of individuals (e.g., from pool sequencing) for each sample (column) of the VCF file. We then interpret the `AD` field as the allele counts of each pool of individuals. Note that only SNP positions are used; positions that contain indels and other non-SNP variants are skipped.


Input frequency table:
  --frequency-table-path TEXT:PATH(existing)=[] ...
                              List of frequency table files or directories to process. For directories, only files with the extension `.(csv|tsv)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --frequency-table-separator-char TEXT:{comma,tab,space,semicolon}=comma Needs: --frequency-table-path
                              Separator char between fields of the frequency table input.
  --frequency-table-missing-value TEXT Needs: --frequency-table-path
                              Marker for denoting missing values in the table. By default, we use `.`, `nan`, and `na`.
  --frequency-table-depth-factor FLOAT:POSITIVE=0 Needs: --frequency-table-path
                              For frequency table input that only contains allele frequencies, without any information on read depth, we need to transform those frequencies into counts for our internal processing. This number is multiplied by the frequency to obtain these pseudo-counts. By default, we use 1000000, to get a reasonable interger approximation of the floating point frequency. This is of course above any typical read depth, but allows for more accurate counts when using for instance haplotype-corrected frequencies such as those from HAF-pipe.
  --frequency-table-freq-is-ref Needs: --frequency-table-path
                              For frequency table input that contains allele frequencies, we need to decide whether those frequencies represent the reference or the alternative allele. By default, we assume the latter, i.e., values are interpreted as alternative allele frequencies. Use this flag to instead interpret them as reference allele frequencies.
  --frequency-table-chr-column TEXT Needs: --frequency-table-path
                              Specify the name of the chromosome column in the header, case sensitive. By default, we look for columns named "chromosome", "chrom", "chr", or "contig", case insensitive.
  --frequency-table-pos-column TEXT Needs: --frequency-table-path
                              Specify the name of the position column in the header, case sensitive. By default, we look for columns named "position" or "pos", case insensitive.
  --frequency-table-ref-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the reference base column in the header, case sensitive. By default, we look for columns named "reference", "referencebase", "ref", or "refbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-alt-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the alternative base column in the header, case sensitive. By default, we look for columns named "alternative", "alternativebase", "alt", or "altbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-sample-ref-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample reference count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "reference", "referencebase", "ref", or "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.ref_cnt" indicates the reference count column for sample "S1".
  --frequency-table-sample-alt-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample alternative count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "alternative", "alternativebase", "alt", or "altbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.alt_cnt" indicates the alternative count column for sample "S1".
  --frequency-table-sample-freq-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample frequency columns in the header, case sensitive. By default, we look for column names having "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.freq" indicates the frequency column for sample "S1". Note that when the input data contains frequencies, but no reference or alternative base columns, such as HAF-pipe output tables, we cannot know the bases, and will hence guess. To properly set the reference bases, consider providing the `--reference-genome-fasta` option.
  --frequency-table-sample-depth-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample read depth columns in the header, case sensitive. By default, we look for column names having "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.read-depth" indicates the read depth column for sample "S1".


Input Settings:
  --multi-file-locus-set TEXT:{union,intersection}=union
                              When multiple input files are provided, select whether the union of all their loci is used (outer join), or their intersection (inner join). For their union, input files that do not have data at a particular locus are considered as missing at that locus. Note that we allow to use multiple input files even with different file types.
  --make-gapless              By default, we only operate on the positions for which there is data. In particular, positions that are absent in the input are completely ignored; they do not even show up in the `missing` column of output tables. This is because for the statistics, data being absent or (marked as) missing is merely a sementic distinction, but it does not change the results. However, it might make processing with downstream tools easier if the output contains all positions, for instance when using `single` windows. With this option, all absent positions are filled in as missing data, so that they show up in the `missing` column and as entries in single windows. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Note that this can lead to large ouput tables when processing single positions.
  --reference-genome-fasta TEXT:FILE Excludes: --reference-genome-dict --reference-genome-fai
                              Provide a reference genome in `.fasta[.gz]` format. This allows to correctly assign the reference bases in file formats that do not store them, and serves as an integrity check in those that do. It further is used as a sequence dictionary to determine the chromosome order and length, on behalf of a dict or fai file.
  --reference-genome-dict TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-fai
                              Provide a reference genome sequence dictionary in `.dict` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.
  --reference-genome-fai TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-dict
                              Provide a reference genome sequence dictionary in `.fai` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.


Sample Names, Groups, and Filters:
  --rename-samples-list TEXT:FILE
                              Allows to rename samples, by providing a file that lists the original and new sample names, one per line, separating original and new names by a comma or tab.
                              By default, we use sample names as provided in the input files. Some file types however do not contain sample names, such as (m)pileup or sync files (unless the non-standard sync header line is provided). For such file types, sample names are automatically assigned by using their input file base name (without path and extension), followed by a dot and numbers 1..n for all samples in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`, `sample.2`, etc.
                              Using this option, those names can be renamed as needed. Use verbose output (`--verbose`) to show a list of all sample names. We then use these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude` options.
  --filter-samples-include TEXT Excludes: --filter-samples-exclude
                              Sample names to include (all other samples are excluded); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --filter-samples-exclude TEXT Excludes: --filter-samples-include
                              Sample names to exclude (all other samples are included); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --sample-group-merge-table TEXT:FILE
                              When the input contains multiple samples (either within a single input file, or by providing multiple input files), these can be merged into new samples, by summing up their nucleotide base counts at each position. This has essentially the same effect as having merged the raw fastq files or the mapped sam/bam files of the samples, that is, all reads from those samples are treated as if they were a single sample. For this grouping, the option takes a simple table file (comma- or tab-separated), with the sample names (after the above renaming, if provided) in the first column, and their assigned group names in the second column. All samples in the same group are then merged into a grouped sample, and the group names are used as the new sample names for the output. Note that the `--pool-sizes` option then need to contain the summed up pool sizes for each group, using the group names.


Region Filters:
  --filter-region TEXT=[] ... Genomic region to filter for, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-list TEXT:FILE=[] ...
                              Genomic regions to filter for, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-bed TEXT:FILE=[] ...
                              Genomic regions to filter for, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-gff TEXT:FILE=[] ...
                              Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-map-bim TEXT:FILE=[] ...
                              Genomic positions to filter for, as a MAP or BIM file as used in PLINK. This only uses the chromosome and coordinate per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-vcf TEXT:FILE=[] ...
                              Genomic positions to filter for, as a VCF/BCF file (such as a known-variants file). This only uses the chromosome and position per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-fasta TEXT:FILE=[] ...
                              Genomic positions to filter for, as a FASTA-like mask file (such as used by vcftools). The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be filtered out or not. Any positions with digits above the `--filter-region-fasta-min` value are removed. Note that this conceptually differs from a mask file, and merely uses the same format.
  --filter-region-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, set the cutoff threshold for the filtered digits. Only positions with that value or lower will be kept. The default is 0, meaning that all positions with digits greater than 0 will be removed.
  --filter-region-fasta-invert :INT in [0 - 9] Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.
  --filter-region-set TEXT:{union,intersection}=union
                              It is possible to provide multiple of the above region filter options, even of different types. In that case, decide on how to combine the loci of these filters.


Masking Filters:
  --filter-mask-samples-bed-list TEXT:FILE Excludes: --filter-mask-samples-fasta-list
                              For each sample, genomic positions to mask (mark as missing), as a set of BED files.
                              See the below `--filter-mask-total-bed` for details. Here, individual BED files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and BED file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-bed-invert Needs: --filter-mask-samples-bed-list
                              When using `--filter-mask-samples-bed-list`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-samples-fasta-list TEXT:FILE Excludes: --filter-mask-samples-bed-list
                              For each sample, genomic positions to mask, as a FASTA-like mask file.
                              See the below `--filter-mask-total-fasta` for details. Here, individual FASTA files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and FASTA file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-samples-fasta-invert Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, invert the mask. When this flag is set, the mask specified above is inverted.
  --filter-mask-total-bed TEXT:FILE Excludes: --filter-mask-total-fasta
                              Genomic positions to mask (mark as missing), as a BED file.
                              The regions listed in the BED file are masked; this is in line with, e.g., smcpp, but is the inverse of the above usage of a BED file for selection regions, where instead the listed regions are kept. Note that this also conceptually differs from the region BED above. We here do not remove the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --filter-mask-total-bed-invert Needs: --filter-mask-total-bed
                              When using `--filter-mask-total-bed`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-total-fasta TEXT:FILE Excludes: --filter-mask-total-bed
                              Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be masked or not. Any positions with digits above the `--filter-mask-total-fasta-min` value are tagged as being masked. Note that this conceptually differs from the region fasta above. We here do not remove the the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
  --filter-mask-total-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-total-fasta-invert Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.


Numerical Filters:
  --filter-sample-min-count UINT=0
                              Minimum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts below that are set to zero, and hence ignored as an allele/variant. For example, singleton read sequencing errors can be filtered out this way.
  --filter-sample-max-count UINT=0
                              Maximum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts above that are set to zero, and hence ignored as an allele/variant. For example, spuriously high read counts can be filtered out this way.
  --filter-sample-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the sample is filtered out.
  --filter-sample-min-read-depth UINT=0
                              Minimum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is less than the provided value, the sample is ignored at this position.
  --filter-sample-max-read-depth UINT=0
                              Maximum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is greater than the provided value, the sample is ignored at this position. This can for example be used to filter spuriously high read depth positions.
  --filter-total-min-read-depth UINT=0
                              Minimum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is less than the provided value, the position is ignored.
  --filter-total-max-read-depth UINT=0
                              Maximum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is greater than the provided value, the position is ignored. This can for example be used to filter spuriously high read depth positions.
  --filter-total-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out, summed across all samples. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the position is filtered out.
  --filter-total-only-biallelic-snps
                              Filter out any positions that do not have exactly two alleles across all samples. That is, after applying all previous filters, if not exactly two counts (in `ACGT`) are non-zero in total across all samples, the position is not considered a biallelic SNP, and ignored.
                              By default, we already filter for invariant sites, so that only SNPs remain for the computation. With this option however, this is further reduced to only biallelic (pure) SNPs.
  --filter-total-snp-min-count UINT=0
                              When filtering for positions that are SNPs, use this minimum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are below this are filtered out.
  --filter-total-snp-max-count UINT=0
                              When filtering for positions that are SNPs, use this maximum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are above this are filtered out; probably not relevant in practice, but offered for completeness.
  --filter-total-snp-min-frequency FLOAT=0
                              Minimum allele frequency that needs to be reached for a position to be used. Positions where the allele frequency `af` across all samples, or `1 - af`, is below this value, are ignored. If both the reference and alternative base are known, allele frequencies are computed based on those; if only the reference base is known, the most frequent non-reference base is used as the alternative; if neither is known, the first and second most frequent bases are used to compute the frequency.


Window:
  --window-type TEXT:{interval,queue,single,regions,chromosomes,genome}=interval REQUIRED
                              Type of window to use. Depending on the type, additional options might need to be provided. 
                              (1) `interval`: Typical sliding window over intervals of fixed length (in bases) along the genome. 
                              (2) `queue`: Sliding window, but instead of using a fixed length of bases along the genome, it uses a fixed number of positions of the input data. Typically used for windowing over variant positions such as (biallelic) SNPs, and useful for example when SNPs are sparse in the genome. 
                              (3) `single`: Treat each position of the input data as an individual window of size 1. This is typically used to process single SNPs, and equivalent to `interval` or `queue` with a width/count of 1, except that positions that are removed by some filter are skipped. 
                              (4) `regions`: Windows corresponding to some regions of interest, such as genes. The regions need to be provided, and can be overlapping or nested as needed. 
                              (5) `chromosomes`: Each window covers a whole chromosome. 
                              (6) `genome`: The whole genome is treated as a single window.
  --window-interval-width UINT=0
                              Required when using `--window-type interval`: Width of each window along the chromosome, in bases.
  --window-interval-stride UINT=0
                              When using `--window-type interval`: Stride between windows along the chromosome, that is how far to move to get to the next window. If set to 0 (default), this is set to the same value as the `--window-interval-width`, in which case windows do not overlap.
  --window-queue-count UINT=0 Required when using `--window-type queue`: Number of positions in the genome in each window. This is most commonly used when also filtering for variant positions such as (biallelic) SNPs (which most commands do implicitly), so that each window of the analysis conists of a fixed number of SNPs, instead of a fixed length along the genome.
  --window-queue-stride UINT=0
                              When using `--window-type queue`: Stride of positions between windows along the chromosome, that is how many positions does the window move forward each time. If set to 0 (default), this is set to the same value as the `--window-queue-count`, meaning that each new window consists of new positions.
  --window-region TEXT=[] ... When using `--window-type regions`: Genomic region to process as windows, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). Multiple region options can be provided to add region windows to be processed.
  --window-region-list TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). Multiple region options can be provided to add region windows to be processed.
  --window-region-bed TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. Multiple region options can be provided to add region windows to be processed.
  --window-region-gff TEXT:FILE=[] ...
                              When using `--window-type regions`: Genomic regions to process as windows, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Multiple region options can be provided to add region windows to be processed.
  --window-region-skip-empty  When using `--window-type regions`: In cases where there is no data in the input files for a region window, by default, we produce some "empty" or NaN output. With this option however, regions without data are skipped in the output.


Window Averaging:
  --window-average-policy TEXT:{window-length,available-loci,valid-loci,valid-snps,sum,provided-loci}
                              Denominator to use when computing the average of a metric in a window: 
                              (1) `window-length`: Simply use the window length, which likely underestimates the metric, in particular in regions with low coverage and high missing data.
                              (2) `available-loci`: Use the number of positions for which there was data at all (that is, absent or missing data is excluded), independent of all other filter settings.
                              (3) `valid-loci`: Use the number of positions that passed all quality and numerical filters (that is, excluding the SNP-related filters). This uses all positions of high quality, and is the recommended policy when the input contains data for all positions.
                              (4) `valid-snps`: Use the number of SNPs only. This might overestimate the metric, but can be useful when the data only consists of SNPs.
                              (5) `sum`: Simply report the sum of the per-site values, with no averaging applied to it. This can be used to apply custom averaging later.
                              (6) `provided-loci`: Use the exact loci provided via `--window-average-loci-bed` or `--window-average-loci-fasta` to determine the denominator for the window averaging, by counting all positions set in this mask in the given window.
  --window-average-loci-bed TEXT:FILE Needs: --window-average-policy Excludes: --window-average-loci-fasta
                              Genomic positions to use for `--window-average-policy provided-loci`, as a BED file. The regions listed in the BED file are counted towards the window average denominator.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --window-average-loci-bed-invert Needs: --window-average-loci-bed
                              When using `--window-average-loci-bed`, invert the set of loci. When this flag is set, the loci that are not set are used for the denominator. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --window-average-loci-fasta TEXT:FILE Needs: --window-average-policy Excludes: --window-average-loci-bed
                              Genomic positions to use for `--window-average-policy provided-loci`, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be counted towards the window denominator. Any positions with digits above the `--window-average-loci-fasta-min` value are used.
  --window-average-loci-fasta-min UINT:INT in [0 - 9]=0 Needs: --window-average-loci-fasta
                              When using `--window-average-loci-fasta`, set the cutoff threshold for the counted digits. All positions above that value are counted. The default is 0, meaning that only exactly the positons with value 0 will not be counted.
  --window-average-loci-fasta-invert Needs: --window-average-loci-fasta
                              When using `--window-average-loci-fasta`, invert the set of loci. When it is set, all positions in the FASTA-like file below or equal to the threshold are counted towards the window average denominator.


Settings:
  --method TEXT:{unbiased-nei,unbiased-hudson,kofler,karlsson}=unbiased-nei REQUIRED
                              FST method to use for the computation.
                              (1) The unbiased pool-sequencing statistic (in two variants, following the definition of Nei, and the definition of Hudson),
                              (2) the statistic by Kofler et al of PoPoolation2, or 
                              (3) the asymptotically unbiased estimator of Karlsson et al (which is also implemented in PoPoolation2). 
                              All except for the Karlsson method also require `--pool-sizes` to be provided.
  --pool-sizes TEXT           Pool sizes for all samples that are used (not filtered out). These are the number of haploids, so 100 diploid individuals correspond to a pool size of 200. Either 
                              (1) a single pool size that is used for all samples, specified on the command line, or 
                              (2) a path to a file that contains a comma- or tab-separated list of sample names and pool sizes, with one name/size pair per line, in any order of lines.
  --comparand TEXT Excludes: --comparand-list
                              By default, statistics between all pairs of samples (that are not filtered) are computed. If this option is given a sample name however, only the pairwise statistics between that sample and all others (that are not filtered) are computed.
  --second-comparand TEXT Needs: --comparand Excludes: --comparand-list
                              If in addition to `--comparand`, this option is also given a (second) sample name, only the statistics between those two samples are computed.
  --comparand-list TEXT:FILE Excludes: --comparand --second-comparand
                              By default, statistics between all pairs of samples are computed. If this option is given a file containing comma- or tab-separated pairs of sample names (one pair per line) however, only these pairwise statistics are computed.
  --write-pi-tables           When using either of the two unbiased (Nei or Hudson) estimators, also write tables of the involved pi values (within, between, and total). See our equations for details. We scale the values using the same `--window-average-policy` that is used for FST.
  --no-extra-columns          Do not output the extra columns containing counts for each position and sample pair that summarize the effects of the filtering. Only the window coordinates and the fst values are printed in that case.
  --no-nan-windows            Do not output windows where all values are n/a. This is can be relevant with small window sizes (or individual positions), to reduce output clutter.


Formatting:
  --separator-char TEXT:{comma,tab,space,semicolon}=comma
                              Separator char between fields of output tabular data.
  --na-entry TEXT=nan         Set the text to use in the output for n/a and NaN entries (e.g., resulting from positions with no counts, or windows with no variants). This is useful to match formatting expectations of downstream software.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress                  If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_fst-cathedral

### Tool Description
Compute the data for an FST cathedral plot.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Compute the data for an FST cathedral plot.
Usage: grenedalf fst-cathedral [OPTIONS]

Input SAM/BAM/CRAM:
  --sam-path TEXT:PATH(existing)=[] ...
                              List of sam/bam/cram files or directories to process. For directories, only files with the extension `.sam[.gz]|.bam|.cram` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --sam-min-map-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled mapping quality score [0-90] for a read in sam/bam/cram files to be considered. Any read that is below the given value of mapping quality will be completely discarded, and its bases not taken into account. Default is 0, meaning no filtering by base quality.
  --sam-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by base quality.
  --sam-split-by-rg Needs: --sam-path
                              Instead of considering the whole sam/bam/cram file as one large colletion of reads, use the `@RG` read group tag to split reads. Each read group is then considered a sample. Reads with an invalid (not in the header) read group tag or without a tag are ignored.
  --sam-flags-include-all TEXT Needs: --sam-path
                              Only use reads with all bits in the given value present in the FLAG field of the read. This is equivalent to the `-f` / `--require-flags` setting in `samtools view`, and uses the same flag names and their corresponding binary values. The value can be specified in hex by beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names as specified by samtools. We are more lenient in parsing flag names than `samtools`, and allow different capitalization and delimiteres such as dashes and underscores in the flag names as well.
  --sam-flags-include-any TEXT Needs: --sam-path
                              Only use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `--rf` / `--incl-flags` / `--include-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-all TEXT Needs: --sam-path
                              Do not use reads with all bits set in the given value present in the FLAG field of the read. This is equivalent to the `-G` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-any TEXT Needs: --sam-path
                              Do not use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / `--exclude-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.


Input (m)pileup:
  --pileup-path TEXT:PATH(existing)=[] ...
                              List of (m)pileup files or directories to process. For directories, only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --pileup-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --pileup-path
                              Minimum phred quality score [0-90] for a base in (m)pileup files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by phred quality score.
  --pileup-quality-encoding TEXT:{sanger,illumina-1.3,illumina-1.5,illumina-1.8,solexa}=sanger Needs: --pileup-path
                              Encoding of the quality scores of the bases in (m)pileup files, when using `--pileup-min-base-qual`. Default is `"sanger"`, which seems to be the most common these days. Both `"sanger"` and `"illumina-1.8"` are identical and use an ASCII offset of 33, while `"illumina-1.3"` and `"illumina-1.5"` are identical with an ASCII offset of 64 (we provide different names for completeness). Lastly, `"solexa"` has an offset of 64, but uses a different equation (not phred score) for the encoding.


Input sync:
  --sync-path TEXT:PATH(existing)=[] ...
                              List of sync (as specified by PoPoolation2) files or directories to process. For directories, only files with the extension `.sync[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Input VCF/BCF:
  --vcf-path TEXT:PATH(existing)=[] ...
                              List of vcf/bcf files or directories to process. For directories, only files with the extension `.vcf[.gz]|.bcf` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times. This expects that the input file has the per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the counts of the reference and alternative base. This assumes that the data that was used to create the VCF file was actually a pool of individuals (e.g., from pool sequencing) for each sample (column) of the VCF file. We then interpret the `AD` field as the allele counts of each pool of individuals. Note that only SNP positions are used; positions that contain indels and other non-SNP variants are skipped.


Input frequency table:
  --frequency-table-path TEXT:PATH(existing)=[] ...
                              List of frequency table files or directories to process. For directories, only files with the extension `.(csv|tsv)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --frequency-table-separator-char TEXT:{comma,tab,space,semicolon}=comma Needs: --frequency-table-path
                              Separator char between fields of the frequency table input.
  --frequency-table-missing-value TEXT Needs: --frequency-table-path
                              Marker for denoting missing values in the table. By default, we use `.`, `nan`, and `na`.
  --frequency-table-depth-factor FLOAT:POSITIVE=0 Needs: --frequency-table-path
                              For frequency table input that only contains allele frequencies, without any information on read depth, we need to transform those frequencies into counts for our internal processing. This number is multiplied by the frequency to obtain these pseudo-counts. By default, we use 1000000, to get a reasonable interger approximation of the floating point frequency. This is of course above any typical read depth, but allows for more accurate counts when using for instance haplotype-corrected frequencies such as those from HAF-pipe.
  --frequency-table-freq-is-ref Needs: --frequency-table-path
                              For frequency table input that contains allele frequencies, we need to decide whether those frequencies represent the reference or the alternative allele. By default, we assume the latter, i.e., values are interpreted as alternative allele frequencies. Use this flag to instead interpret them as reference allele frequencies.
  --frequency-table-chr-column TEXT Needs: --frequency-table-path
                              Specify the name of the chromosome column in the header, case sensitive. By default, we look for columns named "chromosome", "chrom", "chr", or "contig", case insensitive.
  --frequency-table-pos-column TEXT Needs: --frequency-table-path
                              Specify the name of the position column in the header, case sensitive. By default, we look for columns named "position" or "pos", case insensitive.
  --frequency-table-ref-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the reference base column in the header, case sensitive. By default, we look for columns named "reference", "referencebase", "ref", or "refbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-alt-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the alternative base column in the header, case sensitive. By default, we look for columns named "alternative", "alternativebase", "alt", or "altbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-sample-ref-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample reference count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "reference", "referencebase", "ref", or "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.ref_cnt" indicates the reference count column for sample "S1".
  --frequency-table-sample-alt-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample alternative count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "alternative", "alternativebase", "alt", or "altbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.alt_cnt" indicates the alternative count column for sample "S1".
  --frequency-table-sample-freq-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample frequency columns in the header, case sensitive. By default, we look for column names having "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.freq" indicates the frequency column for sample "S1". Note that when the input data contains frequencies, but no reference or alternative base columns, such as HAF-pipe output tables, we cannot know the bases, and will hence guess. To properly set the reference bases, consider providing the `--reference-genome-fasta` option.
  --frequency-table-sample-depth-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample read depth columns in the header, case sensitive. By default, we look for column names having "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.read-depth" indicates the read depth column for sample "S1".


Input Settings:
  --multi-file-locus-set TEXT:{union,intersection}=union
                              When multiple input files are provided, select whether the union of all their loci is used (outer join), or their intersection (inner join). For their union, input files that do not have data at a particular locus are considered as missing at that locus. Note that we allow to use multiple input files even with different file types.
  --make-gapless              By default, we only operate on the positions for which there is data. In particular, positions that are absent in the input are completely ignored; they do not even show up in the `missing` column of output tables. This is because for the statistics, data being absent or (marked as) missing is merely a sementic distinction, but it does not change the results. However, it might make processing with downstream tools easier if the output contains all positions, for instance when using `single` windows. With this option, all absent positions are filled in as missing data, so that they show up in the `missing` column and as entries in single windows. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Note that this can lead to large ouput tables when processing single positions.
  --reference-genome-fasta TEXT:FILE Excludes: --reference-genome-dict --reference-genome-fai
                              Provide a reference genome in `.fasta[.gz]` format. This allows to correctly assign the reference bases in file formats that do not store them, and serves as an integrity check in those that do. It further is used as a sequence dictionary to determine the chromosome order and length, on behalf of a dict or fai file.
  --reference-genome-dict TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-fai
                              Provide a reference genome sequence dictionary in `.dict` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.
  --reference-genome-fai TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-dict
                              Provide a reference genome sequence dictionary in `.fai` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.


Sample Names, Groups, and Filters:
  --rename-samples-list TEXT:FILE
                              Allows to rename samples, by providing a file that lists the original and new sample names, one per line, separating original and new names by a comma or tab.
                              By default, we use sample names as provided in the input files. Some file types however do not contain sample names, such as (m)pileup or sync files (unless the non-standard sync header line is provided). For such file types, sample names are automatically assigned by using their input file base name (without path and extension), followed by a dot and numbers 1..n for all samples in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`, `sample.2`, etc.
                              Using this option, those names can be renamed as needed. Use verbose output (`--verbose`) to show a list of all sample names. We then use these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude` options.
  --filter-samples-include TEXT Excludes: --filter-samples-exclude
                              Sample names to include (all other samples are excluded); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --filter-samples-exclude TEXT Excludes: --filter-samples-include
                              Sample names to exclude (all other samples are included); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --sample-group-merge-table TEXT:FILE
                              When the input contains multiple samples (either within a single input file, or by providing multiple input files), these can be merged into new samples, by summing up their nucleotide base counts at each position. This has essentially the same effect as having merged the raw fastq files or the mapped sam/bam files of the samples, that is, all reads from those samples are treated as if they were a single sample. For this grouping, the option takes a simple table file (comma- or tab-separated), with the sample names (after the above renaming, if provided) in the first column, and their assigned group names in the second column. All samples in the same group are then merged into a grouped sample, and the group names are used as the new sample names for the output. Note that the `--pool-sizes` option then need to contain the summed up pool sizes for each group, using the group names.


Region Filters:
  --filter-region TEXT=[] ... Genomic region to filter for, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-list TEXT:FILE=[] ...
                              Genomic regions to filter for, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-bed TEXT:FILE=[] ...
                              Genomic regions to filter for, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-gff TEXT:FILE=[] ...
                              Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-map-bim TEXT:FILE=[] ...
                              Genomic positions to filter for, as a MAP or BIM file as used in PLINK. This only uses the chromosome and coordinate per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-vcf TEXT:FILE=[] ...
                              Genomic positions to filter for, as a VCF/BCF file (such as a known-variants file). This only uses the chromosome and position per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-fasta TEXT:FILE=[] ...
                              Genomic positions to filter for, as a FASTA-like mask file (such as used by vcftools). The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be filtered out or not. Any positions with digits above the `--filter-region-fasta-min` value are removed. Note that this conceptually differs from a mask file, and merely uses the same format.
  --filter-region-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, set the cutoff threshold for the filtered digits. Only positions with that value or lower will be kept. The default is 0, meaning that all positions with digits greater than 0 will be removed.
  --filter-region-fasta-invert :INT in [0 - 9] Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.
  --filter-region-set TEXT:{union,intersection}=union
                              It is possible to provide multiple of the above region filter options, even of different types. In that case, decide on how to combine the loci of these filters.


Masking Filters:
  --filter-mask-samples-bed-list TEXT:FILE Excludes: --filter-mask-samples-fasta-list
                              For each sample, genomic positions to mask (mark as missing), as a set of BED files.
                              See the below `--filter-mask-total-bed` for details. Here, individual BED files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and BED file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-bed-invert Needs: --filter-mask-samples-bed-list
                              When using `--filter-mask-samples-bed-list`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-samples-fasta-list TEXT:FILE Excludes: --filter-mask-samples-bed-list
                              For each sample, genomic positions to mask, as a FASTA-like mask file.
                              See the below `--filter-mask-total-fasta` for details. Here, individual FASTA files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and FASTA file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-samples-fasta-invert Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, invert the mask. When this flag is set, the mask specified above is inverted.
  --filter-mask-total-bed TEXT:FILE Excludes: --filter-mask-total-fasta
                              Genomic positions to mask (mark as missing), as a BED file.
                              The regions listed in the BED file are masked; this is in line with, e.g., smcpp, but is the inverse of the above usage of a BED file for selection regions, where instead the listed regions are kept. Note that this also conceptually differs from the region BED above. We here do not remove the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --filter-mask-total-bed-invert Needs: --filter-mask-total-bed
                              When using `--filter-mask-total-bed`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-total-fasta TEXT:FILE Excludes: --filter-mask-total-bed
                              Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be masked or not. Any positions with digits above the `--filter-mask-total-fasta-min` value are tagged as being masked. Note that this conceptually differs from the region fasta above. We here do not remove the the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
  --filter-mask-total-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-total-fasta-invert Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.


Numerical Filters:
  --filter-sample-min-count UINT=0
                              Minimum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts below that are set to zero, and hence ignored as an allele/variant. For example, singleton read sequencing errors can be filtered out this way.
  --filter-sample-max-count UINT=0
                              Maximum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts above that are set to zero, and hence ignored as an allele/variant. For example, spuriously high read counts can be filtered out this way.
  --filter-sample-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the sample is filtered out.
  --filter-sample-min-read-depth UINT=0
                              Minimum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is less than the provided value, the sample is ignored at this position.
  --filter-sample-max-read-depth UINT=0
                              Maximum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is greater than the provided value, the sample is ignored at this position. This can for example be used to filter spuriously high read depth positions.
  --filter-total-min-read-depth UINT=0
                              Minimum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is less than the provided value, the position is ignored.
  --filter-total-max-read-depth UINT=0
                              Maximum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is greater than the provided value, the position is ignored. This can for example be used to filter spuriously high read depth positions.
  --filter-total-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out, summed across all samples. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the position is filtered out.
  --filter-total-only-biallelic-snps
                              Filter out any positions that do not have exactly two alleles across all samples. That is, after applying all previous filters, if not exactly two counts (in `ACGT`) are non-zero in total across all samples, the position is not considered a biallelic SNP, and ignored.
                              By default, we already filter out invariant sites, so that only SNPs remain. With this option however, this is further reduced to only biallelic (pure) SNPs. Note that with `--method karlsson`, we implicitly also activate to filter for biallelic SNPs only, as the method requires it.
  --filter-total-snp-min-count UINT=0
                              When filtering for positions that are SNPs, use this minimum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are below this are filtered out.
  --filter-total-snp-max-count UINT=0
                              When filtering for positions that are SNPs, use this maximum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are above this are filtered out; probably not relevant in practice, but offered for completeness.
  --filter-total-snp-min-frequency FLOAT=0
                              Minimum allele frequency that needs to be reached for a position to be used. Positions where the allele frequency `af` across all samples, or `1 - af`, is below this value, are ignored. If both the reference and alternative base are known, allele frequencies are computed based on those; if only the reference base is known, the most frequent non-reference base is used as the alternative; if neither is known, the first and second most frequent bases are used to compute the frequency.


Settings:
  --method TEXT:{unbiased-nei,unbiased-hudson}=unbiased-nei REQUIRED
                              FST method to use for the computation: The unbiased pool-sequencing statistic in two variants, following the definition of Nei, and the definition of Hudson.
  --pool-sizes TEXT REQUIRED  Pool sizes for all samples that are used (not filtered out). These are the number of haploids, so 100 diploid individuals correspond to a pool size of 200. Either 
                              (1) a single pool size that is used for all samples, specified on the command line, or 
                              (2) a path to a file that contains a comma- or tab-separated list of sample names and pool sizes, with one name/size pair per line, in any order of lines.
  --comparand TEXT Excludes: --comparand-list
                              By default, statistics between all pairs of samples (that are not filtered) are computed. If this option is given a sample name however, only the pairwise statistics between that sample and all others (that are not filtered) are computed.
  --second-comparand TEXT Needs: --comparand Excludes: --comparand-list
                              If in addition to `--comparand`, this option is also given a (second) sample name, only the statistics between those two samples are computed.
  --comparand-list TEXT:FILE Excludes: --comparand --second-comparand
                              By default, statistics between all pairs of samples are computed. If this option is given a file containing comma- or tab-separated pairs of sample names (one pair per line) however, only these pairwise statistics are computed.
  --cathedral-width UINT=1500 Width of the plot, in pixels. In particular, this determines the resolution of the last row of the plot, where each pixel corresponds to a window of the size `genome length / plot width`.
  --cathedral-height UINT=500 Height of the plot, in pixels. This determines the number of different window sizes displayed in the plot, from whole chromosome at the top to finest resolution at the bottom.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_simulate

### Tool Description
Create a file with simulated random frequency data.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Create a file with simulated random frequency data.
Usage: grenedalf simulate [OPTIONS]

Settings:
  --format TEXT:{pileup,sync}=pileup
                              Select the output file format, either (m)pileup, or PoPoolation2 sync.
  --random-seed UINT=0        Set the random seed for generating values, which allows reproducible results. If not provided, the system clock is used to obtain a random seed.


Samples:
  --read-depths TEXT REQUIRED Read depths of the samples to simulate, as a comma- or tab-separated list. The read depth of each sample is used at the total count per position to randomly distribute across nucleotides. Per sample, the list can either contain a single number, which will be used as the read depth for that sample at each position, or it can be two numbers separated by a slash, which will be used as min/max to generate random read depth at each position. The length of this list is also used to determine the number of samples to simulate.


Genome:
  --chromosome TEXT=A         Name of the chromosome. This is simply used as the first column in the output file. At the moment, only one chromosome is supported.
  --mutation-rate FLOAT:(FLOAT in [0 - 1]) AND (POSITIVE)=1e-08 Excludes: --mutation-count
                              Mutation rate to simulate. This rate times the `--length` is used as the number of mutations to generate in total (which can alternatively be directly provided via `--mutation-count`).
  --mutation-count UINT=0 Excludes: --mutation-rate
                              Number of mutations to simulate in total across the chromosome, spread across the `--length`.
  --length UINT=0 REQUIRED    Total length of the chromosome to simulate. Mutations are spread across this length.
  --omit-invariant-positions  If set, only write the mutated positions in the output file. Note that these are not standard (m)pileup or sync files any more; still this option might be useful.


Pileup:
  --with-quality-scores       If set, phred-scaled quality scores are written when simulating an (m)pileup file, using the `--min-phred-score` and `--max-phred-score` settings. Ignored otherwise.
  --min-phred-score UINT:UINT in [0 - 90]=10
                              Minimum phred score to use when simulating an (m)pileup file. Ignored otherwise.
  --max-phred-score UINT:UINT in [0 - 90]=40
                              Maximum phred score to use when simulating an (m)pileup file. Ignored otherwise.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress                  If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_sync

### Tool Description
Create a sync file that lists per-sample base counts at each position in the genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Create a sync file that lists per-sample base counts at each position in the genome.
Usage: grenedalf sync [OPTIONS]

Input SAM/BAM/CRAM:
  --sam-path TEXT:PATH(existing)=[] ...
                              List of sam/bam/cram files or directories to process. For directories, only files with the extension `.sam[.gz]|.bam|.cram` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --sam-min-map-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled mapping quality score [0-90] for a read in sam/bam/cram files to be considered. Any read that is below the given value of mapping quality will be completely discarded, and its bases not taken into account. Default is 0, meaning no filtering by base quality.
  --sam-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --sam-path
                              Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by base quality.
  --sam-split-by-rg Needs: --sam-path
                              Instead of considering the whole sam/bam/cram file as one large colletion of reads, use the `@RG` read group tag to split reads. Each read group is then considered a sample. Reads with an invalid (not in the header) read group tag or without a tag are ignored.
  --sam-flags-include-all TEXT Needs: --sam-path
                              Only use reads with all bits in the given value present in the FLAG field of the read. This is equivalent to the `-f` / `--require-flags` setting in `samtools view`, and uses the same flag names and their corresponding binary values. The value can be specified in hex by beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names as specified by samtools. We are more lenient in parsing flag names than `samtools`, and allow different capitalization and delimiteres such as dashes and underscores in the flag names as well.
  --sam-flags-include-any TEXT Needs: --sam-path
                              Only use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `--rf` / `--incl-flags` / `--include-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-all TEXT Needs: --sam-path
                              Do not use reads with all bits set in the given value present in the FLAG field of the read. This is equivalent to the `-G` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.
  --sam-flags-exclude-any TEXT Needs: --sam-path
                              Do not use reads with any bits set in the given value present in the FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / `--exclude-flags` setting in `samtools view`. See `--sam-flags-include-all` above for how to specify the value.


Input (m)pileup:
  --pileup-path TEXT:PATH(existing)=[] ...
                              List of (m)pileup files or directories to process. For directories, only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --pileup-min-base-qual UINT:UINT in [0 - 90]=0 Needs: --pileup-path
                              Minimum phred quality score [0-90] for a base in (m)pileup files to be considered. Bases below this are ignored when computing allele frequencies. Default is 0, meaning no filtering by phred quality score.
  --pileup-quality-encoding TEXT:{sanger,illumina-1.3,illumina-1.5,illumina-1.8,solexa}=sanger Needs: --pileup-path
                              Encoding of the quality scores of the bases in (m)pileup files, when using `--pileup-min-base-qual`. Default is `"sanger"`, which seems to be the most common these days. Both `"sanger"` and `"illumina-1.8"` are identical and use an ASCII offset of 33, while `"illumina-1.3"` and `"illumina-1.5"` are identical with an ASCII offset of 64 (we provide different names for completeness). Lastly, `"solexa"` has an offset of 64, but uses a different equation (not phred score) for the encoding.


Input sync:
  --sync-path TEXT:PATH(existing)=[] ...
                              List of sync (as specified by PoPoolation2) files or directories to process. For directories, only files with the extension `.sync[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.


Input VCF/BCF:
  --vcf-path TEXT:PATH(existing)=[] ...
                              List of vcf/bcf files or directories to process. For directories, only files with the extension `.vcf[.gz]|.bcf` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times. This expects that the input file has the per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the counts of the reference and alternative base. This assumes that the data that was used to create the VCF file was actually a pool of individuals (e.g., from pool sequencing) for each sample (column) of the VCF file. We then interpret the `AD` field as the allele counts of each pool of individuals. Note that only SNP positions are used; positions that contain indels and other non-SNP variants are skipped.


Input frequency table:
  --frequency-table-path TEXT:PATH(existing)=[] ...
                              List of frequency table files or directories to process. For directories, only files with the extension `.(csv|tsv)[.gz]` are processed. To input more than one file or directory, either separate them with spaces, or provide this option multiple times.
  --frequency-table-separator-char TEXT:{comma,tab,space,semicolon}=comma Needs: --frequency-table-path
                              Separator char between fields of the frequency table input.
  --frequency-table-missing-value TEXT Needs: --frequency-table-path
                              Marker for denoting missing values in the table. By default, we use `.`, `nan`, and `na`.
  --frequency-table-depth-factor FLOAT:POSITIVE=0 Needs: --frequency-table-path
                              For frequency table input that only contains allele frequencies, without any information on read depth, we need to transform those frequencies into counts for our internal processing. This number is multiplied by the frequency to obtain these pseudo-counts. By default, we use 1000000, to get a reasonable interger approximation of the floating point frequency. This is of course above any typical read depth, but allows for more accurate counts when using for instance haplotype-corrected frequencies such as those from HAF-pipe.
  --frequency-table-freq-is-ref Needs: --frequency-table-path
                              For frequency table input that contains allele frequencies, we need to decide whether those frequencies represent the reference or the alternative allele. By default, we assume the latter, i.e., values are interpreted as alternative allele frequencies. Use this flag to instead interpret them as reference allele frequencies.
  --frequency-table-chr-column TEXT Needs: --frequency-table-path
                              Specify the name of the chromosome column in the header, case sensitive. By default, we look for columns named "chromosome", "chrom", "chr", or "contig", case insensitive.
  --frequency-table-pos-column TEXT Needs: --frequency-table-path
                              Specify the name of the position column in the header, case sensitive. By default, we look for columns named "position" or "pos", case insensitive.
  --frequency-table-ref-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the reference base column in the header, case sensitive. By default, we look for columns named "reference", "referencebase", "ref", or "refbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-alt-base-column TEXT Needs: --frequency-table-path
                              Specify the name of the alternative base column in the header, case sensitive. By default, we look for columns named "alternative", "alternativebase", "alt", or "altbase", case insensitive, and ignoring any extra punctuation marks.
  --frequency-table-sample-ref-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample reference count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "reference", "referencebase", "ref", or "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.ref_cnt" indicates the reference count column for sample "S1".
  --frequency-table-sample-alt-count-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample alternative count columns in the header, case sensitive. By default, we look leniently for column names that combine any of "alternative", "alternativebase", "alt", or "altbase" with any of "counts", "count", "cnt", or "ct", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.alt_cnt" indicates the alternative count column for sample "S1".
  --frequency-table-sample-freq-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample frequency columns in the header, case sensitive. By default, we look for column names having "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.freq" indicates the frequency column for sample "S1". Note that when the input data contains frequencies, but no reference or alternative base columns, such as HAF-pipe output tables, we cannot know the bases, and will hence guess. To properly set the reference bases, consider providing the `--reference-genome-fasta` option.
  --frequency-table-sample-depth-column TEXT Needs: --frequency-table-path
                              Specify the exact prefix or suffix of the per-sample read depth columns in the header, case sensitive. By default, we look for column names having "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and ignoring any extra punctuation marks, as a prefix or suffix, with the remainder of the column name used as the sample name. For example, "S1.read-depth" indicates the read depth column for sample "S1".


Input Settings:
  --multi-file-locus-set TEXT:{union,intersection}=union
                              When multiple input files are provided, select whether the union of all their loci is used (outer join), or their intersection (inner join). For their union, input files that do not have data at a particular locus are considered as missing at that locus. Note that we allow to use multiple input files even with different file types.
  --make-gapless              By default, we only operate on the positions for which there is data. In particular, positions that are absent in the input are completely ignored; they do not even show up in the `missing` column of output tables. This is because for the statistics, data being absent or (marked as) missing is merely a sementic distinction, but it does not change the results. However, it might make processing with downstream tools easier if the output contains all positions, for instance when using `single` windows. With this option, all absent positions are filled in as missing data, so that they show up in the `missing` column and as entries in single windows. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Note that this can lead to large ouput tables when processing single positions.
  --reference-genome-fasta TEXT:FILE Excludes: --reference-genome-dict --reference-genome-fai
                              Provide a reference genome in `.fasta[.gz]` format. This allows to correctly assign the reference bases in file formats that do not store them, and serves as an integrity check in those that do. It further is used as a sequence dictionary to determine the chromosome order and length, on behalf of a dict or fai file.
  --reference-genome-dict TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-fai
                              Provide a reference genome sequence dictionary in `.dict` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.
  --reference-genome-fai TEXT:FILE Excludes: --reference-genome-fasta --reference-genome-dict
                              Provide a reference genome sequence dictionary in `.fai` format. It is used to determine the chromosome order and length, without having to provide the full reference genome.


Sample Names, Groups, and Filters:
  --rename-samples-list TEXT:FILE
                              Allows to rename samples, by providing a file that lists the original and new sample names, one per line, separating original and new names by a comma or tab.
                              By default, we use sample names as provided in the input files. Some file types however do not contain sample names, such as (m)pileup or sync files (unless the non-standard sync header line is provided). For such file types, sample names are automatically assigned by using their input file base name (without path and extension), followed by a dot and numbers 1..n for all samples in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`, `sample.2`, etc.
                              Using this option, those names can be renamed as needed. Use verbose output (`--verbose`) to show a list of all sample names. We then use these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude` options.
  --filter-samples-include TEXT Excludes: --filter-samples-exclude
                              Sample names to include (all other samples are excluded); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --filter-samples-exclude TEXT Excludes: --filter-samples-include
                              Sample names to exclude (all other samples are included); either (1) a comma- or tab-separated list given on the command line (in a typical shell, this list has to be enclosed in quotation marks), or (2) a file with one sample name per line. If no sample filter is provided, all samples in the input file are used. The option is applied after potentially renaming the samples with `--rename-samples-list`.
  --sample-group-merge-table TEXT:FILE
                              When the input contains multiple samples (either within a single input file, or by providing multiple input files), these can be merged into new samples, by summing up their nucleotide base counts at each position. This has essentially the same effect as having merged the raw fastq files or the mapped sam/bam files of the samples, that is, all reads from those samples are treated as if they were a single sample. For this grouping, the option takes a simple table file (comma- or tab-separated), with the sample names (after the above renaming, if provided) in the first column, and their assigned group names in the second column. All samples in the same group are then merged into a grouped sample, and the group names are used as the new sample names for the output. Note that the `--pool-sizes` option then need to contain the summed up pool sizes for each group, using the group names.


Region Filters:
  --filter-region TEXT=[] ... Genomic region to filter for, in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", or "chr:start..end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-list TEXT:FILE=[] ...
                              Genomic regions to filter for, as a file with one region per line, either in the format "chr" (for whole chromosomes), "chr:position", "chr:start-end", "chr:start..end", or tab- or space-delimited "chr position" or "chr start end". Positions are 1-based and inclusive (closed intervals). The filter keeps all listed positions, and removes all that are not listed. Multiple region options can be provided, see also `--filter-region-set`.
  --filter-region-bed TEXT:FILE=[] ...
                              Genomic regions to filter for, as a BED file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-gff TEXT:FILE=[] ...
                              Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-map-bim TEXT:FILE=[] ...
                              Genomic positions to filter for, as a MAP or BIM file as used in PLINK. This only uses the chromosome and coordinate per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-vcf TEXT:FILE=[] ...
                              Genomic positions to filter for, as a VCF/BCF file (such as a known-variants file). This only uses the chromosome and position per line, and ignores everything else in the file. The filter keeps all listed positions, and removes all that are not listed.
  --filter-region-fasta TEXT:FILE=[] ...
                              Genomic positions to filter for, as a FASTA-like mask file (such as used by vcftools). The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be filtered out or not. Any positions with digits above the `--filter-region-fasta-min` value are removed. Note that this conceptually differs from a mask file, and merely uses the same format.
  --filter-region-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, set the cutoff threshold for the filtered digits. Only positions with that value or lower will be kept. The default is 0, meaning that all positions with digits greater than 0 will be removed.
  --filter-region-fasta-invert :INT in [0 - 9] Needs: --filter-region-fasta
                              When using `--filter-region-mask-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.
  --filter-region-set TEXT:{union,intersection}=union
                              It is possible to provide multiple of the above region filter options, even of different types. In that case, decide on how to combine the loci of these filters.


Masking Filters:
  --filter-mask-samples-bed-list TEXT:FILE Excludes: --filter-mask-samples-fasta-list
                              For each sample, genomic positions to mask (mark as missing), as a set of BED files.
                              See the below `--filter-mask-total-bed` for details. Here, individual BED files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and BED file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-bed-invert Needs: --filter-mask-samples-bed-list
                              When using `--filter-mask-samples-bed-list`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-samples-fasta-list TEXT:FILE Excludes: --filter-mask-samples-bed-list
                              For each sample, genomic positions to mask, as a FASTA-like mask file.
                              See the below `--filter-mask-total-fasta` for details. Here, individual FASTA files can be provided for each sample, for fine-grained control over the masking. The option takes a path to a file that contains a comma- or tab-separated list of sample names and FASTA file paths, with one name/path pair per line, in any order of lines.
  --filter-mask-samples-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-samples-fasta-invert Needs: --filter-mask-samples-fasta-list
                              When using `--filter-mask-samples-fasta-list`, invert the mask. When this flag is set, the mask specified above is inverted.
  --filter-mask-total-bed TEXT:FILE Excludes: --filter-mask-total-fasta
                              Genomic positions to mask (mark as missing), as a BED file.
                              The regions listed in the BED file are masked; this is in line with, e.g., smcpp, but is the inverse of the above usage of a BED file for selection regions, where instead the listed regions are kept. Note that this also conceptually differs from the region BED above. We here do not remove the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
                              This only uses the chromosome, as well as start and end information per line, and ignores everything else in the file. Note that BED uses 0-based positions, and a half-open `[)` interval for the end position; simply using columns extracted from other file formats (such as vcf or gff) will not work.
  --filter-mask-total-bed-invert Needs: --filter-mask-total-bed
                              When using `--filter-mask-total-bed`, set this flag to invert the specified mask. Needs one of `--reference-genome-fasta`, `--reference-genome-dict`, `--reference-genome-fai` to determine chromosome lengths.
  --filter-mask-total-fasta TEXT:FILE Excludes: --filter-mask-total-bed
                              Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).
                              The file contains a sequence of integer digits `[0-9]`, one for each position on the chromosomes, which specify if the position should be masked or not. Any positions with digits above the `--filter-mask-total-fasta-min` value are tagged as being masked. Note that this conceptually differs from the region fasta above. We here do not remove the the masked positions, but instead just mark them as masked, so that they can still contribute to, e.g., denominators in the statistics for certain settings.
  --filter-mask-total-fasta-min UINT:INT in [0 - 9]=0 Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, set the cutoff threshold for the masked digits. All positions above that value are masked. The default is 0, meaning that only exactly the positons with value 0 will not be masked.
  --filter-mask-total-fasta-invert Needs: --filter-mask-total-fasta
                              When using `--filter-mask-total-fasta`, invert the mask. This option has the same effect as the equivalent in vcftools, but instead of specifying the file, this here is a flag. When it is set, the mask specified above is inverted.


Numerical Filters:
  --filter-sample-min-count UINT=0
                              Minimum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts below that are set to zero, and hence ignored as an allele/variant. For example, singleton read sequencing errors can be filtered out this way.
  --filter-sample-max-count UINT=0
                              Maximum base count for a nucleotide (in `ACGT`) to be considered as an allele. Counts above that are set to zero, and hence ignored as an allele/variant. For example, spuriously high read counts can be filtered out this way.
  --filter-sample-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the sample is filtered out.
  --filter-sample-min-read-depth UINT=0
                              Minimum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is less than the provided value, the sample is ignored at this position.
  --filter-sample-max-read-depth UINT=0
                              Maximum read depth expected for a position in a sample to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in a sample is greater than the provided value, the sample is ignored at this position. This can for example be used to filter spuriously high read depth positions.
  --filter-sample-only-snps Excludes: --filter-sample-only-biallelic-snps
                              Filter out any positions in a sample that do not have two or more alleles (i.e., that are invariant). That is, after applying `--filter-sample-min-count` and `--filter-sample-max-count`, if less than two counts (in `ACGT`) are non-zero, the position is not considered a SNP for the sample, and ignored.
  --filter-sample-only-biallelic-snps Excludes: --filter-sample-only-snps
                              Filter out any positions in a sample that do not have exactly two alleles. That is, after applying `--filter-sample-min-count` and `--filter-sample-max-count`, if not exactly two counts (in `ACGT`) are non-zero, the position is not considered a biallelic SNP for the sample, and ignored.
  --filter-total-min-read-depth UINT=0
                              Minimum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is less than the provided value, the position is ignored.
  --filter-total-max-read-depth UINT=0
                              Maximum read depth expected for a position in total to be considered covered. If the sum of nucleotide counts (in `ACGT`) at a given position in total (across all samples) is greater than the provided value, the position is ignored. This can for example be used to filter spuriously high read depth positions.
  --filter-total-deletions-limit UINT=0
                              Maximum number of deletions at a position before being filtered out, summed across all samples. If this is set to a value greater than 0, and the number of deletions at the position is equal to or greater than this value, the position is filtered out.
  --filter-total-only-snps Excludes: --filter-total-only-biallelic-snps
                              Filter out any positions that do not have two or more alleles (i.e., that are invariant) across all samples. That is, after applying all previous filters, if less than two counts (in `ACGT`) are non-zero in total across all samples, the position is not considered a SNP, and ignored.
  --filter-total-only-biallelic-snps Excludes: --filter-total-only-snps
                              Filter out any positions that do not have exactly two alleles across all samples. That is, after applying all previous filters, if not exactly two counts (in `ACGT`) are non-zero in total across all samples, the position is not considered a biallelic SNP, and ignored.
  --filter-total-snp-min-count UINT=0
                              When filtering for positions that are SNPs, use this minimum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are below this are filtered out.
  --filter-total-snp-max-count UINT=0
                              When filtering for positions that are SNPs, use this maximum count (summed across all samples) to identify what is considered a SNP. Positions where the counts are above this are filtered out; probably not relevant in practice, but offered for completeness.
  --filter-total-snp-min-frequency FLOAT=0
                              Minimum allele frequency that needs to be reached for a position to be used. Positions where the allele frequency `af` across all samples, or `1 - af`, is below this value, are ignored. If both the reference and alternative base are known, allele frequencies are computed based on those; if only the reference base is known, the most frequent non-reference base is used as the alternative; if neither is known, the first and second most frequent bases are used to compute the frequency.


Sample Subsampling:
  --subsample-max-read-depth UINT=0
                              If provided, the nucleotide counts of each sample are subsampled so that they do not exceed this given maximum total read depth (sum of the four nucleotide counts `ACGT`, as well as the any `N` and deleted `D` counts). If they are below this value anyway, they are not changed. This transformation is useful to limit the maximum read depth. For instance, the diversity estimators for Theta Pi and Theta Watterson have terms that depend on read depth. In particular when merging samples such as with `--sample-group-merge-table`, having an upper limit can hence avoid long compute times. Furthermore, a very low Tajima's D, usually indicative of a selective sweep, may be found as an artifact in highly covered regions, as such regions have just more sequencing errors. To avoid these kinds of biases we recommend to subsample to an uniform read depth. This transformation is applied after the numerical filters, so that, e.g., filters for high read depth are able to remove any unwanted positions first. See `--subsample-method` for the subsampling method.
  --subsample-method TEXT:{subscale,subsample-with-replacement,subsample-without-replacement}=subscale Needs: --subsample-max-read-depth
                              When using `--subsample-max-read-depth`, decide which method to use. The default `subscale` simply re-scales the base counts to the given max read depth, and hence maintains the allele frequencies (within integer precision). We recommend to use this to subsample to, e.g., a max read depth of 10,000, which is a good compromise in most cases. The two alternative options re-sample instead, with and without replacement, by drawing from a multinomial or multivariate hypergeometric distribution, respectively, based on the original counts of the sample.


Settings:
  --no-header                 We provide an extension of the sync format that allows to store sample names in sync files, where a header line is added to the output file of the form: `#chr pos ref S1...`, where `S1...` is the list of sample names. Not all other tools that read sync files will be able to parse this, and it hence can be deactivated with this option.
  --no-missing-marker         We provide an extension of the sync format that allows to mark positions as missing, by using the format `.:.:.:.:.:.`, instead of setting zero counts for these positions. This is particularly useful when storing data from multiple samples, to for instance distinguish true missing data from positions that have been filtered out. Not all other tools that read sync files will be able to parse this, and it hence can be deactivated here, in which case zero counts are written at these positions instead.
  --gapless-gsync             By default, only the positions for which there is data are printed in the output. However, it might make processing with other tools easier if all files contain all positions, which one might call a `gsync` file (following the `gvcf` format). With this option, all missing positions are filled with the missing data indicator, or with zero counts, depending on the `--no-missing-marker` option. If a referene genome or dictionary is given, this might also include positions beyond where there is input data, up until the length of each chromosome. Hence, the resulting `gsync` files shall all have the exact same number of lines, which is convenient for simply downstream scripts. Note: This option is an alias for the more general `--make-gapless` option.
  --guess-reference-base      By default, when reading from input file formats that do not store the reference base, we do not attempt to guess it. When set however, we use the base with the highest count as the reference base for the output. Alternatively, when a reference genome is provided, we use that to correctly set the reference bases, independently of whether this flag is set.


Output:
  --out-dir TEXT=.            Directory to write files to
  --file-prefix TEXT          File prefix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most grenedalf commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress                  If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting    Allow to overwrite existing output files instead of aborting the command. By default, we abort if any output file already exists, to avoid overwriting by mistake.
  --verbose                   Produce more verbose output.
  --threads UINT=14           Number of threads to use for calculations. If not set, we guess a reasonable number of threads, by looking at the environmental variables (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as well as (3) the hardware concurrency (number of CPU cores), taking hyperthreads into account, in the given order of precedence.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help                      Print this help message and exit.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_citation

### Tool Description
Print references to be cited when using grenedalf.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: PASS

### Original Help Text
```text
Print references to be cited when using grenedalf.
Usage: grenedalf citation [OPTIONS] [keys...]

Positionals:
  keys TEXT:{Czech2023-grenedalf,Kofler2011-PoPoolation,Kofler2011-PoPoolation2}=[] ...
                              Only print the citations for the given keys.

Options:
  --help                      Print this help message and exit.
  --format TEXT:{bibtex,markdown,both}=bibtex
                              Output format for citations.
  --all                       Print all relevant citations used by commands in grenedalf.
  --list                      List all available citation keys.


grenedalf: population genetic statistics for the next generation of pool sequencing
```


## grenedalf_license

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
- **Homepage**: https://github.com/lczech/grenedalf
- **Package**: https://anaconda.org/channels/bioconda/packages/grenedalf/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
grenedalf - Genome Analyses of Differential Allele Frequencies
Copyright (C) 2020-2021 Lucas Czech

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Contact:
Lucas Czech <lczech@carnegiescience.edu>
Department of Plant Biology, Carnegie Institution For Science
260 Panama Street, Stanford, CA 94305, USA
```


## Metadata
- **Skill**: generated
