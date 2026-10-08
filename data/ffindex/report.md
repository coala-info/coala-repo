# ffindex CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ffindex_ffindex_apply | PASS |  |
| ffindex_ffindex_build | PASS |  |
| ffindex_ffindex_from_fasta | PASS |  |
| ffindex_ffindex_from_fasta_with_split | PASS |  |
| ffindex_ffindex_get | PASS |  |
| ffindex_ffindex_modify | PASS | sorting works; the program segfaults with -u (unlink) on this image |
| ffindex_ffindex_order | PASS |  |
| ffindex_ffindex_reduce | PASS |  |
| ffindex_ffindex_unpack | PASS |  |

## ffindex_ffindex_build

### Tool Description
Build an ffindex from files and directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_build [-a|-v] [-s] [-f file]* OUT_DATA_FILE OUT_INDEX_FILE [-d 2ND_DATA_FILE -i 2ND_INDEX_FILE] [DIR_TO_INDEX|FILE]*
	-a		append files/indexes, also needed for sorting an already existing ffindex
	-d FFDATA_FILE	a second ffindex data file for inserting/appending
	-i FFINDEX_FILE	a second ffindex index file for inserting/appending
	-f FILE		file containing a list of file names, one per line
			-f can be specified up to 4096 times
	-s		sort index file, so that the index can queried.
			Another append operations can be done without sorting.
	-v		print version and other info then exit

EXAMPLES:
	Create a new ffindex containing all files from the "bar/" directory containing
	say myfile1.txt, myfile2.txt and sort (-s) it so that e.g. ffindex_get can use it.
		$ ffindex_build -s foo.ffdata foo.ffindex bar/

	Add (-a) more files: myfile3.txt, myfile4.txt.
		$ ffindex_build -a foo.ffdata foo.ffindex myfile3.txt myfile4.txt

	Oops, forgot to sort it (-s) so do it afterwards:
		$ ffindex_build -as foo.ffdata foo.ffindex

NOTE:
	Maximum key/filename length is 32 and maximum entries are by default 200000000
	This can be changed in the sources.

Designed and implemented by Andreas W. Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_get

### Tool Description
Retrieve entries from an ffindex.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_get data_filename index_filename entry name(s)
-n	use index of entry instead of entry name

Designed and implemented by Andy Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_apply

### Tool Description
Run a program on every entry of an ffindex.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
Please specify input data and index file.

Please specify a program to execute.

USAGE: ffindex_apply_mpi [-q] [-k] [-d DATA_FILENAME_OUT -i INDEX_FILENAME_OUT] DATA_FILENAME INDEX_FILENAME -- PROGRAM [PROGRAM_ARGS]*

Designed and implemented by Andy Hauser <hauser@genzentrum.lmu.de> and Milot Mirdita <milot@mirdita.de>.

	[-q]			Silence the logging of every processed entry.
	[-k]			Keep unmerged ffindex splits.
	[-d DATA_FILENAME_OUT]	FFindex data file where the results will be saved to.
	[-i INDEX_FILENAME_OUT]	FFindex index file where the results will be saved to.
	DATA_FILENAME		Input ffindex data file.
	INDEX_FILENAME		Input ffindex index file.
	PROGRAM [PROGRAM_ARGS]	Program to be executed for every ffindex entry.
```

## ffindex_ffindex_modify

### Tool Description
Sort an ffindex index file or unlink entries.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_modify [-s|-u|-v] [-t] [-f file]* index_filename [filename]*
	-f file	file each line containing a filename
		-f can be specified up to 4096 times
	-s	sort index file
	-u	unlink entry (remove from index only)
	-v	print version and other info then exit

Designed and implemented by Andreas W. Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_unpack

### Tool Description
Unpack an ffindex into files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_unpack DATA_FILENAME INDEX_FILENAME OUT_DIR

Designed and implemented by Andy Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_from_fasta

### Tool Description
Create an ffindex from a multi-FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_from_fasta -v | [-s] data_filename index_filename fasta_filename
	-s	sort index file

Bases on a Design and Implementation of Andreas W. Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_from_fasta_with_split

### Tool Description
Create header and sequence ffindex databases from a multi-FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_from_fasta_with_split -v | [-s] data_header_filename index_header_filename data_sequence_filename index_sequence_filename fasta_filename
	-s	sort index file

Bases on a Design and Implementation of Andreas W. Hauser <hauser@genzentrum.lmu.de>.
```

## ffindex_ffindex_order

### Tool Description
Reorder an ffindex by an order file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_order ORDER_FILENAME DATA_FILENAME INDEX_FILENAME SORTED_DATA_OUT_FILE SORTED_INDEX_OUT_FILE

Designed and implemented by Milot Mirdita <milot@mirdita.de>.
```

## ffindex_ffindex_reduce

### Tool Description
Run a program on the entries of an ffindex.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffindex:0.98--h9948957_5
- **Homepage**: https://github.com/soedinglab/ffindex_soedinglab
- **Package**: https://anaconda.org/channels/bioconda/packages/ffindex/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: ffindex_reduce DATA_FILENAME INDEX_FILENAME PROGRAM [PROGRAM_ARGS]*

Designed and implemented by Andy Hauser <hauser@genzentrum.lmu.de>.
```

## Metadata
- **Skill**: generated

