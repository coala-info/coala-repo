# fgbio-minimal CWL Generation Report

## fgbio-minimal_fgbio

### Tool Description
fgbio is a suite of bioinformatics tools for manipulating sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Total Downloads**: 59.1K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/fulcrumgenomics/fgbio
- **Stars**: N/A
### Original Help Text
```text
Feb 25, 2026 1:32:01 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio-minimal/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio-minimal/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

[31mUSAGE:[0m [1m[31mfgbio[0m [31m[fgbio arguments] [command name] [command arguments][0m
[31mVersion: 3.1.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mfgbio[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Default: SILENT].[0m [32mOptions:
                              STRICT, LENIENT, SILENT.[0m
[0m[32m--cram-ref-fasta=PathToFasta[0m  [36mReference FASTA for CRAM encoding/decoding. [32m[Optional].[0m [32m[0m
[0m
[31mUSAGE:[0m [1m[31mfgbio[0m [31m[command] [arguments][0m
[31mVersion: 3.1.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m
[1m[31mAvailable Sub-Commands:
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mBasecalling:                          Tools for manipulating basecalling data.                                          
[0m[32m    ExtractBasecallingParamsForPicard  [36mExtracts sample and library information from an sample sheet for a given lane.[0m
[0m[32m    ExtractIlluminaRunInfo             [36mExtracts information about an Illumina sequencing run from the RunInfo.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mFASTA:                                Tools for manipulating FASTA files.                                               
[0m[32m    CollectAlternateContigNames        [36mCollates the alternate contig names from an NCBI assembly report.[0m
[0m[32m    HardMaskFasta                      [36mConverts soft-masked sequence to hard-masked in a FASTA file.[0m
[0m[32m    SortSequenceDictionary             [36mSorts a sequence dictionary file in the order of another sequence dictionary.[0m
[0m[32m    UpdateFastaContigNames             [36mUpdates the sequence names in a FASTA.[0m
[0m[32m    UpdateIntervalListContigNames      [36mUpdates the sequence names in an Interval List file.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mFASTQ:                                Tools for manipulating FASTQ files.                                               
[0m[32m    DemuxFastqs                        [36mPerforms sample demultiplexing on FASTQs.[0m
[0m[32m    FastqToBam                         [36mGenerates an unmapped BAM (or SAM or CRAM) file from fastq files.[0m
[0m[32m    SortFastq                          [36mSorts a FASTQ file.[0m
[0m[32m    TrimFastq                          [36mTrims reads in one or more line-matched fastq files to a specific read length.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mRNA-Seq:                              Tools for RNA-Seq data                                                            
[0m[32m    CollectErccMetrics                 [36mCollects metrics for ERCC spike-ins for RNA-Seq experiments.[0m
[0m[32m    EstimateRnaSeqInsertSize           [36mComputes the insert size for RNA-Seq experiments.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mSAM/BAM:                              Tools for manipulating SAM, BAM, or related data.                                 
[0m[32m    AnnotateBamWithUmis                [36mAnnotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecula....[0m
[0m[32m    AssignPrimers                      [36mAssigns reads to primers post-alignment.[0m
[0m[32m    AutoGenerateReadGroupsByName       [36mAdds read groups to a BAM file for a single sample by parsing the read names.[0m
[0m[32m    CallOverlappingConsensusBases      [36mConsensus calls overlapping bases in read pairs.[0m
[0m[32m    ClipBam                            [36mClips reads from the same template.[0m
[0m[32m    DownsampleAndNormalizeBam          [36mDownsamples a BAM in a biased way to a uniform coverage across regions.[0m
[0m[32m    ErrorRateByReadPosition            [36mCalculates the error rate by read position on coordinate sorted mapped BAMs.[0m
[0m[32m    EstimatePoolingFractions           [36mExamines sequence data generated from a pooled sample and estimates the fracti....[0m
[0m[32m    ExtractUmisFromBam                 [36mExtracts unique molecular indexes from reads in a BAM file into tags.[0m
[0m[32m    FilterBam                          [36mFilters reads out of a BAM file.[0m
[0m[32m    FindSwitchbackReads                [36mFinds reads where a template switch occurred during library construction.[0m
[0m[32m    FindTechnicalReads                 [36mFind reads that are from technical or synthetic sequences in a BAM file.[0m
[0m[32m    RandomizeBam                       [36mRandomizes the order of reads in a SAM or BAM file.[0m
[0m[32m    RemoveSamTags                      [36mRemoves SAM tags from a SAM or BAM file.[0m
[0m[32m    SetMateInformation                 [36mAdds and/or fixes mate information on paired-end reads.[0m
[0m[32m    SortBam                            [36mSorts a SAM or BAM file.[0m
[0m[32m    SplitBam                           [36mSplits a BAM into multiple BAMs, one per-read group (or library).[0m
[0m[32m    TrimPrimers                        [36mTrims primers from reads post-alignment.[0m
[0m[32m    UpdateReadGroups                   [36mUpdates one or more read groups and their identifiers.[0m
[0m[32m    ZipperBams                         [36mZips together an unmapped and mapped BAM to transfer metadata into the output ....[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mUnique Molecular Identifiers (UMIs):  Tools for manipulating UMIs & reads tagged with UMIs                              
[0m[32m    CallCodecConsensusReads            [36mCalls consensus sequences from reads generated from the the CODEC protocol.[0m
[0m[32m    CallDuplexConsensusReads           [36mCalls duplex consensus sequences from reads generated from the same _double-st....[0m
[0m[32m    CallMolecularConsensusReads        [36mCalls consensus sequences from reads with the same unique molecular tag.[0m
[0m[32m    CollectDuplexSeqMetrics            [36mCollects a suite of metrics to QC duplex sequencing data.[0m
[0m[32m    CopyUmiFromReadName                [36mCopies the UMI at the end of the BAM's read name to the RX tag.[0m
[0m[32m    CorrectUmis                        [36mCorrects UMIs stored in BAM files when a set of fixed UMIs is in use.[0m
[0m[32m    FilterConsensusReads               [36mFilters consensus reads generated by _CallMolecularConsensusReads_ or _CallDup....[0m
[0m[32m    GroupReadsByUmi                    [36mGroups reads together that appear to have come from the same original molecule.[0m
[0m[32m    ReviewConsensusVariants            [36mExtracts data to make reviewing of variant calls from consensus reads easier.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mUtilities:                            Various utility programs.                                                         
[0m[32m    PickIlluminaIndices                [36mPicks a set of molecular indices that should work well together.[0m
[0m[32m    PickLongIndices                    [36mPicks a set of molecular indices that have at least a given number of mismatch....[0m
[0m[32m    UpdateDelimitedFileContigNames     [36mUpdates the contig names in columns of a delimited data file (e.[0m
[0m[32m    UpdateGffContigNames               [36mUpdates the contig names in a GFF.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mVCF/BCF:                              Tools for manipulating VCF, BCF, or related data.                                 
[0m[32m    AssessPhasing                      [36mAssess the accuracy of phasing for a set of variants.[0m
[0m[32m    DownsampleVcf                      [36mRe-genotypes a VCF after downsampling the allele counts.[0m
[0m[32m    FilterSomaticVcf                   [36mApplies one or more filters to a VCF of somatic variants.[0m
[0m[32m    FixVcfPhaseSet                     [36mAdds/fixes the phase set (PS) genotype field.[0m
[0m[32m    HapCutToVcf                        [36mConverts the output of `HAPCUT` (`HapCut1`/`HapCut2`) to a VCF.[0m
[0m[32m    MakeMixtureVcf                     [36mCreates a VCF with one sample whose genotypes are a mixture of other samples'.[0m
[0m[32m    MakeTwoSampleMixtureVcf            [36mCreates a simulated tumor or tumor/normal VCF by in-silico mixing genotypes fr....[0m
[0m[32m    UpdateVcfContigNames               [36mUpdates then contig names in a VCF.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[31mPersonal:                             Various personal programs (not supported).                                        
[0m[32m    GenerateRegionsFromFasta           [36mGenerates a list of `freebayes`/`bamtools` region specifiers.[0m
[0m[32m    SplitTag                           [36mSplits an optional tag in a SAM or BAM into multiple optional tags.[0m
[0m[32m    StripFastqReadNumbers              [36mRemoves trailing /# from read names in fastq.[0m
[0m[32m    SummarizeGff                       [36mTakes in a RefSeq GFF and produces some summary statistics.[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m
```

