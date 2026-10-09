# mbgc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mbgc_a | PASS |  |
| mbgc_c | PASS |  |
| mbgc_d | PASS | extracting a 2-file archive segfaults with more than 1 thread (works with -t 1 and for 3+ files) |
| mbgc_i | PASS |  |
| mbgc_r | PASS | repack of one remaining file segfaults in the tool; multi-file repack works |

## mbgc_c

### Tool Description
Compress FASTA file(s) into an MBGC archive

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for multiple file compression (list of files given as input):
	mbgc c [-m <compressionMode>] [-L] <fastaFileList> <archiveFile>
Usage for single file compression:
	mbgc c [-m <compressionMode>] [-L] -i <inputFastaFile> <archiveFile>

<fastaFileList> name of text file with a list of FASTA files (raw or gz)
	(given in separate lines) for compression
<inputFastaFile> name of a FASTA file (raw or gz) for compression
	for standard input, set <inputFastaFile> to -
<archiveFile> mbgc archive filename
	for standard output in compression, set <archiveFile> to -

Basic options:
	[-m <compressionMode>] (speed: 0; default: 1; repo: 2; max: 3)
	[-L] allow lossy compression
	[-f] overwrite an existing output file
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

Compression modes description:
	(0) speed - for speed (fastest compression and decompression)
	(1) default - regular mode (good ratio, fast)
	(2) repo - for public repositories (better ratio, good speed)
	(3) max - for long-term storage (best ratio, memory-frugal)

------------------ ADVANCED OPTIONS ----------------
[-T <noOfWorkers>] worker threads used by matcher (default: 8)
[-U] converts bases to uppercase
[-Q] disable parallel matching (does not apply to I/O and backend compression)
[-k <matchingKmerLength>] (16 <= k <= 40, default: 32)
[-u <unmatchedFractionFactor>] (1 <= u <= 255, default: 128)
[-r <unmatchedFractionRCFactor>] (0 <= r <= 255, default: 8,
		0 disables rc-matches in reference)
[-s <referenceSamplingStep>] (s > 0, default: 16)
[-o <referenceFactorBinaryOrder>] (0 <= o <= 12, auto-adjusted by default)
[-C] disable circular reference buffer
[-g <gapDepthOffsetEncoding>] (0 <= g <= 128, default: 64, 0 - disable)
[-b <gapBreakingMatchMinimalLength>] (b > 0, default: 256, 0 - disable)
[-x <maxConsecutiveMismatches>] (0 <= x <= 255, default: 10; 0 - disable;
		1 - single mismatch mode)
[-X] disable encoding mismatches with exclusion
[-R <rcMatchMinimalLength>] (R >= 24, default: 0, 0 - disable)

The order of all selected options is arbitrary.
```

## mbgc_d

### Tool Description
Decompress FASTA file(s) from an MBGC archive

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for decompression:
	mbgc d [-z <gzLevel>] <archiveFile> [<outputPath>]
Usage for partial decompression (list of patterns given as input):
	mbgc d [-E <patternsFile>] <archiveFile> [<outputPath>]

<archiveFile> mbgc archive filename
	for standard input in decompression, set <archiveFile> to -
<patternsFile> name of text file with list of patterns (in separate lines)
	excludes files not matching any pattern (does not invalidate -e option)
<outputPath> extraction target path root (current directory by default)
	for standard output, set <outputPath> to - (all files are concatenated)

Basic options:
	[-f] overwrite an existing output files
	[-z <gzLevel>] extract FASTA files to gz archives
		(compression level: 1 <= z <= 12, recommended: 2)
	[-l <basesPerRow>] custom format of decoded sequences (0 - unlimited)
	[-e <pattern>] exclude files with names not containing pattern
	[-E <patternsFile>] exclude files not matching any pattern
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

The order of all selected options is arbitrary.
```

## mbgc_a

### Tool Description
Append FASTA file(s) to an MBGC archive

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for appending multiple FASTA archive (list of files given as input):
	mbgc a <fastaFileList> <archiveFile> [<outputArchiveFile>]
Usage for appending single FASTA file archive:
	mbgc a -i <inputFastaFile> <archiveFile> [<outputArchiveFile>]

<fastaFileList> name of text file with a list of FASTA files (raw or gz)
	(given in separate lines) for appending to the <archiveFile>
<inputFastaFile> name of a FASTA file (raw or gz) appended to the <archiveFile>
	for standard input, set <inputFastaFile> to -
<archiveFile> mbgc archive filename to be appended
	for standard input (and output if <outputArchiveFile> is not defined)
	set <archiveFile> to -
<outputArchiveFile> if defined, <archiveFile> archive remains unchanged
	and new archive is created
	for standard output, set <outputArchiveFile> to -

Basic options:
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

The order of all selected options is arbitrary.
```

## mbgc_r

### Tool Description
Repack selected FASTA files from an existing archive into a new archive

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for repacking part of archive:
	mbgc r [-m <compressionMode>] [-e <pattern>] [-E <patternsFile>]
		<archiveFile> <outputArchiveFile>

<archiveFile> mbgc archive filename for repacking
	for standard input, set <archiveFile> to -
<patternsFile> name of text file with list of patterns (in separate lines)
	excludes files not matching any pattern (does not invalidate -e option)
<outputArchiveFile> name of repacked mbgc archive
	for standard output, set <outputArchiveFile> to -

Basic options:
	[-m <compressionMode>] (speed: 0; default: 1; repo: 2; max: 3)
	[-L] allow lossy compression
	[-f] overwrite an existing output file
	[-l <basesPerRow>] custom format of repacked DNA (0 - unlimited)
	[-e <pattern>] exclude files with names not containing pattern
	[-E <patternsFile>] exclude files not matching any pattern
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

Compression modes description:
	(0) speed - for speed (fastest compression and decompression)
	(1) default - regular mode (good ratio, fast)
	(2) repo - for public repositories (better ratio, good speed)
	(3) max - for long-term storage (best ratio, memory-frugal)

------------------ ADVANCED OPTIONS ----------------
[-T <noOfWorkers>] worker threads used by matcher (default: 8)
[-U] converts bases to uppercase
[-Q] disable parallel matching (does not apply to I/O and backend compression)
[-k <matchingKmerLength>] (16 <= k <= 40, default: 32)
[-u <unmatchedFractionFactor>] (1 <= u <= 255, default: 128)
[-r <unmatchedFractionRCFactor>] (0 <= r <= 255, default: 8,
		0 disables rc-matches in reference)
[-s <referenceSamplingStep>] (s > 0, default: 16)
[-o <referenceFactorBinaryOrder>] (0 <= o <= 12, auto-adjusted by default)
[-C] disable circular reference buffer
[-g <gapDepthOffsetEncoding>] (0 <= g <= 128, default: 64, 0 - disable)
[-b <gapBreakingMatchMinimalLength>] (b > 0, default: 256, 0 - disable)
[-x <maxConsecutiveMismatches>] (0 <= x <= 255, default: 10; 0 - disable;
		1 - single mismatch mode)
[-X] disable encoding mismatches with exclusion
[-R <rcMatchMinimalLength>] (R >= 24, default: 0, 0 - disable)

The order of all selected options is arbitrary.
```

## mbgc_i

### Tool Description
Info about archive contents (FASTA file names and headers)

### Metadata
- **Docker Image**: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
- **Homepage**: https://github.com/kowallus/mbgc
- **Package**: https://anaconda.org/channels/bioconda/packages/mbgc/overview
- **Validation**: PASS

### Original Help Text
```text
Multiple Bacteria Genome Compressor (MBGC) v2.1.1 (c) Tomasz Kowalski, Szymon Grabowski, 2026-02-20

Usage for partial file listing:
	mbgc i [-H] [-e <pattern>] [-E <patternsFile>] <archiveFile>

<archiveFile> mbgc archive filename
	for standard input in decompression, set <archiveFile> to -
<patternsFile> name of text file with list of patterns (in separate lines)
	excludes files not matching any pattern (does not invalidate -e option)

Basic options:
	[-e <pattern>] exclude files with names not containing pattern
	[-E <patternsFile>] exclude files not matching any pattern
	[-H] list sequence headers (using convention: ">sequencename>filename")
	[-t <noOfThreads>] set limit of used threads
	[-I] ignore FASTA file paths (use only filenames)
	[-2] redirect app output to stderr
	[-h] print full command help and exit
	[-v] print version number and exit

The order of all selected options is arbitrary.

Note: selected default command 'i'. Please use 'mbgc' to list all commands.
```
