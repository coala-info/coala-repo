# fgbio-minimal CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fgbio-minimal_CollectAlternateContigNames | PASS |  |
| fgbio-minimal_DemuxFastqs | PASS |  |
| fgbio-minimal_ExtractBasecallingParamsForPicard | PASS |  |
| fgbio-minimal_ExtractIlluminaRunInfo | PASS |  |
| fgbio-minimal_FastqToBam | PASS |  |
| fgbio-minimal_HardMaskFasta | PASS |  |
| fgbio-minimal_SortFastq | PASS |  |
| fgbio-minimal_SortSequenceDictionary | PASS |  |
| fgbio-minimal_TrimFastq | PASS |  |
| fgbio-minimal_UpdateFastaContigNames | PASS |  |
| fgbio-minimal_UpdateIntervalListContigNames | PASS |  |

## fgbio-minimal_UpdateFastaContigNames

### Tool Description
Updates the sequence names in a FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:34:32 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

UpdateFastaContigNames
------------------------------------------------------------------------------------------------------------------------
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

UpdateFastaContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFasta, --input=PathToFasta
                              Input FASTA. 
-d PathToSequenceDictionary, --dict=PathToSequenceDictionary
                              The path to the sequence dictionary with contig aliases. 
-o PathToFasta, --output=PathToFasta
                              Output FASTA. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-l Int, --line-length=Int     Line length or sequence lines. [Default: 100]. 
--skip-missing[[=true|false]] Skip contigs in the FASTA that are not found in the sequence dictionary. [Default:
                              false]. 
--sort-by-dict[[=true|false]] Sort the contigs based on the input sequence dictionary. [Default: false].
                              
--default-contigs=PathToFasta Add sequences from this FASTA when contigs in the sequence dictionary are missing from
                              the input FASTA. [Optional].
```

## fgbio-minimal_HardMaskFasta

### Tool Description
Converts soft-masked sequence to hard-masked in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:33:40 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

HardMaskFasta
------------------------------------------------------------------------------------------------------------------------
Converts soft-masked sequence to hard-masked in a FASTA file. All lower case bases are converted to Ns, all other bases
are left unchanged. Line lengths are also standardized to allow easy indexing with 'samtools faidx'"

HardMaskFasta Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFasta, --input=PathToFasta
                              Input FASTA file. 
-o PathToFasta, --output=PathToFasta
                              Output FASTA file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-l Int, --line-length=Int     Line length or sequence lines. [Default: 100].
```

## fgbio-minimal_ExtractBasecallingParamsForPicard

### Tool Description
Extracts sample and library information from an sample sheet for a given lane.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:33:03 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

ExtractBasecallingParamsForPicard
------------------------------------------------------------------------------------------------------------------------
Extracts sample and library information from an sample sheet for a given lane.

The sample sheet should be an Illumina Experiment Manager sample sheet. The tool writes two files to the output
directory: a barcode parameter file and a library parameter file.

The barcode parameter file is used by Picard's 'ExtractIlluminaBarcodes' and 'CollectIlluminaBasecallingMetrics' to
determine how to match sample barcodes to each read. The parameter file will be written to the output directory with
name 'barcode_params.<lane>.txt'.

The library parameter file is used by Picard's 'IlluminaBasecallsToSam' to demultiplex samples and name the output BAM
file path for each sample output BAM file. The parameter file will be written to the output directory with name
'library_params.<lane>.txt'. The path to each sample's BAM file will be specified in the library parameter file. Each
BAM file will have path '<output>/<sample-name>.<barcode-sequence>.<lane>.bam'.

ExtractBasecallingParamsForPicard Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath The input sample sheet. 
-o DirPath, --output=DirPath  The output folder to where per-lane parameter files should be written. 
-l Int+, --lanes=Int+         The lane(s) (1-based) for which to write per-lane parameter files. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-b DirPath, --bam-output=DirPath
                              Optional output folder to where per-lane BAM files should be written, otherwise the
                              output directory will be used. [Optional].
```

## fgbio-minimal_ExtractIlluminaRunInfo

### Tool Description
Extracts information about an Illumina sequencing run from the RunInfo.xml.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:33:15 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

ExtractIlluminaRunInfo
------------------------------------------------------------------------------------------------------------------------
Extracts information about an Illumina sequencing run from the RunInfo.xml.

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

ExtractIlluminaRunInfo Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath The input RunInfo.xml typically found in the run folder. 
-o FilePath, --output=FilePathThe output file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false].
```

## fgbio-minimal_SortSequenceDictionary

### Tool Description
Sorts a sequence dictionary file in the order of another sequence dictionary.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:34:06 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

SortSequenceDictionary
------------------------------------------------------------------------------------------------------------------------
Sorts a sequence dictionary file in the order of another sequence dictionary.

The inputs are to two '*.dict' files. One to be sorted, and the other to provide the order for the sorting.

If there is a contig in the input dictionary that is not in the sorting dictionary, that contig will be appended to the
end of the sequence dictionary in the same relative order to other appended contigs as in the input dictionary. Missing
contigs can be omitted by setting '--skip-missing-contigs' to true.

If there is a contig in the sorting dictionary that is not in the input dictionary, that contig will be ignored.

The output will be a sequence dictionary, containing the version header line and one line per contig. The fields of the
entries in this dictionary will be the same as in input, but in the order of '--sort-dictionary'.

SortSequenceDictionary Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToSequenceDictionary, --input=PathToSequenceDictionary
                              Input sequence dictionary file to be sorted. 
-d PathToSequenceDictionary, --sort-dictionary=PathToSequenceDictionary
                              Input sequence dictionary file containing contigs in the desired sort order. 
-o PathToSequenceDictionary, --output=PathToSequenceDictionary
                              Output sequence dictionary file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--skip-missing-contigs[[=true|false]]
                              Skip input contigs that have no matching contig in the sort dictionary rather than
                              appending to the end of the output dictionary. [Default: false].
```

## fgbio-minimal_CollectAlternateContigNames

### Tool Description
Collates the alternate contig names from an NCBI assembly report.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:32:39 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

CollectAlternateContigNames
------------------------------------------------------------------------------------------------------------------------
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

CollectAlternateContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i FilePath, --input=FilePath Input NCBI assembly report file. 
-o PathToSequenceDictionary, --output=PathToSequenceDictionary
                              Output sequence dictionary file. 
-a AssemblyReportColumn+, --alternates=AssemblyReportColumn+
                              The assembly report column(s) for the alternate contig name(s) Options:
                              SequenceName, AssignedMolecule, GenBankAccession, RefSeqAccession, UcscName.
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-p AssemblyReportColumn, --primary=AssemblyReportColumn
                              The assembly report column for the primary contig name. [Default:
                              RefSeqAccession]. Options: SequenceName, AssignedMolecule, GenBankAccession,
                              RefSeqAccession, UcscName.
-s SequenceRole*, --sequence-roles=SequenceRole*
                              Only output sequences with the given sequence roles. If none given, all sequences will be
                              output. [Optional]. Options: AssembledMolecule, AltScaffold, FixPatch,
                              NovelPatch, UnlocalizedScaffold, UnplacedScaffold.
-d PathToSequenceDictionary, --existing=PathToSequenceDictionary
                              Update an existing sequence dictionary file. The primary names must match.
                              [Optional].  Cannot be used in conjunction with argument(s):
                              sortBySequencingRole
-x [[true|false]], --allow-mismatching-lengths[[=true|false]]
                              Allow mismatching sequence lengths when using an existing sequence dictionary file.
                              [Default: false]. 
--skip-missing-alternates[[=true|false]]
                              Skip contigs that have no alternates [Default: true]. 
--sort-by-sequencing-role[[=true|false]]
                              Sort by the sequencing role (only when not updating an existing sequence dictionary
                              file). Uses the order from '--sequence-roles' if provided. [Default: false].
                              Cannot be used in conjunction with argument(s): existing (d)
```

## fgbio-minimal_UpdateIntervalListContigNames

### Tool Description
Updates the sequence names in an Interval List file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:34:44 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

UpdateIntervalListContigNames
------------------------------------------------------------------------------------------------------------------------
Updates the sequence names in an Interval List file.

The name of each sequence must match one of the names (including aliases) in the given sequence dictionary. The new
name will be the primary (non-alias) name in the sequence dictionary.

Use '--skip-missing' to ignore intervals where a contig name could not be updated (i.e. missing from the sequence
dictionary).

UpdateIntervalListContigNames Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToIntervals, --input=PathToIntervals
                              Input interval list. 
-d PathToSequenceDictionary, --dict=PathToSequenceDictionary
                              The path to the sequence dictionary with contig aliases. 
-o PathToIntervals, --output=PathToIntervals
                              Output interval list. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
--skip-missing[[=true|false]] Skip contigs in the interval list that are not found in the sequence dictionary.
                              [Default: false].
```

## fgbio-minimal_SortFastq

### Tool Description
Sorts a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:33:53 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

SortFastq
------------------------------------------------------------------------------------------------------------------------
Sorts a FASTQ file. Sorts the records in a FASTQ file based on the lexicographic ordering of their read names. Input
and output files can be either uncompressed or gzip-compressed.

SortFastq Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFastq, --input=PathToFastq
                              Input fastq file. 
-o PathToFastq, --output=PathToFastq
                              Output fastq file. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m Int, --max-records-in-ram=Int
                              Maximum records to keep in RAM at one time. [Default: 500000].
```

## fgbio-minimal_TrimFastq

### Tool Description
Trims reads in one or more line-matched fastq files to a specific read length.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:34:19 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

TrimFastq
------------------------------------------------------------------------------------------------------------------------
Trims reads in one or more line-matched fastq files to a specific read length. The individual fastq files are expected
to have the same set of reads, as would be the case with an 'r1.fastq' and 'r2.fastq' file for the same sample.

Optionally supports dropping of reads across all files when one or more reads is already shorter than the desired trim
length.

Input and output fastq files may be gzipped.

TrimFastq Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFastq+, --input=PathToFastq+
                              One or more input fastq files. 
-o PathToFastq+, --output=PathToFastq+
                              A matching number of output fastq files. 
-l Int+, --length=Int+        Length to trim reads to (either one per input fastq file, or one for all). 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-x [[true|false]], --exclude[[=true|false]]
                              Exclude reads below the trim length. [Default: false].
```

## fgbio-minimal_DemuxFastqs

### Tool Description
Performs sample demultiplexing on FASTQs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:32:51 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

DemuxFastqs
------------------------------------------------------------------------------------------------------------------------
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

DemuxFastqs Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFastq+, --inputs=PathToFastq+
                              One or more input fastq files each corresponding to a sub-read (ex. index-read, read-one,
                              read-two, fragment). 
-o DirPath, --output=DirPath  The output directory in which to place sample BAMs. 
-x FilePath, --metadata=FilePath
                              A file containing the metadata about the samples. 
-r ReadStructure+, --read-structures=ReadStructure+
                              The read structure for each of the FASTQs. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-m FilePath, --metrics=FilePath
                              The file to which per-barcode metrics are written. If none given, a file named
                              'demux_barcode_metrics.txt' will be written to the output directory. [Optional].
                              
-c String, --column-for-sample-barcode=String
                              The column name in the sample sheet or metadata CSV for the sample barcode.
                              [Default: Sample_Barcode]. 
-u String, --unmatched=String Output BAM file name for the unmatched records. [Default: unmatched.bam].
                              
-q QualityEncoding, --quality-format=QualityEncoding
                              A value describing how the quality values are encoded in the FASTQ. Either Solexa for
                              pre-pipeline 1.3 style scores (solexa scaling + 66), Illumina for pipeline 1.3 and above
                              (phred scaling + 64) or Standard for phred scaled scores with a character shift of 33. If
                              this value is not specified, the quality format will be detected automatically.
                              [Optional]. Options: Solexa, Illumina, Standard.
-t Int, --threads=Int         The number of threads to use while de-multiplexing. The performance does not increase
                              linearly with the # of threads and seems not to improve beyond 2-4 threads.
                              [Default: 1]. 
--max-mismatches=Int          Maximum mismatches for a barcode to be considered a match. [Default: 1].
                              
--min-mismatch-delta=Int      Minimum difference between number of mismatches in the best and second best barcodes for
                              a barcode to be considered a match. [Default: 2]. 
--max-no-calls=Int            Maximum allowable number of no-calls in a barcode read before it is considered
                              unmatchable. [Default: 2]. 
--sort-order=SortOrder        The sort order for the output sam/bam file (typically unsorted or queryname).
                              [Default: queryname]. Options: unsorted, queryname, coordinate, duplicate,
                              unknown.
--umi-tag=String              The SAM tag for any molecular barcode. If multiple molecular barcodes are specified, they
                              will be concatenated and stored here. [Default: RX]. 
--platform-unit=String        The platform unit (typically '<flowcell-barcode>-<sample-barcode>.<lane>')
                              [Optional]. 
--sequencing-center=String    The sequencing center from which the data originated [Optional]. 
--predicted-insert-size=Integer
                              Predicted median insert size, to insert into the read group header [Optional].
                              
--platform-model=String       Platform model to insert into the group header (ex. miseq, hiseq2500, hiseqX)
                              [Optional]. 
--platform=String             Platform to insert into the read group header of BAMs (e.g Illumina) [Default:
                              Illumina]. 
--comments=String*            Comment(s) to include in the merged output file's header. [Optional]. 
--run-date=Iso8601Date        Date the run was produced, to insert into the read group header [Optional].
                              
--output-type=OutputType      The type of outputs to produce. [Optional]. Options: Fastq, Bam,
                              BamAndFastq.
--include-all-bases-in-fastqs[[=true|false]]
                              Output all bases (i.e. all sample barcode, molecular barcode, skipped, and template
                              bases) for every read with template bases (ex. read one and read two) as defined by the
                              corresponding read structure(s). [Default: false]. 
--omit-fastq-read-numbers[[=true|false]]
                              Do not include trailing /1 or /2 for R1 and R2 in the FASTQ read name. [Default:
                              false]. 
--include-sample-barcodes-in-fastq[[=true|false]]
                              Insert the sample barcode into the FASTQ header. [Default: false]. 
--illumina-file-names[[=true|false]]
                              Name the output files according to the Illumina file name standards. [Default:
                              false]. 
--omit-failing-reads[[=true|false]]
                              Keep only passing filter reads if true, otherwise keep all reads. Passing filter reads
                              are determined from the comment in the FASTQ header. [Default: false]. 
--omit-control-reads[[=true|false]]
                              Do not keep reads identified as control if true, otherwise keep all reads. Control reads
                              are determined from the comment in the FASTQ header. [Default: false]. 
--mask-bases-below-quality=IntMask bases with a quality score below the specified threshold as Ns [Default:
                              0].
```

## fgbio-minimal_FastqToBam

### Tool Description
Generates an unmapped BAM (or SAM or CRAM) file from fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
- **Homepage**: https://github.com/fulcrumgenomics/fgbio
- **Package**: https://anaconda.org/channels/bioconda/packages/fgbio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
Oct 08, 2026 1:33:27 PM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgbio/fgbio.jar!/com/intel/gkl/native/libgkl_compression.so
WARNING: A restricted method in java.lang.System has been called
WARNING: java.lang.System::load has been called by com.intel.gkl.NativeLibraryLoader in an unnamed module (file:/usr/local/share/fgbio/fgbio.jar)
WARNING: Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module
WARNING: Restricted methods will be blocked in a future release unless native access is enabled

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

FastqToBam
------------------------------------------------------------------------------------------------------------------------
Generates an unmapped BAM (or SAM or CRAM) file from fastq files. Takes in one or more fastq files (optionally
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

FastqToBam Arguments:
------------------------------------------------------------------------------------------------------------------------
-i PathToFastq+, --input=PathToFastq+
                              Fastq files corresponding to each sequencing read (e.g. R1, I1, etc.). 
-o PathToBam, --output=PathToBam
                              The output SAM or BAM file to be written. 
--sample=String               The name of the sequenced sample. 
--library=String              The name/ID of the sequenced library. 
-h [[true|false]], --help[[=true|false]]
                              Display the help message. [Default: false]. 
--version[[=true|false]]      Display the version number for this tool. [Default: false]. 
-r ReadStructure*, --read-structures=ReadStructure*
                              Read structures, one for each of the FASTQs. [Optional]. 
-s [[true|false]], --sort[[=true|false]]
                              If true, queryname sort the BAM file, otherwise preserve input order. [Default:
                              false]. 
-u String, --umi-tag=String   Tag in which to store molecular barcodes/UMIs. [Default: RX]. 
-q String, --umi-qual-tag=String
                              Tag in which to store molecular barcode/UMI qualities. [Optional]. 
-c String, --cell-tag=String  Tag in which to store the cellular barcodes. [Default: CB]. 
-C String, --cell-qual-tag=String
                              Tag in which to store the cellular barcodes qualities. [Optional]. 
-Q [[true|false]], --store-sample-barcode-qualities[[=true|false]]
                              Store the sample barcode qualities in the QT Tag. [Default: false]. 
-n [[true|false]], --extract-umis-from-read-names[[=true|false]]
                              Extract UMI(s) from read names and prepend to UMIs from reads. [Default: false].
                              
--read-group-id=String        Read group ID to use in the file header. [Default: A]. 
-b String, --barcode=String   Library or Sample barcode sequence. [Optional]. 
--platform=String             Sequencing Platform. [Default: illumina]. 
--platform-unit=String        Platform unit (e.g. '<flowcell-barcode>.<lane>.<sample-barcode>') [Optional].
                              
--platform-model=String       Platform model to insert into the group header (ex. miseq, hiseq2500, hiseqX)
                              [Optional]. 
--sequencing-center=String    The sequencing center from which the data originated [Optional]. 
--predicted-insert-size=Integer
                              Predicted median insert size, to insert into the read group header [Optional].
                              
--description=String          Description of the read group. [Optional]. 
--comment=String*             Comment(s) to include in the output file's header. [Optional]. 
--run-date=Iso8601Date        Date the run was produced, to insert into the read group header [Optional].
```

