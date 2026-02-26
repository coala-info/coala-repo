# ngs-bits CWL Generation Report

## ngs-bits_ReadQC

### Tool Description
Calculates QC metrics on unprocessed NGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Total Downloads**: 105.4K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/imgag/ngs-bits
- **Stars**: N/A
### Original Help Text
```text
ReadQC (2025_12)

Calculates QC metrics on unprocessed NGS reads.

Mandatory parameters:
  -in1 <filelist>          Forward input gzipped FASTQ file(s).

Optional parameters:
  -in2 <filelist>          Reverse input gzipped FASTQ file(s) for paired-end mode (same number of cycles/reads as 'in1').
                           Default value: ''
  -out <file>              Output qcML file. If unset, writes to STDOUT.
                           Default value: ''
  -txt                     Writes TXT format instead of qcML.
                           Default value: 'false'
  -out1 <file>             If set, writes merged forward FASTQs to this file (gzipped).
                           Default value: ''
  -out2 <file>             If set, writes merged reverse FASTQs to this file (gzipped)
                           Default value: ''
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'
  -long_read               Support long reads (> 1kb).
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_MappingQC

### Tool Description
Calculates QC metrics based on mapped NGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
MappingQC (2025_12)

Calculates QC metrics based on mapped NGS reads.

Mandatory parameters:
  -in <file>                 Input BAM/CRAM file.

Optional parameters:
  -out <file>                Output qcML file. If unset, writes to STDOUT.
                             Default value: ''
  -roi <file>                Input target region BED file (for panel, WES, etc.).
                             Default value: ''
  -wgs                       WGS mode without target region. Genome information is taken from the BAM/CRAM file.
                             Default value: 'false'
  -rna                       RNA mode without target region. Genome information is taken from the BAM/CRAM file.
                             Default value: 'false'
  -txt                       Writes TXT format instead of qcML.
                             Default value: 'false'
  -min_mapq <int>            Minmum mapping quality to consider a read mapped.
                             Default value: '1'
  -no_cont                   Disables sample contamination calculation, e.g. for tumor or non-human samples.
                             Default value: 'false'
  -debug                     Enables verbose debug outout.
                             Default value: 'false'
  -build <enum>              Genome build used to generate the input (needed for WGS and contamination only).
                             Default value: 'hg38'
                             Valid: 'hg19,hg38,non_human'
  -ref <file>                Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                             Default value: ''
  -cfdna                     Add additional QC parameters for cfDNA samples. Only supported mit '-roi'.
                             Default value: 'false'
  -somatic_custom_bed <file> Somatic custom region of interest (subpanel of actual roi). If specified, additional depth metrics will be calculated.
                             Default value: ''
  -read_qc <file>            If set, a read QC file in qcML format is created (just like ReadQC/SeqPurge).
                             Default value: ''
  -long_read                 Support long reads (> 1kb).
                             Default value: 'false'

Special parameters:
  --help                     Shows this help and exits.
  --version                  Prints version and exits.
  --changelog                Prints changeloge and exits.
  --tdx                      Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]          Settings override file (no other settings files are used).
```


## ngs-bits_VariantQC

### Tool Description
Calculates QC metrics on variant lists.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VariantQC (2025_12)

Calculates QC metrics on variant lists.

Mandatory parameters:
  -in <file>          Input variant list in VCF format.

Optional parameters:
  -ignore_filter      Ignore filter entries, i.e. consider variants that did not pass filters.
                      Default value: 'false'
  -out <file>         Output qcML file. If unset, writes to STDOUT.
                      Default value: ''
  -txt                Writes TXT format instead of qcML.
                      Default value: 'false'
  -long_read          Adds LongRead specific QC values (e.g. phasing information)
                      Default value: 'false'
  -phasing_bed <file> Output BED file containing phasing blocks with id. (requires parameter '-longread')
                      Default value: ''

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```


## ngs-bits_QcToTsv

### Tool Description
Converts qcML files to a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
QcToTsv (2025_12)

Converts qcML files to a TSV file..

Mandatory parameters:
  -in <filelist>    Input qcML files.

Optional parameters:
  -out <file>       Output TSV file. If unset, writes to STDOUT.
                    Default value: ''
  -obo <file>       OBO file to use. If unset, uses the default file compiled into ngs-bits.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_SampleSimilarity

### Tool Description
Calculates pairwise sample similarity metrics from VCF/BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SampleSimilarity (2025_12)

Calculates pairwise sample similarity metrics from VCF/BAM/CRAM files.

In VCF mode, multi-allelic variants are not supported and skipped. Use VcfBreakMulti to split multi-allelic variants into several lines if you want to use them.
Multi-sample VCFs are not supported. Use VcfExtractSamples to split them to one VCF per sample.
In VCF mode, it is assumed that variant lists are left-normalized, e.g. with VcfLeftNormalize.
BAM mode supports BAM as well as CRAM files.
Note: When working on hg38 WES or WGS samples, it is recommended to use the 'roi_hg38_wes_wgs' flag!

Mandatory parameters:
  -in <filelist>      Input variant lists in VCF format (two or more). If only one file is given, each line in this file is interpreted as an input file path.

Optional parameters:
  -out <file>         Output file. If unset, writes to STDOUT.
                      Default value: ''
  -mode <enum>        Mode (input format).
                      Default value: 'vcf'
                      Valid: 'vcf,gsvar,bam'
  -roi <file>         Restrict similarity calculation to variants in target region.
                      Default value: ''
  -roi_hg38_wes_wgs   Used pre-defined high-confidence coding region of hg38. Speeds up calculations, especially for WGS. Also makes scores comparable when mixing WES and WGS or different WES kits.
                      Default value: 'false'
  -include_gonosomes  Includes gonosomes into calculation (by default only variants on autosomes are considered).
                      Default value: 'false'
  -min_cov <int>      Minimum coverage to consider a SNP for the analysis (BAM mode).
                      Default value: '30'
  -max_snps <int>     The maximum number of high-coverage SNPs to extract from BAM/CRAM. 0 means unlimited (BAM mode).
                      Default value: '5000'
  -build <enum>       Genome build used to generate the input (BAM mode).
                      Default value: 'hg38'
                      Valid: 'hg19,hg38'
  -ref <file>         Reference genome for CRAM support (mandatory if CRAM is used).
                      Default value: ''
  -long_read          Support long reads (BAM mode).
                      Default value: 'false'
  -debug              Print debug output.
                      Default value: 'false'

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```


## ngs-bits_SampleGender

### Tool Description
Determines the gender of a sample from the BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SampleGender (2025_12)

Determines the gender of a sample from the BAM/CRAM file.

Mandatory parameters:
  -in <filelist>      Input BAM/CRAM file(s).
  -method <enum>      Method selection: Read distribution on X and Y chromosome (xy), fraction of heterozygous variants on X chromosome (hetx), or coverage of SRY gene (sry).
                      Valid: 'xy,hetx,sry'

Optional parameters:
  -out <file>         Output TSV file - one line per input BAM/CRAM file. If unset, writes to STDOUT.
                      Default value: ''
  -max_female <float> Maximum Y/X ratio for female (method xy).
                      Default value: '0.06'
  -min_male <float>   Minimum Y/X ratio for male (method xy).
                      Default value: '0.09'
  -min_female <float> Minimum heterozygous SNP fraction for female (method hetx).
                      Default value: '0.25'
  -max_male <float>   Maximum heterozygous SNP fraction for male (method hetx).
                      Default value: '0.05'
  -sry_cov <float>    Minimum average coverage of SRY gene for males (method sry).
                      Default value: '20'
  -build <enum>       Genome build used to generate the input (methods hetx and sry).
                      Default value: 'hg38'
                      Valid: 'hg19,hg38'
  -ref <file>         Reference genome for CRAM support (mandatory if CRAM is used).
                      Default value: ''
  -long_read          Support long reads (> 1kb) and uses single-end reads for gender calculation.
                      Default value: 'false'

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```


## ngs-bits_SampleAncestry

### Tool Description
Estimates the ancestry of a sample based on variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SampleAncestry (2025_12)

Estimates the ancestry of a sample based on variants.

Mandatory parameters:
  -in <filelist>        Input variant list(s) in VCF or VCF.GZ format.

Optional parameters:
  -out <file>           Output TSV file. If unset, writes to STDOUT.
                        Default value: ''
  -min_snps <int>       Minimum number of informative SNPs for population determination. If less SNPs are found, 'NOT_ENOUGH_SNPS' is returned.
                        Default value: '1000'
  -score_cutoff <float> Absolute score cutoff above which a sample is assigned to a population.
                        Default value: '0.32'
  -mad_dist <float>     Maximum number of median average diviations that are allowed from median population score.
                        Default value: '4.2'
  -build <enum>         Genome build used to generate the input.
                        Default value: 'hg38'
                        Valid: 'hg19,hg38'

Special parameters:
  --help                Shows this help and exits.
  --version             Prints version and exits.
  --changelog           Prints changeloge and exits.
  --tdx                 Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]     Settings override file (no other settings files are used).
```


## ngs-bits_RohHunter

### Tool Description
ROH detection based on a variant list.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
RohHunter (2025_12)

ROH detection based on a variant list.

Runs of homozygosity (ROH) are detected based on the genotype annotations in the VCF file.Based on the allele frequency of the contained variants, each ROH is assigned an estimated likelyhood to be observed by chance (Q score).

Mandatory parameters:
  -in <file>                Input variant list in VCF format.
  -out <file>               Output TSV file with ROH regions.

Optional parameters:
  -annotate <filelist>      List of BED files used for annotation. Each file adds a column to the output file. The base filename is used as column name and 4th column of the BED file is used as annotation value.
                            Default value: ''
  -exclude <file>           BED files with regions to exclude from ROH analysis. Regions where variant calling is not possible should be removed (centromers, MQ=0 regions and large stretches of N bases).
                            Default value: ''
  -var_min_dp <int>         Minimum variant depth ('DP'). Variants with lower depth are excluded from the analysis.
                            Default value: '20'
  -var_min_q <float>        Minimum variant quality. Variants with lower quality are excluded from the analysis.
                            Default value: '20'
  -var_af_keys <string>     Comma-separated allele frequency info field names in 'in'.
                            Default value: ''
  -var_af_keys_vep <string> Comma-separated VEP CSQ field names of allele frequency annotations in 'in'.
                            Default value: ''
  -roh_min_q <float>        Minimum Q score of output ROH regions.
                            Default value: '30'
  -roh_min_markers <int>    Minimum marker count of output ROH regions.
                            Default value: '20'
  -roh_min_size <float>     Minimum size in Kb of output ROH regions.
                            Default value: '20'
  -ext_marker_perc <float>  Percentage of ROH markers that can be spanned when merging ROH regions.
                            Default value: '1'
  -ext_size_perc <float>    Percentage of ROH size that can be spanned when merging ROH regions.
                            Default value: '50'
  -ext_max_het_perc <float> Maximum percentage of heterozygous markers in ROH regions.
                            Default value: '5'
  -inc_chrx                 Include chrX into the analysis. Excluded by default.
                            Default value: 'false'
  -debug                    Enable debug output
                            Default value: 'false'

Special parameters:
  --help                    Shows this help and exits.
  --version                 Prints version and exits.
  --changelog               Prints changeloge and exits.
  --tdx                     Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]         Settings override file (no other settings files are used).
```


## ngs-bits_UpdHunter

### Tool Description
UPD detection from trio variant data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
UpdHunter (2025_12)

UPD detection from trio variant data.

Mandatory parameters:
  -in <file>               Input VCF file of trio.
  -c <string>              Header name of child.
  -f <string>              Header name of father.
  -m <string>              Header name of mother.
  -out <file>              Output TSV file containing the detected UPDs.

Optional parameters:
  -out_informative <file>  Output IGV file containing informative variants.
                           Default value: ''
  -exclude <file>          BED file with regions to exclude, e.g. copy-number variant regions.
                           Default value: ''
  -var_min_dp <int>        Minimum depth (DP) of a variant (in all three samples).
                           Default value: '20'
  -var_min_q <float>       Minimum quality (QUAL) of a variant.
                           Default value: '20'
  -var_use_indels          Also use InDels. The default is to use SNVs only.
                           Default value: 'false'
  -ext_marker_perc <float> Percentage of markers that can be spanned when merging adjacent regions .
                           Default value: '1'
  -ext_size_perc <float>   Percentage of base size that can be spanned when merging adjacent regions.
                           Default value: '20'
  -reg_min_kb <float>      Mimimum size in kilo-bases required for a UPD region.
                           Default value: '1000'
  -reg_min_markers <int>   Mimimum number of UPD markers required in a region.
                           Default value: '15'
  -reg_min_q <float>       Mimimum Q-score required for a UPD region.
                           Default value: '20'
  -debug                   Enable verbose debug output.
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_SeqPurge

### Tool Description
Removes adapter sequences from paired-end sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SeqPurge (2025_12)

Removes adapter sequences from paired-end sequencing data.

Mandatory parameters:
  -in1 <filelist>          Forward input gzipped FASTQ file(s).
  -in2 <filelist>          Reverse input gzipped FASTQ file(s).
  -out1 <file>             Forward output gzipped FASTQ file.
  -out2 <file>             Reverse output gzipped FASTQ file.

Optional parameters:
  -a1 <string>             Forward adapter sequence (at least 15 bases).
                           Default value: 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCA'
  -a2 <string>             Reverse adapter sequence (at least 15 bases).
                           Default value: 'AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT'
  -match_perc <float>      Minimum percentage of matching bases for sequence/adapter matches.
                           Default value: '80'
  -mep <float>             Maximum error probability of insert and adapter matches.
                           Default value: '1e-06'
  -qcut <int>              Quality trimming cutoff for trimming from the end of reads using a sliding window approach. Set to 0 to disable.
                           Default value: '15'
  -qwin <int>              Quality trimming window size.
                           Default value: '5'
  -qoff <int>              Quality trimming FASTQ score offset.
                           Default value: '33'
  -ncut <int>              Number of subsequent Ns to trimmed using a sliding window approach from the front of reads. Set to 0 to disable.
                           Default value: '7'
  -min_len <int>           Minimum read length after adapter trimming. Shorter reads are discarded.
                           Default value: '30'
  -threads <int>           The number of threads used for trimming (up to three additional threads are used for reading and writing).
                           Default value: '1'
  -out3 <file>             Name prefix of singleton read output files (if only one read of a pair is discarded).
                           Default value: ''
  -summary <file>          Write summary/progress to this file instead of STDOUT.
                           Default value: ''
  -qc <file>               If set, a read QC file in qcML format is created (just like ReadQC).
                           Default value: ''
  -block_size <int>        Number of FASTQ entries processed in one block.
                           Default value: '10000'
  -block_prefetch <int>    Number of blocks that may be pre-fetched into memory.
                           Default value: '32'
  -ec                      Enable error-correction of adapter-trimmed reads (only those with insert match).
                           Default value: 'false'
  -debug                   Enables debug output (use only with one thread).
                           Default value: 'false'
  -progress <int>          Enables progress output at the given interval in milliseconds (disabled by default).
                           Default value: '-1'
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_BamFilter

### Tool Description
Filter alignments in BAM/CRAM file (no input sorting required).

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamFilter (2025_12)

Filter alignments in BAM/CRAM file (no input sorting required).

Mandatory parameters:
  -in <file>        Input BAM/CRAM file.
  -out <file>       Output BAM/CRAM file.

Optional parameters:
  -minMQ <int>      Minimum mapping quality.
                    Default value: '30'
  -maxMM <int>      Maximum number of mismatches in aligned read, -1 to disable.
                    Default value: '4'
  -maxGap <int>     Maximum number of gaps (indels) in aligned read, -1 to disable.
                    Default value: '1'
  -minDup <int>     Minimum number of duplicates.
                    Default value: '0'
  -maxIS <int>      Maximum insert size, -1 to disable.
                    Default value: '-1'
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -write_cram       Writes a CRAM file as output.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_BamClipOverlap

### Tool Description
Softclipping of overlapping reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamClipOverlap (2025_12)

Softclipping of overlapping reads.

Overlapping reads will be soft-clipped from start to end. There are several parameters available for handling of mismatches in overlapping reads. Within the overlap the higher base quality will be kept for each basepair.

Mandatory parameters:
  -in <file>                Input BAM/CRAM file. Needs to be sorted by name.
  -out <file>               Output BAM file.

Optional parameters:
  -overlap_mismatch_mapq    Set mapping quality of pair to 0 if mismatch is found in overlapping reads.
                            Default value: 'false'
  -overlap_mismatch_remove  Remove pair if mismatch is found in overlapping reads.
                            Default value: 'false'
  -overlap_mismatch_baseq   Reduce base quality if mismatch is found in overlapping reads.
                            Default value: 'false'
  -overlap_mismatch_basen   Set base to N if mismatch is found in overlapping reads.
                            Default value: 'false'
  -ignore_indels            Turn off indel detection in overlap.
                            Default value: 'false'
  -v                        Verbose mode.
                            Default value: 'false'
  -ref <file>               Reference genome for CRAM support (mandatory if CRAM is used).
                            Default value: ''

Special parameters:
  --help                    Shows this help and exits.
  --version                 Prints version and exits.
  --changelog               Prints changeloge and exits.
  --tdx                     Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]         Settings override file (no other settings files are used).
```


## ngs-bits_BamToFastq

### Tool Description
Converts a coordinate-sorted BAM file to FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamToFastq (2025_12)

Converts a coordinate-sorted BAM file to FASTQ files.

Mandatory parameters:
  -in <file>               Input BAM/CRAM file.
  -out1 <file>             Read 1 output FASTQ.GZ file.

Optional parameters:
  -out2 <file>             Read 2 output FASTQ.GZ file (required for pair-end samples).
                           Default value: ''
  -reg <string>            Export only reads in the given region. Format: chr:start-end.
                           Default value: ''
  -remove_duplicates       Does not export reads marked as duplicates in SAM flags into the FASTQ file.
                           Default value: 'false'
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'
  -write_buffer_size <int> Output write buffer size (number of FASTQ entry pairs).
                           Default value: '100'
  -ref <file>              Reference genome for CRAM support (mandatory if CRAM is used).
                           Default value: ''
  -extend <int>            Extend all reads to the given length. Base 'N' and base qualiy '2' are used for extension.
                           Default value: '0'
  -fix                     Keep only one read pair if several have the same name (note: needs much memory as read names are kept in memory).
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_BedCoverage

### Tool Description
Annotates a BED file with the average coverage of the regions from one or several BAM/CRAM file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedCoverage (2025_12)

Annotates a BED file with the average coverage of the regions from one or several BAM/CRAM file(s).

Mandatory parameters:
  -bam <filelist>   Input BAM/CRAM file(s).

Optional parameters:
  -min_mapq <int>   Minimum mapping quality.
                    Default value: '1'
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -decimals <int>   Number of decimals used in output.
                    Default value: '2'
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -clear            Clear previous annotation columns before annotating (starting from 4th column).
                    Default value: 'false'
  -threads <int>    Number of threads used.
                    Default value: '1'
  -random_access    Use random access via index to get reads from BAM/CRAM instead of chromosome-wise sweep. Random access is quite slow, especially on CRAM, so use it only if a small subset of the file needs to be accessed.
                    Default value: 'false'
  -debug            Enable debug output.
                    Default value: 'false'
  -skip_mismapped   Skip reads with mapping quality less than 20 that are not properly paired (they are often mis-mapped).
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_BedAnnotateGenes

### Tool Description
Annotates BED file regions with gene names.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedAnnotateGenes (2025_12)

Annotates BED file regions with gene names.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -extend <int>     The number of bases to extend the gene regions before annotation.
                    Default value: '0'
  -test             Uses the test database instead of on the production database.
                    Default value: 'false'
  -clear            Clear all annotations present in the input file.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_BedAnnotateGC

### Tool Description
Annotates GC content fraction to regions in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedAnnotateGC (2025_12)

Annotates GC content fraction to regions in a BED file.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -ref <file>       Reference genome FASTA file. If unset, 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''
  -extend <int>     Bases to extend around the input region for calculating the GC content.
                    Default value: '0'
  -clear            Clear all annotations present in the input file.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_BedLowCoverage

### Tool Description
Detects low-coverage regions from a BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedLowCoverage (2025_12)

Detects low-coverage regions from a BAM/CRAM file.

Note that only read start/end are used. Thus, deletions in the CIGAR string are treated as covered.

Mandatory parameters:
  -bam <file>       Input BAM/CRAM file.
  -cutoff <int>     Minimum depth to consider a base 'high coverage'.

Optional parameters:
  -in <file>        Input BED file containing the regions of interest. If unset, reads from STDIN.
                    Default value: ''
  -random_access    Use random access via index to get reads from BAM/CRAM instead of chromosome-wise sweep. Random access is quite slow, so use it only if a small subset of the file needs to be accessed.
                    Default value: 'false'
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -min_mapq <int>   Minimum mapping quality to consider a read.
                    Default value: '1'
  -min_baseq <int>  Minimum base quality to consider a base.
                    Default value: '0'
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -threads <int>    Number of threads used.
                    Default value: '1'
  -debug            Enable debug output.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_BedHighCoverage

### Tool Description
Detects high-coverage regions from a BAM/CRAM file.
Note that only read start/end are used. Thus, deletions in the CIGAR string are treated as covered.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedHighCoverage (2025_12)

Detects high-coverage regions from a BAM/CRAM file.

Note that only read start/end are used. Thus, deletions in the CIGAR string are treated as covered.

Mandatory parameters:
  -bam <file>       Input BAM/CRAM file.
  -cutoff <int>     Minimum depth to consider a base 'high coverage'.

Optional parameters:
  -in <file>        Input BED file containing the regions of interest. If unset, reads from STDIN.
                    Default value: ''
  -random_access    Use random access via index to get reads from BAM/CRAM instead of chromosome-wise sweep. Random access is quite slow, so use it only if a small subset of the file needs to be accessed.
                    Default value: 'false'
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -min_mapq <int>   Minimum mapping quality to consider a read.
                    Default value: '1'
  -min_baseq <int>  Minimum base quality to consider a base.
                    Default value: '0'
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -threads <int>    Number of threads used.
                    Default value: '1'
  -debug            Enable debug output.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_VcfAnnotateConsequence

### Tool Description
Adds transcript-specific consequence predictions to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateConsequence (2025_12)

Adds transcript-specific consequence predictions to a VCF file.

Variants are normalized accoring to the HGVS 3' rule to assess the effect, i.e. they are moved as far as possible in translation direction.
Note: HGVS consequence calcualtion is only done if the variant is fully inside the transcript region.

Mandatory parameters:
  -in <file>               Input VCF file to annotate.
  -gff <file>              Ensembl-style GFF file with transcripts, e.g. from https://ftp.ensembl.org/pub/release-115/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz.
  -out <file>              Output VCF file annotated with predicted consequences for each variant.

Optional parameters:
  -ref <file>              Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                           Default value: ''
  -threads <int>           The number of threads used to read, process and write files.
                           Default value: '1'
  -block_size <int>        Number of lines processed in one chunk.
                           Default value: '5000'
  -prefetch <int>          Maximum number of blocks that may be pre-fetched into memory.
                           Default value: '64'
  -all                     If set, all transcripts are used for annotation. The default is to skip transcripts not labeled with 'gencode_basic' and not labeled with 'RefSeq'/'BestRefSeq' origin for Refseq.
                           Default value: 'false'
  -skip_not_hgnc           Skip genes that do not have a HGNC identifier.
                           Default value: 'false'
  -tag <string>            Tag that is used for the consequence annotation.
                           Default value: 'CSQ'
  -max_dist_to_trans <int> Maximum distance between variant and transcript.
                           Default value: '5000'
  -splice_region_ex <int>  Number of bases at exon boundaries that are considered to be part of the splice region.
                           Default value: '3'
  -splice_region_in5 <int> Number of bases at intron boundaries (5') that are considered to be part of the splice region.
                           Default value: '20'
  -splice_region_in3 <int> Number of bases at intron boundaries (3') that are considered to be part of the splice region.
                           Default value: '20'
  -source <enum>           GFF source.
                           Default value: 'ensembl'
                           Valid: 'ensembl,refseq'
  -debug                   Enable debug output
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_VcfAdd

### Tool Description
Merges several VCF files into one VCF by appending one to the other.
Variant lines from all other input files are appended to the first input file.
VCF header lines are taken from the first input file only.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAdd (2025_12)

Merges several VCF files into one VCF by appending one to the other.

Variant lines from all other input files are appended to the first input file.
VCF header lines are taken from the first input file only.

Mandatory parameters:
  -in <filelist>        Input files to merge in VCF or VCG.GZ format.

Optional parameters:
  -out <file>           Output VCF file with all variants.
                        Default value: ''
  -filter <string>      Tag variants from all but the first input file with this filter entry.
                        Default value: ''
  -filter_desc <string> Description used in the filter header - use underscore instead of spaces.
                        Default value: ''
  -skip_duplicates      Skip variants if they occur more than once.
                        Default value: 'false'

Special parameters:
  --help                Shows this help and exits.
  --version             Prints version and exits.
  --changelog           Prints changeloge and exits.
  --tdx                 Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]     Settings override file (no other settings files are used).
```


## ngs-bits_VcfAnnotateFromVcf

### Tool Description
Annotates a VCF file with data from one or more source VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateFromVcf (2025_12)

Annotates a VCF file with data from one or more source VCF files.

NOTICE: the parameter '-existence_only' cannot be used together with '-config_file', '-info_keys' or '-id_column'.

Optional parameters:
  -in <file>                   Input VCF(.GZ) file that is annotated. If unset, reads from STDIN.
                               Default value: ''
  -out <file>                  Output VCF file. If unset, writes to STDOUT.
                               Default value: ''
  -config_file <file>          TSV file for annotation from multiple source files. For each source file, these tab-separated columns have to be given: source file name, prefix, INFO keys, ID column.
                               Default value: ''
  -source <file>               Tabix indexed VCF.GZ file that is the source of the annotated data.
                               Default value: ''
  -info_keys <string>          INFO key(s) in 'source' that should be annotated (Multiple keys are be separated by ',', optional keys can be renamed using this syntax: 'original_key=new_key').
                               Default value: ''
  -id_column <string>          ID column in 'source' (must be 'ID'). If unset, the ID column is not annotated. Alternative output name can be specified by using 'ID=new_name'.
                               Default value: ''
  -prefix <string>             Prefix added to all annotations in the output VCF file.
                               Default value: ''
  -allow_missing_header        If set the execution is not aborted if a INFO header is missing in the source file.
                               Default value: 'false'
  -existence_only              Only annotate if variant exists in source.
                               Default value: 'false'
  -existence_key_name <string> Defines the INFO key name.
                               Default value: 'EXISTS_IN_SOURCE'
  -threads <int>               The number of threads used to process VCF lines.
                               Default value: '1'
  -block_size <int>            Number of lines processed in one chunk.
                               Default value: '10000'
  -prefetch <int>              Maximum number of chunks that may be pre-fetched into memory.
                               Default value: '64'
  -debug                       Enables debug output (use only with one thread).
                               Default value: 'false'
  -hts_version                 Prints used htlib version and exits.
                               Default value: 'false'

Special parameters:
  --help                       Shows this help and exits.
  --version                    Prints version and exits.
  --changelog                  Prints changeloge and exits.
  --tdx                        Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]            Settings override file (no other settings files are used).
```


## ngs-bits_VcfAnnotateFromBed

### Tool Description
Annotates the INFO column of a VCF with data from a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateFromBed (2025_12)

Annotates the INFO column of a VCF with data from a BED file.

Characters which are not allowed in the INFO column based on the VCF 4.2 definition are URL encoded.
The following characters are replaced:
% -> %25; 	 -> %09; 
 -> %0A; 
 -> %0D;   -> %20; , -> %2C; ; -> %3B; = -> %3D; 

Mandatory parameters:
  -bed <file>       BED file used as source of annotations (name column).
  -name <string>    Annotation name in INFO column of output VCF file.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF list. If unset, writes to STDOUT.
                    Default value: ''
  -sep <string>     Separator used if there are several matches for one variant.
                    Default value: ':'
  -threads <int>    The number of threads used to read, process and write files.
                    Default value: '1'
  -block_size <int> Number of lines processed in one chunk.
                    Default value: '5000'
  -prefetch <int>   Maximum number of chunks that may be pre-fetched into memory.
                    Default value: '64'
  -debug <int>      Enables debug output at the given interval in milliseconds (disabled by default, cannot be combined with writing to STDOUT).
                    Default value: '-1'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_FastaFromBam

### Tool Description
Download the reference genome FASTA file for a BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastaFromBam (2025_12)

Download the reference genome FASTA file for a BAM/CRAM file.

Mandatory parameters:
  -in <file>        Input BAM/CRAM file.
  -out <file>       Output reference genome FASTA file.

Optional parameters:
  -ref <file>       Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```


## ngs-bits_VcfSort

### Tool Description
Sorts variant lists according to chromosomal position.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfSort (2025_12)

Sorts variant lists according to chromosomal position.

Mandatory parameters:
  -in <file>               Input variant list in VCF format.
  -out <file>              Output variant list in VCF or VCF.GZ format.

Optional parameters:
  -qual                    Also sort according to variant quality. Ignored if 'fai' file is given.
                           Default value: 'false'
  -fai <file>              FAI file defining different chromosome order.
                           Default value: ''
  -compression_level <int> Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written.
                           Default value: '10'
  -remove_unused_contigs   Remove comment lines of contigs, i.e. chromosomes, that are not used in the output VCF.
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```


## ngs-bits_BedSort

### Tool Description
Sort the regions in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedSort (2025_12)

Sort the regions in a BED file.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -with_name        Uses name column (i.e. the 4th column) to sort if chr/start/end are equal.
                    Default value: 'false'
  -uniq             If set, entries with the same chr/start/end are removed after sorting.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

