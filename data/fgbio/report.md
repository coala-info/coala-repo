# fgbio CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fgbio_AnnotateBamWithUmis | PASS |  |
| fgbio_AssessPhasing | PASS |  |
| fgbio_AssignPrimers | PASS | synthetic data: primer coordinates planted around real UMI read-pair ends; 45% of pairs were assigned to the two amplicons. |
| fgbio_AutoGenerateReadGroupsByName | PASS | read names taken from the Illumina ID in a real FASTQ header; four read groups were created from flowcell and lane. |
| fgbio_CallCodecConsensusReads | Not completed | no CODEC test data; it runs on duplex-seq read pairs, but that output cannot confirm CODEC consensus calls. |
| fgbio_CallDuplexConsensusReads | PASS |  |
| fgbio_CallMolecularConsensusReads | PASS |  |
| fgbio_CallOverlappingConsensusBases | PASS |  |
| fgbio_ClipBam | PASS |  |
| fgbio_CollectAlternateContigNames | PASS |  |
| fgbio_CollectDuplexSeqMetrics | PASS |  |
| fgbio_CollectErccMetrics | PASS | synthetic data: no ERCC BAM available, so a real RNA-seq BAM was used with a planted concentration file; metrics and plot were written. |
| fgbio_CopyUmiFromReadName | PASS |  |
| fgbio_CorrectUmis | PASS |  |
| fgbio_DemuxFastqs | PASS |  |
| fgbio_DownsampleAndNormalizeBam | PASS |  |
| fgbio_DownsampleVcf | PASS |  |
| fgbio_ErrorRateByReadPosition | PASS |  |
| fgbio_EstimatePoolingFractions | PASS | two real BAMs merged as the pool; estimated fractions 0.48 and 0.52 for the two pooled samples. |
| fgbio_EstimateRnaSeqInsertSize | PASS | real human RNA-seq BAM with a UCSC refGene refFlat for chr6; the tool writes .rnaseq_insert_size files, not the .rna_seq_ names in its help. |
| fgbio_ExtractBasecallingParamsForPicard | PASS |  |
| fgbio_ExtractIlluminaRunInfo | PASS |  |
| fgbio_ExtractUmisFromBam | PASS |  |
| fgbio_FastqToBam | PASS |  |
| fgbio_FilterBam | PASS |  |
| fgbio_FilterConsensusReads | PASS |  |
| fgbio_FilterSomaticVcf | PASS | ran on germline GIAB calls with a matching NA12878 BAM (no somatic test data); ATAP and ERFAP annotations added |
| fgbio_FindSwitchbackReads | PASS |  |
| fgbio_FindTechnicalReads | PASS |  |
| fgbio_FixVcfPhaseSet | PASS |  |
| fgbio_GenerateRegionsFromFasta | PASS | the tool ignores its --output option and prints to standard output, so the CWL captures standard output. |
| fgbio_GroupReadsByUmi | PASS |  |
| fgbio_HapCutToVcf | PASS | 342 variants written and 237 phased, matching the counts in the fgbio test for this data. |
| fgbio_HardMaskFasta | PASS |  |
| fgbio_MakeMixtureVcf | PASS |  |
| fgbio_MakeTwoSampleMixtureVcf | PASS | input limited to bi-allelic sites with genotypes in both samples; the tool crashes on multi-allelic records. |
| fgbio_PickIlluminaIndices | PASS | no input data needed; 8 indices of length 6 were picked. |
| fgbio_PickLongIndices | PASS | no input data needed; 20 indices of length 12 were picked. |
| fgbio_RandomizeBam | PASS | the tool requires its input file to be writable, so the CWL stages the input in the work directory. |
| fgbio_RemoveSamTags | PASS |  |
| fgbio_ReviewConsensusVariants | PASS |  |
| fgbio_SetMateInformation | PASS |  |
| fgbio_SortBam | PASS |  |
| fgbio_SortFastq | PASS |  |
| fgbio_SortSequenceDictionary | PASS |  |
| fgbio_SplitBam | PASS |  |
| fgbio_SplitTag | PASS |  |
| fgbio_StripFastqReadNumbers | PASS |  |
| fgbio_SummarizeGff | PASS | synthetic data: real RefSeq GFF with a stand-in reference holding only the contig name; counts match the GFF gene biotypes. |
| fgbio_TrimFastq | PASS |  |
| fgbio_TrimPrimers | PASS | synthetic data: primer coordinates planted at the ends of real read pairs; primers trimmed and mate fields updated |
| fgbio_UpdateDelimitedFileContigNames | PASS | synthetic data: contig alias 17 added by hand to the dictionary to rename a real VCF from 17 to chr17. |
| fgbio_UpdateFastaContigNames | PASS |  |
| fgbio_UpdateGffContigNames | PASS |  |
| fgbio_UpdateIntervalListContigNames | PASS |  |
| fgbio_UpdateReadGroups | PASS |  |
| fgbio_UpdateVcfContigNames | PASS |  |
| fgbio_ZipperBams | PASS |  |

## fgbio_ExtractBasecallingParamsForPicard

### Tool Description
Extracts sample and library information from an sample sheet for a given lane.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Total Downloads**: 418.9K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/fulcrumgenomics/fgbio
- **Stars**: N/A
### Original Help Text
```text
Feb 25, 2026 1:22:29 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mExtractBasecallingParamsForPicard[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mExtracts sample and library information from an sample sheet for a given lane.

The sample sheet should be an Illumina Experiment Manager sample sheet. The tool writes two files to the output
directory: a barcode parameter file and a library parameter file.

The barcode parameter file is used by Picard's 'ExtractIlluminaBarcodes' and 'CollectIlluminaBasecallingMetrics' to
determine how to match sample barcodes to each read. The parameter file will be written to the output directory with
name 'barcode_params.<lane>.txt'.

The library parameter file is used by Picard's 'IlluminaBasecallsToSam' to demultiplex samples and name the output BAM
file path for each sample output BAM file. The parameter file will be written to the output directory with name
'library_params.<lane>.txt'. The path to each sample's BAM file will be specified in the library parameter file. Each
BAM file will have path '<output>/<sample-name>.<barcode-sequence>.<lane>.bam'.
[0m[31m
[1m[31mExtractBasecallingParamsForPicard[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mThe input sample sheet. [32m[0m
[0m[33m-o DirPath, --output=DirPath[0m  [36mThe output folder to where per-lane parameter files should be written. [32m[0m
[0m[33m-l Int+, --lanes=Int+[0m         [36mThe lane(s) (1-based) for which to write per-lane parameter files. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-b DirPath, --bam-output=DirPath[0m
                              [36mOptional output folder to where per-lane BAM files should be written, otherwise the
                              output directory will be used. [32m[Optional].[0m [32m[0m
[0m
[1m[31melp does not match one of T|True|F|False|Yes|Y|No|N[0m
```


## fgbio_ExtractIlluminaRunInfo

### Tool Description
Extracts information about an Illumina sequencing run from the RunInfo.xml.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:23:34 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mExtractIlluminaRunInfo[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mExtracts information about an Illumina sequencing run from the RunInfo.xml.

The output file will contain a header column and a single column containing the following rows:

  1. 'run_barcode:' the unique identifier for the sequencing run and flowcell, stored as
     '<instrument-name>_<flowcell-barcode>'.
  2. 'flowcell_barcode:' the flowcell barcode.
  3. 'instrument_name': the instrument name.
  4. 'run_date': the date of the sequencing run.
  5. 'read_structure': the description of the logical structure of cycles within the sequencing run, including which
     cycles correspond to sample barcodes, molecular barcodes, cell barcodes, template bases, and bases that should be
     skipped.
  6. 'number_of_lanes': the number of lanes in the flowcell.
[0m[31m
[1m[31mExtractIlluminaRunInfo[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mThe input RunInfo.xml typically found in the run folder. [32m[0m
[0m[33m-o FilePath, --output=FilePath[0m[36mThe output file. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_CollectAlternateContigNames

### Tool Description
Collates the alternate contig names from an NCBI assembly report.
The input is to be the '*.assembly_report.txt' obtained from NCBI.
The output will be a "sequence dictionary", which is a valid SAM file, containing the version header line and one line
per contig. The primary contig name (i.e. '@SQ.SN') is specified with '--primary' option, while alternate names (i.e.
aliases) are specified with the '--alternates' option.
The 'Assigned-Molecule' column, if specified as an '--alternate', will only be used for sequences with 'Sequence-Role'
'assembled-molecule'.
When updating an existing sequence dictionary with '--existing' the primary contig names must match. I.e. the contig
name from the assembly report column specified by '--primary' must match the contig name in the existing sequence
dictionary ('@SQ.SN'). All contigs in the existing sequence dictionary must be present in the assembly report.
Furthermore, contigs in the assembly report not found in the sequence dictionary will be ignored.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:24:22 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mCollectAlternateContigNames[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mCollates the alternate contig names from an NCBI assembly report.

The input is to be the '*.assembly_report.txt' obtained from NCBI.

The output will be a "sequence dictionary", which is a valid SAM file, containing the version header line and one line
per contig. The primary contig name (i.e. '@SQ.SN') is specified with '--primary' option, while alternate names (i.e.
aliases) are specified with the '--alternates' option.

The 'Assigned-Molecule' column, if specified as an '--alternate', will only be used for sequences with 'Sequence-Role'
'assembled-molecule'.

When updating an existing sequence dictionary with '--existing' the primary contig names must match. I.e. the contig
name from the assembly report column specified by '--primary' must match the contig name in the existing sequence
dictionary ('@SQ.SN'). All contigs in the existing sequence dictionary must be present in the assembly report.
Furthermore, contigs in the assembly report not found in the sequence dictionary will be ignored.
[0m[31m
[1m[31mCollectAlternateContigNames[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mInput NCBI assembly report file. [32m[0m
[0m[33m-o PathToSequenceDictionary, --output=PathToSequenceDictionary[0m
                              [36mOutput sequence dictionary file. [32m[0m
[0m[33m-a AssemblyReportColumn+, --alternates=AssemblyReportColumn+[0m
                              [36mThe assembly report column(s) for the alternate contig name(s) [32mOptions:
                              SequenceName, AssignedMolecule, GenBankAccession, RefSeqAccession, UcscName.[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-p AssemblyReportColumn, --primary=AssemblyReportColumn[0m
                              [36mThe assembly report column for the primary contig name. [32m[Default:
                              RefSeqAccession].[0m [32mOptions: SequenceName, AssignedMolecule, GenBankAccession,
                              RefSeqAccession, UcscName.[0m
[0m[32m-s SequenceRole*, --sequence-roles=SequenceRole*[0m
                              [36mOnly output sequences with the given sequence roles. If none given, all sequences will be
                              output. [32m[Optional].[0m [32mOptions: AssembledMolecule, AltScaffold, FixPatch,
                              NovelPatch, UnlocalizedScaffold, UnplacedScaffold.[0m
[0m[32m-d PathToSequenceDictionary, --existing=PathToSequenceDictionary[0m
                              [36mUpdate an existing sequence dictionary file. The primary names must match.
                              [32m[Optional].[0m [32m[0m Cannot be used in conjunction with argument(s):
                              sortBySequencingRole
[0m[32m-x [[true|false]], --allow-mismatching-lengths[[=true|false]][0m
                              [36mAllow mismatching sequence lengths when using an existing sequence dictionary file.
                              [32m[Default: false].[0m [32m[0m
[0m[32m--skip-missing-alternates[[=true|false]][0m
                              [36mSkip contigs that have no alternates [32m[Default: true].[0m [32m[0m
[0m[32m--sort-by-sequencing-role[[=true|false]][0m
                              [36mSort by the sequencing role (only when not updating an existing sequence dictionary
                              file). Uses the order from '--sequence-roles' if provided. [32m[Default: false].[0m
                              [32m[0mCannot be used in conjunction with argument(s): existing (d)
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_HardMaskFasta

### Tool Description
Converts soft-masked sequence to hard-masked in a FASTA file. All lower case bases are converted to Ns, all other bases are left unchanged. Line lengths are also standardized to allow easy indexing with 'samtools faidx'

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:25:07 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mHardMaskFasta[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mConverts soft-masked sequence to hard-masked in a FASTA file. All lower case bases are converted to Ns, all other bases
are left unchanged. Line lengths are also standardized to allow easy indexing with 'samtools faidx'"
[0m[31m
[1m[31mHardMaskFasta[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFasta, --input=PathToFasta[0m
                              [36mInput FASTA file. [32m[0m
[0m[33m-o PathToFasta, --output=PathToFasta[0m
                              [36mOutput FASTA file. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-l Int, --line-length=Int[0m     [36mLine length or sequence lines. [32m[Default: 100].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_SortSequenceDictionary

### Tool Description
Sorts a sequence dictionary file in the order of another sequence dictionary.

The inputs are to two '*.dict' files. One to be sorted, and the other to provide the order for the sorting.

If there is a contig in the input dictionary that is not in the sorting dictionary, that contig will be appended to the
end of the sequence dictionary in the same relative order to other appended contigs as in the input dictionary. Missing
contigs can be omitted by setting '--skip-missing-contigs' to true.

If there is a contig in the sorting dictionary that is not in the input dictionary, that contig will be ignored.

The output will be a sequence dictionary, containing the version header line and one line per contig. The fields of the
entries in this dictionary will be the same as in input, but in the order of '--sort-dictionary'.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:25:53 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mSortSequenceDictionary[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mSorts a sequence dictionary file in the order of another sequence dictionary.

The inputs are to two '*.dict' files. One to be sorted, and the other to provide the order for the sorting.

If there is a contig in the input dictionary that is not in the sorting dictionary, that contig will be appended to the
end of the sequence dictionary in the same relative order to other appended contigs as in the input dictionary. Missing
contigs can be omitted by setting '--skip-missing-contigs' to true.

If there is a contig in the sorting dictionary that is not in the input dictionary, that contig will be ignored.

The output will be a sequence dictionary, containing the version header line and one line per contig. The fields of the
entries in this dictionary will be the same as in input, but in the order of '--sort-dictionary'.
[0m[31m
[1m[31mSortSequenceDictionary[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToSequenceDictionary, --input=PathToSequenceDictionary[0m
                              [36mInput sequence dictionary file to be sorted. [32m[0m
[0m[33m-d PathToSequenceDictionary, --sort-dictionary=PathToSequenceDictionary[0m
                              [36mInput sequence dictionary file containing contigs in the desired sort order. [32m[0m
[0m[33m-o PathToSequenceDictionary, --output=PathToSequenceDictionary[0m
                              [36mOutput sequence dictionary file. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--skip-missing-contigs[[=true|false]][0m
                              [36mSkip input contigs that have no matching contig in the sort dictionary rather than
                              appending to the end of the output dictionary. [32m[Default: false].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_UpdateFastaContigNames

### Tool Description
Updates the sequence names in a FASTA.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

By default, the sort order of the contigs will be the same as the input FASTA. Use the '--sort-by-dict' option to sort
by the input sequence dictionary. Furthermore, the sequence dictionary may contain more contigs than the input FASTA, 
and they wont be used.

Use the '--skip-missing' option to skip contigs in the input FASTA that cannot be renamed (i.e. who are not present in
the input sequence dictionary); missing contigs will not be written to the output FASTA. Finally, use the
'--default-contigs' option to specify an additional FASTA which will be queried to locate contigs not present in the
input FASTA but present in the sequence dictionary.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:26:45 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mUpdateFastaContigNames[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mUpdates the sequence names in a FASTA.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

By default, the sort order of the contigs will be the same as the input FASTA. Use the '--sort-by-dict' option to sort
by the input sequence dictionary. Furthermore, the sequence dictionary may contain more contigs than the input FASTA,
and they wont be used.

Use the '--skip-missing' option to skip contigs in the input FASTA that cannot be renamed (i.e. who are not present in
the input sequence dictionary); missing contigs will not be written to the output FASTA. Finally, use the
'--default-contigs' option to specify an additional FASTA which will be queried to locate contigs not present in the
input FASTA but present in the sequence dictionary.
[0m[31m
[1m[31mUpdateFastaContigNames[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFasta, --input=PathToFasta[0m
                              [36mInput FASTA. [32m[0m
[0m[33m-d PathToSequenceDictionary, --dict=PathToSequenceDictionary[0m
                              [36mThe path to the sequence dictionary with contig aliases. [32m[0m
[0m[33m-o PathToFasta, --output=PathToFasta[0m
                              [36mOutput FASTA. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-l Int, --line-length=Int[0m     [36mLine length or sequence lines. [32m[Default: 100].[0m [32m[0m
[0m[32m--skip-missing[[=true|false]][0m [36mSkip contigs in the FASTA that are not found in the sequence dictionary. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--sort-by-dict[[=true|false]][0m [36mSort the contigs based on the input sequence dictionary. [32m[Default: false].[0m
                              [32m[0m
[0m[32m--default-contigs=PathToFasta[0m [36mAdd sequences from this FASTA when contigs in the sequence dictionary are missing from
                              the input FASTA. [32m[Optional].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_UpdateIntervalListContigNames

### Tool Description
Updates the sequence names in an Interval List file.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

Use '--skip-missing' to ignore intervals where a contig name could not be updated (i.e. missing from the sequence
dictionary).

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:27:33 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mUpdateIntervalListContigNames[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mUpdates the sequence names in an Interval List file.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

Use '--skip-missing' to ignore intervals where a contig name could not be updated (i.e. missing from the sequence
dictionary).
[0m[31m
[1m[31mUpdateIntervalListContigNames[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToIntervals, --input=PathToIntervals[0m
                              [36mInput interval list. [32m[0m
[0m[33m-d PathToSequenceDictionary, --dict=PathToSequenceDictionary[0m
                              [36mThe path to the sequence dictionary with contig aliases. [32m[0m
[0m[33m-o PathToIntervals, --output=PathToIntervals[0m
                              [36mOutput interval list. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--skip-missing[[=true|false]][0m [36mSkip contigs in the interval list that are not found in the sequence dictionary.
                              [32m[Default: false].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_DemuxFastqs

### Tool Description
Performs sample demultiplexing on FASTQs.

Please see https://github.com/fulcrumgenomics/fqtk for a faster and supported replacement

The sample barcode for each sample in the sample sheet will be compared against the sample barcode bases extracted from
the FASTQs, to assign each read to a sample. Reads that do not match any sample within the given error tolerance will
be placed in the 'unmatched' file.

The type of output is specified with the '--output-type' option, and can be BAM ('--output-type Bam'), gzipped FASTQ
('--output-type Fastq'), or both ('--output-type BamAndFastq').

For BAM output, the output directory will contain one BAM file per sample in the sample sheet or metadata CSV file, 
plus a BAM for reads that could not be assigned to a sample given the criteria. The output file names will be the
concatenation of sample id, sample name, and sample barcode bases (expected not observed), delimited by '-'. A metrics
file will also be output providing analogous information to the metric described SampleBarcodeMetric
(http://fulcrumgenomics.github.io/fgbio/metrics/latest/#samplebarcodemetric).

For gzipped FASTQ output, one or more gzipped FASTQs per sample in the sample sheet or metadata CSV file will be
written to the output directory. For paired end data, the output will have the suffix '_R1.fastq.gz' and '_R2.fastq.gz'
for read one and read two respectively. The sample barcode and molecular barcodes (concatenated) will be appended to
the read name and delimited by a colon. If the '--illumina-standards' option is given, then the output read names and
file names will follow the Illumina standards described here
(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).

The output base qualities will be standardized to Sanger/SAM format.

FASTQs and associated read structures for each sub-read should be given:

  * a single fragment read should have one FASTQ and one read structure
  * paired end reads should have two FASTQs and two read structures
  * a dual-index sample with paired end reads should have four FASTQs and four read structures given: two for the two
    index reads, and two for the template reads.

If multiple FASTQs are present for each sub-read, then the FASTQs for each sub-read should be concatenated together
prior to running this tool (ex. 'cat s_R1_L001.fq.gz s_R1_L002.fq.gz > s_R1.fq.gz').

Read structures (https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures) are made up of '<number><operator>'
pairs much like the 'CIGAR' string in BAM files. Four kinds of operators are supported by this tool:

  1. 'T' identifies a template read
  2. 'B' identifies a sample barcode read
  3. 'M' identifies a unique molecular index read
  4. 'S' identifies a set of bases that should be skipped or ignored

The last '<number><operator>' pair may be specified using a '+' sign instead of number to denote "all remaining bases".
This is useful if, e.g., fastqs have been trimmed and contain reads of varying length. Both reads must have template
bases. Any molecular identifiers will be concatenated using the '-' delimiter and placed in the given SAM record tag
('RX' by default). Similarly, the sample barcode bases from the given read will be placed in the 'BC' tag.

Metadata about the samples should be given in either an Illumina Experiment Manager sample sheet or a metadata CSV
file. Formats are described in detail below.

The read structures will be used to extract the observed sample barcode, template bases, and molecular identifiers from
each read. The observed sample barcode will be matched to the sample barcodes extracted from the bases in the sample
metadata and associated read structures.

Sample Sheet
------------

The read group's sample id, sample name, and library id all correspond to the similarly named values in the sample
sheet. Library id will be the sample id if not found, and the platform unit will be the sample name concatenated with
the sample barcode bases delimited by a '.'.

The sample section of the sample sheet should contain information related to each sample with the following columns:

  * Sample_ID: The sample identifier unique to the sample in the sample sheet.
  * Sample_Name: The sample name.
  * Library_ID: The library Identifier. The combination sample name and library identifier should be unique across the
    samples in the sample sheet.
  * Description: The description of the sample, which will be placed in the description field in the output BAM's read
    group. This column may be omitted.
  * Sample_Barcode: The sample barcode bases unique to each sample. The name of the column containing the sample
    barcode can be changed using the '--column-for-sample-barcode' option. If the sample barcode is present across
    multiple reads (ex. dual-index, or inline in both reads of a pair), then the expected barcode bases from each read
    should be concatenated in the same order as the order of the reads' FASTQs and read structures given to this tool.

Metadata CSV
------------

In lieu of a sample sheet, a simple CSV file may be provided with the necessary metadata. This file should contain the
same columns as described above for the sample sheet ('Sample_ID', 'Sample_Name', 'Library_ID', and 'Description').

Example Command Line
--------------------

As an example, if the sequencing run was 2x100bp (paired end) with two 8bp index reads both reading a sample barcode, 
as well as an in-line 8bp sample barcode in read one, the command line would be

  --inputs r1.fq i1.fq i2.fq r2.fq --read-structures 8B92T 8B 8B 100T \
      --metadata SampleSheet.csv --metrics metrics.txt --output output_folder

Output Standards
----------------

The following options affect the output format:

  1. If '--omit-fastq-read-numbers' is specified, then trailing /1 and /2 for R1 and R2 respectively, will not be
     appended to e FASTQ read name. By default they will be appended.
  2. If '--include-sample-barcodes-in-fastq' is specified, then sample barcode will replace the last field in the first
     comment in the FASTQ header, e.g. replace 'NNNNNN' in the header '@Instrument:RunID:FlowCellID:Lane:X:Y
     1:N:0:NNNNNN'
  3. If '--illumina-file-names' is specified, the output files will be named according to the Illumina FASTQ file
     naming conventions:

a. The file extension will be '_R1_001.fastq.gz' for read one, and '_R2_001.fastq.gz' for read two (if paired end). b.
The per-sample output prefix will be '<SampleName>_S<SampleOrdinal>_L<LaneNumber>' (without angle brackets).

Options (1) and (2) require the input FASTQ read names to contain the following elements:

'@<instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<x-pos>:<y-pos> <read>:<is filtered>:<control number>:<index>'

See the Illumina FASTQ conventions for more details.
(https://support.illumina.com/help/BaseSpace_OLH_009008/Content/Source/Informatics/BS/FASTQFiles_Intro_swBS.htm)

Use the following options to upload to Illumina BaseSpace:

'--omit-fastq-read-numbers=true --include-sample-barcodes-in-fastq=false --illumina-file-names=true'

See the Illumina BaseSpace standards described here
(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).

To output with recent Illumina conventions (circa 2021) that match 'bcl2fastq' and 'BCLconvert', use:

'--omit-fastq-read-numbers=true --include-sample-barcodes-in-fastq=true --illumina-file-names=true'

By default all input reads are output. If your input FASTQs contain reads that do not pass filter (as defined by the
Y/N filter flag in the FASTQ comment) these can be filtered out during demultiplexing using the '--omit-failing-reads'
option.

To output only reads that are not control reads, as encoded in the '<control number>' field in the header comment, use
the '--omit-control-reads' flag

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:28:11 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mDemuxFastqs[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mPerforms sample demultiplexing on FASTQs.

Please see https://github.com/fulcrumgenomics/fqtk for a faster and supported replacement

The sample barcode for each sample in the sample sheet will be compared against the sample barcode bases extracted from
the FASTQs, to assign each read to a sample. Reads that do not match any sample within the given error tolerance will
be placed in the 'unmatched' file.

The type of output is specified with the '--output-type' option, and can be BAM ('--output-type Bam'), gzipped FASTQ
('--output-type Fastq'), or both ('--output-type BamAndFastq').

For BAM output, the output directory will contain one BAM file per sample in the sample sheet or metadata CSV file,
plus a BAM for reads that could not be assigned to a sample given the criteria. The output file names will be the
concatenation of sample id, sample name, and sample barcode bases (expected not observed), delimited by '-'. A metrics
file will also be output providing analogous information to the metric described SampleBarcodeMetric
(http://fulcrumgenomics.github.io/fgbio/metrics/latest/#samplebarcodemetric).

For gzipped FASTQ output, one or more gzipped FASTQs per sample in the sample sheet or metadata CSV file will be
written to the output directory. For paired end data, the output will have the suffix '_R1.fastq.gz' and '_R2.fastq.gz'
for read one and read two respectively. The sample barcode and molecular barcodes (concatenated) will be appended to
the read name and delimited by a colon. If the '--illumina-standards' option is given, then the output read names and
file names will follow the Illumina standards described here
(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).

The output base qualities will be standardized to Sanger/SAM format.

FASTQs and associated read structures for each sub-read should be given:

  * a single fragment read should have one FASTQ and one read structure
  * paired end reads should have two FASTQs and two read structures
  * a dual-index sample with paired end reads should have four FASTQs and four read structures given: two for the two
    index reads, and two for the template reads.

If multiple FASTQs are present for each sub-read, then the FASTQs for each sub-read should be concatenated together
prior to running this tool (ex. 'cat s_R1_L001.fq.gz s_R1_L002.fq.gz > s_R1.fq.gz').

Read structures (https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures) are made up of '<number><operator>'
pairs much like the 'CIGAR' string in BAM files. Four kinds of operators are supported by this tool:

  1. 'T' identifies a template read
  2. 'B' identifies a sample barcode read
  3. 'M' identifies a unique molecular index read
  4. 'S' identifies a set of bases that should be skipped or ignored

The last '<number><operator>' pair may be specified using a '+' sign instead of number to denote "all remaining bases".
This is useful if, e.g., fastqs have been trimmed and contain reads of varying length. Both reads must have template
bases. Any molecular identifiers will be concatenated using the '-' delimiter and placed in the given SAM record tag
('RX' by default). Similarly, the sample barcode bases from the given read will be placed in the 'BC' tag.

Metadata about the samples should be given in either an Illumina Experiment Manager sample sheet or a metadata CSV
file. Formats are described in detail below.

The read structures will be used to extract the observed sample barcode, template bases, and molecular identifiers from
each read. The observed sample barcode will be matched to the sample barcodes extracted from the bases in the sample
metadata and associated read structures.

Sample Sheet
------------

The read group's sample id, sample name, and library id all correspond to the similarly named values in the sample
sheet. Library id will be the sample id if not found, and the platform unit will be the sample name concatenated with
the sample barcode bases delimited by a '.'.

The sample section of the sample sheet should contain information related to each sample with the following columns:

  * Sample_ID: The sample identifier unique to the sample in the sample sheet.
  * Sample_Name: The sample name.
  * Library_ID: The library Identifier. The combination sample name and library identifier should be unique across the
    samples in the sample sheet.
  * Description: The description of the sample, which will be placed in the description field in the output BAM's read
    group. This column may be omitted.
  * Sample_Barcode: The sample barcode bases unique to each sample. The name of the column containing the sample
    barcode can be changed using the '--column-for-sample-barcode' option. If the sample barcode is present across
    multiple reads (ex. dual-index, or inline in both reads of a pair), then the expected barcode bases from each read
    should be concatenated in the same order as the order of the reads' FASTQs and read structures given to this tool.

Metadata CSV
------------

In lieu of a sample sheet, a simple CSV file may be provided with the necessary metadata. This file should contain the
same columns as described above for the sample sheet ('Sample_ID', 'Sample_Name', 'Library_ID', and 'Description').

Example Command Line
--------------------

As an example, if the sequencing run was 2x100bp (paired end) with two 8bp index reads both reading a sample barcode,
as well as an in-line 8bp sample barcode in read one, the command line would be

  --inputs r1.fq i1.fq i2.fq r2.fq --read-structures 8B92T 8B 8B 100T \
      --metadata SampleSheet.csv --metrics metrics.txt --output output_folder

Output Standards
----------------

The following options affect the output format:

  1. If '--omit-fastq-read-numbers' is specified, then trailing /1 and /2 for R1 and R2 respectively, will not be
     appended to e FASTQ read name. By default they will be appended.
  2. If '--include-sample-barcodes-in-fastq' is specified, then sample barcode will replace the last field in the first
     comment in the FASTQ header, e.g. replace 'NNNNNN' in the header '@Instrument:RunID:FlowCellID:Lane:Tile:X:Y
     1:N:0:NNNNNN'
  3. If '--illumina-file-names' is specified, the output files will be named according to the Illumina FASTQ file
     naming conventions:

a. The file extension will be '_R1_001.fastq.gz' for read one, and '_R2_001.fastq.gz' for read two (if paired end). b.
The per-sample output prefix will be '<SampleName>_S<SampleOrdinal>_L<LaneNumber>' (without angle brackets).

Options (1) and (2) require the input FASTQ read names to contain the following elements:

'@<instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<x-pos>:<y-pos> <read>:<is filtered>:<control number>:<index>'

See the Illumina FASTQ conventions for more details.
(https://support.illumina.com/help/BaseSpace_OLH_009008/Content/Source/Informatics/BS/FASTQFiles_Intro_swBS.htm)

Use the following options to upload to Illumina BaseSpace:

'--omit-fastq-read-numbers=true --include-sample-barcodes-in-fastq=false --illumina-file-names=true'

See the Illumina BaseSpace standards described here
(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).

To output with recent Illumina conventions (circa 2021) that match 'bcl2fastq' and 'BCLconvert', use:

'--omit-fastq-read-numbers=true --include-sample-barcodes-in-fastq=true --illumina-file-names=true'

By default all input reads are output. If your input FASTQs contain reads that do not pass filter (as defined by the
Y/N filter flag in the FASTQ comment) these can be filtered out during demultiplexing using the '--omit-failing-reads'
option.

To output only reads that are not control reads, as encoded in the '<control number>' field in the header comment, use
the '--omit-control-reads' flag
[0m[31m
[1m[31mDemuxFastqs[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFastq+, --inputs=PathToFastq+[0m
                              [36mOne or more input fastq files each corresponding to a sub-read (ex. index-read, read-one,
                              read-two, fragment). [32m[0m
[0m[33m-o DirPath, --output=DirPath[0m  [36mThe output directory in which to place sample BAMs. [32m[0m
[0m[33m-x FilePath, --metadata=FilePath[0m
                              [36mA file containing the metadata about the samples. [32m[0m
[0m[33m-r ReadStructure+, --read-structures=ReadStructure+[0m
                              [36mThe read structure for each of the FASTQs. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-m FilePath, --metrics=FilePath[0m
                              [36mThe file to which per-barcode metrics are written. If none given, a file named
                              'demux_barcode_metrics.txt' will be written to the output directory. [32m[Optional].[0m
                              [32m[0m
[0m[32m-c String, --column-for-sample-barcode=String[0m
                              [36mThe column name in the sample sheet or metadata CSV for the sample barcode.
                              [32m[Default: Sample_Barcode].[0m [32m[0m
[0m[32m-u String, --unmatched=String[0m [36mOutput BAM file name for the unmatched records. [32m[Default: unmatched.bam].[0m
                              [32m[0m
[0m[32m-q QualityEncoding, --quality-format=QualityEncoding[0m
                              [36mA value describing how the quality values are encoded in the FASTQ. Either Solexa for
                              pre-pipeline 1.3 style scores (solexa scaling + 66), Illumina for pipeline 1.3 and above
                              (phred scaling + 64) or Standard for phred scaled scores with a character shift of 33. If
                              this value is not specified, the quality format will be detected automatically.
                              [32m[Optional].[0m [32mOptions: Solexa, Illumina, Standard.[0m
[0m[32m-t Int, --threads=Int[0m         [36mThe number of threads to use while de-multiplexing. The performance does not increase
                              linearly with the # of threads and seems not to improve beyond 2-4 threads.
                              [32m[Default: 1].[0m [32m[0m
[0m[32m--max-mismatches=Int[0m          [36mMaximum mismatches for a barcode to be considered a match. [32m[Default: 1].[0m
                              [32m[0m
[0m[32m--min-mismatch-delta=Int[0m      [36mMinimum difference between number of mismatches in the best and second best barcodes for
                              a barcode to be considered a match. [32m[Default: 2].[0m [32m[0m
[0m[32m--max-no-calls=Int[0m            [36mMaximum allowable number of no-calls in a barcode read before it is considered
                              unmatchable. [32m[Default: 2].[0m [32m[0m
[0m[32m--sort-order=SortOrder[0m        [36mThe sort order for the output sam/bam file (typically unsorted or queryname).
                              [32m[Default: queryname].[0m [32mOptions: unsorted, queryname, coordinate, duplicate,
                              unknown.[0m
[0m[32m--umi-tag=String[0m              [36mThe SAM tag for any molecular barcode. If multiple molecular barcodes are specified, they
                              will be concatenated and stored here. [32m[Default: RX].[0m [32m[0m
[0m[32m--platform-unit=String[0m        [36mThe platform unit (typically '<flowcell-barcode>-<sample-barcode>.<lane>')
                              [32m[Optional].[0m [32m[0m
[0m[32m--sequencing-center=String[0m    [36mThe sequencing center from which the data originated [32m[Optional].[0m [32m[0m
[0m[32m--predicted-insert-size=Integer[0m
                              [36mPredicted median insert size, to insert into the read group header [32m[Optional].[0m
                              [32m[0m
[0m[32m--platform-model=String[0m       [36mPlatform model to insert into the group header (ex. miseq, hiseq2500, hiseqX)
                              [32m[Optional].[0m [32m[0m
[0m[32m--platform=String[0m             [36mPlatform to insert into the read group header of BAMs (e.g Illumina) [32m[Default:
                              Illumina].[0m [32m[0m
[0m[32m--comments=String*[0m            [36mComment(s) to include in the merged output file's header. [32m[Optional].[0m [32m[0m
[0m[32m--run-date=Iso8601Date[0m        [36mDate the run was produced, to insert into the read group header [32m[Optional].[0m
                              [32m[0m
[0m[32m--output-type=OutputType[0m      [36mThe type of outputs to produce. [32m[Optional].[0m [32mOptions: Fastq, Bam,
                              BamAndFastq.[0m
[0m[32m--include-all-bases-in-fastqs[[=true|false]][0m
                              [36mOutput all bases (i.e. all sample barcode, molecular barcode, skipped, and template
                              bases) for every read with template bases (ex. read one and read two) as defined by the
                              corresponding read structure(s). [32m[Default: false].[0m [32m[0m
[0m[32m--omit-fastq-read-numbers[[=true|false]][0m
                              [36mDo not include trailing /1 or /2 for R1 and R2 in the FASTQ read name. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--include-sample-barcodes-in-fastq[[=true|false]][0m
                              [36mInsert the sample barcode into the FASTQ header. [32m[Default: false].[0m [32m[0m
[0m[32m--illumina-file-names[[=true|false]][0m
                              [36mName the output files according to the Illumina file name standards. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--omit-failing-reads[[=true|false]][0m
                              [36mKeep only passing filter reads if true, otherwise keep all reads. Passing filter reads
                              are determined from the comment in the FASTQ header. [32m[Default: false].[0m [32m[0m
[0m[32m--omit-control-reads[[=true|false]][0m
                              [36mDo not keep reads identified as control if true, otherwise keep all reads. Control reads
                              are determined from the comment in the FASTQ header. [32m[Default: false].[0m [32m[0m
[0m[32m--mask-bases-below-quality=Int[0m[36mMask bases with a quality score below the specified threshold as Ns [32m[Default:
                              0].[0m [32m[0m
[0m
[1m[31mException: MissingArgumentException
Error: Argument 'inputs' must be specified at least once.[0m
```


## fgbio_FastqToBam

### Tool Description
Generates an unmapped BAM (or SAM or CRAM) file from fastq files. Takes in one or more fastq files (optionally gzipped), each representing a different sequencing read (e.g. R1, R2, I1 or I2) and can use a set of read structures to allocate bases in those reads to template reads, sample indices, unique molecular indices, cell barcodes, or to designate bases to be skipped over.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:28:58 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mFastqToBam[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mGenerates an unmapped BAM (or SAM or CRAM) file from fastq files. Takes in one or more fastq files (optionally
gzipped), each representing a different sequencing read (e.g. R1, R2, I1 or I2) and can use a set of read structures to
allocate bases in those reads to template reads, sample indices, unique molecular indices, cell barcodes, or to
designate bases to be skipped over.

Read structures are made up of '<number><operator>' pairs much like the CIGAR string in BAM files. Five kinds of
operators are recognized:

  1. 'T' identifies a template read
  2. 'B' identifies a sample barcode read
  3. 'M' identifies a unique molecular index read
  4. 'C' identifies a cell barcode read
  5. 'S' identifies a set of bases that should be skipped or ignored

The last '<number><operator>' pair may be specified using a '+' sign instead of number to denote "all remaining bases".
This is useful if, e.g., FASTQs have been trimmed and contain reads of varying length. For example to convert a
paired-end run with an index read and where the first 5 bases of R1 are a UMI and the second five bases are
monotemplate you might specify:

  --input r1.fq r2.fq i1.fq --read-structures 5M5S+T +T +B

Alternative if you know your reads are of fixed length you could specify:

  --input r1.fq r2.fq i1.fq --read-structures 5M5S65T 75T 8B

For more information on read structures see the Read Structure Wiki Page
(https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures)

UMIs may be extracted from the read sequences, the read names, or both. If '--extract-umis-from-read-names' is
specified, any UMIs present in the read names are extracted; read names are expected to be ':'-separated with any UMIs
present in the 8th field. If this option is specified, the '--umi-qual-tag' option may not be used as qualities are not
available for UMIs in the read name. If UMI segments are present in the read structures those will also be extracted.
If UMIs are present in both, the final UMIs are constructed by first taking the UMIs from the read names, then adding a
hyphen, then the UMIs extracted from the reads.

The same number of input files and read structures must be provided, with one exception: if supplying exactly 1 or 2
fastq files, both of which are solely template reads, no read structures need be provided.

The output file can be sorted by queryname using the '--sort-order' option; the default is to produce a BAM with reads
in the same order as they appear in the fastq file.
[0m[31m
[1m[31mFastqToBam[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFastq+, --input=PathToFastq+[0m
                              [36mFastq files corresponding to each sequencing read (e.g. R1, I1, etc.). [32m[0m
[0m[33m-o PathToBam, --output=PathToBam[0m
                              [36mThe output SAM or BAM file to be written. [32m[0m
[0m[33m--sample=String[0m               [36mThe name of the sequenced sample. [32m[0m
[0m[33m--library=String[0m              [36mThe name/ID of the sequenced library. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-r ReadStructure*, --read-structures=ReadStructure*[0m
                              [36mRead structures, one for each of the FASTQs. [32m[Optional].[0m [32m[0m
[0m[32m-s [[true|false]], --sort[[=true|false]][0m
                              [36mIf true, queryname sort the BAM file, otherwise preserve input order. [32m[Default:
                              false].[0m [32m[0m
[0m[32m-u String, --umi-tag=String[0m   [36mTag in which to store molecular barcodes/UMIs. [32m[Default: RX].[0m [32m[0m
[0m[32m-q String, --umi-qual-tag=String[0m
                              [36mTag in which to store molecular barcode/UMI qualities. [32m[Optional].[0m [32m[0m
[0m[32m-c String, --cell-tag=String[0m  [36mTag in which to store the cellular barcodes. [32m[Default: CB].[0m [32m[0m
[0m[32m-C String, --cell-qual-tag=String[0m
                              [36mTag in which to store the cellular barcodes qualities. [32m[Optional].[0m [32m[0m
[0m[32m-Q [[true|false]], --store-sample-barcode-qualities[[=true|false]][0m
                              [36mStore the sample barcode qualities in the QT Tag. [32m[Default: false].[0m [32m[0m
[0m[32m-n [[true|false]], --extract-umis-from-read-names[[=true|false]][0m
                              [36mExtract UMI(s) from read names and prepend to UMIs from reads. [32m[Default: false].[0m
                              [32m[0m
[0m[32m--read-group-id=String[0m        [36mRead group ID to use in the file header. [32m[Default: A].[0m [32m[0m
[0m[32m-b String, --barcode=String[0m   [36mLibrary or Sample barcode sequence. [32m[Optional].[0m [32m[0m
[0m[32m--platform=String[0m             [36mSequencing Platform. [32m[Default: illumina].[0m [32m[0m
[0m[32m--platform-unit=String[0m        [36mPlatform unit (e.g. '<flowcell-barcode>.<lane>.<sample-barcode>') [32m[Optional].[0m
                              [32m[0m
[0m[32m--platform-model=String[0m       [36mPlatform model to insert into the group header (ex. miseq, hiseq2500, hiseqX)
                              [32m[Optional].[0m [32m[0m
[0m[32m--sequencing-center=String[0m    [36mThe sequencing center from which the data originated [32m[Optional].[0m [32m[0m
[0m[32m--predicted-insert-size=Integer[0m
                              [36mPredicted median insert size, to insert into the read group header [32m[Optional].[0m
                              [32m[0m
[0m[32m--description=String[0m          [36mDescription of the read group. [32m[Optional].[0m [32m[0m
[0m[32m--comment=String*[0m             [36mComment(s) to include in the output file's header. [32m[Optional].[0m [32m[0m
[0m[32m--run-date=Iso8601Date[0m        [36mDate the run was produced, to insert into the read group header [32m[Optional].[0m
                              [32m[0m
[0m
[1m[31mException: MissingArgumentException
Error: Argument 'input' must be specified at least once.[0m
```


## fgbio_SortFastq

### Tool Description
Sorts a FASTQ file. Sorts the records in a FASTQ file based on the lexicographic ordering of their read names. Input and output files can be either uncompressed or gzip-compressed.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:29:45 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mSortFastq[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mSorts a FASTQ file. Sorts the records in a FASTQ file based on the lexicographic ordering of their read names. Input
and output files can be either uncompressed or gzip-compressed.
[0m[31m
[1m[31mSortFastq[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFastq, --input=PathToFastq[0m
                              [36mInput fastq file. [32m[0m
[0m[33m-o PathToFastq, --output=PathToFastq[0m
                              [36mOutput fastq file. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-m Int, --max-records-in-ram=Int[0m
                              [36mMaximum records to keep in RAM at one time. [32m[Default: 500000].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgbio_TrimFastq

### Tool Description
Trims reads in one or more line-matched fastq files to a specific read length. The individual fastq files are expected to have the same set of reads, as would be the case with an 'r1.fastq' and 'r2.fastq' file for the same sample.

Optionally supports dropping of reads across all files when one or more reads is already shorter than the desired trim length.

Input and output fastq files may be gzipped.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:30:32 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
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
[1m[31mTrimFastq[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mTrims reads in one or more line-matched fastq files to a specific read length. The individual fastq files are expected
to have the same set of reads, as would be the case with an 'r1.fastq' and 'r2.fastq' file for the same sample.

Optionally supports dropping of reads across all files when one or more reads is already shorter than the desired trim
length.

Input and output fastq files may be gzipped.
[0m[31m
[1m[31mTrimFastq[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToFastq+, --input=PathToFastq+[0m
                              [36mOne or more input fastq files. [32m[0m
[0m[33m-o PathToFastq+, --output=PathToFastq+[0m
                              [36mA matching number of output fastq files. [32m[0m
[0m[33m-l Int+, --length=Int+[0m        [36mLength to trim reads to (either one per input fastq file, or one for all). [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-x [[true|false]], --exclude[[=true|false]][0m
                              [36mExclude reads below the trim length. [32m[Default: false].[0m [32m[0m
[0m
[1m[31mException: MissingArgumentException
Error: Argument 'input' must be specified at least once.[0m
```


## fgbio_GroupReadsByUmi

### Tool Description
Groups reads together that appear to have come from the same original molecule.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

GroupReadsByUmi
------------------------------------------------------------------------------------------------------------------------
Groups reads together that appear to have come from the same original molecule. Reads are grouped by template, and then
templates are sorted by the 5' mapping positions of the reads from the template, used from earliest mapping position to
latest. Reads that have the same end positions are then sub-grouped by UMI sequence.

Accepts reads in any order (including 'unsorted') and outputs reads sorted by:

  1. The lower genome coordinate of the two outer ends of the templates (strand-aware)
  2. The sequencing library
  3. The assigned UMI tag
  4. Read Name

It is recommended to sort the reads into template-coordinate (i.e. 'SO:unsorted GO:query
SS:unsorted:template-coordinate') prior to running this tool to avoid this tool re-sorting the input. It is recommended
to use 'samtools sort --template-coordinate --threads $(nrpoc)' for the pre-sorting. The output will always be written
in template-coordinate order.

During grouping, reads and templates are filtered out as follows:

  1. Templates are filtered if all reads for the template are unmapped
  2. Templates are filtered if any non-secondary, non-supplementary read has mapping quality < 'min-map-q'
  3. Templates are filtered if any UMI sequence contains one or more 'N' bases
  4. Templates are filtered if '--min-umi-length' is specified and the UMI does not meet the length requirement
  5. Records are filtered out if flagged as either secondary or supplementary

Grouping of UMIs is performed by one of four strategies:

  1. identity: only reads with identical UMI sequences are grouped together. This strategy may be useful for evaluating
     data, but should generally be avoided as it will generate multiple UMI groups per original molecule in the presence
     of errors.
  2. edit: reads are clustered into groups such that each read within a group has at least one other read in the group
     with <= edits differences and there are inter-group pairings with <= edits differences. Effective when there are
     small numbers of reads per UMI, but breaks down at very high coverage of UMIs.
  3. adjacency: a version of the directed adjacency method described in umi_tools (http://dx.doi.org/10.1101/051755)
     that allows for errors between UMIs but only when there is a count gradient.
  4. paired: similar to adjacency but for methods that produce template such that a read with A-B is related to but not
     identical to a read with B-A. Expects the UMI sequences to be stored in a single SAM tag separated by a hyphen (e.g.
     'ACGT-CCGG') and allows for one of the two UMIs to be absent (e.g. 'ACGT-' or '-ACGT'). The molecular IDs produced
     have more structure than for single UMI strategies and are of the form '{base}/{A|B}'. E.g. two UMI pairs would be
     mapped as follows AAAA-GGGG -> 1/A, GGGG-AAAA -> 1/B.

Strategies 'edit', 'adjacency', and 'paired' make use of the '--edits' parameter to control the matching of
non-identical UMIs.

By default, all UMIs must be the same length. If '--min-umi-length=len' is specified then reads that have a UMI shorter
than 'len' will be discarded, and when comparing UMIs of different lengths, the first len bases will be compared, where
'len' is the length of the shortest UMI. The UMI length is the number of ACGT bases in the UMI (i.e. does not count
dashes and other non-ACGT characters). This option is not implemented for reads with UMI pairs (i.e. using the paired
assigner).

If the '--mark-duplicates' option is given, reads will also have their duplicate flag set in the BAM file. Each
tag-family is treated separately, and a single template within the tag family is chosen to be the "unique" template and
marked as non-duplicate, while all other templates in the tag family are then marked as duplicate. There are a few
limitations of duplicate-marking mode (vs. e.g. Picard MarkDuplicates):

  1. read pairs with one unmapped read are duplicate-marked independently from read pairs with both reads mapped
  2. secondary and supplementary records are discarded

Note: the '--min-map-q' parameter defaults to 0 in duplicate marking mode and 1 otherwise, and is directly settable on
the command line.

Multi-threaded operation is supported via the '--threads/-@' option. This only applies to the Adjacency and Paired
strategies. Additionally the only operation that is multi-threaded is the comparisons of UMIs at the same genomic
position. Running with e.g. '--threads 8' can provide a substantial reduction in runtime when there are many UMIs
observed at the same genomic location, such as can occur in amplicon sequencing or ultra-deep coverage data.

GroupReadsByUmi Arguments:
------------------------------------------------------------------------------------------------------------------------
-s Strategy, --strategy=Strategy
                              The UMI assignment strategy. Options: Identity, Edit, Adjacency, Paired.
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-i PathToBam, --input=PathToBam
                              The input BAM file. [Default: /dev/stdin]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathToBam, --output=PathToBam
                              The output BAM file. [Default: /dev/stdout]. 
-f FilePath, --family-size-histogram=FilePath
                              Optional output of tag family size counts. [Optional]. 
-g FilePath, --grouping-metrics=FilePath
                              Optional output of UMI grouping metrics. [Optional]. 
-t String, --raw-tag=String   The tag containing the raw UMI. [Default: RX]. 
-T String, --assign-tag=StringThe output tag for UMI grouping. [Default: MI]. 
-c String, --cell-tag=String  The tag containing the cell barcode. [Default: CB]. 
-d [[true|false]], --mark-duplicates[[=true|false]]
                              Turn on duplicate marking mode. [Default: false]. 
-m Int, --min-map-q=Int       Minimum mapping quality for mapped reads. [Optional]. 
-n [[true|false]], --include-non-pf-reads[[=true|false]]
                              Include non-PF reads. [Default: false]. 
-e Int, --edits=Int           The allowable number of edits between UMIs. [Default: 1]. 
-l Int, --min-umi-length=Int  The minimum UMI length. If not specified then all UMIs must have the same length,
                              otherwise discard reads with UMIs shorter than this length and allow for differing UMI
                              lengths. [Optional]. 
-@ Int, --threads=Int         Number of threads to use when comparing UMIs. Only recommended for amplicon or similar
                              data. [Default: 1].
```


## fgbio_CallMolecularConsensusReads

### Tool Description
Calls consensus sequences from reads with the same unique molecular tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

CallMolecularConsensusReads
------------------------------------------------------------------------------------------------------------------------
Calls consensus sequences from reads with the same unique molecular tag.

Reads with the same unique molecular tag are examined base-by-base to assess the likelihood of each base in the source
molecule. The likelihood model is as follows:

  1. First, the base qualities are adjusted. The base qualities are assumed to represent the probability of a
     sequencing error (i.e. the sequencer observed the wrong base present on the cluster/flowcell/well). The base quality
     scores are converted to probabilities incorporating a probability representing the chance of an error from the time
     the unique molecular tags were integrated to just prior to sequencing. The resulting probability is the error rate of
     all processes from right after integrating the molecular tag through to the end of sequencing.
  2. Next, a consensus sequence is called for all reads with the same unique molecular tag base-by-base. For a given
     base position in the reads, the likelihoods that an A, C, G, or T is the base for the underlying source molecule
     respectively are computed by multiplying the likelihood of each read observing the base position being considered.
     The probability of error (from 1.) is used when the observed base does not match the hypothesized base for the
     underlying source molecule, while one minus that probability is used otherwise. The computed likelihoods are
     normalized by dividing them by the sum of all four likelihoods to produce a posterior probability, namely the
     probability that the source molecule was an A, C, G, or T from just after integrating molecular tag through to
     sequencing, given the observations. The base with the maximum posterior probability as the consensus call, and the
     posterior probability is used as its raw base quality.
  3. Finally, the consensus raw base quality is modified by incorporating the probability of an error prior to
     integrating the unique molecular tags. Therefore, the probability used for the final consensus base quality is the
     posterior probability of the source molecule having the consensus base given the observed reads with the same
     molecular tag, all the way from sample extraction and through sample and library preparation, through preparing the
     library for sequencing (e.g. amplification, target selection), and finally, through sequencing.

This tool assumes that reads with the same tag are grouped together (consecutive in the file). Also, this tool calls
each end of a pair independently, and does not jointly call bases that overlap within a pair. Insertion or deletion
errors in the reads are not considered in the consensus model.

The consensus reads produced are unaligned, due to the difficulty and error-prone nature of inferring the conesensus
alignment. Consensus reads should therefore be aligned after, which should not be too expensive as likely there are far
fewer consensus reads than input raw raws. Please see how best to use this tool within the best-practice pipeline:
https://github.com/fulcrumgenomics/fgbio/blob/main/docs/best-practice-consensus-pipeline.md

Particular attention should be paid to setting the '--min-reads' parameter as this can have a dramatic effect on both
results and runtime. For libraries with low duplication rates (e.g. 100-300X exomes libraries) in which it is desirable
to retain singleton reads while making consensus reads from sets of duplicates, '--min-reads=1' is appropriate. For
libraries with high duplication rates where it is desirable to only produce consensus reads supported by 2+ reads to
allow error correction, '--min-reads=2' or higher is appropriate. After generation, consensus reads can be further
filtered using the FilterConsensusReads tool. As such it is always safe to run with '--min-reads=1' and filter later,
but filtering at this step can improve performance significantly.

Consensus reads have a number of additional optional tags set in the resulting BAM file. The tags break down into those
that are single-valued per read:

  consensus depth      [cD] (int)  : the maximum depth of raw reads at any point in the consensus read
  consensus min depth  [cM] (int)  : the minimum depth of raw reads at any point in the consensus read
  consensus error rate [cE] (float): the fraction of bases in raw reads disagreeing with the final consensus calls

And those that have a value per base:

  consensus depth  [cd] (short[]): the count of bases contributing to the consensus read at each position
  consensus errors [ce] (short[]): the number of bases from raw reads disagreeing with the final consensus base

The per base depths and errors are both capped at 32,767. In all cases no-calls ('N's) and bases below the
'--min-input-base-quality' are not counted in tag value calculations.

CallMolecularConsensusReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file to write consensus reads. 
-M Int, --min-reads=Int       The minimum number of reads to produce a consensus base. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r PathToBam, --rejects=PathToBam
                              Optional output SAM or BAM file to write reads not used. [Optional]. 
-s FilePath, --stats=FilePath Optional output text file of key consensus calling statistics. [Optional].
                              
-t String, --tag=String       The SAM attribute with the unique molecule tag. [Default: MI]. 
-p String, --read-name-prefix=String
                              The Prefix all consensus read names [Optional]. 
-R String, --read-group-id=String
                              The new read group ID for all the consensus reads. [Default: A]. 
-1 PhredScore, --error-rate-pre-umi=PhredScore
                              The Phred-scaled error rate for an error prior to the UMIs being integrated.
                              [Default: 45]. 
-2 PhredScore, --error-rate-post-umi=PhredScore
                              The Phred-scaled error rate for an error post the UMIs have been integrated.
                              [Default: 40]. 
-m PhredScore, --min-input-base-quality=PhredScore
                              Ignore bases in raw reads that have Q below this value. [Default: 10]. 
--max-reads=Int               The maximum number of reads to use when building a consensus. If more than this many
                              reads are present in a tag family, the family is randomly downsampled to exactly
                              max-reads reads. [Optional]. 
-B [[true|false]], --output-per-base-tags[[=true|false]]
                              If true produce tags on consensus reads that contain per-base information. [Default:
                              true]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output, the same as the input if not given. [Optional].
                              Options: Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted,
                              Unknown.
-D [[true|false]], --debug[[=true|false]]
                              Turn on debug logging. [Default: false]. 
-c String, --cell-tag=String  Tag containing the cellular barcodes. [Default: CB]. 
--threads=Int                 The number of threads to use while consensus calling. [Default: 1]. 
--consensus-call-overlapping-bases[[=true|false]]
                              Consensus call overlapping bases in mapped paired end reads [Default: true].
```


## fgbio_CallDuplexConsensusReads

### Tool Description
Calls duplex consensus sequences from reads generated from the same double-stranded source molecule.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

CallDuplexConsensusReads
------------------------------------------------------------------------------------------------------------------------
Calls duplex consensus sequences from reads generated from the same double-stranded source molecule. Prior to running
this tool, read must have been grouped with 'GroupReadsByUmi' using the 'paired' strategy. Doing so will apply (by
default) MI tags to all reads of the form '*/A' and '*/B' where the /A and /B suffixes with the same identifier denote
reads that are derived from opposite strands of the same source duplex molecule.

Reads from the same unique molecule are first partitioned by source strand and assembled into single strand consensus
molecules as described by CallMolecularConsensusReads. Subsequently, for molecules that have at least one observation
of each strand, duplex consensus reads are assembled by combining the evidence from the two single strand consensus
reads.

Because of the nature of duplex sequencing, this tool does not support fragment reads - if found in the input they are
ignored. Similarly, read pairs for which consensus reads cannot be generated for one or other read (R1 or R2) are
omitted from the output.

The consensus reads produced are unaligned, due to the difficulty and error-prone nature of inferring the conesensus
alignment. Consensus reads should therefore be aligned after, which should not be too expensive as likely there are far
fewer consensus reads than input raw raws. Please see how best to use this tool within the best-practice pipeline:
https://github.com/fulcrumgenomics/fgbio/blob/main/docs/best-practice-consensus-pipeline.md

Consensus reads have a number of additional optional tags set in the resulting BAM file. The tag names follow a pattern
where the first letter (a, b or c) denotes that the tag applies to the first single strand consensus (a), second
single-strand consensus (b) or the final duplex consensus (c). The second letter is intended to capture the meaning of
the tag (e.g. d=depth, m=min depth, e=errors/error-rate) and is upper case for values that are one per read and lower
case for values that are one per base.

The tags break down into those that are single-valued per read:

  consensus depth      [aD,bD,cD] (int)  : the maximum depth of raw reads at any point in the consensus reads
  consensus min depth  [aM,bM,cM] (int)  : the minimum depth of raw reads at any point in the consensus reads
  consensus error rate [aE,bE,cE] (float): the fraction of bases in raw reads disagreeing with the final consensus calls

And those that have a value per base (duplex values are not generated, but can be generated by summing):

  consensus depth  [ad,bd] (short[]): the count of bases contributing to each single-strand consensus read at each position
  consensus errors [ae,be] (short[]): the count of bases from raw reads disagreeing with the final single-strand consensus base
  consensus errors [ac,bc] (string): the single-strand consensus bases
  consensus errors [aq,bq] (string): the single-strand consensus qualities

The per base depths and errors are both capped at 32,767. In all cases no-calls (Ns) and bases below the
min-input-base-quality are not counted in tag value calculations.

The --min-reads option can take 1-3 values similar to 'FilterConsensusReads'. For example:

  CallDuplexConsensusReads ... --min-reads 10 5 3

If fewer than three values are supplied, the last value is repeated (i.e. '5 4' -> '5 4 4' and '1' -> '1 1 1'. The
first value applies to the final consensus read, the second value to one single-strand consensus, and the last value to
the other single-strand consensus. It is required that if values two and three differ, the more stringent value comes
earlier.

CallDuplexConsensusReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file to write consensus reads. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r PathToBam, --rejects=PathToBam
                              Optional output SAM or BAM file to write reads not used. [Optional]. 
-s FilePath, --stats=FilePath Optional output text file of key consensus calling statistics. [Optional].
                              
-p String, --read-name-prefix=String
                              The prefix all consensus read names [Optional]. 
-R String, --read-group-id=String
                              The new read group ID for all the consensus reads. [Default: A]. 
-1 PhredScore, --error-rate-pre-umi=PhredScore
                              The Phred-scaled error rate for an error prior to the UMIs being integrated.
                              [Default: 45]. 
-2 PhredScore, --error-rate-post-umi=PhredScore
                              The Phred-scaled error rate for an error post the UMIs have been integrated.
                              [Default: 40]. 
-m PhredScore, --min-input-base-quality=PhredScore
                              Ignore bases in raw reads that have Q below this value. [Default: 10]. 
-t [[true|false]], --trim[[=true|false]]
                              If true, quality trim input reads in addition to masking low Q bases. [Default:
                              false]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output, the same as the input if not given. [Optional].
                              Options: Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted,
                              Unknown.
-M Int{1..3}, --min-reads=Int{1..3}
                              The minimum number of input reads to a consensus read. [Default: 1]. 
--max-reads-per-strand=Int    The maximum number of reads to use when building a single-strand consensus. If more than
                              this many reads are present in a tag family, the family is randomly downsampled to
                              exactly max-reads reads. [Optional]. 
-c String, --cell-tag=String  Tag containing the cellular barcodes. [Default: CB]. 
--threads=Int                 The number of threads to use while consensus calling. [Default: 1]. 
--consensus-call-overlapping-bases[[=true|false]]
                              Consensus call overlapping bases in mapped paired end reads [Default: true].
```


## fgbio_CallCodecConsensusReads

### Tool Description
Calls consensus sequences from reads generated from the the CODEC protocol.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

CallCodecConsensusReads
------------------------------------------------------------------------------------------------------------------------
Calls consensus sequences from reads generated from the the CODEC protocol. For more information on the CODEC
sequencing protocol and the resulting data please refer to Bae et al 20231.

Prior to running this tool, reads must have been grouped with 'GroupReadsByUmi' using the 'adjacency' or 'identity'
strategy (NOT 'paired').

Reads from the same original duplex are collected, and the R1s and R2s assembled into single strand consensus reads as
described by 'CallMolecularConsensusReads'. Subsequently, a single consensus read is generated including both any
single-strand regions as well as the double-stranded region of the template.

The consensus reads produced are unaligned, due to the difficulty and error-prone nature of inferring the consensus
alignment. Consensus reads should therefore be aligned after, which should not be too expensive as likely there are
significantly fewer consensus reads than input raw reads. Please see how best to use this tool within the best-practice
pipeline: https://github.com/fulcrumgenomics/fgbio/blob/main/docs/best-practice-consensus-pipeline.md

Consensus reads have a number of additional optional tags set in the resulting BAM file. The tag names follow a pattern
where the first letter (a, b or c) denotes that the tag applies to the first single strand consensus (a), second
single-strand consensus (b) or the final duplex consensus (c). The second letter is intended to capture the meaning of
the tag (e.g. d=depth, m=min depth, e=errors/error-rate) and is upper case for values that are one per read and lower
case for values that are one per base.

The tags break down into those that are single-valued per read:

  consensus depth      [aD,bD,cD] (int)  : the maximum depth of raw reads at any point in the consensus reads
  consensus min depth  [aM,bM,cM] (int)  : the minimum depth of raw reads at any point in the consensus reads
  consensus error rate [aE,bE,cE] (float): the fraction of bases in raw reads disagreeing with the final consensus calls

And those that have a value per base (duplex values are not generated, but can be generated by summing):

  consensus depth  [ad,bd] (short[]): the count of bases contributing to each single-strand consensus read at each position
  consensus errors [ae,be] (short[]): the count of bases from raw reads disagreeing with the final single-strand consensus base
  consensus errors [ac,bc] (string): the single-strand consensus bases
  consensus errors [aq,bq] (string): the single-strand consensus qualities

The per base depths and error counts are both capped at 32,767. In all cases no-calls (Ns) and bases below the
min-input-base-quality are not counted in tag value calculations.

1 https://doi.org/10.1038/s41588-023-01376-0

CallCodecConsensusReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file to write consensus reads. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r PathToBam, --rejects=PathToBam
                              Optional output SAM or BAM file to write reads not used. [Optional]. 
-s FilePath, --stats=FilePath Optional output text file of key consensus calling statistics. [Optional].
                              
-p String, --read-name-prefix=String
                              The prefix all consensus read names [Optional]. 
-R String, --read-group-id=String
                              The new read group ID for all the consensus reads. [Default: A]. 
-1 PhredScore, --error-rate-pre-umi=PhredScore
                              The Phred-scaled error rate for an error prior to the UMIs being integrated.
                              [Default: 45]. 
-2 PhredScore, --error-rate-post-umi=PhredScore
                              The Phred-scaled error rate for an error post the UMIs have been integrated.
                              [Default: 40]. 
-m PhredScore, --min-input-base-quality=PhredScore
                              Ignore bases in raw reads that have Q below this value. [Default: 10]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output, the same as the input if not given. [Optional].
                              Options: Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted,
                              Unknown.
-M Int, --min-read-pairs=Int  The minimum number of codec read pairs to form a consensus read. [Default: 1].
                              
--max-read-pairs=Int          The maximum number of reads to use when building a single-strand consensus. If more than
                              this many reads are present in a tag family, the family is randomly downsampled to
                              exactly max-reads-pairs reads. [Optional]. 
-d Int, --min-duplex-length=Int
                              Minimum length of the duplex region (where R1 and R2 overlap). [Default: 1].
                              
-q PhredScore, --single-strand-qual=PhredScore
                              Reduce quality scores in single stranded regions of the consensus read to the given
                              quality. [Optional]. 
-Q PhredScore, --outer-bases-qual=PhredScore
                              Reduce the first and last 'outer-bases-length' bases to the given quality.
                              [Optional]. 
-O Int, --outer-bases-length=Int
                              The number of bases at the start and end of the read to reduce quality over if
                              'outer-bases-qual' is specified. [Default: 5]. 
-x Double, --max-duplex-disagreement-rate=Double
                              Discard consensus reads where greater than this fraction of duplex bases disagree.
                              [Default: 1.0]. 
-X Int, --max-duplex-disagreements=Int
                              Discard consensus reads where greater than this number of duplex bases disagree.
                              [Default: 2147483647]. 
-c String, --cell-tag=String  Tag containing the cellular barcodes. [Default: CB]. 
--threads=Int                 The number of threads to use while consensus calling. [Default: 1].
```


## fgbio_FilterConsensusReads

### Tool Description
Filters consensus reads generated by CallMolecularConsensusReads or CallDuplexConsensusReads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

FilterConsensusReads
------------------------------------------------------------------------------------------------------------------------
Filters consensus reads generated by CallMolecularConsensusReads or CallDuplexConsensusReads. Two kinds of filtering
are performed:

  1. Masking/filtering of individual bases in reads
  2. Filtering out of reads (i.e. not writing them to the output file)

Base-level filtering/masking is only applied if per-base tags are present (see CallDuplexConsensusReads and
CallMolecularConsensusReads for descriptions of these tags). Read-level filtering is always applied. When filtering
reads, secondary alignments and supplementary records may be removed independently if they fail one or more filters; if
either R1 or R2 primary alignments fail a filter then all records for the template will be filtered out.

The filters applied are as follows:

  1. Reads with fewer than min-reads contributing reads are filtered out
  2. Reads with an average consensus error rate higher than max-read-error-rate are filtered out
  3. Reads with mean base quality of the consensus read, prior to any masking, less than min-mean-base-quality are
     filtered out (if specified)
  4. Bases with quality scores below min-base-quality are masked to Ns
  5. Bases with fewer than min-reads contributing raw reads are masked to Ns
  6. Bases with a consensus error rate (defined as the fraction of contributing reads that voted for a different base
     than the consensus call) higher than max-base-error-rate are masked to Ns
  7. For duplex reads, if require-single-strand-agreement is provided, masks to Ns any bases where the base was
     observed in both single-strand consensus reads and the two reads did not agree
  8. Reads with a fraction or count of Ns higher than max-no-calls after per-base filtering are filtered out.
     'max-no-calls' is interpreted as a fraction if less than 1.0, and a count if >= 1.0.

When filtering single-umi consensus reads generated by CallMolecularConsensusReads a single value each should be
supplied for '--min-reads', '--max-read-error-rate', and '--max-base-error-rate'.

When filtering duplex consensus reads generated by CallDuplexConsensusReads each of the three parameters may
independently take 1-3 values. For example:

  FilterConsensusReads ... --min-reads 10 5 3 --max-base-error-rate 0.1

In each case if fewer than three values are supplied, the last value is repeated (i.e. '80 40' -> '80 40 40' and '0.1'
-> '0.1 0.1 0.1'. The first value applies to the final consensus read, the second value to one single-strand consensus,
and the last value to the other single-strand consensus. It is required that if values two and three differ, the more
stringent value comes earlier.

In order to correctly filter reads in or out by template, the input BAM must be either 'queryname' sorted or 'query'
grouped. If your BAM is not already in an appropriate order, this can be done in streaming fashion with:

  samtools sort -n -u in.bam | fgbio FilterConsensusReads -i /dev/stdin ...

The output sort order may be specified with '--sort-order'. If not given, then the output will be in the same order as
input.

The '--reverse-tags-per-base' option controls whether per-base tags should be reversed before being used on reads
marked as being mapped to the negative strand. This is necessary if the reads have been mapped and the bases/quals
reversed but the consensus tags have not. If true, the tags written to the output BAM will be reversed where necessary
in order to line up with the bases and quals.

FilterConsensusReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file of consensus reads. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. 
-r PathToFasta, --ref=PathToFasta
                              Reference fasta file. 
-M Int{1..3}, --min-reads=Int{1..3}
                              The minimum number of reads supporting a consensus base/read. 
-N PhredScore, --min-base-quality=PhredScore
                              Mask (make 'N') consensus bases with quality less than this threshold. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-R [[true|false]], --reverse-per-base-tags[[=true|false]]
                              Reverse complement per base tags on reverse strand reads. [Default: false].
                              
-E Double{1..3}, --max-read-error-rate=Double{1..3}
                              The maximum raw-read error rate across the entire consensus read. [Default:
                              0.025]. 
-e Double{1..3}, --max-base-error-rate=Double{1..3}
                              The maximum error rate for a single consensus base. [Default: 0.1]. 
-n Double, --max-no-calls=Double
                              Maximum fraction (if < 1.0) or number (if >= 1.0) of no-calls in the read after
                              filtering. [Default: 0.2]. 
-q PhredScore, --min-mean-base-quality=PhredScore
                              The minimum mean base quality across the consensus read. [Optional]. 
-s [[true|false]], --require-single-strand-agreement[[=true|false]]
                              Mask (make 'N') consensus bases where the AB and BA consensus reads disagree (for
                              duplex-sequencing only). [Default: false]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output. If not given, output will be in the same order as input if
                              the input is query name sorted or query grouped, otherwise queryname order.
                              [Optional]. Options: Coordinate, Queryname, Random, RandomQuery,
                              TemplateCoordinate, Unsorted, Unknown.
```


## fgbio_CorrectUmis

### Tool Description
Corrects UMIs stored in BAM files when a set of fixed UMIs is in use.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

CorrectUmis
------------------------------------------------------------------------------------------------------------------------
Corrects UMIs stored in BAM files when a set of fixed UMIs is in use. If the set of UMIs used in an experiment is known
and is a subset of the possible randomers of the same length, it is possible to error-correct UMIs prior to grouping
reads by UMI. This tool takes an input BAM with UMIs in a tag ('RX' by default) and set of known UMIs (either on the
command line or in a file) and produces:

  1. A new BAM with corrected UMIs in the same tag the UMIs were found in
  2. Optionally a set of metrics about the representation of each UMI in the set
  3. Optionally a second BAM file of reads whose UMIs could not be corrected within the specific parameters

All of the fixed UMIs must be of he same length, and all UMIs in the BAM file must also have the same length. Multiple
UMIs that are concatenated with hyphens (e.g. 'AACCAGT-AGGTAGA') are split apart, corrected individually and then
re-assembled. A read is accepted only if all the UMIs can be corrected.

Correction is controlled by two parameters that are applied per-UMI:

  1. --max-mismatches controls how many mismatches (no-calls are counted as mismatches) are tolerated between a UMI as
     read and a fixed UMI.
  2. --min-distance controls how many more mismatches the next best hit must have

For example, with two fixed UMIs 'AAAAA' and 'CCCCC' and '--max-mismatches=3' and '--min-distance=2' the following
would happen:

  * AAAAA would match to AAAAA
  * AAGTG would match to AAAAA with three mismatches because CCCCCC has six mismatches and 6 >= 3 + 2
  * AACCA would be rejected because it is 2 mismatches to AAAAA and 3 to CCCCCC and 3 <= 2 + 2

The set of fixed UMIs may be specified on the command line using '--umis umi1 umi2 ...' or via one or more files of
UMIs with a single sequence per line using '--umi-files umis.txt more_umis.txt'. If there are multiple UMIs per
template, leading to hyphenated UMI tags, the values for the fixed UMIs should be single, non-hyphenated UMIs (e.g. if
a record has 'RX:Z:ACGT-GGCA', you would use '--umis ACGT GGCA').

Records which have their UMIs corrected (i.e. the UMI is not identical to one of the expected UMIs but is close enough
to be corrected) will by default have their original UMI stored in the 'OX' tag. This can be disabled with the
'--dont-store-original-umis' option.

For a large number of input UMIs, the '--cache-size' option may used to speed up the tool. To disable using a cache,
set the value to '0'.

The reverse complement (using '--revcomp') option will reverse complement the UMI in place. In the case of multiple
UMIs concatenated together, the individual UMIs are reverse complemented and the order reversed (eg. 'AAGG-ACTG' is
changed to 'CAGT-CCTT').

CorrectUmis Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. 
-m Int, --max-mismatches=Int  Maximum number of mismatches between a UMI and an expected UMI. 
-d Int, --min-distance=Int    Minimum difference (of mismatch distance) to next-best UMI. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r PathToBam, --rejects=PathToBam
                              Reject BAM file to save unassigned reads. [Optional]. 
-M FilePath, --metrics=FilePath
                              Metrics file to write. [Optional]. 
-u String*, --umis=String*    Expected UMI sequences. [Optional]. 
-U FilePath*, --umi-files=FilePath*
                              File of UMI sequences, one per line. [Optional]. 
-t String, --umi-tag=String   Tag in which UMIs are stored. [Default: RX]. 
-x [[true|false]], --dont-store-original-umis[[=true|false]]
                              Don't store original UMIs upon correction. [Default: false]. 
--cache-size=Int              The number of uncorrected UMIs to cache; zero will disable the cache. [Default:
                              100000]. 
--min-corrected=Double        The minimum ratio of kept UMIs to accept. A ratio below this will cause a failure (but
                              all files will still be written). [Optional]. 
--revcomp[[=true|false]]      Reverse complement the UMIs in the BAM file prior to correcting. [Default:
                              false].
```


## fgbio_CollectDuplexSeqMetrics

### Tool Description
Collects a suite of metrics to QC duplex sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

CollectDuplexSeqMetrics
------------------------------------------------------------------------------------------------------------------------
Collects a suite of metrics to QC duplex sequencing data.

Inputs
------

The input to this tool must be a BAM file that is either:

  1. The exact BAM output by the 'GroupReadsByUmi' tool (in the sort-order it was produced in)
  2. A BAM file that has MI tags present on all reads (usually set by 'GroupReadsByUmi' and has been sorted with
     'SortBam' into 'TemplateCoordinate' order.

Calculation of metrics may be restricted to a set of regions using the '--intervals' parameter. This can significantly
affect results as off-target reads in duplex sequencing experiments often have very different properties than on-target
reads due to the lack of enrichment.

Several metrics are calculated related to the fraction of tag families that have duplex coverage. The definition of
"duplex" is controlled by the '--min-ab-reads' and '--min-ba-reads' parameters. The default is to treat any tag family
with at least one observation of each strand as a duplex, but this could be made more stringent, e.g. by setting
'--min-ab-reads=3 --min-ba-reads=3'. If different thresholds are used then '--min-ab-reads' must be the higher value.

Outputs
-------

The following output files are produced:

  1. <output>.family_sizes.txt: metrics on the frequency of different types of families of different sizes
  2. <output>.duplex_family_sizes.txt: metrics on the frequency of duplex tag families by the number of observations
     from each strand
  3. <output>.duplex_yield_metrics.txt: summary QC metrics produced using 5%, 10%, 15%...100% of the data
  4. <output>.umi_counts.txt: metrics on the frequency of observations of UMIs within reads and tag families
  5. <output>.duplex_qc.pdf: a series of plots generated from the preceding metrics files for visualization
  6. <output>.duplex_umi_counts.txt: (optional) metrics on the frequency of observations of duplex UMIs within reads
     and tag families. This file is only produced if the '--duplex-umi-counts' option is used as it requires significantly
     more memory to track all pairs of UMIs seen when a large number of UMI sequences are present.

Within the metrics files the prefixes 'CS', 'SS' and 'DS' are used to mean:

  * CS: tag families where membership is defined solely on matching genome coordinates and strand
  * SS: single-stranded tag families where membership is defined by genome coordinates, strand and UMI; ie. 50/A and
    50/B are considered different tag families.
  * DS: double-stranded tag families where membership is collapsed across single-stranded tag families from the same
    double-stranded source molecule; i.e. 50/A and 50/B become one family

Requirements
------------

For plots to be generated R must be installed and the ggplot2 package installed with suggested dependencies.
Successfully executing the following in R will ensure a working installation:

  install.packages("ggplot2", repos="http://cran.us.r-project.org", dependencies=TRUE)

CollectDuplexSeqMetrics Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file generated by 'GroupReadsByUmi'. 
-o PathPrefix, --output=PathPrefix
                              Prefix of output files to write. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-l PathToIntervals, --intervals=PathToIntervals
                              Optional set of intervals over which to restrict analysis. [Optional]. 
-d String, --description=String
                              Description of data set used to label plots. Defaults to sample/library.
                              [Optional]. 
-u [[true|false]], --duplex-umi-counts[[=true|false]]
                              If true, produce the .duplex_umi_counts.txt file with counts of duplex UMI observations.
                              [Default: false]. 
-a Int, --min-ab-reads=Int    Minimum AB reads to call a tag family a 'duplex'. [Default: 1]. 
-b Int, --min-ba-reads=Int    Minimum BA reads to call a tag family a 'duplex'. [Default: 1]. 
-t String, --umi-tag=String   The tag containing the raw UMI. [Default: RX]. 
-T String, --mi-tag=String    The output tag for UMI grouping. [Default: MI]. 
-c String, --cell-tag=String  The tag containing the cell barcode. [Default: CB].
```


## fgbio_ExtractUmisFromBam

### Tool Description
Extracts unique molecular indexes from reads in a BAM file into tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

ExtractUmisFromBam
------------------------------------------------------------------------------------------------------------------------
Extracts unique molecular indexes from reads in a BAM file into tags.

Currently only unmapped reads are supported.

Only template bases will be retained as read bases (stored in the 'SEQ' field) as specified by the read structure.

A read structure should be provided for each read of a template. For example, paired end reads should have two read
structures specified. The tags to store the molecular indices will be associated with the molecular index segment(s) in
the read structure based on the order specified. If only one molecular index tag is given, then the molecular indices
will be concatenated and stored in that tag. Otherwise the number of molecular indices in the read structure should
match the number of tags given. In the resulting BAM file each end of a pair will contain the same molecular index tags
and values. Additionally, when multiple molecular indices are present the '--single-tag' option may be used to write
all indices, concatenated, to a single tag in addition to the tags specified in '--molecular-index-tags'.

Optionally, the read names can be annotated with the molecular indices directly. In this case, the read name will be
formatted '<NAME>+<UMIs1><UMIs2>' where '<UMIs1>' is the concatenation of read one's molecular indices. Similarly for
'<UMIs2>'.

Mapping information will not be adjusted, as such, this tool should not be used on reads that have been mapped since it
will lead to an BAM with inconsistent records.

The read structure describes the structure of a given read as one or more read segments. A read segment describes a
contiguous stretch of bases of the same type (ex. template bases) of some length and some offset from the start of the
read. Read structures are made up of '<number><operator>' pairs much like the CIGAR string in BAM files. Five kinds of
operators are recognized:

  1. 'T' identifies a template read
  2. 'B' identifies a sample barcode read
  3. 'M' identifies a unique molecular index read
  4. 'C' identifies a cell barcode read
  5. 'S' identifies a set of bases that should be skipped or ignored

The last '<number><operator>' pair may be specified using a '+' sign instead of number to denote "all remaining bases".
This is useful if, e.g., fastqs have been trimmed and contain reads of varying length.

An example would be '10B3M7S100T' which describes 120 bases, with the first ten bases being a sample barcode, bases
11-13 being a molecular index, bases 14-20 ignored, and bases 21-120 being template bases. See Read Structures
(https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures) for more information.

ExtractUmisFromBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-o PathToBam, --output=PathToBam
                              Output BAM file. 
-r ReadStructure+, --read-structure=ReadStructure+
                              The read structure, one per read in a template. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-t String*, --molecular-index-tags=String*
                              SAM tag(s) in which to store the molecular indices. [Optional]. 
-s String, --single-tag=StringSingle tag into which to concatenate all molecular indices. [Optional].
                              
-a [[true|false]], --annotate-read-names[[=true|false]]
                              Annotate the read names with the molecular indices. See usage for more details.
                              [Default: false]. 
-c String, --clipping-attribute=String
                              The SAM tag with the position in read to clip adapters (e.g. 'XT' as produced by Picard's
                              'MarkIlluminaAdapters'). [Optional].
```


## fgbio_AnnotateBamWithUmis

### Tool Description
Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular IDs, Molecular barcodes) from separate FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

AnnotateBamWithUmis
------------------------------------------------------------------------------------------------------------------------
Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular IDs, Molecular barcodes) from separate
FASTQ files. Takes an existing BAM file and either one FASTQ file with UMI reads or multiple FASTQs if there are
multiple UMIs per template, matches the reads between the files based on read names, and produces an output BAM file
where each record is annotated with an optional tag (specified by 'attribute') that contains the read sequence of the
UMI. Trailing read numbers ('/1' or '/2') are removed from FASTQ read names, as is any text after whitespace, before
matching. If multiple UMI segments are specified (see '--read-structure') across one or more FASTQs, they are delimited
in the same order as FASTQs are specified on the command line. The delimiter is controlled by the '--delimiter' option.

The '--read-structure' option may be used to specify which bases in the FASTQ contain UMI bases. Otherwise it is
assumed the FASTQ contains only UMI bases.

The '--sorted' option may be used to indicate that the FASTQ has the same reads and is sorted in the same order as the
BAM file.

At the end of execution, reports how many records were processed and how many were missing UMIs. If any read from the
BAM file did not have a matching UMI read in the FASTQ file, the program will exit with a non-zero exit status. The
'--fail-fast' option may be specified to cause the program to terminate the first time it finds a records without a
matching UMI.

In order to avoid sorting the input files, the entire UMI fastq file(s) is read into memory. As a result the program
needs to be run with memory proportional the size of the (uncompressed) fastq(s). Use the '--sorted' option to traverse
the UMI fastq and BAM files assuming they are in the same order. More precisely, the UMI fastq file will be traversed
first, reading in the next set of BAM reads with same read name as the UMI's read name. Those BAM reads will be
annotated. If no BAM reads exist for the UMI, no logging or error will be reported.

AnnotateBamWithUmis Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file. 
-f PathToFastq+, --fastq=PathToFastq+
                              Input FASTQ(s) with UMI reads. 
-o PathToBam, --output=PathToBam
                              Output BAM file to write. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-t String, --attribute=String The BAM attribute to store UMI bases in. [Default: RX]. 
-q String, --qual-attribute=String
                              The BAM attribute to store UMI qualities in. [Optional]. 
-r ReadStructure+, --read-structure=ReadStructure+
                              The read structure for the FASTQ, otherwise all bases will be used. [Default:
                              +M]. 
-s [[true|false]], --sorted[[=true|false]]
                              Whether the FASTQ file is sorted in the same order as the BAM. [Default: false].
                              
--fail-fast[[=true|false]]    If set, fail on the first missing UMI. [Default: false].
```


## fgbio_SortBam

### Tool Description
Sorts a SAM or BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

SortBam
------------------------------------------------------------------------------------------------------------------------
Sorts a SAM or BAM file. Several sort orders are available:

  1. Coordinate: sorts reads by their reference sequence and left-most aligned coordinate
  2. Queryname: sort the reads by their query (i.e. read) name
  3. Random: sorts the reads into a random order. The output is deterministic for any given input. and several
  4. RandomQuery: sorts the reads into a random order but keeps reads with the same queryname together. The ordering is
     deterministic for any given input.
  5. TemplateCoordinate: The sort order used by 'GroupReadByUmi'. Sorts reads by the earlier unclipped 5' coordinate of
     the read pair, the higher unclipped 5' coordinate of the read pair, library, the molecular identifier (MI tag), read
     name, and if R1 has the lower coordinates of the pair.

Uses a temporary directory to buffer sets of sorted reads to disk. The number of reads kept in memory affects memory
use and can be changed with the '--max-records-in-ram' option. The temporary directory to use can be set with the fgbio
global option '--tmp-dir'.

An example invocation might look like:

  java -Xmx4g -jar fgbio.jar --tmp-dir=/my/big/scratch/volume \
    SortBam --input=queryname.bam --sort-order=Coordinate --output coordinate.bam

SortBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-s SamOrder, --sort-order=SamOrder
                              Order into which to sort the records. [Default: Coordinate]. Options:
                              Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.
-m Int, --max-records-in-ram=Int
                              Max records in RAM. [Default: 1000000].
```


## fgbio_FilterBam

### Tool Description
Filters reads out of a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

FilterBam
------------------------------------------------------------------------------------------------------------------------
Filters reads out of a BAM file. Removes reads that may not be useful in downstream processing or visualization. By
default will remove unmapped reads, reads with MAPQ=0, reads marked as secondary alignments, reads marked as
duplicates, and if a set of Intervals are provided, reads that do not overlap any of the intervals.

If '--min-insert-size' or '--min-mapped-bases' is specified, unmapped reads will also be removed even if
'--remove-unmapped-reads' is false.

NOTE: this will usually produce a BAM file in which some mate-pairs are orphaned (i.e. read 1 or read 2 is included,
but not both), but does not update any flag fields.

FilterBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-o PathToBam, --output=PathToBam
                              Output BAM file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r PathToBam, --rejects=PathToBam
                              Optional output SAM or BAM file to write reads not kept. [Optional]. 
-l PathToIntervals, --intervals=PathToIntervals
                              Optionally remove reads not overlapping intervals. [Optional]. 
-D [[true|false]], --remove-duplicates[[=true|false]]
                              If true remove all reads that are marked as duplicates. [Default: true].
                              
-U [[true|false]], --remove-unmapped-reads[[=true|false]]
                              Remove all unmapped reads. [Default: true]. 
-M Int, --min-map-q=Int       Remove all mapped reads with MAPQ lower than this number. [Default: 1].
                              
-P [[true|false]], --remove-single-end-mappings[[=true|false]]
                              Removes non-PE reads and any read whose mate pair is unmapped. [Default: false].
                              
-S [[true|false]], --remove-secondary-alignments[[=true|false]]
                              Remove all reads marked as secondary alignments. [Default: true]. 
--min-insert-size=Int         Remove all reads with insert size < this value. [Optional]. 
--max-insert-size=Int         Remove all reads with insert size > this value. [Optional]. 
-m Int, --min-mapped-bases=IntRemove reads with fewer than this many mapped bases. [Optional].
```


## fgbio_ClipBam

### Tool Description
Clips reads from the same template.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

ClipBam
------------------------------------------------------------------------------------------------------------------------
Clips reads from the same template. Ensures that at least N bases are clipped from any end of the read (i.e. R1 5' end,
R1 3' end, R2 5' end, and R2 3' end). Optionally clips reads from the same template to eliminate overlap between the
reads. This ensures that downstream processes, particularly variant calling, cannot double-count evidence from the same
template when both reads span a variant site in the same template.

Clipping overlapping reads is only performed on 'FR' read pairs, and is implemented by clipping approximately half the
overlapping bases from each read. By default hard clipping is performed; soft-clipping may be substituted using the
'--soft-clip' parameter.

Secondary alignments and supplemental alignments are not clipped, but are passed through into the output.

In order to correctly clip reads by template and update mate information, the input BAM must be either 'queryname'
sorted or 'query' grouped. If your input BAM is not in an appropriate order the sort can be done in streaming fashion
with, for example:

  samtools sort -n -u in.bam | fgbio ClipBam -i /dev/stdin ...

The output sort order may be specified with '--sort-order'. If not given, then the output will be in the same order as
input.

Any existing 'NM', 'UQ' and 'MD' tags are repaired, and mate-pair information updated.

Three clipping modes are supported:

  1. 'Soft' - soft-clip the bases and qualities.
  2. 'SoftWithMask' - soft-clip and mask the bases and qualities (make bases Ns and qualities the minimum).
  3. 'Hard' - hard-clip the bases and qualities.

The '--upgrade-clipping' parameter will convert all existing clipping in the input to the given more stringent mode:
from 'Soft' to either 'SoftWithMask' or 'Hard', and 'SoftWithMask' to 'Hard'. In all other cases, clipping remains the
same prior to applying any other clipping criteria.

ClipBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file of aligned reads in coordinate order. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. 
-r PathToFasta, --ref=PathToFasta
                              Reference sequence fasta file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m FilePath, --metrics=FilePath
                              Optional output of clipping metrics. [Optional]. 
-c ClippingMode, --clipping-mode=ClippingMode
                              The type of clipping to perform. [Default: Hard]. Options: Soft,
                              SoftWithMask, Hard.
-a [[true|false]], --auto-clip-attributes[[=true|false]]
                              Automatically clip extended attributes that are the same length as bases. [Default:
                              false]. 
-H [[true|false]], --upgrade-clipping[[=true|false]]
                              Upgrade all existing clipping in the input to the given clipping mode prior to applying
                              any other clipping criteria. [Default: false]. 
--read-one-five-prime=Int     Require at least this number of bases to be clipped on the 5' end of R1 [Default:
                              0]. 
--read-one-three-prime=Int    Require at least this number of bases to be clipped on the 3' end of R1 [Default:
                              0]. 
--read-two-five-prime=Int     Require at least this number of bases to be clipped on the 5' end of R2 [Default:
                              0]. 
--read-two-three-prime=Int    Require at least this number of bases to be clipped on the 3' end of R2 [Default:
                              0]. 
--clip-overlapping-reads[[=true|false]]
                              Clip overlapping reads. [Default: false]. 
--clip-bases-past-mate[[=true|false]]
                              Clip reads in FR pairs that sequence past the far end of their mate. [Default:
                              false]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output. If not given, output will be in the same order as input if
                              the input. [Optional]. Options: Coordinate, Queryname, Random, RandomQuery,
                              TemplateCoordinate, Unsorted, Unknown.
```


## fgbio_TrimPrimers

### Tool Description
Trims primers from reads post-alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

TrimPrimers
------------------------------------------------------------------------------------------------------------------------
Trims primers from reads post-alignment. Takes in a BAM file of aligned reads and a tab-delimited file with five
columns ('chrom', 'left_start', 'left_end', 'right_start', and 'right_end') which provide the 1-based inclusive start
and end positions of the primers for each amplicon. The primer file must include headers, e.g:

  chrom  left_start  left_end  right_start right_end
  chr1   1010873     1010894   1011118     1011137

Both paired end reads and fragment reads that map to a given amplicon position are trimmed so that the alignment
no-longer includes the primer sequences. This includes both the 5' and 3' ends of each read. All other aligned reads
have the maximum primer length trimmed from the 5' end only!

Reads that are trimmed will have the 'NM', 'UQ' and 'MD' tags cleared as they are no longer guaranteed to be accurate.
If a reference is provided the reads will be re-sorted by coordinate after trimming and the 'NM', 'UQ' and 'MD' tags
recalculated.

If the input BAM is not 'queryname' sorted it will be sorted internally so that mate information between paired-end
reads can be corrected before writing the output file.

The '--first-of-pair' option will cause only the first of pair (R1) reads to be trimmed based solely on the primer
location of R1. This is useful when there is a target specific primer on the 5' end of R1 but no primer sequenced on R2
(eg. single gene-specific primer target enrichment), as well as fragment reads. In this case, the location of each
target specific primer should be specified in an amplicons left or right primer exclusively. The coordinates of the
non-specific-target primer should be '-1' for both start and end, e.g:

  chrom  left_start  left_end  right_start right_end
  chr1   1010873     1010894   -1          -1
  chr2   -1          -1        1011118     1011137

TrimPrimers Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-o PathToBam, --output=PathToBam
                              Output BAM file. 
-p FilePath, --primers=FilePath
                              File with primer locations. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-H [[true|false]], --hard-clip[[=true|false]]
                              If true, hard clip reads, else soft clip. [Default: false]. 
-S Int, --slop=Int            Match to primer locations +/- this many bases. [Default: 5]. 
-s SamOrder, --sort-order=SamOrder
                              Sort order of output BAM file (defaults to input sort order). [Optional].
                              Options: Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted,
                              Unknown.
-r PathToFasta, --ref=PathToFasta
                              Optional reference fasta for recalculating NM, MD and UQ tags. [Optional].
                              
-a [[true|false]], --auto-trim-attributes[[=true|false]]
                              Automatically trim extended attributes that are the same length as bases. [Default:
                              false]. 
--first-of-pair[[=true|false]]Trim only first of pair reads (R1s) or fragment reads, otherwise both ends of a pair.
                              [Default: false].
```


## fgbio_ZipperBams

### Tool Description
Zips together an unmapped and mapped BAM to transfer metadata into the output BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

ZipperBams
------------------------------------------------------------------------------------------------------------------------
Zips together an unmapped and mapped BAM to transfer metadata into the output BAM.

Both the unmapped and mapped BAMs must be a) queryname sorted or grouped (i.e. all records with the same name are
grouped together in the file), and b) have the same ordering of querynames. If either of these are violated the output
is undefined!

All tags present on the unmapped reads are transferred to the mapped reads. The options '--tags-to-reverse' and
'--tags-to-revcomp' will cause tags on the unmapped reads to be reversed or reverse complemented before being copied to
reads mapped to the negative strand. These options can take a mixture of two-letter tag names and the names of tag
sets, which will be expanded into sets of tag names. Currently the only named tag set is "Consensus" which contains all
the per-base consensus tags produced by fgbio consensus callers.

By default the mapped BAM is read from standard input (stdin) and the output BAM is written to standard output
(stdout). This can be changed using the '--input/-i' and '--output/-o' options.

By default the output BAM file is emitted in the same order as the input BAMs. This can be overridden using the
'--sort' option, though in practice it may be faster to do the following:

  fgbio --compression 0 ZipperBams -i mapped.bam -u unmapped.bam -r ref.fa | samtools sort -@ $(nproc)

ZipperBams Arguments:
------------------------------------------------------------------------------------------------------------------------
-u PathToBam, --unmapped=PathToBam
                              Unmapped SAM or BAM. 
-r PathToFasta, --ref=PathToFasta
                              Path to the reference used in alignment. Must have accompanying .dict file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-i PathToBam, --input=PathToBam
                              Mapped SAM or BAM. [Default: /dev/stdin]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. [Default: /dev/stdout]. 
--tags-to-remove=String*      Tags to remove from the mapped BAM records. [Optional]. 
--tags-to-reverse=String*     Set of optional tags to reverse on reads mapped to the negative strand.
                              [Optional]. 
--tags-to-revcomp=String*     Set of optional tags to reverse complement on reads mapped to the negative strand.
                              [Optional]. 
-s SamOrder, --sort=SamOrder  Sort the output BAM into the given order. [Optional]. Options: Coordinate,
                              Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.
-b Int, --buffer=Int          Buffer this many read-pairs while reading the input BAMs. [Default: 5000].
```


## fgbio_SetMateInformation

### Tool Description
Adds and/or fixes mate information on paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

SetMateInformation
------------------------------------------------------------------------------------------------------------------------
Adds and/or fixes mate information on paired-end reads. Sets the MQ (mate mapping quality), 'MC' (mate cigar string),
ensures all mate-related flag fields are set correctly, and that the mate reference and mate start position are
correct.

Supplementary records are handled correctly (updated with their mate's non-supplemental attributes). Secondary
alignments are passed through but are not updated.

The input file must be query-name sorted or query-name grouped (i.e. all records from the same query sequence must be
adjacent in the file, though the ordering between queries is unspecified).

SetMateInformation Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-i PathToBam, --input=PathToBam
                              Input SAM/BAM/CRAM file. [Default: /dev/stdin]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathToBam, --output=PathToBam
                              Output SAM/BAM/CRAM file. [Default: /dev/stdout]. 
-r PathToFasta, --ref=PathToFasta
                              Reference fasta, only needed if writing CRAM. [Optional]. 
-x [[true|false]], --allow-missing-mates[[=true|false]]
                              If specified, do not fail when reads marked as paired are missing their mate pairs.
                              [Default: false].
```


## fgbio_UpdateReadGroups

### Tool Description
Updates one or more read groups and their identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

UpdateReadGroups
------------------------------------------------------------------------------------------------------------------------
Updates one or more read groups and their identifiers.

This tool will replace each read group with a new read group, including a new read group identifier. If the read group
identifier is not to be changed, it is recommended to use 'samtools reheader' or Picard's 'ReplaceSamHeader' instead as
in this case only the header needs modification. If all read groups are to be assigned to one read group, it is
recommended to use Picard's 'AddOrReplaceReadGroups'. Nonetheless, if the read group identifier also needs to be
changed, use this tool.

Each read group in the input file will be mapped to one and only one new read group identifier, unless
'--ignore-missing-read-groups' is set. A SAM header file should be given with the new read groups and the ID field
foreach read group containing the new read group identifier. An additional attribute ('FR') should be provided that
gives the original read group identifier ('ID') to which this new read group corresponds.

If '--keep-read-group-attributes' is true, then any read group attribute not replaced will be kept in the new read
group. Otherwise, only the attributes in the provided SAM header file will be used.

UpdateReadGroups Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-o PathToBam, --output=PathToBam
                              Output BAM file. 
-r PathToBam, --read-groups-file=PathToBam
                              A SAM header file with the replacement read groups (see detailed usage). 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-k [[true|false]], --keep-read-group-attributes[[=true|false]]
                              Keep all read group attributes that are not replaced. [Default: false].
                              
-g [[true|false]], --ignore-missing-read-groups[[=true|false]]
                              Keep all read groups not found in the replacement header, otherwise throw an error.
                              [Default: false].
```


## fgbio_ErrorRateByReadPosition

### Tool Description
Calculates the error rate by read position on coordinate sorted mapped BAMs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

ErrorRateByReadPosition
------------------------------------------------------------------------------------------------------------------------
Calculates the error rate by read position on coordinate sorted mapped BAMs. The output file contains a row per read
(first of pair, second of pair and unpaired), per position in read, with the total number of bases observed, the number
of errors observed, the overall error rate, and the rate of each kind of substitution error.

Substitution types are collapsed based on the reference or expected base, with only six substitution types being
reported: 'A>C', 'A>G', 'A>T', 'C>A', 'C>G' and 'C>T'. For example, 'T>G' is grouped in with 'A>C'.

Analysis can be restricted to a set of intervals via the '--intervals' option. Genomic positions can be excluded from
analysis by supplying a set of variants (either known variants in the sample or a catalog of known variants such as
dbSNP). For data believed to have low error rates it is recommended to use both the '--intervals' and '--variants'
options to restrict analysis to only regions expected to be homozygous reference in the data.

The following are reads / bases are excluded from the analysis:

  * Unmapped reads
  * Reads marked as failing vendor quality
  * Reads marked as duplicates (unless '--include-duplicates' is specified)
  * Secondary and supplemental records
  * Soft-clipped bases in records
  * Reads with MAPQ < '--min-mapping-quality' (default: 20)
  * Bases with base quality < '--min-base-quality' (default: 0)
  * Bases where either the read base or the reference base is non-ACGT

An output text file is generated with the extension '.error_rate_by_read_position.txt'

If R's 'Rscript' utility is on the path and 'ggplot2' is installed in the R distribution then a PDF of error rate plots
will also be generated with extension '.error_rate_by_read_position.pdf'.

ErrorRateByReadPosition Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-r PathToFasta, --ref=PathToFasta
                              Reference sequence fasta file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathPrefix, --output=PathPrefix
                              Output metrics prefix. If not given, will use the input BAM basename.
                              [Optional]. 
-v PathToVcf, --variants=PathToVcf
                              Optional file of variant sites to ignore. [Optional]. 
-l PathToIntervals, --intervals=PathToIntervals
                              Optional list of intervals to restrict analysis to. [Optional]. 
-d [[true|false]], --include-duplicates[[=true|false]]
                              Include duplicate reads, otherwise ignore. [Default: false]. 
-m Int, --min-mapping-quality=Int
                              The minimum mapping quality for a read to be included. [Default: 20]. 
-q Int, --min-base-quality=IntThe minimum base quality for a base to be included. [Default: 0]. 
--collapse[[=true|false]]     Collapse substitution types based on the reference or expected base, with only six
                              substitution types being reported: 'A>C', 'A>G', 'A>T', 'C>A', 'C>G' and 'C>T'.For
                              example, 'T>G' is grouped in with 'A>C'. Otherwise, all possible substitution types will
                              be reported. [Default: true].
```


## fgbio_DownsampleAndNormalizeBam

### Tool Description
Downsamples a BAM in a biased way to a uniform coverage across regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

DownsampleAndNormalizeBam
------------------------------------------------------------------------------------------------------------------------
Downsamples a BAM in a biased way to a uniform coverage across regions.

Attempts to downsample a BAM such that every base in the genome (or in the target 'regions' if provided) is covered by
at least 'coverage' reads. When computing coverage:

  * Reads marked as secondary, duplicate or unmapped are not used
  * A base can receive coverage from only one read with the same queryname (i.e. mate overlaps are not counted)
  * Coverage is counted if a read spans a base, even if that base is deleted in the read

Reads are first sorted into a random order (by hashing read names). Reads are then consumed one template at a time, and
if any read adds coverage to base that is under the target coverage, all reads (including secondary, unmapped, etc.)
for that template are emitted into the output.

Given the procedure used for downsampling, it is likely the output BAM will have coverage up to 2X the requested
coverage at regions in the input BAM that are i) well covered and ii) are close to regions that are poorly covered.

DownsampleAndNormalizeBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. 
-c Int, --coverage=Int        Desired minimum coverage. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m Int, --min-map-q=Int       Minimum mapping quality to count a read as covering. [Default: 0]. 
-s Int, --seed=Int            Random seed to use when randomizing order of reads/templates. [Default: 42].
                              
-l PathToIntervals, --regions=PathToIntervals
                              Optional set of regions for coverage targeting. [Optional]. 
-M Int, --max-in-memory=Int   Maximum records to be held in memory while sorting. [Default: 1000000].
```


## fgbio_UpdateVcfContigNames

### Tool Description
Updates then contig names in a VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

UpdateVcfContigNames
------------------------------------------------------------------------------------------------------------------------
Updates then contig names in a VCF.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

Use '--skip-missing' to ignore variants where a contig name could not be updated (i.e. missing from the sequence
dictionary).

UpdateVcfContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              Input VCF. 
-d PathToSequenceDictionary, --dict=PathToSequenceDictionary
                              The path to the sequence dictionary with contig aliases. 
-o PathToVcf, --output=PathToVcf
                              Output VCF. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--skip-missing[[=true|false]] Skip contigs in the VCF that are not found in the sequence dictionary. [Default:
                              false].
```


## fgbio_UpdateGffContigNames

### Tool Description
Updates the contig names in a GFF.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

UpdateGffContigNames
------------------------------------------------------------------------------------------------------------------------
Updates the contig names in a GFF.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

Please note: the output GFF will be in the same order as the input GFF.

UpdateGffContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath Input GFF. 
-d PathToSequenceDictionary, --dict=PathToSequenceDictionary
                              The path to the sequence dictionary with contig aliases. 
-o FilePath, --output=FilePathOutput GFF. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--skip-missing[[=true|false]] Skip contigs in the GFF that are not found in the sequence dictionary. [Default:
                              false].
```


## fgbio_FilterSomaticVcf

### Tool Description
Applies one or more filters to a VCF of somatic variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

FilterSomaticVcf
------------------------------------------------------------------------------------------------------------------------
Applies one or more filters to a VCF of somatic variants. The VCF must contain genotype information for the tumor
sample. If the VCF also contains genotypes for one or more other samples, the '--sample' option must be provided to
specify the sample whose genotypes to examine and whose reads are present in the BAM file.

Various options are available for filtering the reads coming from the BAM file, including '--min-mapping-quality',
'--min-base-quality' and '--paired-reads-only'. The latter filters to only paired end reads where both reads are
mapped. Reads marked as duplicates, secondary alignments and supplemental alignments are all filtered out.

Each available filter may generate annotations in the 'INFO' field of the output VCF and optionally, if a threshold is
specified, may apply one or more 'FILTER's to applicable variants.

In previous versions of this tool, the only available filter was specific to A-base addition artifacts and was referred
to as the 'End Repair Artifact Filter.' This filter has been renamed to 'A-tailing Artifact Filter', but its
functionality is unchanged. The filter's associated command-line parameters, 'INFO' field key, and 'FILTER' tag have
also been renamed accordingly, as described below.

Available Filters
-----------------

A-tailing Artifact Filter (previously 'End Repair Artifact Filter')
-------------------------------------------------------------------

The A-tailing artifact filter attempts to measure the probability that a single-nucleotide mismatch is the product of
errors in the template generated during the A-base addition steps that are common to many Illumina library preparation
protocols. The artifacts occur if/when a recessed 3' end is incorrectly filled in with one\ or more adenines during
A-base addition. Incorrect adenine incorporation presents specifically as errors to T at the beginning of reads (and in
very short templates, as matching errors to A at the ends of reads).

The filter adds the 'INFO' field 'ATAP' (previously 'ERAP') to SNVs with an A or T alternate allele. This field records
the p-value representing the probability of the null hypothesis that the variant is a true mutation, so lower p-values
indicate that the variant is more likely an A-tailing artifact. If a threshold p-value is specified, the 'FILTER' tag
'ATailingArtifact' (previously 'EndRepairArtifact') will be applied to variants with p-values less than or equal to the
threshold.

Two options are available:

  * '--a-tailing-distance' (previously '--end-repair-distance') allows control over how close to the ends of
    reads/templates errors can be considered to be candidates for the A-tailing artifact. Higher values decrease the
    power of the test, so this should be set as low as possible given observed errors.
  * '--a-tailing-p-value' (previously '--end-repair-p-value') the p-value at or below which a filter should be applied.
    If no value is supplied only the 'INFO' annotation is produced and no 'FILTER' is applied.

End Repair Fill-in Artifact Filter
----------------------------------

The end repair fill-in artifact filter attempts to measure the probability that a single-nucleotide mismatch is the
product of an error in the template generated during the end repair fill-in step that is common to many Illumina
library preparation protocols, in which single-stranded 3' overhangs are filled in to create a blunt end. These
artifacts originate from single-stranded templates containing damaged bases, often as a consequence of oxidative
damage. These DNA lesions, for example 8-oxoguanine, undergo mismatched pairing, which after PCR appear as mutations at
the ends of reads.

The filter adds the 'INFO' field 'ERFAP' to records SNVs. This field records the p-value representing the probability
of the null hypothesis (e.g. that the variant is a true mutation), so lower p-values indicate that the variant is more
likely an end repair fill-in artifact. If a threshold p-value is specified, then the 'FILTER' tag
'EndRepairFillInArtifact' will be applied to variants with p-values less than or equal to the threshold.

Two options are available:

  * '--end-repair-fill-in-distance' allows control over how close to the ends of reads/templates errors can be
    considered to be candidates for the artifact. Higher values decrease the power of the test, so this should be set as
    low as possible given observed errors.
  * '--end-repair-fill-in-p-value' the p-value below which a filter should be applied. If no value is supplied only the
    annotation is produced and no filtering is performed.

Performance Expectations
------------------------

By default '--access-pattern' will be set to 'RandomAccess' and the input BAM will be queried using index-based random
access. Random access is mandatory if the input VCF is not coordinate sorted. If random access is not requested and the
input VCF is not coordinate sorted, then an exception will be raised on the first non-coordinate increasing VCF record
found. The BAM must be coordinate sorted in all cases and additionally be indexed if random access is requested.

Often, a VCF file will contain a sparse set of records that are scattered across a given territory within a genome (or
the records will be sparsely scattered genome-wide). If the territory of the VCF records is markedly smaller than the
territory of all aligned SAM records in the BAM file, then random access may be the most efficient BAM access pattern.
However, there are cases where random access will be less efficient such as when the VCF is coordinate sorted and the
variant call records are very densely packed across a similar territory as compared to all aligned SAM records. Such a
case is common in deeply sequenced hybrid selection NGS experiments and setting '--access-pattern' to 'Streaming' will
often be the most efficient BAM access pattern.

FilterSomaticVcf Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              Input VCF of somatic variant calls. 
-o PathToVcf, --output=PathToVcf
                              Output VCF of filtered somatic variants. 
-b PathToBam, --bam=PathToBam BAM file for the tumor sample. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-s String, --sample=String    Sample name in VCF if '> 1' sample present. [Optional]. 
-m Int, --min-mapping-quality=Int
                              Minimum mapping quality for reads. [Default: 20]. 
-q Int, --min-base-quality=IntMinimum base quality. [Default: 20]. 
-p [[true|false]], --paired-reads-only[[=true|false]]
                              Use only paired reads mapped in pairs. [Default: false]. 
-A BamAccessPattern, --access-pattern=BamAccessPattern
                              The type of BAM access pattern to use. [Default: RandomAccess]. Options:
                              RandomAccess, Streaming.
--a-tailing-distance=Int      Distance from 5-prime end of read to implicate A-base addition artifacts. Set to :none:
                              to deactivate the filter. [Default: 2]. 
--a-tailing-p-value=Double    Minimum acceptable p-value for the A-base addition artifact test. [Optional].
                              
--end-repair-fill-in-distance=Int
                              Distance from 5-prime end of read to implicate end repair fill-in artifacts. Set to
                              :none: to deactivate the filter. [Default: 15]. 
--end-repair-fill-in-p-value=Double
                              Minimum acceptable p-value for the end repair fill-in artifact test. [Optional].
```


## fgbio_AssessPhasing

### Tool Description
Assess the accuracy of phasing for a set of variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fgbio [fgbio arguments] [command name] [command arguments]
Version: 3.1.1
------------------------------------------------------------------------------------------------------------------------

fgbio Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--async-io[[=true|false]]     Use asynchronous I/O where possible, e.g. for SAM and BAM files. [Default:
                              false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--compression=Int             Default GZIP compression level, BAM compression level. [Default: 5]. 
--tmp-dir=DirPath             Directory to use for temporary files. [Default: /tmp]. 
--log-level=LogLevel          Minimum severity log-level to emit. [Default: Info]. Options: Debug, Info,
                              Warning, Error, Fatal.
--sam-validation-stringency=ValidationStringency
                              Validation stringency for SAM/BAM reading. [Default: SILENT]. Options:
                              STRICT, LENIENT, SILENT.
--cram-ref-fasta=PathToFasta  Reference FASTA for CRAM encoding/decoding. [Optional]. 

AssessPhasing
------------------------------------------------------------------------------------------------------------------------
Assess the accuracy of phasing for a set of variants.

All phased genotypes should be annotated with the 'PS' (phase set) 'FORMAT' tag, which by convention is the position of
the first variant in the phase set (see the VCF specification). Furthermore, the alleles of a phased genotype should
use the '|' separator instead of the '/' separator, where the latter indicates the genotype is unphased.

The input VCFs are assumed to be single sample: the genotype from the first sample is used.

Only bi-allelic heterozygous SNPs are considered.

The input known phased variants can be subsetted using the known interval list, for example to keep only variants from
high-confidence regions.

If the intervals argument is supplied, only the set of chromosomes specified will be analyzed. Note that the full
chromosome will be analyzed and start/stop positions will be ignored.

AssessPhasing Arguments:
------------------------------------------------------------------------------------------------------------------------
-c PathToVcf, --called-vcf=PathToVcf
                              The VCF with called phased variants. 
-t PathToVcf, --truth-vcf=PathToVcf
                              The VCF with known phased variants. 
-o PathPrefix, --output=PathPrefix
                              The output prefix for all output files. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-k PathToIntervals, --known-intervals=PathToIntervals
                              The interval list over which known phased variants should be kept. [Optional].
                              
-m [[true|false]], --allow-missing-fields-in-vcf-header[[=true|false]]
                              Allow missing fields in the VCF header. [Default: true]. 
-s [[true|false]], --skip-mismatching-alleles[[=true|false]]
                              Skip sites where the truth and call are both called but do not share the same alleles.
                              [Default: true]. 
-l PathToIntervals, --intervals=PathToIntervals
                              Analyze only the given chromosomes in the interval list. The entire chromosome will be
                              analyzed (start and end ignored). [Optional]. 
-b [[true|false]], --modify-blocks[[=true|false]]
                              Remove enclosed phased blocks and truncate overlapping blocks. [Default: true].
                              
-d [[true|false]], --debug-vcf[[=true|false]]
                              Output a VCF with the called variants annotated by if their phase matches the truth
                              [Default: false].
```


## fgbio_AssignPrimers

### Tool Description
Assigns reads to primers post-alignment. Takes in a BAM file of aligned reads and a tab-delimited file with five

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
AssignPrimers
------------------------------------------------------------------------------------------------------------------------
Assigns reads to primers post-alignment. Takes in a BAM file of aligned reads and a tab-delimited file with five
columns ('chrom', 'left_start', 'left_end', 'right_start', and 'right_end') which provide the 1-based inclusive start
and end positions of the primers for each amplicon. The primer file must include headers, e.g:

  chrom  left_start  left_end  right_start right_end
  chr1   1010873     1010894   1011118     1011137

Optionally, a sixth column column 'id' may be given with a unique name for the amplicon. If not given, the coordinates
of the amplicon's primers will be used: '<chrom>:<left_start>-<left_end>,<chrom>:<right_start>:<right_end>'

Each read is assigned independently of its mate (for paired end reads). The primer for a read is assumed to be located
at the start of the read in 5' sequencing order. Therefore, a positive strand read will use its aligned start position
to match against the amplicon's left-most coordinate, while a negative strand read will use its aligned end position to
match against the amplicon's right-most coordinate.

For paired end reads, the assignment for mate will also be stored in the current read, using the same procedure as
above but using the mate's coordinates. This requires the input BAM have the mate-cigar ("MC") SAM tag. Read pairs must
have both ends mapped in forward/reverse configuration to have an assignment. Furthermore, the amplicon assignment may
be different for a read and its mate. This may occur, for example, if tiling nearby amplicons and a large deletion
occurs over a given primer and therefore "skipping" an amplicon. This may also occur if there are translocations across
amplicons.

The output will have the following tags added:

  * ap: the assigned primer coordinates (ex. 'chr1:1010873-1010894')
  * am: the mate's assigned primer coordinates (ex. 'chr1:1011118-1011137')
  * ip: the assigned amplicon id
  * im: the mate's assigned amplicon id (or '=' if the same as the assigned amplicon)

The read sequence of the primer is not checked against the expected reference sequence at the primer's genomic
coordinates.

In some cases, large deletions within one end of a read pair may cause a primary and supplementary alignments to be
produced by the aligner, with the supplementary alignment containing the primer end of the read (5' sequencing order).
In this case, the primer may not be assigned for this end of the read pair. Therefore, it is recommended to prefer or
choose the primary alignment that has the closest aligned read base to the 5' end of the read in sequencing order. For
example, from 'bwa' version '0.7.16' onwards, the '-5' option may be used. Consider also using the '-q' option for
'bwa' '0.7.16' as well, which is standard in '0.7.17' onwards when the '-5' option is used.

The '--annotate-all' option may be used to annotate all alignments for a given read end (eg. R1) with the same
assignment. If the assignment differs across alignments for the same read end, no assignment is given. Furthermore, if
the input BAM is neither 'queryname' sorted nor 'query' grouped, it will be sorted into queryname order to assign all
alignments cross a template simultaneously. The output is written in coordinate order.

AssignPrimers Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-o PathToBam, --output=PathToBam
                              Output BAM file. 
-m FilePath, --metrics=FilePath
                              Output metrics file. 
-p FilePath, --primers=FilePath
                              File with primer locations. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-S Int, --slop=Int            Match to primer locations +/- this many bases. [Default: 5]. 
-U [[true|false]], --unclipped-coordinates[[=true|false]]
                              True to based on the unclipped coordinates (adjust based on hard/soft clipping),
                              otherwise the aligned bases [Default: true]. 
--primer-coordinates-tag=String
                              The SAM tag for the assigned primer coordinate. [Default: rp]. 
--mate-primer-coordinates-tag=String
                              The SAM tag for the mate's assigned primer coordinate. [Default: mp]. 
--amplicon-identifier-tag=String
                              The SAM tag for the assigned amplicon identifier. [Default: ra]. 
--mate-amplicon-identifier-tag=String
                              The SAM tag for the mate's assigned amplicon identifier. [Default: ma].
                              
--annotate-all[[=true|false]] Annotate all R1 (or R2) with same value. [Default: false].
```

## fgbio_AutoGenerateReadGroupsByName

### Tool Description
Adds read groups to a BAM file for a single sample by parsing the read names.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
AutoGenerateReadGroupsByName
------------------------------------------------------------------------------------------------------------------------
Adds read groups to a BAM file for a single sample by parsing the read names.

Will add one or more read groups by parsing the read names. The read names should be of the form:

  <instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<xpos>:<y-pos>

Each unique combination of '<instrument>:<run number>:<flowcell ID>:<lane>' will be its own read group. The ID of the
read group will be an integer and the platform unit will be '<flowcell-id>.<lane>'.

The input is assumed to contain reads for one sample and library. Therefore, the sample and library must be given and
will be applied to all read groups. Read groups will be replaced if present.

Two passes will be performed on the input: first to gather all the read groups, and second to write the output BAM
file.

AutoGenerateReadGroupsByName Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file 
-s String, --sample=String    The sample to insert into the read groups 
-l String, --library=String   The library to insert into the read groups 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--sequencing-center=String    The sequencing center from which the data originated [Optional]. 
--predicted-insert-size=Integer
                              Predicted median insert size, to insert into the read groups [Optional].
                              
--program-group=String        Program group to insert into the read groups [Optional]. 
--platform-model=String       Platform model to insert into the groups (free-form text providing further details of the
                              platform/technology used) [Optional]. 
--description=String          Description inserted into the read groups [Optional]. 
--run-date=Iso8601Date        Date the run was produced (ISO 8601: 'YYYY-MM-DD' ), to insert into the read groups
                              [Optional]. 
--comments=String*            Comment(s) to include in the merged output file's header. [Optional]. 
--sort-order=SamOrder         The sort order for the output sam/bam file. [Optional]. Options:
                              Coordinate, Queryname, Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.
```

## fgbio_CallOverlappingConsensusBases

### Tool Description
Consensus calls overlapping bases in read pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
CallOverlappingConsensusBases
------------------------------------------------------------------------------------------------------------------------
Consensus calls overlapping bases in read pairs.

Inputs and Outputs
------------------

In order to correctly correct reads by template, the input BAM must be either 'queryname' sorted or 'query' grouped.
The sort can be done in streaming fashion with:

  samtools sort -n -u in.bam | fgbio CallOverlappingConsensusBases -i /dev/stdin ...

The output sort order may be specified with '--sort-order'. If not given, then the output will be in the same order as
input.

The reference FASTA must be given so that any existing 'NM', 'UQ' and 'MD' tags can be repaired.

Correction
----------

Only mapped read pairs with overlapping bases will be eligible for correction.

Each read base from the read and its mate that map to same position in the reference will be used to create a consensus
base as follows:

  1. If the base agree, then the chosen agreement strategy ('--agreement-strategy') will be used.
  2. If the base disagree, then the chosen disagreement strategy ('--disagreement-strategy') will be used.

The agreement strategies are as follows:

  * Consensus: Call the consensus base and return a new base quality that is the sum of the two base qualities.
  * MaxQual: Call the consensus base and return a new base quality that is the maximum of the two base qualities.
  * PassThrough: Leave the bases and base qualities unchanged.

In the context of disagreement strategies, masking a base will make the base an "N" with base quality phred-value "2".
The disagreement strategies are as follows:

  * MaskBoth: Mask both bases.
  * MaskLowerQual: Mask the base with the lowest base quality, with the other base unchanged. If the base qualities are
    the same, mask both bases.
  * Consensus: Consensus call the base. If the base qualities are the same, mask both bases. Otherwise, call the base
    with the highest base quality and return a new base quality that is the difference between the highest and lowest
    base quality.

CallOverlappingConsensusBases Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file of aligned reads. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file. 
-m FilePath, --metrics=FilePath
                              Output metrics file. 
-r PathToFasta, --ref=PathToFasta
                              Reference sequence fasta file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--threads=Int                 The number of threads to use while consensus calling. [Default: 1]. 
-S SamOrder, --sort-order=SamOrder
                              The sort order of the output. If not given, output will be in the same order as input if
                              the input. [Optional]. Options: Coordinate, Queryname, Random, RandomQuery,
                              TemplateCoordinate, Unsorted, Unknown.
--agreement-strategy=AgreementStrategy
                              The strategy to consensus call when both bases agree. See the usage for more details
                              [Default: Consensus]. Options: Consensus, MaxQual, PassThrough.
--disagreement-strategy=DisagreementStrategy
                              The strategy to consensus call when both bases disagree. See the usage for more details
                              [Default: Consensus]. Options: MaskBoth, MaskLowerQual, Consensus.
```

## fgbio_CollectErccMetrics

### Tool Description
Collects metrics for ERCC spike-ins for RNA-Seq experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
CollectErccMetrics
------------------------------------------------------------------------------------------------------------------------
Collects metrics for ERCC spike-ins for RNA-Seq experiments.

Currently calculates per-transcript ERCC metrics and summarizes dose response, but does not calculate fold-change
response.

The input BAM should contain reads mapped to a reference containing the ERCC transcripts. The reference may have
additional contigs, for example, when concatenating the sample's reference genome and the ERCC transcripts. The BAM
should have sequence lines in the header matching the ERCC ids (ex. ERCC-00130 or ERCC-00004).

The standard ERCC transcripts, including their unique IDs and concentrations, are taken from here
(https://assets.thermofisher.com/TFS-Assets/LSG/manuals/cms_095046.txt). The second column lists the ERCC transcript
identifier which should be present as a sequence line in the BAM header, while columns four and five give the
concentration of the transcript for mixtures #1 and #2.

The choice of mixture to use can be specified with the '--mixture-name' option (either 'Mix1' or 'Mix2'), or with a
file containing a custom list of transcripts and concentrations using the '--custom-mixture' option as follows. The
custom mixture file should be tab-delimited file containing the following columns:

  1. ERCC ID - each ERCC ID should match a contig/reference-sequence name in the input SAM/BAM header.
  2. Concentration - the concentration (in 'attomoles/ul'). The custom mixture file should contain a header line with
     names for each column, though the actual values will be ignored.

Three outputs will be produced:

  1. <output>.ercc_summary_metrics.txt - summary statistics for total # of reads mapping to the ERCC transcripts and
     dose response metrics.
  2. <output>.ercc_detailed_metrics.txt - gives a per-ERCC-transcript expected concentration and observed fragment
     count.
  3. <output>.ercc_metrics.pdf - plots the expected concentration versus the observed fragment count.

Secondary andsupplementary reads will be ignored. A read pair mapping to an ERCC transcript is counted only if both
ends of the pair map to the same ERCC transcript. A minimum mapping quality can be required for reads to be counted as
mapped to an ERCC transcript.

CollectErccMetrics Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file of aligned reads in coordinate order. 
-o PathPrefix, --output=PathPrefix
                              Output prefix. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m ErccMixture, --mixture-name=ErccMixture
                              The name of the standard ERCC mixture. [Optional]. Options: Mix1, Mix2.
                              Cannot be used in conjunction with argument(s): customMixture
--custom-mixture=FilePath     Tab-delimited file containing ERCC IDs and expected concentrations. [Optional].
                              Cannot be used in conjunction with argument(s): mixtureName (m)
-c Int, --min-transcript-count=Int
                              Minimum # of counts required to include an ERCC transcript. [Default: 3].
                              
-M Int, --minimum-mapping-quality=Int
                              The minimum mapping quality [Default: 10].
```

## fgbio_CopyUmiFromReadName

### Tool Description
Copies the UMI at the end of the BAM's read name to the RX tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
CopyUmiFromReadName
------------------------------------------------------------------------------------------------------------------------
Copies the UMI at the end of the BAM's read name to the RX tag.

The read name is split on ':' characters with the last field assumed to be the UMI sequence. The UMI will be copied to
the 'RX' tag as per the SAM specification. If any read does not have a UMI composed of valid bases (ACGTN), the program
will report the error and fail.

If a read name contains multiple UMIs they may be delimited (typically by a hyphen ('-') or plus ('+')). The
'--umi-delimiter' option specifies the delimiter on which to split. The resulting UMI in the 'RX' tag will always be
hyphen delimited.

Some tools (e.g. BCL Convert) may reverse-complement UMIs on R2 and add an 'r' prefix to indicate that the sequence has
been reverse-complemented. By default, the 'r' prefix is removed and the sequence is reverse-complemented back to the
forward orientation. The '--override-reverse-complement-umis' disables the latter behavior, such that the 'r' prefix is
removed but the UMI sequence is left as reverse-complemented.

CopyUmiFromReadName Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              The input BAM file. 
-o PathToBam, --output=PathToBam
                              The output BAM file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--remove-umi[[=true|false]]   Remove the UMI from the read name. [Default: false]. 
--field-delimiter=Char        Delimiter between the read name and UMI. [Default: :]. 
--umi-delimiter=Char          Delimiter between UMI sequences. [Default: +]. 
--override-reverse-complement-umis[[=true|false]]
                              Do not reverse-complement UMIs prefixed with 'r'. [Default: false].
```

## fgbio_DownsampleVcf

### Tool Description
Re-genotypes a VCF after downsampling the allele counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
DownsampleVcf
------------------------------------------------------------------------------------------------------------------------
Re-genotypes a VCF after downsampling the allele counts.

The input VCF must have at least one sample.

If the input VCF contains a single sample, the downsampling target may be specified as a proportion of the original
read depth using '--proportion=(0..1)', or as the combination of the original and target number of sequenced bases
('--originalBases' and '--downsampleToBases'). For multi-sample VCFs, the downsampling target must be specified using
'--downsampleToBases', and a metadata file with the total number of sequenced bases per sample is required as well. The
metadata file must follow the [https://www.internationalgenome.org/category/meta-data/ 1000 Genomes index format], but
the only required columns are 'SAMPLE_NAME' and 'BASE_COUNT'. A propportion for each sample is calculated by dividing
the target number of sequenced bases by the original number of sequenced bases.

The tool first (optionally) winnows the VCF file to remove variants within a distance to each other specified by
'--window-size' (the default value of '0' disables winnowing). Next, each sample at each variant is examined
independently. The allele depths per-genotype are randoml downsampled given the proportion. The downsampled allele
depths are then used to re-compute allele likelhoods and produce a new genotype. In the event that the downsampled
allele depth is below minAdHomref (for HOMREF calls) or minAdHomvar (for HOMVAR calls), the new genotype will be set to
NOCALL. minAdHomvar has a default value of 3 to prevent downsampled VCFs from having an excess proportion of HOMVAR
calls (that a variant caller would likely not call on such weak evidence). minAdHomref has a default value of 1 (i.e.
no HOMREF calls are rejected).

The tool outputs a downsampled VCF file with the winnowed variants removed, and with the genotype calls and 'DP', 'AD',
and 'PL' tags updated for each sample at each retained variant.

DownsampleVcf Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              The vcf to downsample. 
-o PathToVcf, --output=PathToVcf
                              Output file name. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-p Double, --proportion=DoubleProportion of bases to retain (for single-sample VCF). [Optional]. 
-b Double, --original-bases=Double
                              Original number of bases (for single-sample VCF). [Optional]. 
-m FilePath, --metadata=FilePath
                              Index file with bases per sample. [Optional]. 
-n Double, --downsample-to-bases=Double
                              Target number of bases to downsample to. [Optional]. 
-w Int, --window-size=Int     Winnowing window size. [Default: 0]. 
-e Double, --epsilon=Double   Sequencing Error rate for genotyping. [Default: 0.01]. 
-v Int, --min-ad-homvar=Int   Minimum allele depth to call HOMVAR (otherwise NO-CALL) [Default: 3]. 
-r Int, --min-ad-homref=Int   Minimum allele depth to call HOMREF (otherwise NO-CALL) [Default: 1]. 
-c [[true|false]], --write-no-call[[=true|false]]
                              True to write out no-calls. [Default: false]. 
-s Int, --seed=Int            Random seed value. [Default: 42].
```

## fgbio_EstimatePoolingFractions

### Tool Description
Examines sequence data generated from a pooled sample and estimates the fraction of sequence data coming from each

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
EstimatePoolingFractions
------------------------------------------------------------------------------------------------------------------------
Examines sequence data generated from a pooled sample and estimates the fraction of sequence data coming from each
constituent sample. Uses a VCF of known genotypes for the samples within the mixture along with a BAM of sequencing
data derived from the pool. Performs a multiple regression for the alternative allele fractions at each SNP locus,
using as inputs the individual sample's genotypes. Only SNPs that are bi-allelic within the pooled samples are used.

Each sample's contribution of REF vs. ALT alleles at each site is derived in one of two ways: (1) if the sample's
genotype in the VCF has the 'AF' attribute then the value from that field will be used, (2) if the genotype has no 'AF'
attribute then the contribution is estimated based on the genotype (e.g. 0/0 will be 100% ref, 0/1 will be 50% ref and
50% alt, etc.).

Various filtering parameters can be used to control which loci are used:

  * --intervals will restrict analysis to variants within the described intervals
  * --min-genotype-quality will filter out any site with any genotype with GQ < n
  * --min-mean-sample-coverage requires that the coverage of a site in the BAM be >= 'min-mean-sample-coverage *
    n_samples'
  * --min-mapping-quality filters out reads in the BAM with MQ < n
  * --min-base-quality filters out bases in the BAM with Q < n

EstimatePoolingFractions Arguments:
------------------------------------------------------------------------------------------------------------------------
-v PathToVcf, --vcf=PathToVcf VCF of individual sample genotypes. 
-b PathToBam, --bam=PathToBam Path to BAM file of sequencing data. 
-o FilePath, --output=FilePathOutput file to write with pooling fractions. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-l PathToIntervals*, --intervals=PathToIntervals*
                              Zero or more set of regions to restrict analysis to. [Optional]. 
-s String*, --samples=String* Optional subset of samples from VCF to use. [Optional]. 
-n String+, --non-autosomes=String+
                              Non-autosomal chromosomes to avoid. [Default: M, chrM, MT, X, chrX, Y, chrY].
                              
-g Int, --min-genotype-quality=Int
                              Minimum genotype quality. Use -1 to disable. [Default: 30]. 
-c Int, --min-mean-sample-coverage=Int
                              Minimum (sequencing coverage @ SNP site / n_samples). [Default: 6]. 
-m Int, --min-mapping-quality=Int
                              Minimum mapping quality. [Default: 20]. 
-q Int, --min-base-quality=IntMinimum base quality. [Default: 5].
```

## fgbio_EstimateRnaSeqInsertSize

### Tool Description
Computes the insert size for RNA-Seq experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
EstimateRnaSeqInsertSize
------------------------------------------------------------------------------------------------------------------------
Computes the insert size for RNA-Seq experiments.

Computes the insert size by counting the # of bases sequenced in transcript space. The insert size is defined as the
distance between the first bases sequenced of each pair respectively (5' sequencing ends).

This tool skips reads that overlap multiple genes, reads that aren't fully enclosed in a gene, and reads where the
insert size would disagree across transcripts from the same gene. Also skips reads that are unpaired, failed QC,
secondary, supplementary, pairs without both ends mapped, duplicates, and pairs whose reads map to different
chromosomes. Finally, skips transcripts where too few mapped read bases overlap exonic sequence.

This tool requires each mapped pair to have the mate cigar ('MC') tag. Use 'SetMateInformation' to add the mate cigar.

The output metric file will have the extension '.rna_seq_insert_size.txt' and the output histogram file will have the
extension '.rna_seq_insert_size_histogram.txt'. The histogram file gives for each orientation ('FR', 'RF', 'tandem'),
the number of read pairs that had the given insert size.

EstimateRnaSeqInsertSize Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input BAM file. 
-r FilePath, --ref-flat=FilePath
                              Input gene annotations in RefFlat
                              (http://genome.ucsc.edu/goldenPath/gbdDescriptionsOld.html#RefFlat) form 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-p PathPrefix, --prefix=PathPrefix
                              Output prefix file. The file will have the extension '.rna_seq_insert_size.txt' if not
                              given [Optional]. 
-d [[true|false]], --include-duplicates[[=true|false]]
                              Include duplicates [Default: false]. 
-D Double, --deviations=DoubleGenerate mean and standard deviation by filtering to 'median +
                              deviations*median_absolute_deviation'. This is done because insert size data typically
                              includes enough anomalous values from chimeras and other artifacts to make the mean and
                              sd grossly misleading regarding the real distribution. " [Default: 10.0].
                              
-q Int, --minimum-mapping-quality=Int
                              Ignore reads with mapping quality less than this value. [Default: 30]. 
-m Double, --minimum-overlap=Double
                              The minimum fraction of read bases that must overlap exonic sequence in a transcript
                              [Default: 0.95].
```

## fgbio_FindSwitchbackReads

### Tool Description
Finds reads where a template switch occurred during library construction. Some library construction methods, notably

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
FindSwitchbackReads
------------------------------------------------------------------------------------------------------------------------
Finds reads where a template switch occurred during library construction. Some library construction methods, notably
ultra-low-input shotgun methods, are prone to template switching events that create molecules (templates, inserts) that
instead of being a linear copy of a segment of genomic DNA, instead are chimeras formed by starting on one strand of
DNA and then, switching to the opposite strand. Frequently when the switch occurs there may be a small offset between
where the first strand was departed and the opposite strand joined.

Algorithm
---------

Templates that contain strand switch events (switch-backs) are found by this tool in two different ways:

  1. By looking at reads that contain soft-clipped bases at their 5' end that, when reverse complemented, matches the
     genome proximal to the 5'-most mapped base of the read. We call these matches "read based switchbacks". Finding read
     based switchbacks is based on several parameters:
    1. 'max-offset' controls how far away to search for the reverse-complemented sequence. The default value of '35'
       allows matches to be found when the soft-clipped sequence matches the genome starting at most 35bp from the 5'
       mapped position of the read, and reading in the opposite direction.
    2. 'min-length' controls the minimum number of soft-clipped bases that must exist to trigger the search. Given that
       the search looks at '2 * max-offset' locations (default=70) it is important that 'min-length' is set such that
       '4^min-length >> 2 * 'max-offset` in order to avoid false positives.
    3. 'max-error-rate' allows for some mismatches to exist between the soft-clipped sequence and the genome when
       matching.
  2. By identifying templates with 'FF' or 'RR' (aka tandem) orientation where it is surmised that the template switch
     occurred in the un-sequenced region of the template between R1 and R2. We call these 'tandem based switchbacks'. This
     is controlled by a single parameter, 'max-gap', which causes the tool to only identify a tandem read pair as a
     switch-back if the gap between the end of the first read and the start of the second read is '+/- max-gap'.

By default, when a switch-back template is identified, the primary reads are made unmapped (and the original alignment
stored in the OA tag) and all secondary and supplementary alignments are discarded. This can be disabled with the
'--dont-unmap' or '-d' option.

All reads from a switch-back template are also tagged with an 'sb' tag that describes the nature of the switchback. If
the template was identified base on soft-clipped sequence within a read the format is:

'sb:Z:r,[read|mate],{offset},{length}'

If the template is identified due to it's tandem pair orientation then the format is:

'sb:Z:t,{gap}'

Inputs and Outputs
------------------

The tool takes as input a SAM or BAM file, and by default consumes from 'stdin'. The primary output is also a SAM or
BAM file, and defaults to compressed BAM on 'stdout'. This allows the tool to be run immediately after an aligner in a
pipe, e.g. 'bwa mem ref.fa r1.fq r2.fq | fgbio -Xmx8g --ref=ref.fa | ...'.

If the input is neither 'queryname' sorted nor 'queryname' grouped (i.e. all reads with the same name grouped together)
it will be sorted into 'queryname' order by the tool before processing.

By default the output BAM is produced in the order the reads were processed (i.e. the input ordering or queryname
sorted if sorting was required). This can be overridden with the '--sort-order' option.

A number of text files are also produced if the '--metrics' option is specified. E.g. when specifying
'--metrics=s1.switchback' the following files are produced:

  1. 's1.switchback.summary.txt': A table of summary metrics describing the number of reads, switchbacks, etc.
  2. 's1.switchback.lengths.txt': A table of the distribution of observed switchback lengths in read-based switchbacks.
  3. 's1.switchback.offsets.txt': A table of the distribution of observed offsets in read-based switchbacks.
  4. 's1.switchback.gaps.txt': A table of the distribution of gap lengths in tampl
  5. 's1.switchback.plots.pdf': A PDF containing plots of the distributions from 2-4.

Note: because this tool accesses the reference genome in a random manner it pre-loads the entire reference fasta into
memory. As a result the tool is best run with '-Xmx8g' to give it sufficient memory.

FindSwitchbackReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-r PathToFasta, --ref=PathToFasta
                              Reference genome fasta file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-i PathToBam, --input=PathToBam
                              Input BAM file. [Default: /dev/stdin]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathToBam, --output=PathToBam
                              Output BAM file. [Default: /dev/stdout]. 
-m PathPrefix, --metrics=PathPrefix
                              Metrics output file. [Optional]. 
-s SamOrder, --sort-order=SamOrder
                              Output sort order. [Optional]. Options: Coordinate, Queryname, Random,
                              RandomQuery, TemplateCoordinate, Unsorted, Unknown.
-O Int, --max-offset=Int      Maximum offset between end the two segments of the read on the reference. Set to 0 to
                              disable read-based checks. [Default: 35]. 
-g Int, --max-gap=Int         Maximum gap between R1 and R2 of tandem reads to call a template a switchback. Set to 0
                              to disable tandem-based checks. [Default: 500]. 
-l Int, --min-length=Int      Minimum match length of the switched back segment. [Default: 6]. 
-e Double, --max-error-rate=Double
                              Maximum mismatch error rate of switchback match to genome. [Default: 0.1].
                              
-d [[true|false]], --dont-unmap[[=true|false]]
                              IF true, do NOT unmap reads from switchback templates. [Default: false].
```

## fgbio_FindTechnicalReads

### Tool Description
Find reads that are from technical or synthetic sequences in a BAM file. Takes in a BAM file, extracts the read pairs

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
FindTechnicalReads
------------------------------------------------------------------------------------------------------------------------
Find reads that are from technical or synthetic sequences in a BAM file. Takes in a BAM file, extracts the read pairs
and fragment reads that are unmapped, and tests them to see if they are likely generated from a technical sequence
(e.g. adapter dimer).

The identification of reads is done by testing the first N bases (controlled by the match-length parameter) of each
read against all sub-sequences of length N from the technical sequences. Sub-sequences are generated from both the
sequences and the reverse complement of the sequences, ignoring any sub-sequences that include 'N's.

By default the output BAM file will contain all reads that matched to a sub-sequence of the technical sequences and, if
the read is paired, the read's mate pair. An option is available to apply a tag to matched reads (--tag/-t), and if
specified each matching read will be tagged with the 0-based index of the sequence to which it matched. In combination
with tagging it is possible to output all reads (-a/--all-reads) which will re-create the input BAM with the addition
of tags on matching reads.

The default set of sequences include a range of different Illumina adapter sequences with the sample index/barcode
region masked to Ns.

FindTechnicalReads Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM file 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m Int, --match-length=Int    The number of bases at the start of the read to match against. [Default: 15].
                              
-e Int, --max-errors=Int      The maximum number of errors in the matched region. [Default: 1]. 
-s String+, --sequences=String+
                              The set of technical sequences to look for. [Default:
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACGCCTCCCTCGCGCCATCAGAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCTGAGCGGGCTGGCAAGGCAGACCGNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCCGAGCCCACGAGACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG]. 
-a [[true|false]], --all-reads[[=true|false]]
                              Output all reads. [Default: false]. 
-t String, --tag=String       Tag to set to indicate a read is a technical sequence. [Optional].
```

## fgbio_FixVcfPhaseSet

### Tool Description
Adds/fixes the phase set (PS) genotype field.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
FixVcfPhaseSet
------------------------------------------------------------------------------------------------------------------------
Adds/fixes the phase set (PS) genotype field.

The VCF specification allows phased genotypes to be annotated with the 'PS' (phase set) 'FORMAT' field. The value
should be a non-negative integer, corresponding to the position of the first variant in the phase set. Some tools will
output a non-integer value, as well as describe this field as having non-Integer type in the VCF header. This tool will
update the phase set ('PS') 'FORMAT' field to be VCF spec-compliant.

The handling of unphased genotypes with phase-sets is controlled by the '-x' option:

  * If '-x' is used the genotype will be converted to a phased genotype (e.g. '0/1' => '0|1')
  * Otherwise the phase-set ('PS') will be removed from the genotype

The '--keep-original' option may be used to store the original 'PS' value in a new 'OPS' field. The type described in
the header will match the original.

This tool cannot fix phased variants without a phase set, or phased variant sets who have different phase set values.

In some cases, VCFs (e.g. from GIAB/NIST or Platinum Genomes) have illegal header lines, for example, a 'PEDIGREE'
header line without a 'ID' key-value field. The '-z' option can be used to remove those lines. This option is included
in this tool for convenience as those example VCFs in some cases have these illegal header lines, and it is convenient
to fix the phase set in addition to removing those illegal header lines.

FixVcfPhaseSet Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              Input VCF. 
-o PathToVcf, --output=PathToVcf
                              Output VCF. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-k [[true|false]], --keep-original[[=true|false]]
                              Store the original phase set in the 'OPS' field. [Default: false]. 
-x [[true|false]], --phase-genotypes-with-phase-set[[=true|false]]
                              Set unphased genotypes with a PS FORMAT value to be phased. [Default: false].
                              
-z [[true|false]], --remove-no-id-header-lines[[=true|false]]
                              Remove header lines that do not contain an ID key-value, which is required in VCF.
                              [Default: false].
```

## fgbio_GenerateRegionsFromFasta

### Tool Description
Generates a list of 'freebayes'/'bamtools' region specifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
GenerateRegionsFromFasta
------------------------------------------------------------------------------------------------------------------------
Generates a list of 'freebayes'/'bamtools' region specifiers.

GenerateRegionsFromFasta Arguments:
------------------------------------------------------------------------------------------------------------------------
--input=PathToFasta           The input FASTA. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--output=Path                 The output. [Default: /dev/stdout]. 
--region-size=Int             The size of the regions to output. [Default: 100000].
```

## fgbio_HapCutToVcf

### Tool Description
Converts the output of 'HAPCUT' ('HapCut1'/'HapCut2') to a VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
HapCutToVcf
------------------------------------------------------------------------------------------------------------------------
Converts the output of 'HAPCUT' ('HapCut1'/'HapCut2') to a VCF.

The output of 'HAPCUT' does not include all input variants, but simply those variants that are in phased blocks. This
tool takes the original VCF and the output of 'HAPCUT', and produces a VCF containing both the variants that were
phased and the variants that were not phased, such that all variants in the original file are in the output.

The original VCF provided to 'HAPCUT' is assumed to contain a single sample, as 'HAPCUT' only supports a single sample.

By default, all phased genotypes are annotated with the 'PS' (phase set) 'FORMAT' tag, which by convention is the
position of the first variant in the phase set (see the VCF specification). Furthermore, this tool formats the alleles
of a phased genotype using the '|' separator instead of the '/' separator, where the latter indicates the genotype is
unphased. If the option to output phased variants in GATK's 'ReadBackedPhasing' format is used, then the first variant
in a phase set will have '/' instead of '|' separating its alleles. Also, all phased variants will have 'PASS' set in
its 'FILTER' column, while unphased variants will have 'NotPhased' set in their 'FILTER' column. Unlike GATK's
'ReadBackedPhasing', homozygous variants will always be unphased.

More information about the purpose and operation of GATK's Read-backed phasing, including its output format, can be
found in the GATK Forum
(http://gatkforums.broadinstitute.org/gatk/discussion/45/purpose-and-operation-of-read-backed-phasing)

Additional 'FORMAT' fields for phased variants are provided corresponding to per-genotype information produced by
'HapCut1':

  1. The 'RC' tag gives the counts of calls supporting 'allele0' and 'allele1' respectively.
  2. The 'LC' tag gives the change in likelihood if this SNP is made homozygous or removed.
  3. The 'MCL' tag gives the maximum change in likelihood if this SNP is made homozygous or removed.
  4. The 'RMEC' tag gives the reduction in 'MEC' score if we remove this variant altogether.

Additional 'FORMAT' fields for phased variants are provided corresponding to per-genotype information produced by
'HapCut2':

  1. The 'PR' tag is '1' if 'HapCut2' pruned this variant, '0' otherwise.
  2. The 'SE' tag gives the confidence ('log10') that there is not a switch error occurring immediately before the SNV
     (closer to zero means that a switch error is more likely).
  3. The 'NE' tag gives the confidence ('log10') that the SNV is not a mismatch (single SNV) error (closer to zero
     means a mismatch is more likely).

HapCut2 should not be run with '--call-homozygous' as the genotypes may be different than the input and so is not
currently supported.

For more information about 'HapCut1', see the source code or paper below. source code:
https://github.com/vibansal/hapcut HapCut1 paper: An efficient and accurate algorithm for the haplotype assembly
problem Bioinformatics. 2008 Aug 15;24(16):i153-9.

For more information about 'HapCut2', see the source code (https://github.com/vibansal/HapCUT2) below.

HapCutToVcf Arguments:
------------------------------------------------------------------------------------------------------------------------
-v PathToVcf, --vcf=PathToVcf The original VCF provided to 'HapCut1'/'HapCut2'. 
-i FilePath, --input=FilePath The file produced by 'HapCut1'/'HapCut2'. 
-o PathToVcf, --output=PathToVcf
                              The output VCF with both phased and unphased variants. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r [[true|false]], --gatk-phasing-format[[=true|false]]
                              Output phased variants in GATK's 'ReadBackedPhasing' format. [Default: false].
                              
--fix-ambiguous-reference-alleles[[=true|false]]
                              Fix IUPAC codes in the original VCF to be VCF 4.3 spec-compliant (ex 'R' -> 'A'). Does
                              not support BCF inputs. [Default: false].
```

## fgbio_MakeMixtureVcf

### Tool Description
Creates a VCF with one sample whose genotypes are a mixture of other samples'.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
MakeMixtureVcf
------------------------------------------------------------------------------------------------------------------------
Creates a VCF with one sample whose genotypes are a mixture of other samples'.

The input VCF must contain all samples to be mixed, and may optionally contain other samples. Sample mixtures can be
specified in one of several ways:

  1. '--samples s1 s2 s3': specifies that the samples with names 's1', 's'2 and 's3' should be mixed equally.
  2. ' --samples s1@0.1 s2@0.1 s3@0.8': specifies that the three samples should be mixed at '0.1', '0.1', and '0.8'
     respectively
  3. '--samples s1@0.1 s2 s3': specifies that 's1' should form '0.1' of the mixture and that the remaining ('0.9')
     should be equally split amongst 's2' and s'3'
  4. If no sample names are given, all samples in the input VCF will be used, mixing equally

The input samples are assumed to be diploid with the allele fraction defined by the genotype ('0/0', '0/1' or '1/1').
The '--allele-fraction-field' option may be specified, in which case the allele fraction of the input genotypes will be
retrieved from the specified 'FORMAT' field in the VCF genotypes. All genotypes except hom-ref and no-call genotypes
must have this field present if supplied.

If the --'no-call-is-hom-ref' flag is 'true' (the default) then no-call genotypes in the input VCF are interpreted as
hom-ref genotypes. If it is 'false', any location with a no-call genotype will be emitted as a no-call in the mixture,
and will be filtered.

MakeMixtureVcf Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              Input VCF containing genotypes for the samples to be mixed. 
-o PathToVcf, --output=PathToVcf
                              Output VCF of mixture sample. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-s String*, --samples=String* Samples to mix. See general usage for format and examples. [Optional]. 
-S String, --output-sample-name=String
                              Output sample name. [Default: mixture]. 
-N [[true|false]], --no-call-is-hom-ref[[=true|false]]
                              Treat no-calls for samples as hom-ref genotypes. [Default: true]. 
-a String, --allele-fraction-field=String
                              Format field containing allele fraction. [Optional]. 
-p Int, --precision=Int       Digits of precision in generated allele fractions. [Default: 5].
```

## fgbio_MakeTwoSampleMixtureVcf

### Tool Description
Creates a simulated tumor or tumor/normal VCF by in-silico mixing genotypes from two samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
MakeTwoSampleMixtureVcf
------------------------------------------------------------------------------------------------------------------------
Creates a simulated tumor or tumor/normal VCF by in-silico mixing genotypes from two samples.

The tumor genotypes are created by mixing the incoming genotypes for the for the 'tumor' sample and the incoming
genotypes for the 'normal' samples with the 'tumor' alleles accounting for 'tumorFraction' of the resulting mixture and
the 'normal' alleles accounting for '1 - tumorFraction' of the resulting mixture (see '--tumor-fraction'). E.g. if the
'tumor' genotype is 'A/C', the 'normal' genotype is 'C/C', and 'tumorFraction' is set at 0.5, then the resulting tumor
genotype will be 'A/C' with an allele fraction of '0.75'. The resulting allele fraction is written to the 'AF' info
field in the VCF.

In tumor-only mode ('--tumor-only') only tumor genotypes are output. In tumor/normal mode genotypes for the 'normal'
samples are also emitted, and match the genotypes from the input sample.

All loci (potentially restricted by intervals) that are variant in one or both samples are written to the output VCF,
though in several cases the variants will be filtered:

  * If either of the tumor or normal sample is no-called the resulting locus will have the 'unknown_gt' filter applied
  * If the tumor and the normal have more than one alternative allele between them the 'multi_allelic' filter will be
    applied
  * In tumor/normal mode (as opposed to tumor-only) loci that have an alt allele in the normal sample will have the
    'alt_allele_in_normal' filter applied

MakeTwoSampleMixtureVcf Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToVcf, --input=PathToVcf
                              Input VCF file. 
-o PathToVcf, --output=PathToVcf
                              Output VCF file. 
-t String, --tumor=String     Name of the 'tumor' sample in the input VCF. 
-n String, --normal=String    Name of the 'normal' sample in the input VCF. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-f Double, --tumor-fraction=Double
                              What fraction of the mixture comes from the 'tumor' sample. [Default: 0.5].
                              
-T [[true|false]], --tumor-only[[=true|false]]
                              Tumor only mode - only output tumor genotypes and don't filter sites. [Default:
                              false]. 
-N [[true|false]], --no-call-is-hom-ref[[=true|false]]
                              Treat no-calls for either sample as hom-ref genotypes. [Default: true].
                              
-l PathToIntervals, --intervals=PathToIntervals
                              Optional set of intervals to restrict to. [Optional].
```

## fgbio_PickIlluminaIndices

### Tool Description
Picks a set of molecular indices that should work well together.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
PickIlluminaIndices
------------------------------------------------------------------------------------------------------------------------
Picks a set of molecular indices that should work well together.

The indexes to evaluate are generated randomly, unless the '--candidates' option is given. The latter specifies a path
to a file with one index per line from which indices are picked.

PickIlluminaIndices Arguments:
------------------------------------------------------------------------------------------------------------------------
-n Int, --indices=Int         The number of indices desired. 
-o FilePath, --output=FilePathFile to write indices to. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-l Int, --length=Int          The length of each barcode sequence. [Default: 8]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-e Int, --edit-distance=Int   The minimum edit distance between two indices in the set. [Default: 3].
                              
--allow-reverses[[=true|false]]
                              Allow indices that are lexical reverses of one another [Default: false].
                              
--allow-reverse-complements[[=true|false]]
                              Allow indices that are reverse complements of one another [Default: false].
                              
--allow-palindromes[[=true|false]]
                              Allow indices that are palindromic ('bases == rev(bases)'). [Default: false].
                              
--max-homopolymer=Int         Reject indices with a homopolymer of greater than this length. [Default: 2].
                              
--min-gc=Double               The minimum GC fraction for a barcode to be accepted. [Default: 0.0]. 
--max-gc=Double               The maximum GC fraction for a barcode to be accepted. [Default: 0.7]. 
-t Int, --threads=Int         Number of threads to use. [Default: 4]. 
--vienna-rna-dir=DirPath      The installation directory for 'ViennaRNA'. [Optional]. 
--min-delta-g=Double          The lowest acceptable secondary structure 'deltaG'. [Default: -10.0]. 
--adapters=String+            The indexed adapter sequence into which the indices will be integrated. [Default:
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG]. 
--avoid-sequence=String+      Sequences that should be avoided. Any kmer of 'length' that appears in these sequences
                              and their reverse complements will be thrown out. [Default:
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACGCCTCCCTCGCGCCATCAGAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCTGAGCGGGCTGGCAAGGCAGACCGNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCCGAGCCCACGAGACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG]. 
--candidates=FilePath         The candidate indices from which to choose with one index per line (nothing else),
                              otherwise generate all possible indices [Optional].
```

## fgbio_PickLongIndices

### Tool Description
Picks a set of molecular indices that have at least a given number of mismatches between them. Whereas

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
PickLongIndices
------------------------------------------------------------------------------------------------------------------------
Picks a set of molecular indices that have at least a given number of mismatches between them. Whereas
'PickIlluminaIndices' attempts to pick a near-optimal set of indices, 'PickLongIndices' implements a significantly more
efficient method based on generation of random indices that can generate a large set of satisfactory indices in a small
amount of time and memory even for index lengths '>> 10bp'.

Many options exist for controlling aspects of the indices picked, including length, edit distance (mismatches only), gc
range, homopolymer content, secondary structure etc.

Secondary structure is predicted using ViennaRNA's 'RNAfold' in DNA mode. To enable structure checking both the
'--vienna-rna-dir' and '--adapters' must be specified. Adapters must be strings of A, C, G, and T with a single block
of Ns (e.g. 'ACGTNNNN' or 'ACNNNNGT'). At runtime the Ns are replaced with indices, and 'deltaG' of the
index-containing sequence is calculated.

The number of indices requested may not be possible to produce given other constraints. When this is the case the tool
will output as many indices as possible, though less than the requested number. In such cases it may be useful to try
different values for '--attempt'. This parameter controls how many attempts are made to find the next valid index
before quitting and outputting the accumulated indices. Higher values will yield incrementally more indices but require
significantly longer runtimes.

A file of existing indices may be provided. Existing indices must be of the same length as requested indices and
composed of A, C, G and Ts, but are subject to no other constraints. Index picking will then built a set comprised of
the existing indices, and new indices which satisfy all constraints. Existing indices are included in the generated
output file.

PickLongIndices Arguments:
------------------------------------------------------------------------------------------------------------------------
-n Int, --number-of-indices=Int
                              The number of indices desired. 
-o FilePath, --output=FilePathFile to write indices to. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-l Int, --length=Int          The length of each index sequence. [Default: 8]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-e Int, --edit-distance=Int   The minimum edit distance between two indices in the set. [Default: 3].
                              
--allow-reverses[[=true|false]]
                              Allow indices that are lexical reverses of one another [Default: false].
                              
--allow-reverse-complements[[=true|false]]
                              Allow indices that are reverse complements of one another [Default: false].
                              
--allow-palindromes[[=true|false]]
                              Allow indices that are palindromic ('index == revcomp(index)'). [Default:
                              false]. 
--max-homopolymer=Int         Reject indices with a homopolymer of greater than this length. [Default: 2].
                              
-g Double, --min-gc=Double    The minimum GC fraction for an index to be accepted. [Default: 0.2]. 
-G Double, --max-gc=Double    The maximum GC fraction for an index to be accepted. [Default: 0.8]. 
--existing=FilePath           File of existing index sequences to integrate, one per line. [Optional].
                              
-s Long, --seed=Long          Random seed value. [Default: 1]. 
-a Int, --attempts=Int        Attempts to pick the next index before quitting. [Default: 100000]. 
--vienna-rna-dir=DirPath      The installation directory for 'ViennaRNA'. [Optional]. 
-t Double, --temperature=Double
                              The temperature at which to predict secondary structure. [Default: 25.0].
                              
--min-delta-g=Double          The lowest acceptable secondary structure 'deltaG'. [Default: -10.0]. 
--adapters=String*            Adapter sequence(s) into which indices will be inserted. [Optional]. 
--avoid-sequence=String+      Any index sequence that appears in an avoid sequence or its reverse complement will be
                              discarded. [Default: AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACGCCTCCCTCGCGCCATCAGAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCTGAGCGGGCTGGCAAGGCAGACCGNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG,
                              CTGTCTCTTATACACATCTCCGAGCCCACGAGACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACNNNNNNNNACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG].
```

## fgbio_RandomizeBam

### Tool Description
Randomizes the order of reads in a SAM or BAM file. Randomization is done by sorting on a hash of the 'queryname' (and

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
RandomizeBam
------------------------------------------------------------------------------------------------------------------------
Randomizes the order of reads in a SAM or BAM file. Randomization is done by sorting on a hash of the 'queryname' (and
bases and quals if not query-grouping). By default reads with the same query name are grouped together in the output
file; this can be turned off by specifying --query-group=false.

RandomizeBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
-i PathToBam, --input=PathToBam
                              The input SAM or BAM file. [Default: /dev/stdin]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-o PathToBam, --output=PathToBam
                              The output SAM or BAM file. [Default: /dev/stdout]. 
-s Int, --seed=Int            Random seed. [Default: 42]. 
-q [[true|false]], --query-group[[=true|false]]
                              Group together reads by queryname. [Default: true].
```

## fgbio_RemoveSamTags

### Tool Description
Removes SAM tags from a SAM or BAM file. If no tags to remove are given, the original file is produced.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
RemoveSamTags
------------------------------------------------------------------------------------------------------------------------
Removes SAM tags from a SAM or BAM file. If no tags to remove are given, the original file is produced.

RemoveSamTags Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM. 
-o PathToBam, --output=PathToBam
                              Output SAM or BAM. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-t String*, --tags-to-remove=String*
                              The tags to remove. [Optional].
```

## fgbio_ReviewConsensusVariants

### Tool Description
Extracts data to make reviewing of variant calls from consensus reads easier. Creates a list of variant sites from the

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
ReviewConsensusVariants
------------------------------------------------------------------------------------------------------------------------
Extracts data to make reviewing of variant calls from consensus reads easier. Creates a list of variant sites from the
input VCF (SNPs only) or IntervalList then extracts all the consensus reads that do not contain a reference allele at
the the variant sites, and all raw reads that contributed to those consensus reads. This will include consensus reads
that carry the alternate allele, a third allele, a no-call or a spanning deletion at the variant site.

Reads are correlated between consensus and grouped BAMs using a molecule ID stored in an optional attribute, 'MI' by
default. In order to support paired molecule IDs where two or more molecule IDs are related (e.g. see the Paired
assignment strategy in GroupReadsByUmi) the molecule ID is truncated at the last '/' if present (e.g. '1/A => 1' and '2
=> 2').

Both input BAMs must be coordinate sorted and indexed.

A pair of output BAMs named '<output>.consensus.bam' and '<output>.grouped.bam' are created with the relevant reads
from each input BAM, and a review file '<output>.txt' is created. The review file contains details on each variant
position along with detailed information on each consensus read that supports the variant. If the sample-name argument
is supplied and the input is VCF, genotype information for that sample will be retrieved. If the sample-name isn't
supplied and the VCF contains only a single sample then those genotypes will be used.

ReviewConsensusVariants Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath Input VCF or IntervalList of variant locations. 
-c PathToBam, --consensus-bam=PathToBam
                              BAM file of consensus reads used to call variants. 
-g PathToBam, --grouped-bam=PathToBam
                              BAM file of grouped raw reads used to build consensuses. 
-r PathToFasta, --ref=PathToFasta
                              Reference fasta file. 
-o PathPrefix, --output=PathPrefix
                              Basename of output files to create. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-s String, --sample=String    Name of the sample being reviewed. [Optional]. 
-N [[true|false]], --ignore-ns-in-consensus-reads[[=true|false]]
                              Ignore N bases in the consensus reads. [Default: false]. 
-m Double, --maf=Double       Only output detailed information for variants at maf and below. [Default: 0.05].
```

## fgbio_SplitBam

### Tool Description
Splits a BAM into multiple BAMs, one per-read group (or library).

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
SplitBam
------------------------------------------------------------------------------------------------------------------------
Splits a BAM into multiple BAMs, one per-read group (or library).

The resulting BAMs will be named '<output-prefix>.<read-group-id>.bam', or '<output-prefix>.<library-name>.bam' when
splitting by the library. All reads without a read group, or without a library when splitting by library, will be
written to '<output-prefix>.unknown.bam'. If no such reads exist, then no such file will exist.

By default, async writing of BAM files is controlled by the '--async-io' common tool option to increase performance. If
the input BAM has significantly more read groups (or libraries) than your system has CPUs it is recommended to disable
this feature for this tool using '--no-async-writing'. Asynchronous reading is not affected.

SplitBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToBam, --input=PathToBam
                              Input SAM or BAM file. 
-o PathPrefix, --output=PathPrefix
                              Output prefix for all SAM or BAM files (ex. output/sample-name). 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-s SplitType, --split-by=SplitType
                              Split by library instead of read group [Default: ReadGroup]. Options:
                              Library, ReadGroup.
-u String, --unknown=String   The name to use for the unknown file [Default: unknown]. 
--no-async-writing[[=true|false]]
                              Do not write the records asynchronously. Use this to reduce memory usage when many read
                              groups/libraries are present. [Default: false].
```

## fgbio_SplitTag

### Tool Description
Splits an optional tag in a SAM or BAM into multiple optional tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
SplitTag
------------------------------------------------------------------------------------------------------------------------
Splits an optional tag in a SAM or BAM into multiple optional tags.

SplitTag Arguments:
------------------------------------------------------------------------------------------------------------------------
--input=PathToBam             Input SAM or BAM. 
--output=PathToBam            Output SAM or BAM. 
--tag-to-split=String         Tag to split. 
--tags-to-output=String+      Tag(s) to output. There should be one per produced token. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--delimiter=String            The delimiter used to split the string. [Default: -].
```

## fgbio_StripFastqReadNumbers

### Tool Description
Removes trailing /# from read names in fastq. Read names that end in a slash and a single digit will have the slash and

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
StripFastqReadNumbers
------------------------------------------------------------------------------------------------------------------------
Removes trailing /# from read names in fastq. Read names that end in a slash and a single digit will have the slash and
digit removed. Read names that do not end with a slash and a number will be untouched.

StripFastqReadNumbers Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFastq, --input=PathToFastq
                              Input fastq file. 
-o PathToFastq, --output=PathToFastq
                              Output fastq file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false].
```

## fgbio_SummarizeGff

### Tool Description
Takes in a RefSeq GFF and produces some summary statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
SummarizeGff
------------------------------------------------------------------------------------------------------------------------
Takes in a RefSeq GFF and produces some summary statistics.

SummarizeGff Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath Input RefSeq GFF 
-r PathToFasta, --ref=PathToFasta
                              Reference sequence fasta. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false].
```

## fgbio_UpdateDelimitedFileContigNames

### Tool Description
Updates the contig names in columns of a delimited data file (e.g. CSV, TSV).

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio/overview
- **Validation**: PASS

### Original Help Text
```text
UpdateDelimitedFileContigNames
------------------------------------------------------------------------------------------------------------------------
Updates the contig names in columns of a delimited data file (e.g. CSV, TSV).

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary. Use '--skip-missing' to ignore lines where a
contig name could not be updated (i.e. missing from the sequence dictionary).

UpdateDelimitedFileContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath Input delimited data file. 
-d PathToSequenceDictionary, --dict=PathToSequenceDictionary
                              The path to the sequence dictionary with contig aliases. 
-c Int+, --columns=Int+       The column indices for the contig names (0-based). 
-o FilePath, --output=FilePathOutput delimited data file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-T Char, --delimiter=Char     The delimiter [Default: \t]. 
-H String, --comment=String   Treat lines with this starting string as comments (always printed) [Default: #].
                              
-n Int, --output-first-num-lines=Int
                              Output the first 'N' lines as-is (always printed). [Default: 0]. 
--skip-missing[[=true|false]] Skip contigs in the delimited file that are not found in the sequence dictionary.
                              [Default: false]. 
-s SortOrder, --sort-order=SortOrder
                              Sort the output based on the following order. [Default: Unsorted]. Options:
                              Unsorted, ByContigOnly, ByCoordinate.
--contig=Int                  The column index for the contig (0-based) for sorting. Use the first column if not given.
                              [Optional]. 
--position=Int                The column index for the genomic position (0-based) for sorting by coordinate.
                              [Optional]. 
--max-objects-in-ram=Int      The maximum number of objects to store in memory [Default: 1000000].
```

## Metadata
- **Skill**: generated
