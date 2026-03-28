# fgbio

Tools for working with genomic and high throughput sequencing data.

[View the Project on GitHub](https://github.com/fulcrumgenomics/fgbio)

* [Download **ZIP File**](https://github.com/fulcrumgenomics/fgbio/zipball/gh-pages)
* [Download **TAR Ball**](https://github.com/fulcrumgenomics/fgbio/tarball/gh-pages)
* [View On **GitHub**](https://github.com/fulcrumgenomics/fgbio)

# fgbio tools

The following tools are available in fgbio version 3.1.2.

## Basecalling

Tools for manipulating basecalling data.

| Tool | Description |
| --- | --- |
| [ExtractBasecallingParamsForPicard](/fgbio/tools/latest/ExtractBasecallingParamsForPicard.html) | Extracts sample and library information from an sample sheet for a given lane |
| [ExtractIlluminaRunInfo](/fgbio/tools/latest/ExtractIlluminaRunInfo.html) | Extracts information about an Illumina sequencing run from the RunInfo |

## FASTA

Tools for manipulating FASTA files.

| Tool | Description |
| --- | --- |
| [CollectAlternateContigNames](/fgbio/tools/latest/CollectAlternateContigNames.html) | Collates the alternate contig names from an NCBI assembly report |
| [HardMaskFasta](/fgbio/tools/latest/HardMaskFasta.html) | Converts soft-masked sequence to hard-masked in a FASTA file |
| [SortSequenceDictionary](/fgbio/tools/latest/SortSequenceDictionary.html) | Sorts a sequence dictionary file in the order of another sequence dictionary |
| [UpdateFastaContigNames](/fgbio/tools/latest/UpdateFastaContigNames.html) | Updates the sequence names in a FASTA |
| [UpdateIntervalListContigNames](/fgbio/tools/latest/UpdateIntervalListContigNames.html) | Updates the sequence names in an Interval List file |

## FASTQ

Tools for manipulating FASTQ files.

| Tool | Description |
| --- | --- |
| [DemuxFastqs](/fgbio/tools/latest/DemuxFastqs.html) | Performs sample demultiplexing on FASTQs |
| [FastqToBam](/fgbio/tools/latest/FastqToBam.html) | Generates an unmapped BAM (or SAM or CRAM) file from fastq files |
| [SortFastq](/fgbio/tools/latest/SortFastq.html) | Sorts a FASTQ file |
| [TrimFastq](/fgbio/tools/latest/TrimFastq.html) | Trims reads in one or more line-matched fastq files to a specific read length |

## RNA-Seq

Tools for RNA-Seq data

| Tool | Description |
| --- | --- |
| [CollectErccMetrics](/fgbio/tools/latest/CollectErccMetrics.html) | Collects metrics for ERCC spike-ins for RNA-Seq experiments |
| [EstimateRnaSeqInsertSize](/fgbio/tools/latest/EstimateRnaSeqInsertSize.html) | Computes the insert size for RNA-Seq experiments |

## SAM/BAM

Tools for manipulating SAM, BAM, or related data.

| Tool | Description |
| --- | --- |
| [AnnotateBamWithUmis](/fgbio/tools/latest/AnnotateBamWithUmis.html) | Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular IDs, Molecular barcodes) from separate FASTQ files |
| [AssignPrimers](/fgbio/tools/latest/AssignPrimers.html) | Assigns reads to primers post-alignment |
| [AutoGenerateReadGroupsByName](/fgbio/tools/latest/AutoGenerateReadGroupsByName.html) | Adds read groups to a BAM file for a single sample by parsing the read names |
| [CallOverlappingConsensusBases](/fgbio/tools/latest/CallOverlappingConsensusBases.html) | Consensus calls overlapping bases in read pairs |
| [ClipBam](/fgbio/tools/latest/ClipBam.html) | Clips reads from the same template |
| [DownsampleAndNormalizeBam](/fgbio/tools/latest/DownsampleAndNormalizeBam.html) | Downsamples a BAM in a biased way to a uniform coverage across regions |
| [ErrorRateByReadPosition](/fgbio/tools/latest/ErrorRateByReadPosition.html) | Calculates the error rate by read position on coordinate sorted mapped BAMs |
| [EstimatePoolingFractions](/fgbio/tools/latest/EstimatePoolingFractions.html) | Examines sequence data generated from a pooled sample and estimates the fraction of sequence data coming from each constituent sample |
| [ExtractUmisFromBam](/fgbio/tools/latest/ExtractUmisFromBam.html) | Extracts unique molecular indexes from reads in a BAM file into tags |
| [FilterBam](/fgbio/tools/latest/FilterBam.html) | Filters reads out of a BAM file |
| [FindSwitchbackReads](/fgbio/tools/latest/FindSwitchbackReads.html) | Finds reads where a template switch occurred during library construction |
| [FindTechnicalReads](/fgbio/tools/latest/FindTechnicalReads.html) | Find reads that are from technical or synthetic sequences in a BAM file |
| [RandomizeBam](/fgbio/tools/latest/RandomizeBam.html) | Randomizes the order of reads in a SAM or BAM file |
| [RemoveSamTags](/fgbio/tools/latest/RemoveSamTags.html) | Removes SAM tags from a SAM or BAM file |
| [SetMateInformation](/fgbio/tools/latest/SetMateInformation.html) | Adds and/or fixes mate information on paired-end reads |
| [SortBam](/fgbio/tools/latest/SortBam.html) | Sorts a SAM or BAM file |
| [SplitBam](/fgbio/tools/latest/SplitBam.html) | Splits a BAM into multiple BAMs, one per-read group (or library) |
| [TrimPrimers](/fgbio/tools/latest/TrimPrimers.html) | Trims primers from reads post-alignment |
| [UpdateReadGroups](/fgbio/tools/latest/UpdateReadGroups.html) | Updates one or more read groups and their identifiers |
| [ZipperBams](/fgbio/tools/latest/ZipperBams.html) | Zips together an unmapped and mapped BAM to transfer metadata into the output BAM |

## Unique Molecular Identifiers (UMIs)

Tools for manipulating UMIs & reads tagged with UMIs

| Tool | Description |
| --- | --- |
| [CallCodecConsensusReads](/fgbio/tools/latest/CallCodecConsensusReads.html) | Calls consensus sequences from reads generated from the the CODEC protocol |
| [CallDuplexConsensusReads](/fgbio/tools/latest/CallDuplexConsensusReads.html) | Calls duplex consensus sequences from reads generated from the same double-stranded source molecule |
| [CallMolecularConsensusReads](/fgbio/tools/latest/CallMolecularConsensusReads.html) | Calls consensus sequences from reads with the same unique molecular tag |
| [CollectDuplexSeqMetrics](/fgbio/tools/latest/CollectDuplexSeqMetrics.html) | Collects a suite of metrics to QC duplex sequencing data |
| [CopyUmiFromReadName](/fgbio/tools/latest/CopyUmiFromReadName.html) | Copies the UMI at the end of the BAM’s read name to the RX tag |
| [CorrectUmis](/fgbio/tools/latest/CorrectUmis.html) | Corrects UMIs stored in BAM files when a set of fixed UMIs is in use |
| [FilterConsensusReads](/fgbio/tools/latest/FilterConsensusReads.html) | Filters consensus reads generated by CallMolecularConsensusReads or CallDuplexConsensusReads |
| [GroupReadsByUmi](/fgbio/tools/latest/GroupReadsByUmi.html) | Groups reads together that appear to have come from the same original molecule |
| [ReviewConsensusVariants](/fgbio/tools/latest/ReviewConsensusVariants.html) | Extracts data to make reviewing of variant calls from consensus reads easier |

## Utilities

Various utility programs.

| Tool | Description |
| --- | --- |
| [PickIlluminaIndices](/fgbio/tools/latest/PickIlluminaIndices.html) | Picks a set of molecular indices that should work well together |
| [PickLongIndices](/fgbio/tools/latest/PickLongIndices.html) | Picks a set of molecular indices that have at least a given number of mismatches between them |
| [UpdateDelimitedFileContigNames](/fgbio/tools/latest/UpdateDelimitedFileContigNames.html) | Updates the contig names in columns of a delimited data file (e |
| [UpdateGffContigNames](/fgbio/tools/latest/UpdateGffContigNames.html) | Updates the contig names in a GFF |

## VCF/BCF

Tools for manipulating VCF, BCF, or related data.

| Tool | Description |
| --- | --- |
| [AssessPhasing](/fgbio/tools/latest/AssessPhasing.html) | Assess the accuracy of phasing for a set of variants |
| [DownsampleVcf](/fgbio/tools/latest/DownsampleVcf.html) | Re-genotypes a VCF after downsampling the allele counts |
| [FilterSomaticVcf](/fgbio/tools/latest/FilterSomaticVcf.html) | Applies one or more filters to a VCF of somatic variants |
| [FixVcfPhaseSet](/fgbio/tools/latest/FixVcfPhaseSet.html) | Adds/fixes the phase set (PS) genotype field |
| [HapCutToVcf](/fgbio/tools/latest/HapCutToVcf.html) | Converts the output of ‘HAPCUT’ (‘HapCut1’/’HapCut2’) to a VCF |
| [MakeMixtureVcf](/fgbio/tools/latest/MakeMixtureVcf.html) | Creates a VCF with one sample whose genotypes are a mixture of other samples’ |
| [MakeTwoSampleMixtureVcf](/fgbio/tools/latest/MakeTwoSampleMixtureVcf.html) | Creates a simulated tumor or tumor/normal VCF by in-silico mixing genotypes from two samples |
| [UpdateVcfContigNames](/fgbio/tools/latest/UpdateVcfContigNames.html) | Updates then contig names in a VCF |

Project maintained by [fulcrumgenomics](https://github.com/fulcrumgenomics)

Hosted on GitHub Pages — Theme by [orderedlist](https://github.com/orderedlist)