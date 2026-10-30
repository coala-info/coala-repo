# ngs-bits CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ngs-bits_BamCleanHaloplex | PASS |  |
| ngs-bits_BamClipOverlap | PASS |  |
| ngs-bits_BamDownsample | PASS |  |
| ngs-bits_BamExtract | PASS |  |
| ngs-bits_BamFilter | PASS |  |
| ngs-bits_BamInfo | PASS |  |
| ngs-bits_BamRemoveVariants | PASS |  |
| ngs-bits_BamToFastq | PASS |  |
| ngs-bits_BedAdd | PASS |  |
| ngs-bits_BedAnnotateFreq | PASS |  |
| ngs-bits_BedAnnotateFromBed | PASS |  |
| ngs-bits_BedAnnotateGC | PASS |  |
| ngs-bits_BedAnnotateGenes | Not completed | needs an NGSD database (MySQL) with gene annotations; no usable test database |
| ngs-bits_BedChunk | PASS |  |
| ngs-bits_BedCoverage | PASS |  |
| ngs-bits_BedExtend | PASS |  |
| ngs-bits_BedHighCoverage | PASS |  |
| ngs-bits_BedInfo | PASS |  |
| ngs-bits_BedIntersect | PASS |  |
| ngs-bits_BedLiftOver | PASS |  |
| ngs-bits_BedLowCoverage | PASS |  |
| ngs-bits_BedMerge | PASS |  |
| ngs-bits_BedReadCount | PASS |  |
| ngs-bits_BedShrink | PASS |  |
| ngs-bits_BedSort | PASS |  |
| ngs-bits_BedSubtract | PASS |  |
| ngs-bits_BedToEpigen | PASS |  |
| ngs-bits_BedToFasta | PASS |  |
| ngs-bits_BedpeAnnotateBreakpointDensity | PASS |  |
| ngs-bits_BedpeAnnotateCnvOverlap | PASS |  |
| ngs-bits_BedpeAnnotateFromBed | PASS |  |
| ngs-bits_BedpeExtractGenotype | PASS |  |
| ngs-bits_BedpeExtractInfoField | PASS |  |
| ngs-bits_BedpeFilter | PASS |  |
| ngs-bits_BedpeSort | PASS |  |
| ngs-bits_BedpeToBed | PASS |  |
| ngs-bits_CfDnaQC | PASS |  |
| ngs-bits_CnvFilterAnnotations | PASS |  |
| ngs-bits_CnvReferenceCohort | PASS |  |
| ngs-bits_ExtractMethylationData | PASS |  |
| ngs-bits_FastaFromBam | PASS | synthetic data: M5 tag added to the header of a real BAM; output sequence equals the reference |
| ngs-bits_FastaInfo | PASS |  |
| ngs-bits_FastaMask | PASS |  |
| ngs-bits_FastqAddBarcode | PASS |  |
| ngs-bits_FastqCheckUMI | PASS |  |
| ngs-bits_FastqConcat | PASS |  |
| ngs-bits_FastqConvert | PASS |  |
| ngs-bits_FastqDownsample | PASS |  |
| ngs-bits_FastqExtract | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqExtractBarcode | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqExtractUMI | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqFormat | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqList | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqMidParser | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqToFasta | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_FastqTrim | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_GenePrioritization | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_GraphStringDb | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_MantaVcfFix | PASS | output identical to the ngs-bits repo expected test output |
| ngs-bits_MappingQC | PASS | ROI mode checked on SARS-CoV-2 data (mapped 98.5 percent, depth 0.93 match samtools); -wgs with -build non_human prints -inf depth |
| ngs-bits_QcToTsv | PASS |  |
| ngs-bits_ReadQC | PASS |  |
| ngs-bits_RnaQC | PASS | ran on nf-core RNA BAM with a merged exon BED from the nf-core chr22 GTF |
| ngs-bits_RohHunter | PASS |  |
| ngs-bits_SampleAncestry | PASS |  |
| ngs-bits_SampleGender | PASS |  |
| ngs-bits_SampleSimilarity | PASS | VCF mode matches the repo expected output; BAM mode gave zero overlap without an hg38 reference (not verified) |
| ngs-bits_SeqPurge | PASS |  |
| ngs-bits_SnifflesVcfFix | PASS |  |
| ngs-bits_SomaticQC | PASS | ran on ngs-bits test BAMs; qcML matches the expected file except the linked-file path |
| ngs-bits_SvFilterAnnotations | PASS |  |
| ngs-bits_TrioMaternalContamination | PASS |  |
| ngs-bits_TrioMendelianErrors | PASS |  |
| ngs-bits_TsvDiff | PASS | exit code 1 on differences is allowed (successCodes) |
| ngs-bits_TsvFilter | PASS |  |
| ngs-bits_TsvInfo | PASS |  |
| ngs-bits_TsvMerge | PASS |  |
| ngs-bits_TsvSlice | PASS |  |
| ngs-bits_TsvToQC | PASS |  |
| ngs-bits_UpdHunter | PASS |  |
| ngs-bits_VariantAnnotateASE | PASS | ran on nf-core RNA BAM with dbSNP SNVs (het genotype column added) from the same chr22 slice |
| ngs-bits_VariantAnnotateFrequency | PASS | ran on nf-core DNA BAM with dbSNP SNVs from the same chr22 slice |
| ngs-bits_VariantFilterAnnotations | PASS |  |
| ngs-bits_VariantFilterRegions | PASS |  |
| ngs-bits_VariantQC | PASS |  |
| ngs-bits_VcfAdd | PASS |  |
| ngs-bits_VcfAnnotateConsequence | Not completed | needs the hg38 reference genome FASTA (about 3 GB) that goes with the repo test data; no small Ensembl-style test set available |
| ngs-bits_VcfAnnotateFromBed | PASS |  |
| ngs-bits_VcfAnnotateFromBigWig | PASS |  |
| ngs-bits_VcfAnnotateFromVcf | PASS |  |
| ngs-bits_VcfAnnotateHexplorer | PASS | ran on the chr21/chr22 variants of the ngs-bits test VCF with a chr21/22 hg38 FASTA |
| ngs-bits_VcfAnnotateMaxEntScan | PASS | ran on the chr21/chr22 variants of the ngs-bits test VCF with a chr21/22 hg38 FASTA |
| ngs-bits_VcfBreakMulti | PASS |  |
| ngs-bits_VcfCalculatePRS | PASS | ran on chr21/chr22 subset of the ngs-bits test data (real PGS000004 weights) with a chr21/22 hg38 FASTA |
| ngs-bits_VcfCheck | PASS | ran on nf-core dbSNP chr22 slice; tool exits 1 when it finds errors |
| ngs-bits_VcfExtractSamples | PASS |  |
| ngs-bits_VcfFilter | PASS | ran with a small genome FASTA (nf-core chr22 slice) because the tool requires -ref; -reg also tested with a BED file (File or string input): 23 of 59 variants kept, the same count as a direct check of the region |
| ngs-bits_VcfLeftNormalize | PASS | ran on nf-core dbSNP chr22 slice with its matching small genome FASTA |
| ngs-bits_VcfReplaceSamples | PASS |  |
| ngs-bits_VcfSort | PASS |  |
| ngs-bits_VcfSplit | PASS |  |
| ngs-bits_VcfStreamSort | PASS |  |
| ngs-bits_VcfStrip | PASS |  |
| ngs-bits_VcfSubtract | PASS |  |
| ngs-bits_VcfToBed | PASS |  |
| ngs-bits_VcfToBedpe | PASS |  |
| ngs-bits_VcfToTsv | PASS |  |

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


## ngs-bits_FastqExtract

### Tool Description
Extracts reads from a FASTQ file according to an ID list. Trims the reads if lengths are given.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqExtract (2025_12)

Extracts reads from a FASTQ file according to an ID list. Trims the reads if lengths are given.

Mandatory parameters:
  -in <file>               Input FASTQ file (gzipped or plain).
  -ids <file>              Input TSV file containing IDs (without the '@') in the first column and optional length in the second column.
  -out <file>              Output FASTQ file.

Optional parameters:
  -v                       Invert match: keep non-matching reads.
                           Default value: 'false'
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

## ngs-bits_FastqExtractBarcode

### Tool Description
Cuts bases from the beginning of reads and stores them in an additional fastq.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqExtractBarcode (2025_12)

Cuts bases from the beginning of reads and stores them in an additional fastq.

Mandatory parameters:
  -in <file>               input fastq file1.
  -out_main <string>       output filename for main fastq.

Optional parameters:
  -out_index <string>      output filename for index fastq.
                           Default value: 'index.fastq.gz'
  -cut <int>               number of bases from the beginning of reads to use as barcodes.
                           Default value: '0'
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_FastqExtractUMI

### Tool Description
Cuts UMI bases from the beginning of reads and adds them to read headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqExtractUMI (2025_12)

Cuts UMI bases from the beginning of reads and adds them to read headers.

Mandatory parameters:
  -in1 <file>              Input FASTQ file 1.
  -in2 <file>              Input FASTQ file 2.
  -out1 <file>             Output filename for read 1 FASTQ.
  -out2 <file>             Output filename for read 2 FASTQ.

Optional parameters:
  -cut1 <int>              Number of bases from the head of read 1 to use as UMI.
                           Default value: '0'
  -cut2 <int>              Number of bases from the head of read 2 to use as UMI.
                           Default value: '0'
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_FastqFormat

### Tool Description
Determines the FastQ quality encoding format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqFormat (2025_12)

Determines the FastQ quality encoding format.

Mandatory parameters:
  -in <file>        Input FASTQ file (gzipped or plain).

Optional parameters:
  -out <file>       Output text file. If unset, writes to STDOUT.
                    Default value: ''
  -reads <int>      The number of reads to parse.
                    Default value: '10000'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqList

### Tool Description
List read IDs and base count.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqList (2025_12)

List read IDs and base count.

Mandatory parameters:
  -in <file>        Input FASTQ file (gzipped or plain).

Optional parameters:
  -out <file>       Output TSV file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqMidParser

### Tool Description
Counts the number of occurances of each MID in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqMidParser (2025_12)

Counts the number of occurances of each MID in a FASTQ file.

Mandatory parameters:
  -in <file>        Input gzipped FASTQ file.

Optional parameters:
  -out <file>       Output TXT file. If unset, writes to STDOUT.
                    Default value: ''
  -lines <int>      The number of FASTQ entries in the input file to parse. 0 is unlimited.
                    Default value: '1000'
  -mids <int>       The number of top-ranking MIDs to print. 0 is unlimited.
                    Default value: '20'
  -sheet <file>     Optional sample sheet CSV file as provided to CASAVA. If given, the closest match in the sample sheet is printed after each MID.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqToFasta

### Tool Description
Converts a FASTQ file to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqToFasta (2025_12)

Converts a FASTQ file to FASTA format.

Mandatory parameters:
  -in <file>        Input gzipped FASTQ file.

Optional parameters:
  -out <file>       Output FASTA file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqTrim

### Tool Description
Trims start/end bases from all reads in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqTrim (2025_12)

Trims start/end bases from all reads in a FASTQ file.

Mandatory parameters:
  -in <file>               Input gzipped FASTQ file.
  -out <file>              Output gzipped FASTQ file.

Optional parameters:
  -start <int>             Trim this number of bases from the start of the read.
                           Default value: '0'
  -end <int>               Trim this number of bases from the end of the read.
                           Default value: '0'
  -len <int>               Restrict read length to this value (after trimming from start/end).
                           Default value: '0'
  -max_len <int>           Only trim reads smaller than the given length. Used e.g. to remove UMIs at the read end from read-throughs.
                           Default value: '0'
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

## ngs-bits_GenePrioritization

### Tool Description
Performs gene prioritization based on list of known disease genes of a disease and a PPI graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
GenePrioritization (2025_12)

Performs gene prioritization based on list of known disease genes of a disease and a PPI graph.

Mandatory parameters:
  -in <file>        Input TSV file with one gene identifier per line (known disease genes of a disease).
  -graph <file>     Graph TSV file with two gene identifiers per line (PPI graph).
  -out <file>       Output TSV file containing prioritized genes for the disease.

Optional parameters:
  -method <enum>    Gene prioritization method to use.
                    Default value: 'flooding'
                    Valid: 'flooding,random_walk'
  -n <int>          Number of network diffusion iterations (flooding).
                    Default value: '2'
  -restart <float>  Restart probability (random_walk).
                    Default value: '0.4'
  -debug <file>     Output TSV file for debugging
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_GraphStringDb

### Tool Description
Creates simple representation of String-DB interaction graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
GraphStringDb (2025_12)

Creates simple representation of String-DB interaction graph.

Mandatory parameters:
  -string <file>     String-DB file with protein interactions (https://stringdb-static.org/download/protein.links.v11.5/9606.protein.links.v11.5.txt.gz).
  -alias <file>      Input TSV file with aliases for String protein IDs (https://stringdb-static.org/download/protein.aliases.v11.5/9606.protein.aliases.v11.5.txt.gz).
  -out <file>        Output TSV file with edges.

Optional parameters:
  -min_score <float> Minimum confidence score cutoff for String-DB interaction (0-1).
                     Default value: '0.4'

Special parameters:
  --help             Shows this help and exits.
  --version          Prints version and exits.
  --changelog        Prints changeloge and exits.
  --tdx              Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]  Settings override file (no other settings files are used).
```

## ngs-bits_MantaVcfFix

### Tool Description
Fixes issues in VCF of Manta SV calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
MantaVcfFix (2025_12)

Fixes issues in VCF of Manta SV calls.

Removes invalid VCF lines containing empty REF entries.
Removes duplicate SV calls from Manta VCFs.

Mandatory parameters:
  -in <file>        Input VCF file.
  -out <file>       Output VCF file.

Optional parameters:
  -debug            Print verbose output to STDERR.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BamCleanHaloplex

### Tool Description
BAM cleaning for Haloplex.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamCleanHaloplex (2025_12)

BAM cleaning for Haloplex.

Mandatory parameters:
  -in <file>        Input BAM/CRAM file.
  -out <file>       Output BAM/CRAM file.

Optional parameters:
  -min_match <int>  Minimum number of CIGAR matches (M).
                    Default value: '30'
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BamDownsample

### Tool Description
Downsamples a BAM file to the given percentage of reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamDownsample (2025_12)

Downsamples a BAM file to the given percentage of reads.

Mandatory parameters:
  -in <file>          Input BAM/CRAM file.
  -percentage <float> Percentage of reads to keep.
  -out <file>         Output BAM/CRAM file.

Optional parameters:
  -test               Test mode: fix random number generator seed and write kept read names to STDOUT.
                      Default value: 'false'
  -ref <file>         Reference genome for CRAM support (mandatory if CRAM is used).
                      Default value: ''

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```

## ngs-bits_BamExtract

### Tool Description
Extract reads from BAM/CRAM by read name.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamExtract (2025_12)

Extract reads from BAM/CRAM by read name.

Mandatory parameters:
  -in <file>        Input BAM/CRAM file.
  -ids <file>       Input text file containing read names (one per line).
  -out <file>       Output BAM/CRAM file with matching reads.

Optional parameters:
  -out2 <file>      Output BAM/CRAM file with not matching reads.
                    Default value: ''
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BamInfo

### Tool Description
Basic BAM information.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamInfo (2025_12)

Basic BAM information.

Mandatory parameters:
  -in <filelist>    Input BAM/CRAM files.

Optional parameters:
  -out <file>       Output TSV file. If unset, writes to STDOUT.
                    Default value: ''
  -name             Add filename only to output. The default is to add the canonical file path.
                    Default value: 'false'
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BamRemoveVariants

### Tool Description
Removes reads which contain the provided variants

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BamRemoveVariants (2025_12)

Removes reads which contain the provided variants

Mandatory parameters:
  -in <file>        Input BAM/CRAM file.
  -out <file>       Output BAM/CRAM file.
  -vcf <file>       Input indexed VCF.GZ file.

Optional parameters:
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -mask             Replace variant bases with reference instead of removing the read (SNV only)
                    Default value: 'false'
  -single_end       Input file is from single-end sequencing (e.g. lrGS).
                    Default value: 'false'
  -keep_indels      Do not remove InDels in mask mode.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedAdd

### Tool Description
Merges regions from several BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedAdd (2025_12)

Merges regions from several BED files.

Mandatory parameters:
  -in <filelist>    Input BED files.

Optional parameters:
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedAnnotateFreq

### Tool Description
Extracts base counts and depth in the given regions from a BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedAnnotateFreq (2025_12)

Extracts base counts and depth in the given regions from a BAM/CRAM files.

Mandatory parameters:
  -bam <filelist>   Input BAM/CRAM file(s).

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output TSV file. If unset, writes to STDOUT.
                    Default value: ''
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''
  -min_mapq <int>   Minimum mapping quality.
                    Default value: '1'
  -min_baseq <int>  Minimum base quality.
                    Default value: '25'
  -long_read        Support long reads (> 1kb).
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedAnnotateFromBed

### Tool Description
Annotates BED file regions with information from a second BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedAnnotateFromBed (2025_12)

Annotates BED file regions with information from a second BED file.

Mandatory parameters:
  -in2 <file>       BED file that is used as annotation source.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -col <int>        Annotation source column (if column number does not exist, 'yes' is used).
                    Default value: '4'
  -clear            Clear all annotations present in the 'in' file.
                    Default value: 'false'
  -no_duplicates    Remove duplicate annotations if several intervals from 'in2' overlap.
                    Default value: 'false'
  -overlap          Annotate overlap with regions in 'in2'. The regular annotation is appended in brackets.
                    Default value: 'false'
  -url_decode       Decode URL encoded characters
                    Default value: 'false'
  -name <string>    Use this name as column header of TSV files output files. If unset, the base file name if 'in2' is used.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedChunk

### Tool Description
Splits all regions to chunks of an approximate desired size.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedChunk (2025_12)

Splits all regions to chunks of an approximate desired size.

Mandatory parameters:
  -n <int>          The desired chunk size. Note: Not all chunks will have this size. Regions are split to chunks that are closest to the desired size.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedExtend

### Tool Description
Extends the regions in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedExtend (2025_12)

Extends the regions in a BED file.

Mandatory parameters:
  -n <int>          The number of bases to extend (on both sides of each region).

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -fai <file>       Optional FASTA index file that determines the maximum position for each chromosome.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedInfo

### Tool Description
Prints information about a (merged) BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedInfo (2025_12)

Prints information about a (merged) BED file.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output file. If unset, writes to STDOUT.
                    Default value: ''
  -nomerge          If set, the input is not merged before printing statistics.
                    Default value: 'false'
  -filename         If set, prints the input file name before each line.
                    Default value: 'false'
  -fai <file>       If set, checks that the maximum position for each chromosome is not exceeded.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedIntersect

### Tool Description
Intersects the regions in two BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedIntersect (2025_12)

Intersects the regions in two BED files.

Mandatory parameters:
  -in2 <file>       Second input BED file.

Optional parameters:
  -mode <enum>      Output mode: intersect of both files (intersect), original entry of file 1 (in) or original entry of file 2 (in2).
                    Default value: 'intersect'
                    Valid: 'intersect,in,in2'
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedLiftOver

### Tool Description
Lift-over of regions in a BED file to a different genome build.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedLiftOver (2025_12)

Lift-over of regions in a BED file to a different genome build.

Mandatory parameters:
  -in <file>           Input BED file with the regions to lift.
  -out <file>          The file where the lifted regions will be written to.

Optional parameters:
  -unmapped <file>     The file where the unmappable regions will be written to.
                       Default value: ''
  -chain <string>      Input Chain file in .chain/.chain.gz format or "hg19_hg38" / "hg38_hg19" to read from settings file.
                       Default value: 'hg19_hg38'
  -max_deletion <int>  Allowed percentage of deleted/unmapped bases in each region.
                       Default value: '5'
  -max_increase <int>  Allowed percentage size increase of a region.
                       Default value: '10'
  -remove_special_chr  Removes regions that are mapped to special chromosomes.
                       Default value: 'false'
  -merged_output       Output lifted and unlifted regions in the output file, keeping the order of the input regions.
                       Default value: 'false'

Special parameters:
  --help               Shows this help and exits.
  --version            Prints version and exits.
  --changelog          Prints changeloge and exits.
  --tdx                Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]    Settings override file (no other settings files are used).
```

## ngs-bits_BedMerge

### Tool Description
Merges overlapping regions in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedMerge (2025_12)

Merges overlapping regions in a BED file.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -keep_b2b         Do not merge non-overlapping but adjacent (back-to-back) regions.
                    Default value: 'false'
  -merge_names      Merge name columns instead of removing all annotations.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedReadCount

### Tool Description
Annotates the regions in a BED file with the read count from a BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedReadCount (2025_12)

Annotates the regions in a BED file with the read count from a BAM/CRAM file.

Mandatory parameters:
  -bam <file>       Input BAM/CRAM file.

Optional parameters:
  -min_mapq <int>   Minimum mapping quality.
                    Default value: '1'
  -in <file>        Input BED file (note that overlapping regions will be merged before processing). If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''
  -ref <file>       Reference genome for CRAM support (mandatory if CRAM is used).
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedShrink

### Tool Description
Shrinks the regions in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedShrink (2025_12)

Shrinks the regions in a BED file.

Mandatory parameters:
  -n <int>          The number of bases to shrink (on both sides of each region).

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedSubtract

### Tool Description
Subtracts the regions in one BED file from another.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedSubtract (2025_12)

Subtracts the regions in one BED file from another.

Mandatory parameters:
  -in2 <file>       Input BED file which is subtracted from 'in'.

Optional parameters:
  -in <file>        Input BED file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BED file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedToEpigen

### Tool Description
Converts a modkit BED file to a Epigen TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedToEpigen (2025_12)

Converts a modkit BED file to a Epigen TSV file.

Mandatory parameters:
  -id_file <file>   Input CSV file containing Illumina CpG IDs.
  -sample <string>  Sample name used in output file header.

Optional parameters:
  -in <file>        Input modkit (bgzipped) BED file. If unset, read from STDIN.
                    Default value: ''
  -out <file>       Output FASTA file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedToFasta

### Tool Description
Converts a BED file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedToFasta (2025_12)

Converts a BED file to a FASTA file.

Mandatory parameters:
  -in <file>        Input BED file.

Optional parameters:
  -out <file>       Output FASTA file. If unset, writes to STDOUT.
                    Default value: ''
  -ref <file>       Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedpeAnnotateBreakpointDensity

### Tool Description
Annotates a BEDPE file with breakpoint density.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeAnnotateBreakpointDensity (2025_12)

Annotates a BEDPE file with breakpoint density.

Mandatory parameters:
  -density <file>     IGV density file containing break point density.

Optional parameters:
  -density_sys <file> Optional IGV density file containing break point density for a specific processing system.
                      Default value: ''
  -in <file>          Input BEDPE file. If unset, reads from STDIN.
                      Default value: ''
  -out <file>         Output BEDPE file. If unset, writes to STDOUT.
                      Default value: ''

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```

## ngs-bits_BedpeAnnotateCnvOverlap

### Tool Description
Annotates a SV file with (high-quality) CNV overlap of a given file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeAnnotateCnvOverlap (2025_12)

Annotates a SV file with (high-quality) CNV overlap of a given file.

Mandatory parameters:
  -in <file>        Input SV file (in BEDPE format).
  -out <file>       Output SV file (in BEDPE format).
  -cnv <file>       Input CNV file (in TSV format).

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedpeAnnotateFromBed

### Tool Description
Annotates a BEDPE file with information from a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeAnnotateFromBed (2025_12)

Annotates a BEDPE file with information from a BED file.

Mandatory parameters:
  -bed <file>          BED file that is used as annotation source.

Optional parameters:
  -in <file>           Input BEDPE file. If unset, reads from STDIN.
                       Default value: ''
  -out <file>          Output BEDPE file. If unset, writes to STDOUT.
                       Default value: ''
  -col <int>           Annotation source column (default: 4).
                       Default value: '4'
  -col_name <string>   Name of the annotated column
                       Default value: 'ANNOTATION'
  -no_duplicates       Remove duplicate annotations if several intervals from 'bed' overlap.
                       Default value: 'false'
  -url_decode          Decode URL encoded characters.
                       Default value: 'false'
  -replace_underscore  Replaces underscores with spaces in the annotation column.
                       Default value: 'false'
  -max_value           Select maximum value if several intervals from 'bed' overlap. (only for numeric columns)
                       Default value: 'false'
  -only_breakpoints    Only annotate overlaps with the confidence intervall of the break points.
                       Default value: 'false'

Special parameters:
  --help               Shows this help and exits.
  --version            Prints version and exits.
  --changelog          Prints changeloge and exits.
  --tdx                Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]    Settings override file (no other settings files are used).
```

## ngs-bits_BedpeExtractGenotype

### Tool Description
Extracts the phased genotype into seperate column.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeExtractGenotype (2025_12)

Extracts the phased genotype into seperate column.

Optional parameters:
  -in <file>         Input BEDPE file. If unset, reads from STDIN.
                     Default value: ''
  -out <file>        Output BEDPE file. If unset, writes to STDOUT.
                     Default value: ''
  -include_unphased  Also annotate genotype of unphased SVs.
                     Default value: 'false'

Special parameters:
  --help             Shows this help and exits.
  --version          Prints version and exits.
  --changelog        Prints changeloge and exits.
  --tdx              Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]  Settings override file (no other settings files are used).
```

## ngs-bits_BedpeExtractInfoField

### Tool Description
Extract a given INFO field key and annotates it as a separate column.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeExtractInfoField (2025_12)

Extract a given INFO field key and annotates it as a separate column.

Mandatory parameters:
  -info_fields <string> Comma separate list of INFO keys (and column header names) which should be extracted: "INFO_KEY1[:COLUMN_HEADER1],INFO_KEY2[:COLUMN_HEADER2],..."

Optional parameters:
  -in <file>            Input BEDPE file. If unset, reads from STDIN.
                        Default value: ''
  -out <file>           Output BEDPE file. If unset, writes to STDOUT.
                        Default value: ''
  -info_column <string> Header name of the INFO column.
                        Default value: 'INFO_A'

Special parameters:
  --help                Shows this help and exits.
  --version             Prints version and exits.
  --changelog           Prints changeloge and exits.
  --tdx                 Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]     Settings override file (no other settings files are used).
```

## ngs-bits_BedpeFilter

### Tool Description
Filters a BEDPE file by region.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeFilter (2025_12)

Filters a BEDPE file by region.

Optional parameters:
  -in <file>        Input BEDPE file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output BEDPE file. If unset, writes to STDOUT.
                    Default value: ''
  -bed <file>       BED file that is used as ROI.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedpeSort

### Tool Description
Sort a BEDPE file according to chromosomal position.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeSort (2025_12)

Sort a BEDPE file according to chromosomal position.

Mandatory parameters:
  -in <file>        Input BEDPE file.
  -out <file>       Output BEDPE file.

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_BedpeToBed

### Tool Description
Converts a BEDPE file into BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
BedpeToBed (2025_12)

Converts a BEDPE file into BED file.

Mandatory parameters:
  -in <file>        Input BEDPE file.
  -out <file>       Output BED file.

Optional parameters:
  -merge            Merge the resulting BED file.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_CfDnaQC

### Tool Description
Calculates QC metrics for cfDNA samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
CfDnaQC (2025_12)

Calculates QC metrics for cfDNA samples.

Mandatory parameters:
  -bam <file>              Input BAM/CRAM file.
  -cfdna_panel <file>      Input BED file containing the (personalized) cfDNA panel.

Optional parameters:
  -out <file>              Output qcML file. If unset, writes to STDOUT.
                           Default value: ''
  -tumor_bam <file>        Input tumor BAM/CRAM file for sample similarity.
                           Default value: ''
  -related_bams <filelist> BAM files of related cfDNA samples to compute sample similarity.
                           Default value: ''
  -error_rates <file>      Input TSV containing umiVar error rates.
                           Default value: ''
  -build <enum>            Genome build used to generate the input.
                           Default value: 'hg38'
                           Valid: 'hg19,hg38'
  -ref <file>              Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                           Default value: ''
  -min_mapq <int>          Set minimal mapping quality (default:0)
                           Default value: '0'
  -txt                     Writes TXT format instead of qcML.
                           Default value: 'false'
  -threads <int>           The number of threads used for coverage calculation.
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_CnvFilterAnnotations

### Tool Description
Filter a copy-number variant list in TSV format based on variant annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
CnvFilterAnnotations (2025_12)

Filter a copy-number variant list in TSV format based on variant annotations.

The filter definition file lists one filter per line using the following syntax:
name[tab]param1=value[tab]param2=value...

The order in the filter definition file defines the order in which the filters are applied.

Several of the filters offer more than one action:
  FILTER - Remove variants if they do not match the filter.
  REMOVE - Remove variants if they match the filter.
  KEEP - Force variants to be kept, even if filtered out by previous filter steps.

The following filters are supported:
CNV OMIM genes             Filter for OMIM genes i.e. the 'OMIM' column is not empty.
                           Parameters:
                             action - Action to perform [default=FILTER] [valid=REMOVE,FILTER]
CNV allele frequency       Filter for CNV allele frequency in the analyzed cohort.
                           Parameters:
                             max_af - Maximum allele frequency [default=0.05] [min=0.0] [max=1.0]
CNV clonality              Filter based on CNV clonality.
                           Parameters:
                             min_clonality - Minimum Clonality of the CNV  [default=0]
                             max_clonality - Maximum Clonality of the CNV  [default=1]
CNV compound-heterozygous  Filter for compound-heterozygous CNVs.
                           Mode 'CNV-CNV' detects genes with two or more CNV hits.
                           Mode 'CNV-SNV/INDEL' detects genes with at least one CNV and at least one heterozygous small variant hit (after other filters are applied).
                           Parameters:
                             mode - Compound-heterozygotes detection mode. [default=n/a] [valid=n/a,CNV-CNV,CNV-SNV/INDEL]
CNV copy-number            Filter for CNV copy number.
                           Parameters:
                             cn - Copy number [valid=0,1,2,3,4,5+] [non-empty]
CNV gene constraint        Filter based on gene constraint (gnomAD o/e score for LOF variants).
                           Note that gene constraint is most helpful for early-onset severe diseases.
                           For details on gnomAD o/e, see https://macarthurlab.org/2018/10/17/gnomad-v2-1/
                           Parameters:
                             max_oe_lof - Maximum gnomAD o/e score for LoF variants [default=0.35] [min=0.0] [max=1.0]
CNV gene overlap           Filter based on gene overlap.
                           Parameters:
                             complete - Overlaps the complete gene. [default=true]
                             exonic/splicing - Overlaps the coding or splicing region of the gene. [default=true]
                             intronic/intergenic - Overlaps the intronic/intergenic region of the gene only. [default=false]
CNV log-likelihood         Filter for CNV log-likelihood.
                           The log-likelihood is the logarithm of the ratio between likelihoods of the no CN change model vs the CN equal to the reported state model (bigger is better). If scale by region is checked the total log-likelihood value is normalized by the number of regions.
                           Note: when applied to multi-sample CNV lists, each log-likelihood entry must exceed the cutuff!
                           Note: this filter works for CNV lists generated by ClinCNV only!
                           Note: log-likelihood scaling can only be applied to CNV lists with regions count
                           Parameters:
                             min_ll - Minimum log-likelihood [default=20] [min=0.0]
                             scale_by_regions - Scale log-likelihood by number of regions. [default=false]
CNV maximum log-likelihood Filter for maximum log-likelihood
                           Can be used to display artefact CNVs only
                           Works only for tumor-normal pairs
                           Parameters:
                             max_ll - Maixmum log-likelihood [default=200] [min=0.0]
                             scale_by_regions - Scale log-likelihood by number of regions. [default=false]
CNV pathogenic CNV overlap Filter for overlap with pathogenic CNVs from the NGSD i.e. the 'ngsd_pathogenic_cnvs' column is not empty.
                           Parameters:
                             action - Action to perform [default=FILTER] [valid=FILTER,KEEP]
CNV polymorphism region    Filter for overlap with CNP regions.
                           Parameters:
                             column - CNP column name [default=overlap af_genomes_imgag]
                             max_ol - Maximum overlap [default=0.95] [min=0.0] [max=1.0]
CNV q-value                Filter for CNV q-value.
                           The q-value is the p-value corrected for the number of CNVs detected (smaller is better)
                           Note: when applied to multi-sample CNV lists, each q-value must be below the cutuff!
                           Note: this filter works for CNV lists generated by ClinCNV only!
                           Parameters:
                             max_q - Maximum q-value [default=1] [min=0.0] [max=1.0]
CNV regions                Filter for number of regions/exons.
                           Parameters:
                             regions - Minimum number of regions [default=3] [min=1]
CNV size                   Filter for CNV size (kilobases).
                           Parameters:
                             size - Minimum CNV size in kilobases [default=0] [min=0]
CNV tumor CN change        Filter based on CNV tumor copy number.
                           Parameters:
                             min_tumor_cn - Minimum tumor copy number of the CNV [default=0]
                             max_tumor_cn - Maximum tumor copy number of the CNV. [default=10]

Mandatory parameters:
  -in <file>        Input CNV list in TSV format.
  -out <file>       Output CNV list in TSV format.
  -filters <file>   Filter definition file.

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_CnvReferenceCohort

### Tool Description
Create a reference cohort for CNV calling from a list of coverage profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
CnvReferenceCohort (2025_12)

Create a reference cohort for CNV calling from a list of coverage profiles.

This tool creates a reference cohort for CNV calling by analyzing the correlation between the main sample coverage profile and a list of reference coverage profiles.
The coverage profiles of the samples that correlate best with the main sample are saved in the output TSV file.
The TSV file contains the chromosome, start, and end positions in the first three columns, with subsequent columns showing the coverage for each selected reference file.

Mandatory parameters:
  -in <file>          Coverage profile of main sample in BED format.
  -in_ref <filelist>  Reference coverage profiles of other sample in BED format (GZ files supported).
  -out <file>         Output TSV file with coverage profiles of selected reference samples.

Optional parameters:
  -exclude <filelist> Regions in the given BED file(s) are excluded from the coverage calcualtion, e.g. copy-number polymorphic regions.
                      Default value: ''
  -cov_max <int>      Best n reference coverage files to include in 'out' based on correlation.
                      Default value: '150'
  -debug              Enable debug output.
                      Default value: 'false'

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```

## ngs-bits_ExtractMethylationData

### Tool Description
Extracts the methylation state for a given set of loci

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
ExtractMethylationData (2025_12)

Extracts the methylation state for a given set of loci

Mandatory parameters:
  -in <file>              Tabix indexed BED.GZ file that contains the methylation info for each base (modkit).
  -loci <file>            BED file containig position and strand of intrest

Optional parameters:
  -out <file>             Output BED file containing combined methylation info of provided loci. If unset, writes to STDOUT.
                          Default value: ''
  -ref <file>             Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                          Default value: ''
  -add_methylation_types  Also report 5mC (m) and 5hmC (h) entries as separate columns
                          Default value: 'false'
  -skip_invalid_sites     Skip invalid CpG sites instead of aborting.
                          Default value: 'false'

Special parameters:
  --help                  Shows this help and exits.
  --version               Prints version and exits.
  --changelog             Prints changeloge and exits.
  --tdx                   Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]       Settings override file (no other settings files are used).
```

## ngs-bits_FastaInfo

### Tool Description
Basic info on a FASTA file containing DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastaInfo (2025_12)

Basic info on a FASTA file containing DNA sequences.

Optional parameters:
  -in <file>          Input FASTA file. If unset, reads from STDIN.
                      Default value: ''
  -out <file>         Output file. If unset, writes to STDOUT.
                      Default value: ''
  -write_n <file>     Write BED file with N base coordinates
                      Default value: ''
  -write_other <file> Write BED file with other base coordinates
                      Default value: ''

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```

## ngs-bits_FastaMask

### Tool Description
Mask regions in a FASTA file with N bases.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastaMask (2025_12)

Mask regions in a FASTA file with N bases.

Mandatory parameters:
  -in <file>        Input FASTA file.
  -reg <file>       Input BED file with regions to mask.
  -out <file>       Output file.

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqAddBarcode

### Tool Description
Adds barcodes from separate FASTQ file to read headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqAddBarcode (2025_12)

Adds barcodes from separate FASTQ file to read headers.

Mandatory parameters:
  -in1 <filelist>          Input FASTQ file 1.
  -in2 <filelist>          Input FASTQ file 2.
  -in_barcode <filelist>   Input barcode file.
  -out1 <file>             Output filename for read 1 FASTQ.
  -out2 <file>             Output filename for read 2 FASTQ.

Optional parameters:
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_FastqCheckUMI

### Tool Description
Returns the UMI info of a FastQ file on STDOUT.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqCheckUMI (2025_12)

Returns the UMI info of a FastQ file on STDOUT.

Mandatory parameters:
  -in <file>        Input FASTQ file.

Optional parameters:
  -out <file>       Output file containing the result string. If unset, writes to STDOUT.
                    Default value: ''
  -lines <int>      Number of lines which should be checked. (default: 10)
                    Default value: '10'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_FastqConcat

### Tool Description
Concatinates several FASTQ files into one output FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqConcat (2025_12)

Concatinates several FASTQ files into one output FASTQ file.

Mandatory parameters:
  -in <filelist>           Input (gzipped) FASTQ files.
  -out <file>              Output gzipped FASTQ file.

Optional parameters:
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

## ngs-bits_FastqConvert

### Tool Description
Converts the quality scores from Illumina 1.5 offset to Sanger/Illumina 1.8 offset.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqConvert (2025_12)

Converts the quality scores from Illumina 1.5 offset to Sanger/Illumina 1.8 offset.

Mandatory parameters:
  -in <file>               Input gzipped FASTQ file.
  -out <file>              Output gzipped FASTQ file.

Optional parameters:
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_FastqDownsample

### Tool Description
Downsamples paired-end FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
FastqDownsample (2025_12)

Downsamples paired-end FASTQ files.

Mandatory parameters:
  -in1 <file>              Forward input gzipped FASTQ file(s).
  -in2 <file>              Reverse input gzipped FASTQ file(s).
  -percentage <float>      Percentage of reads to keep.
  -out1 <file>             Forward output gzipped FASTQ file.
  -out2 <file>             Reverse output gzipped FASTQ file.

Optional parameters:
  -test                    Test mode: fix random number generator seed and write kept read names to STDOUT.
                           Default value: 'false'
  -compression_level <int> Output FASTQ compression level from 1 (fastest) to 9 (best compression).
                           Default value: '1'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_RnaQC

### Tool Description
Calculates QC metrics for RNA samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
RnaQC (2025_12)

Calculates QC metrics for RNA samples.

Mandatory parameters:
  -bam <file>                Input BAM/CRAM file.

Optional parameters:
  -housekeeping_genes <file> BED file containing the exon region of housekeeping genes.
                             Default value: ''
  -roi <file>                BED file containing the target region of the analysis.
                             Default value: ''
  -out <file>                Output qcML file. If unset, writes to STDOUT.
                             Default value: ''
  -splicing <file>           TSV file containing spliced reads by gene.
                             Default value: ''
  -expression <file>         TSV file containing RNA expression.
                             Default value: ''
  -ref <file>                Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                             Default value: ''
  -min_mapq <int>            Set minimal mapping quality (default:1)
                             Default value: '1'
  -txt                       Writes TXT format instead of qcML.
                             Default value: 'false'

Special parameters:
  --help                     Shows this help and exits.
  --version                  Prints version and exits.
  --changelog                Prints changeloge and exits.
  --tdx                      Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]          Settings override file (no other settings files are used).
```

## ngs-bits_SnifflesVcfFix

### Tool Description
Fixes VCF file from Sniffles SV Caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SnifflesVcfFix (2025_12)

Fixes VCF file from Sniffles SV Caller.

Converts lowEvidence variants into het variants.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF list. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_SomaticQC

### Tool Description
Calculates QC metrics based on tumor-normal pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SomaticQC (2025_12)

Calculates QC metrics based on tumor-normal pairs.

SomaticQC integrates the output of the other QC tools and adds several metrics specific for tumor-normal pairs.
All tools produce qcML, a generic XML format for QC of -omics experiments, which we adapted for NGS.

Mandatory parameters:
  -tumor_bam <file>    Input tumor BAM/CRAM file.
  -normal_bam <file>   Input normal BAM/CRAM file.
  -somatic_vcf <file>  Input somatic VCF file.

Optional parameters:
  -out <file>          Output qcML file. If unset, writes to STDOUT.
                       Default value: ''
  -links <filelist>    Files that appear in the link part of the qcML file.
                       Default value: ''
  -target_bed <file>   Target file used for tumor and normal experiment.
                       Default value: ''
  -target_exons <file> BED file containing target exons, neccessary for TMB calculation. Please provide a file that contains the coordinates of all exons in the reference genome.
                       Default value: ''
  -blacklist <file>    BED file containing regions which are ignored in TMB calculation.
                       Default value: ''
  -tsg_bed <file>      BED file containing regions of tumor suppressor genes for TMB calculation.
                       Default value: ''
  -ref <file>          Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                       Default value: ''
  -skip_plots          Skip plots (intended to increase speed of automated tests).
                       Default value: 'false'
  -build <enum>        Genome build used to generate the input.
                       Default value: 'hg38'
                       Valid: 'hg19,hg38'

Special parameters:
  --help               Shows this help and exits.
  --version            Prints version and exits.
  --changelog          Prints changeloge and exits.
  --tdx                Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]    Settings override file (no other settings files are used).
```

## ngs-bits_SvFilterAnnotations

### Tool Description
Filter a structural variant list in BEDPE format based on variant annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
SvFilterAnnotations (2025_12)

Filter a structural variant list in BEDPE format based on variant annotations.

The filter definition file lists one filter per line using the following syntax:
name[tab]param1=value[tab]param2=value...

The order in the filter definition file defines the order in which the filters are applied.

Several of the filters offer more than one action:
  FILTER - Remove variants if they do not match the filter.
  REMOVE - Remove variants if they match the filter.
  KEEP - Force variants to be kept, even if filtered out by previous filter steps.

The following filters are supported:
SV CNV overlap              Filter the removes DEL/DUP without support from CNV calling.
                            Parameters:
                              min_ol - Minimum CNV overlap. [default=0.5] [min=0.0] [max=1.0]
                              min_size - Minimum SV size in bases. [default=10000] [min=0]
SV OMIM genes               Filter for OMIM genes i.e. the 'OMIM' column is not empty.
                            Parameters:
                              action - Action to perform [default=FILTER] [valid=REMOVE,FILTER]
SV PE read depth            Show only SVs with at least a certain number of Paired End Reads
                            (In trio/multi sample all (affected) samples must meet the requirements.)
                            Parameters:
                              PE Read Depth - minimal number of Paired End Reads [default=0] [min=0]
                              only_affected - Apply filter only to affected Samples. [default=false]
SV SomaticScore             Show only SVs with at least a certain Somaticscore
                            Parameters:
                              Somaticscore - min. Somaticscore [default=0] [min=0]
SV allele frequency NGSD    Filter based on the allele frequency of this structural variant in the NGSD.
                            Note: this filter should only be used for whole genome samples.
                            Parameters:
                              max_af - Maximum allele frequency in % [default=1] [min=0.0] [max=200.0]
SV annotated pathogenic     Filter variants that are already annotated to be pathogenic in NGSD..
                            Parameters:
                              action - Action to perform [default=FILTER] [valid=FILTER,KEEP]
SV break point density NGSD Filter based on the density of SV break points in the NGSD in the CI of the structural variant.
                            Parameters:
                              max_density - Maximum density in the confidence interval of the SV [default=20] [min=0]
                              remove_strict - Remove also SVs in which only one break point is above threshold. [default=false]
                              only_system_specific - Filter only based on the density of breakpoint of the current processing system. [default=false]
SV compound-heterozygous    Filter for compound-heterozygous SVs.
                            Mode 'SV-SV' detects genes with two or more SV hits.
                            Mode 'SV-SNV/INDEL' detects genes with at least one SV and at least one small variant hit (after other filters are applied).
                            Parameters:
                              mode - Compound-heterozygotes detection mode. [default=n/a] [valid=n/a,SV-SV,SV-SNV/INDEL]
SV count NGSD               Filter based on the hom/het occurances of a structural variant in the NGSD.
                            Parameters:
                              max_count - Maximum NGSD SV count [default=20] [min=0]
                              ignore_genotype - If set, all NGSD entries are counted independent of the variant genotype. Otherwise, for homozygous variants only homozygous NGSD entries are counted and for heterozygous variants all NGSD entries are counted. [default=false]
SV filter columns           Filter structural variants based on the entries of the 'FILTER' column.
                            Parameters:
                              entries - Filter column entries [non-empty]
                              action - Action to perform [default=REMOVE] [valid=REMOVE,FILTER,KEEP]
SV gene constraint          Filter based on gene constraint (gnomAD o/e score for LOF variants).
                            Note that gene constraint is most helpful for early-onset severe diseases.
                            For details on gnomAD o/e, see https://macarthurlab.org/2018/10/17/gnomad-v2-1/
                            Parameters:
                              max_oe_lof - Maximum gnomAD o/e score for LoF variants [default=0.35] [min=0.0] [max=1.0]
SV gene overlap             Filter based on gene overlap.
                            Parameters:
                              complete - Overlaps the complete gene. [default=true]
                              exonic/splicing - Overlaps the coding or splicing region of the gene. [default=true]
                              intronic/near gene - Overlaps the intronic region or less than 5kb up/down stream of the gene . [default=false]
SV genotype affected        Filter structural variants (of affected samples) based on their genotype.
                            Parameters:
                              genotypes - Structural variant genotype(s) [valid=wt,het,hom,n/a] [non-empty]
                              same_genotype - Also check that all 'control' samples have the same genotype. [default=false]
SV genotype control         Filter structural variants of control samples based on their genotype.
                            Parameters:
                              genotypes - Structural variant genotype(s) [valid=wt,het,hom,n/a] [non-empty]
                              same_genotype - Also check that all 'control' samples have the same genotype. [default=false]
SV paired read AF           Show only SVs with a certain Paired Read Allele Frequency +/- 10%
                            (In trio/multi sample all (affected) samples must meet the requirements.)
                            Parameters:
                              Paired Read AF - Paired Read Allele Frequency +/- 10% [default=0] [min=0.0] [max=1.0]
                              only_affected - Apply filter only to affected Samples. [default=false]
SV quality                  Filter structural variants based on their quality.
                            Parameters:
                              quality - Minimum quality score [default=0] [min=0]
SV remove chr type          Removes all structural variants which contains non-standard/standard chromosomes.
                            Parameters:
                              chromosome type - Structural variants containing non-standard/standard chromosome are removed. [default=special chromosomes] [valid=special chromosomes,standard chromosomes] [non-empty]
SV size                     Filter for SV size in the given range.
                            Parameters:
                              min_size - Minimum SV size (absolute size). [default=0] [min=0]
                              max_size - Maximum SV size (absolute size). Select 0 for infinity. [default=0] [min=0]
SV split read AF            Show only SVs with a certain Split Read Allele Frequency +/- 10%
                            (In trio/multi sample all (affected) samples must meet the requirements.)
                            Parameters:
                              Split Read AF - Split Read Allele Frequency +/- 10% [default=0] [min=0.0] [max=1.0]
                              only_affected - Apply filter only to affected Samples. [default=false]
SV trio                     Filter trio structural variants
                            Parameters:
                              types - Variant types [default=de-novo,recessive,comp-het,LOH,x-linked] [valid=de-novo,recessive,comp-het,LOH,x-linked,imprinting]
                              gender_child - Gender of the child - if 'n/a', the gender from the GSvar file header is taken [default=n/a] [valid=male,female,n/a]
                              build - Genome build used for pseudoautosomal region coordinates [default=hg19] [valid=hg19,hg38]
SV type                     Filter based on SV types.
                            Parameters:
                              Structural variant type - Structural variant type [valid=DEL,DUP,INS,INV,BND] [non-empty]
SV-lr AF                    Show only (lr) SVs with a allele frequency between the given interval
                            Parameters:
                              min_af - minimal allele frequency [default=0] [min=0.0] [max=1.0]
                              max_af - maximal allele frequency [default=1] [min=0.0] [max=1.0]
SV-lr support reads         Show only (lr) SVs with a minimum number of supporting reads
                            Parameters:
                              min_support - Minimum support read count [default=5] [min=0] [max=10000]

Mandatory parameters:
  -in <file>        Input structural variant list in BEDPE format.
  -out <file>       Output structural variant list in BEDPE format.
  -filters <file>   Filter definition file.

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TrioMaternalContamination

### Tool Description
Detects maternal contamination of a child using SNPs from parents.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TrioMaternalContamination (2025_12)

Detects maternal contamination of a child using SNPs from parents.

Determines the percentage of heterozygous SNPs passed on to the child from mother/father.
This percentage should be similar for mother/father. If it is much higher for the mother, maternal contamination is likely.

Mandatory parameters:
  -bam_m <file>        Input BAM/CRAM file of mother.
  -bam_f <file>        Input BAM/CRAM file of father.
  -bam_c <file>        Input BAM/CRAM file of child.

Optional parameters:
  -min_depth <int>     Minimum depth for calling SNPs.
                       Default value: '3'
  -min_alt_count <int> Minimum number of alternate observations for calling a SNP.
                       Default value: '1'
  -build <enum>        Genome build used to generate the input.
                       Default value: 'hg38'
                       Valid: 'hg19,hg38'
  -out <file>          Output file. If unset, writes to STDOUT.
                       Default value: ''
  -ref <file>          Reference genome for CRAM support (mandatory if CRAM is used).
                       Default value: ''

Special parameters:
  --help               Shows this help and exits.
  --version            Prints version and exits.
  --changelog          Prints changeloge and exits.
  --tdx                Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]    Settings override file (no other settings files are used).
```

## ngs-bits_TrioMendelianErrors

### Tool Description
Determines mendelian error rate from a trio VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TrioMendelianErrors (2025_12)

Determines mendelian error rate from a trio VCF.

Mandatory parameters:
  -vcf <file>       Multi-sample VCF or VCF.GZ file.
  -c <string>       Sample name of child in VCF.
  -f <string>       Sample name of father in VCF.
  -m <string>       Sample name of mother in VCF.

Optional parameters:
  -out <file>       Output text file. If unset, writes to STDOUT.
                    Default value: ''
  -min_dp <int>     Minimum depth in each sample.
                    Default value: '0'
  -min_qual <float> Minimum QUAL of variants.
                    Default value: '0'
  -debug            Enable debug output
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TsvDiff

### Tool Description
Compares TSV files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvDiff (2025_12)

Compares TSV files.

Mandatory parameters:
  -in1 <file>                      First input TSV file.
  -in2 <file>                      Second input TSV file.

Optional parameters:
  -out <file>                      Output file with differences. If unset, writes to stdout.
                                   Default value: ''
  -skip_comments                   Do not compare comment lines starting with '##'.
                                   Default value: 'false'
  -skip_comments_matching <string> Comma-separated list of sub-strings for skipping comment lines (case-sensitive matching).
                                   Default value: ''
  -skip_cols <string>              Comma-separated list of colums to skip during line comparison.
                                   Default value: ''
  -comp <string>                   Comma-separated list of columns to use for comparison (all other columns are ignored).
                                   Default value: ''
  -diff_abs <string>               Comma-separated list of column=difference tuples for defining maximum allowed numeric difference of columns.
                                   Default value: ''
  -no_error                        Do not exit with error state if differences are detected.
                                   Default value: 'false'
  -debug <int>                     Debug level (0=none, 1=basic, 2=extended
                                   Default value: '0'

Special parameters:
  --help                           Shows this help and exits.
  --version                        Prints version and exits.
  --changelog                      Prints changeloge and exits.
  --tdx                            Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]                Settings override file (no other settings files are used).
```

## ngs-bits_TsvFilter

### Tool Description
Filters the rows of a TSV file according to the value of a specific column.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvFilter (2025_12)

Filters the rows of a TSV file according to the value of a specific column.

Mandatory parameters:
  -filter <string>  Filter string with column name, operation and value,e.g. 'depth > 17'.
Valid operations are '>','>=','=','<=','<','is','contains'.

Optional parameters:
  -in <file>        Input TSV file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output TSV file. If unset, writes to STDOUT.
                    Default value: ''
  -numeric          If set, column name is interpreted as a 1-based column number.
                    Default value: 'false'
  -v                Invert filter.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TsvInfo

### Tool Description
Prints general information about a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvInfo (2025_12)

Prints general information about a TSV file.

Optional parameters:
  -in <file>        Input TSV file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output file. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TsvMerge

### Tool Description
Merges TSV file based on a list of columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvMerge (2025_12)

Merges TSV file based on a list of columns.

Mandatory parameters:
  -in <filelist>    Input TSV files that are merged. If only one file is given, each line in this file is interpreted as an input file path.
  -cols <string>    Comma-separated list of column names used as key for merging.

Optional parameters:
  -out <file>       Output file. If unset, writes to STDOUT.
                    Default value: ''
  -numeric          If set, column names are interpreted as 1-based column numbers.
                    Default value: 'false'
  -simple           Fast and memory-efficient mode for merging files that are ordered in the same way and have no missing lines.
                    Default value: 'false'
  -mv <string>      Missing value, i.e. value that is inserted when key is missing in a file.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TsvSlice

### Tool Description
Extracts/reorders columns of a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvSlice (2025_12)

Extracts/reorders columns of a TSV file.

Mandatory parameters:
  -cols <string>    Comma-separated list of column names to extract.

Optional parameters:
  -in <file>        Input TSV file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output file. If unset, writes to STDOUT.
                    Default value: ''
  -numeric          If set, column names are interpreted as 1-based column numbers.
                    Default value: 'false'
  -rm               If set, the columns given in 'cols' are removed instead of extracted.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_TsvToQC

### Tool Description
Converts TSV file to a qcML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
TsvToQC (2025_12)

Converts TSV file to a qcML file.

Mandatory parameters:
  -sources <filelist> Source files the QC terms were extracted from.

Optional parameters:
  -in <file>          Input TSV file with two columns (QC term accession and value). If unset, reads from STDIN.
                      Default value: ''
  -out <file>         Output qcML file. If unset, writes to STDOUT.
                      Default value: ''

Special parameters:
  --help              Shows this help and exits.
  --version           Prints version and exits.
  --changelog         Prints changeloge and exits.
  --tdx               Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]   Settings override file (no other settings files are used).
```

## ngs-bits_VariantAnnotateASE

### Tool Description
Annotates a variant list with variant frequencies from a RNA BAM/CRAM file. Used to check for allele-specific expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VariantAnnotateASE (2025_12)

Annotates a variant list with variant frequencies from a RNA BAM/CRAM file. Used to check for allele-specific expression.

Mandatory parameters:
  -in <file>        Input variant list to annotate in GSvar format.
  -bam <file>       Input BAM/CRAM file.
  -out <file>       Output variant list file name (VCF or GSvar).

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

## ngs-bits_VariantAnnotateFrequency

### Tool Description
Annotates a variant list with variant frequencies from a BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VariantAnnotateFrequency (2025_12)

Annotates a variant list with variant frequencies from a BAM/CRAM file.

Mandatory parameters:
  -in <file>        Input variant list to annotate in GSvar format.
  -bam <file>       Input BAM/CRAM file.
  -out <file>       Output variant list file in GSvar format.

Optional parameters:
  -depth            Annotate an additional column containing the depth.
                    Default value: 'false'
  -mapq0            Annotate an additional column containing the percentage of mapq 0 reads.
                    Default value: 'false'
  -name <string>    Column header prefix in output file.
                    Default value: ''
  -ref <file>       Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''
  -long_read        Support long reads (> 1kb).
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VariantFilterAnnotations

### Tool Description
Filter a variant list in GSvar format based on variant annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VariantFilterAnnotations (2025_12)

Filter a variant list in GSvar format based on variant annotations.

The filter definition file lists one filter per line using the following syntax:
name[tab]param1=value[tab]param2=value...

The order in the filter definition file defines the order in which the filters are applied.

Several of the filters offer more than one action:
  FILTER - Remove variants if they do not match the filter.
  REMOVE - Remove variants if they match the filter.
  KEEP - Force variants to be kept, even if filtered out by previous filter steps.

The following filters are supported:
Allele frequency                   Filter based on overall allele frequency given by gnomAD and if available 1000g.
                                   Parameters:
                                     max_af - Maximum allele frequency in % [default=1] [min=0.0] [max=100.0]
Allele frequency (sub-populations) Filter based on sub-population allele frequency given by gnomAD.
                                   Parameters:
                                     max_af - Maximum allele frequency in % [default=1] [min=0.0] [max=100.0]
Annotated pathogenic               Filter that matches variants annotated to be pathogenic by ClinVar or HGMD.
                                   Parameters:
                                     sources - Sources of pathogenicity to use [default=ClinVar,HGMD] [valid=ClinVar,HGMD] [non-empty]
                                     also_likely_pathogenic - Also consider likely pathogenic variants [default=false]
                                     action - Action to perform [default=KEEP] [valid=KEEP,FILTER]
Classification NGSD                Filter for variant classification from NGSD.
                                   Parameters:
                                     classes - NGSD classes [default=4,5] [valid=1,2,3,4,5,M,R] [non-empty]
                                     action - Action to perform [default=KEEP] [valid=KEEP,FILTER,REMOVE]
Column match                       Filter that matches the content of a column against a perl-compatible regular expression.
                                   For details about regular expressions, see http://perldoc.perl.org/perlretut.html
                                   Parameters:
                                     pattern - Pattern to match to column [non-empty]
                                     column - Column to filter [non-empty]
                                     action - Action to perform [default=KEEP] [valid=KEEP,FILTER,REMOVE]
Conservedness                      Filter for variants that affect conserved bases
                                   Parameters:
                                     min_score - Minimum phlyoP score. [default=1.6]
Count NGSD                         Filter based on the hom/het occurances of a variant in the NGSD.
                                   Parameters:
                                     max_count - Maximum NGSD count [default=20] [min=0]
                                     ignore_genotype - If set, all variants in NGSD are counted independent of the genotype. Otherwise, for homozygous variants only homozygous NGSD variants are counted and for heterozygous variants homozygous and heterozygous NGSD variants are counted. [default=false]
                                     mosaic_as_het - If set, mosaic variants are counted as heterozygous. Otherwise, they are not counted. [default=false]
Filter column empty                Filter that perserves variants which have no entry in the 'filter' column.
Filter columns                     Filter based on the entries of the 'filter' column.
                                   Parameters:
                                     entries - Filter column entries [non-empty]
                                     action - Action to perform [default=REMOVE] [valid=KEEP,REMOVE,FILTER]
GSvar score/rank                   Filter based GSvar score/rank.
                                   Parameters:
                                     top - Show top X rankging variants only. [default=10] [min=1]
Gene constraint                    Filter based on gene constraint (gnomAD o/e score for LOF variants).
                                   Note that gene constraint is most helpful for early-onset severe diseases.
                                   For details on gnomAD o/e, see https://macarthurlab.org/2018/10/17/gnomad-v2-1/
                                   Note: ExAC pLI is deprected and support for backward compatibility with old GSvar files.
                                   Parameters:
                                     max_oe_lof - Maximum gnomAD o/e score for LoF variants [default=0.35] [min=0.0] [max=1.0]
                                     min_pli - Minumum ExAC pLI score [default=0.9] [min=0.0] [max=1.0]
Gene inheritance                   Filter based on gene inheritance.
                                   Parameters:
                                     modes - Inheritance mode(s) [valid=AR,AD,XLR,XLD,MT,n/a] [non-empty]
Genes                              Filter that preserves a gene set.
                                   Parameters:
                                     genes - Gene set [non-empty]
Genotype affected                  Filter for genotype(s) of the 'affected' sample(s).
                                   Variants pass if 'affected' samples have the same genotype and the genotype is in the list selected genotype(s).
                                   comp-het works on unphased data (short-read) and keeps all het variants where are at least two (remaining) variants per gene.
                                   comp-het (phased) only works on phased data (long-read) on completely phased genes and keeps all het variants where are at least one het variant on each allele per gene.
                                   comp-het (unphased) only works on phased data (long-read) on genes with at least one unphased variant or multiple phasing blocks and keeps all het variants where are at least two het variant per gene (inverse of com-het (phased)).
                                   You can only select one of the three above at a time.
                                   Parameters:
                                     genotypes - Genotype(s) [valid=wt,het,hom,n/a,comp-het,comp-het (phased),comp-het (unphased)] [non-empty]
                                     same_genotype - Also check that all 'control' samples have the same genotype. [default=false]
Genotype control                   Filter for genotype of the 'control' sample(s).
                                   Parameters:
                                     genotypes - Genotype(s) [valid=wt,het,hom,n/a] [non-empty]
                                     same_genotype - Also check that all 'control' samples have the same genotype. [default=false]
Impact                             Filter based on the variant impact given by VEP.
                                   For more details see: https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html
                                   Parameters:
                                     impact - Valid impacts [default=HIGH,MODERATE,LOW] [valid=HIGH,MODERATE,LOW,MODIFIER] [non-empty]
OMIM genes                         Filter for OMIM genes i.e. the 'OMIM' column is not empty.
                                   Parameters:
                                     action - Action to perform [default=FILTER] [valid=REMOVE,FILTER]
Predicted pathogenic               Filter for variants predicted to be pathogenic.
                                   Pathogenicity predictions used by this filter are: phyloP, CADD, REVEL and AlphaMissense.
                                   Parameters:
                                     min - Minimum number of pathogenic predictions [default=1] [min=1]
                                     action - Action to perform [default=FILTER] [valid=KEEP,FILTER]
                                     skip_high_impact - Do not apply this filter to variants with impact 'HIGH'. [default=false]
                                     cutoff_phylop - Minimum phyloP score for a pathogenic prediction. The phyloP score is not used if set to -10.0. [default=1.6]
                                     cutoff_cadd - Minimum CADD score for a pathogenic prediction. The CADD score is not used if set to 0.0. [default=22.7] [min=0]
                                     cutoff_revel - Minimum REVEL score for a pathogenic prediction. The REVEL score is not used if set to 0.0. [default=0.9] [min=0] [max=1]
                                     cutoff_alphamissense - Minimum AlphaMissense score for a pathogenic prediction. The AlphaMissense score is not used if set to 0.0. [default=0.564] [min=0] [max=1]
RNA ASE allele frequency           Filter based on the allele specific expression allele frequency.
                                   Parameters:
                                     min_af - Minimal expression allele frequency. [default=0] [min=0.0] [max=1.0]
                                     max_af - Maximal expression allele frequency. [default=1] [min=0.0] [max=1.0]
RNA ASE alternative count          Filter based on the allele specific expression alternative count.
                                   Parameters:
                                     min_ac - Minimal expression alternative count. [default=5] [min=0]
RNA ASE depth                      Filter based on the allele specific expression depth.
                                   Parameters:
                                     min_depth - Minimal expression depth. [default=20] [min=0]
RNA ASE p-value                    Filter based on the allele specific expression p-value.
                                   Parameters:
                                     max_pval - Maximal expression p-value. [default=0.05] [min=0.0] [max=1.0]
RNA aberrant splicing fraction     Filter based on the fraction of aberrant splicing reads.
                                   Parameters:
                                     min_asf - Minimal aberrant splicing fraction. [default=0.01] [min=0.0] [max=1.0]
RNA expression fold-change         Filter based on the absolute gene expression log2 fold-change.
                                   Parameters:
                                     min_fc - Minimal absolute fold-change. [default=2] [min=0.0]
RNA expression z-score             Filter based on the absolute gene expression z-score.
                                   Parameters:
                                     min_zscore - Minimal absolute z-score. [default=2] [min=0.0]
RNA gene expression                Filter based on the gene expression in transcripts-per-million
                                   Parameters:
                                     min_tpm - Minimal gene expression in transcripts-per-million. [default=5] [min=0.0]
Regulatory                         Filter for regulatory variants, i.e. the 'regulatory' column is not empty.
                                   Parameters:
                                     action - Action to perform [default=FILTER] [valid=REMOVE,FILTER]
SNVs only                          Filter that preserves SNVs and removes all other variant types.
                                   Parameters:
                                     invert - If set, removes all SNVs and keeps all other variants. [default=false]
Somatic allele frequency           Filter based on the allele frequency of variants in tumor/normal samples.
                                   Parameters:
                                     min_af_tum - Minimum allele frequency in tumor sample [%] [default=5] [min=0.0] [max=100.0]
                                     max_af_nor - Maximum allele frequency in normal sample [%] [default=1] [min=0.0] [max=100.0]
Splice effect                      Filter based on the predicted change in splice effect
                                   Parameters:
                                     SpliceAi - Minimum SpliceAi score. Disabled if set to zero. [default=0.5] [min=0] [max=1]
                                     MaxEntScan - Minimum predicted splice effect. Disabled if set to LOW. [default=HIGH] [valid=HIGH,MODERATE,LOW]
                                     splice_site_only - Use native splice site predictions only and skip de-novo acceptor/donor predictions. [default=true]
                                     action - Action to perform [default=FILTER] [valid=KEEP,FILTER]
Text search                        Filter for text match in variant annotations.
                                   The text comparison ignores the case.
                                   Parameters:
                                     term - Search term [non-empty]
                                     action - Action to perform [default=FILTER] [valid=FILTER,KEEP,REMOVE]
Trio                               Filter trio variants
                                   Parameters:
                                     types - Variant types [default=de-novo,recessive,comp-het,LOH,x-linked] [valid=de-novo,recessive,comp-het,LOH,x-linked,imprinting]
                                     gender_child - Gender of the child - if 'n/a', the gender from the GSvar file header is taken [default=n/a] [valid=male,female,n/a]
                                     build - Genome build used for pseudoautosomal region coordinates [default=hg38] [valid=hg19,hg38]
Tumor zygosity                     Filter based on the zygosity of tumor-only samples. Filters out germline het/hom calls.
                                   Parameters:
                                     het_af_range - Consider allele frequencies of 50% ± het_af_range as heterozygous and thus as germline. [default=0] [min=0] [max=49.9]
                                     hom_af_range - Consider allele frequencies of 100% ± hom_af_range as homozygous and thus as germline. [default=0] [min=0] [max=99.9]
Variant quality                    Filter for variant quality
                                   Parameters:
                                     qual - Minimum variant quality score (Phred) [default=250] [min=0]
                                     depth - Minimum depth [default=0] [min=0]
                                     mapq - Minimum mapping quality of alternate allele (Phred) [default=40] [min=0]
                                     strand_bias - Maximum strand bias Phred score of alternate allele (set -1 to disable) [default=20] [min=-1]
                                     allele_balance - Maximum allele balance Phred score (set -1 to disable) [default=40] [min=-1]
                                     min_occurences - Minimum occurences of the variant per strand [default=1] [min=0]
                                     min_af - Minimum allele frequency of the variant in the sample [default=0] [min=0.0] [max=1.0]
                                     max_af - Maximum allele frequency of the variant in the sample [default=1] [min=0.0] [max=1.0]
Variant type                       Filter for variant types as defined by sequence ontology.
                                   For details see http://www.sequenceontology.org/browser/obob.cgi
                                   Parameters:
                                     HIGH - High impact variant types [default=frameshift_variant,splice_acceptor_variant,splice_donor_variant,start_lost,start_retained_variant,stop_gained,stop_lost] [valid=frameshift_variant,splice_acceptor_variant,splice_donor_variant,start_lost,start_retained_variant,stop_gained,stop_lost]
                                     MODERATE - Moderate impact variant types [default=inframe_deletion,inframe_insertion,missense_variant] [valid=inframe_deletion,inframe_insertion,missense_variant]
                                     LOW - Low impact variant types [default=splice_region_variant] [valid=splice_region_variant,stop_retained_variant,synonymous_variant]
                                     MODIFIER - Lowest impact variant types [valid=3_prime_UTR_variant,5_prime_UTR_variant,NMD_transcript_variant,downstream_gene_variant,intergenic_variant,intron_variant,mature_miRNA_variant,non_coding_transcript_exon_variant,non_coding_transcript_variant,upstream_gene_variant]
lr short-read overlap              Filter that preserves variants if they were called in short-read WGS sample only.
                                   Parameters:
                                     invert - If set, removes all variants if they were called in short-read WGS sample. [default=false]

Mandatory parameters:
  -filters <file>   Filter definition file.

Optional parameters:
  -in <file>        Input variant list in GSvar format.
                    Default value: ''
  -out <file>       Output variant list in GSvar format.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VariantFilterRegions

### Tool Description
Filter a variant list based on a target region.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VariantFilterRegions (2025_12)

Filter a variant list based on a target region.

Mandatory parameters:
  -in <file>               Input variant list. In VCF (default) or GSvar format.

Optional parameters:
  -out <file>              Output variant list (same format as 'in'). If unset, writes to STDOUT.
                           Default value: ''
  -reg <file>              Input target region in BED format.
                           Default value: ''
  -r <string>              Single target region in the format chr17:41194312-41279500.
                           Default value: ''
  -mark <string>           If set, instead of removing variants, they are marked with the given flag in the 'filter' column.
                           Default value: ''
  -inv                     Inverts the filter, i.e. variants inside the region are removed/marked.
                           Default value: 'false'
  -mode <enum>             Mode (input format).
                           Default value: 'vcf'
                           Valid: 'vcf,gsvar'
  -compression_level <int> Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written.
                           Default value: '10'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_VcfAnnotateFromBigWig

### Tool Description
Annotates the INFO column of a VCF with data from a bigWig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateFromBigWig (2025_12)

Annotates the INFO column of a VCF with data from a bigWig file.

The annotation is decided according the following rules:
Insertions are not annotated.
SNPs are annotated according to the corresponding value in the bigWig file. If the file has no corresponding value no annotation is written.
MNPs, complex INDELs and Deletions the annotated value is choosen according to the given mode:
max - maximum; min - minimum; avg - average; of the values in the affected reference region.
none - regions that affect multiple reference bases are not annotated.

Mandatory parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
  -bw <file>        BigWig file containen the data to be used in the annotation.
  -name <string>    Name of the new INFO column.
  -mode <enum>      Annotate mode: How the annotation is chosen when multiple bases are affected.
                    Valid: 'max,min,avg,none'

Optional parameters:
  -out <file>       Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT.
                    Default value: ''
  -threads <int>    The number of threads used to read, process and write files.
                    Default value: '1'
  -block_size <int> Number of lines processed in one chunk.
                    Default value: '5000'
  -prefetch <int>   Maximum number of blocks that may be pre-fetched into memory.
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

## ngs-bits_VcfAnnotateHexplorer

### Tool Description
Annotates a VCF with Hexplorer and HBond scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateHexplorer (2025_12)

Annotates a VCF with Hexplorer and HBond scores.

Mandatory parameters:
  -out <file>       Output VCF file containing HEXplorer and HBOND scores in the INFO column.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -ref <file>       Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfAnnotateMaxEntScan

### Tool Description
Annotates a VCF file with MaxEntScan scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfAnnotateMaxEntScan (2025_12)

Annotates a VCF file with MaxEntScan scores.

This is essentially a multithreaded C++ reimplementation of the MaxEntScan plugin for VEP (https://github.com/Ensembl/VEP_plugins/blob/release/109/MaxEntScan.pm). MaxEntScan was first introduced by Shamsani et al. (https://doi.org/10.1093/bioinformatics/bty960).
Benchmarking of this tool showed that it is up to 10x faster than the VEP plugin when using one thread.
The standard MES scores are only computed for variants which are close to known splice sites (which are computed from the provided GFF file).
De-novo splice sites can be found by using the MES scores from the sliding window approach (SWA).
Intergenic variants never get a MES scores.

Mandatory parameters:
  -gff <file>        Ensembl-style GFF file with transcripts, e.g. from https://ftp.ensembl.org/pub/release-115/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz.

Optional parameters:
  -out <file>        Output VCF file containing the MaxEntScan scores in the INFO column. If unset, writes to STDOUT.
                     Default value: ''
  -in <file>         Input VCF file. If unset, reads from STDIN.
                     Default value: ''
  -swa               Enables sliding window approach, i.e. predictions of de-novo acceptor/donor sites.
                     Default value: 'false'
  -all               If set, all transcripts are used for annotation (the default is to skip transcripts not labeled with the 'GENCODE basic' tag).
                     Default value: 'false'
  -tag <string>      Info entry name used for native splice site scores.
                     Default value: 'MES'
  -tag_swa <string>  Info entry name used for SWA scores.
                     Default value: 'MES_SWA'
  -decimals <int>    Number of decimals of output scores.
                     Default value: '2'
  -min_score <float> Minimum score to report.
                     Default value: '-1000'
  -threads <int>     The number of threads used to process VCF line chunk.
                     Default value: '1'
  -block_size <int>  Number of VCF lines processed in one chunk.
                     Default value: '10000'
  -prefetch <int>    Maximum number of chunks that may be pre-fetched into memory.
                     Default value: '64'
  -ref <file>        Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                     Default value: ''
  -debug             Enables debug output (use only with one thread).
                     Default value: 'false'

Special parameters:
  --help             Shows this help and exits.
  --version          Prints version and exits.
  --changelog        Prints changeloge and exits.
  --tdx              Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]  Settings override file (no other settings files are used).
```

## ngs-bits_VcfBreakMulti

### Tool Description
Breaks multi-allelic variants into several lines, making sure that allele-specific INFO/SAMPLE fields are still valid.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfBreakMulti (2025_12)

Breaks multi-allelic variants into several lines, making sure that allele-specific INFO/SAMPLE fields are still valid.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF list. If unset, writes to STDOUT.
                    Default value: ''
  -no_errors        Ignore VCF format errors if possible.
                    Default value: 'false'
  -verbose          Writes ignored VCF format errors to stderr.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfCalculatePRS

### Tool Description
Calculates the Polgenic Risk Score(s) for a sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfCalculatePRS (2025_12)

Calculates the Polgenic Risk Score(s) for a sample.

The PRS VCF files have to contain WEIGHT and POP_AF fields in the INFO column.
Additionally some information about the PRS score is required in the VCF header.
An example VCF file can be found at https://github.com/imgag/ngs-bits/blob/master/src/tools-TEST/data_in/VcfCalculatePRS_prs2.vcf

Mandatory parameters:
  -in <file>        Tabix indexed VCF.GZ file of a sample.
  -prs <filelist>   List of PRS VCFs.
  -bam <file>       BAM file corresponding to the VCF.
  -out <file>       Output TSV file containing Scores and PRS details

Optional parameters:
  -details <file>   Output TSV containing each variant with weight, allele count and population AF.
                    Default value: ''
  -ref <file>       Reference genome FASTA file. If unset, 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''
  -min_depth <int>  Depth cutoff below which uncalled SNPs are considered not callable and POP_AF is used instead of genotype.
                    Default value: '10'
  -long_read        Support long reads (> 1kb).
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfCheck

### Tool Description
Checks a VCF file for errors.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfCheck (2025_12)

Checks a VCF file for errors.

Checks the input VCF file with SNVs and small InDels for errors and warnings.
If the VEP-based CSQ annotation is present, it also checks that the Miso terms in the consequence field are valid.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output file. If unset, writes to STDOUT.
                    Default value: ''
  -lines <int>      Number of variant lines to check in the VCF file (unlimited if 0)
                    Default value: '5000'
  -ref <file>       Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                    Default value: ''
  -info             Add general information about the input file to the output.
                    Default value: 'false'
  -duplicates       Check for variants occuring twice (input VCF needs to be sorted).
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfExtractSamples

### Tool Description
Extract one or several samples from a VCF file. Can also be used to re-order sample columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfExtractSamples (2025_12)

Extract one or several samples from a VCF file. Can also be used to re-order sample columns.

Mandatory parameters:
  -samples <string> Comma-separated list of samples to extract (in the given order).

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF list. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfFilter

### Tool Description
Filters a VCF based on the given criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfFilter (2025_12)

Filters a VCF based on the given criteria.

Missing annotation in the SAMPLE filter are treated as passing the filter.
INFO flags (i.e. entries without value) are ignored, i.e. they cannot be filtered.

Optional parameters:
  -in <file>               Input VCF file. If unset, reads from STDIN.
                           Default value: ''
  -out <file>              Output VCF list. If unset, writes to STDOUT.
                           Default value: ''
  -reg <string>            Region of interest in BED format, or comma-separated list of region, e.g. 'chr1:454540-454678,chr2:473457-4734990'.
                           Default value: ''
  -remove_invalid          Removes invalid variants, i.e. invalid position of ref/alt.
                           Default value: 'false'
  -remove_non_ref          Remove '<NON_REF>' entries (used in gVCF files).
                           Default value: 'false'
  -variant_type <string>   Filters by variant type. Possible types are: 'snp','indel','multi-allelic','other'.
                           Default value: ''
  -id <string>             Filter by ID column (regular expression).
                           Default value: ''
  -qual <float>            Filter by QUAL column (minimum).
                           Default value: '0'
  -filter <string>         Filter by FILTER column - keep matches (regular expression).
                           Default value: ''
  -filter_exclude <string> Filter by FILTER column - exclude matches (regular expression).
                           Default value: ''
  -filter_clear            Remove filter entries of all variants, i.e. sets filter to PASS.
                           Default value: 'false'
  -filter_empty            Removes entries with non-empty FILTER column.
                           Default value: 'false'
  -info <string>           Filter by INFO column entries - use ';' as separator for several filters, e.g. 'DP > 5;AO > 2' (spaces are important).
Valid operations are '>','>=','=','!=','<=','<','is','not','contains'.
                           Default value: ''
  -sample <string>         Filter by sample-specific entries - use ';' as separator for several filters, e.g. 'GT is 1/1' (spaces are important).
Valid operations are '>','>=','=','!=','<=','<','is','not','contains'.
                           Default value: ''
  -sample_one_match        If set, a line will pass if one sample passes all filters (default behaviour is that all samples have to pass all filters).
                           Default value: 'false'
  -no_special_chr          Removes variants that are on special chromosomes, i.e. not on autosomes, not on gonosomes and not on chrMT.
                           Default value: 'false'
  -ref <file>              Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                           Default value: ''

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_VcfLeftNormalize

### Tool Description
Normalizes all variants and shifts indels to the left in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfLeftNormalize (2025_12)

Normalizes all variants and shifts indels to the left in a VCF file.

Note: Multi-allelic variants, SNVs, MNPs, complex InDels and invalid variants are skipped!

Optional parameters:
  -in <file>               Input VCF or VCF.GZ file. If unset, reads from STDIN.
                           Default value: ''
  -out <file>              Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT.
                           Default value: ''
  -ref <file>              Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used.
                           Default value: ''
  -compression_level <int> Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written.
                           Default value: '10'
  -stream                  Allows to stream the input and output VCF without loading the whole file into memory. Only supported with uncompressed VCF files.
                           Default value: 'false'
  -right                   Right-normalize VCF instead of left-normalizing it.
                           Default value: 'false'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_VcfReplaceSamples

### Tool Description
Replaces sample identifiers in the VCF header.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfReplaceSamples (2025_12)

Replaces sample identifiers in the VCF header.

Note: the sample ID matching is performed case-sensitive.

Mandatory parameters:
  -ids <string>            Comma-separated list of sample ID pairs in the format 'old1=new1,old2=new2,...'.

Optional parameters:
  -in <file>               Input variant list in VCF or VCF.GZ format. If unset, reads from STDIN.
                           Default value: ''
  -out <file>              Output variant list in VCF format. If unset, writes to STDOUT.
                           Default value: ''
  -compression_level <int> Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written.
                           Default value: '10'

Special parameters:
  --help                   Shows this help and exits.
  --version                Prints version and exits.
  --changelog              Prints changeloge and exits.
  --tdx                    Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file]        Settings override file (no other settings files are used).
```

## ngs-bits_VcfSplit

### Tool Description
Splits a VCF into several chunks

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfSplit (2025_12)

Splits a VCF into several chunks

Mandatory parameters:
  -lines <int>      Number of variant lines per chunk.
  -out <string>     Output VCF base name. Suffixed with chunk number and extension, e.g. '0001.vcf'

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfStreamSort

### Tool Description
Sort entries of a VCF file according to genomic position using a stream. Variants must be grouped by chromosome!

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfStreamSort (2025_12)

Sort entries of a VCF file according to genomic position using a stream. Variants must be grouped by chromosome!

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF list. If unset, writes to STDOUT.
                    Default value: ''
  -n <int>          Number of variants to cache for sorting.
                    Default value: '10000'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfStrip

### Tool Description
Removes unwanted information from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfStrip (2025_12)

Removes unwanted information from a VCF file.

Optional parameters:
  -in <file>        Input VCF file. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output VCF file. If unset, writes to STDOUT.
                    Default value: ''
  -info <string>    Comma-separated list of INFO entries to keep. If unset, all INFO entries are kept.
                    Default value: ''
  -format <string>  Comma-separated list of FORMAT entries to keep. If unset, all FORMAT entries are kept
                    Default value: ''
  -clear_info       Remove all INFO fields
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfSubtract

### Tool Description
Substracts the variants in a VCF from a second VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfSubtract (2025_12)

Substracts the variants in a VCF from a second VCF.

Mandatory parameters:
  -in2 <file>       Variants in VCF format that are remove from 'in'

Optional parameters:
  -in <file>        Input VCF file from which the variants of 'in2' are substracted.
                    Default value: ''
  -out <file>       Output VCF file with variants from 'in2' removed from 'in'.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfToBed

### Tool Description
Converts a VCF file to a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfToBed (2025_12)

Converts a VCF file to a BED file.

For SNVs exactly one base is in the output region.
For insertions the base before and after the insertion is contained.
For deletions the base before the deletion and all deleted bases are contained.

Optional parameters:
  -in <file>        Input variant list in VCF format.
                    Default value: ''
  -out <file>       Output region in BED format.
                    Default value: ''
  -add_chr          Add 'chr' to chromosome names if missing.
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfToBedpe

### Tool Description
Converts a VCF file containing structural variants to BEDPE format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfToBedpe (2025_12)

Converts a VCF file containing structural variants to BEDPE format.

Input can be MANTA oder DELLY VCF files.

Mandatory parameters:
  -in <file>        Input structural variant list in VCF or VCF.GZ format.
  -out <file>       Output structural variant list in BEDPE format.

Optional parameters:
  -no_sort          Do not sort results
                    Default value: 'false'

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## ngs-bits_VcfToTsv

### Tool Description
Converts a VCF file to a tab-separated text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
- **Homepage**: https://github.com/imgag/ngs-bits
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-bits/overview
- **Validation**: PASS

### Original Help Text
```text
VcfToTsv (2025_12)

Converts a VCF file to a tab-separated text file.

Multi-allelic variants are supported. All alternative sequences are stored as a comma-seperated list.
Multi-sample VCFs are supported. For every combination of FORMAT and SAMPLE a seperate column is generated and named in the following way: <SAMPLEID>_<FORMATID>_<format>.

Optional parameters:
  -in <file>        Input variant list in VCF or VCF.GZ format. If unset, reads from STDIN.
                    Default value: ''
  -out <file>       Output variant list in TSV format. If unset, writes to STDOUT.
                    Default value: ''

Special parameters:
  --help            Shows this help and exits.
  --version         Prints version and exits.
  --changelog       Prints changeloge and exits.
  --tdx             Writes a Tool Definition Xml file. The file name is the application name with the suffix '.tdx'.
  --settings [file] Settings override file (no other settings files are used).
```

## Metadata
- **Skill**: generated
