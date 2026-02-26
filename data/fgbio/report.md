# fgbio CWL Generation Report

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

