# fgbio CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fgbio_AnnotateBamWithUmis | PASS |  |
| fgbio_AssessPhasing | PASS |  |
| fgbio_CallCodecConsensusReads | Not completed | no CODEC test data; it runs on duplex-seq read pairs, but that output cannot confirm CODEC consensus calls. |
| fgbio_CallDuplexConsensusReads | PASS |  |
| fgbio_CallMolecularConsensusReads | PASS |  |
| fgbio_ClipBam | PASS |  |
| fgbio_CollectAlternateContigNames | PASS |  |
| fgbio_CollectDuplexSeqMetrics | PASS |  |
| fgbio_CorrectUmis | PASS |  |
| fgbio_DemuxFastqs | PASS |  |
| fgbio_DownsampleAndNormalizeBam | PASS |  |
| fgbio_ErrorRateByReadPosition | PASS |  |
| fgbio_ExtractBasecallingParamsForPicard | PASS |  |
| fgbio_ExtractIlluminaRunInfo | PASS |  |
| fgbio_ExtractUmisFromBam | PASS |  |
| fgbio_FastqToBam | PASS |  |
| fgbio_FilterBam | PASS |  |
| fgbio_FilterConsensusReads | PASS |  |
| fgbio_FilterSomaticVcf | PASS | ran on germline GIAB calls with a matching NA12878 BAM (no somatic test data); ATAP and ERFAP annotations added |
| fgbio_GroupReadsByUmi | PASS |  |
| fgbio_HardMaskFasta | PASS |  |
| fgbio_SetMateInformation | PASS |  |
| fgbio_SortBam | PASS |  |
| fgbio_SortFastq | PASS |  |
| fgbio_SortSequenceDictionary | PASS |  |
| fgbio_TrimFastq | PASS |  |
| fgbio_TrimPrimers | PASS | synthetic data: primer coordinates planted at the ends of real read pairs; primers trimmed and mate fields updated |
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


## Metadata
- **Skill**: generated
