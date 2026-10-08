# fgap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fgap_FGAP | PASS |  |

## fgap_FGAP

### Tool Description
FGAP: an automated gap closing tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgap:1.8.1--hdfd78af_2
- **Homepage**: https://github.com/pirovc/fgap
- **Package**: https://anaconda.org/channels/bioconda/packages/fgap/overview
- **Validation**: PASS

### Original Help Text
```text
------------------------------------------
		FGAP v1.8.1
------------------------------------------
Usage in command-line mode (compiled): ./run_fgap.sh <MCR installation folder> -d <draft file> -a "<dataset(s) file(s)>" [parameters]
Usage in Matlab/Octave (source): fgap -d <draft file> -a '<dataset(s) file(s)>' [parameters]
-d /--draft-file	Draft genome file [fasta format - Ex: 'draft.fasta']
-a /--datasets-files	List of datasets files to close gaps [fasta format - Ex: 'dataset1.fasta,dataset2.fasta']
-s /--min-score		Min Score (raw) to return results from BLAST (integer) - Default: 25
-e /--max-evalue	Max E-Value to return results from BLAST (float) - Default: 1e-7
-i /--min-identity	Min identity (%) to return results from BLAST (integer [0-100]) - Default: 70
-C /--contig-end-length	Length (bp) of contig ends to perform BLAST alignment (integer) - Default: 300
-T /--edge-trim-length	Length of ignored bases (bp) upstream and downstrem of the gap (integer) - Default: 0
-R /--max-remove-length	Max number of bases (bp) that can be removed (integer) - Default: 500
-I /--max-insert-length	Max number of bases (bp) that can be inserted (integer) - Default: 500
-p /--positive-gap	Enable closing of positive gaps (with insertion) (integer [0-1]) - Default: 1
-z /--zero-gap		Enable closing of zero gaps (without insert any base) (integer [0-1]) - Default: 0
-g /--negative-gap	Enable closing of negative gaps (overlapping contig ends) (integer [0-1]) - Default: 0
-c /--gap-char				Base that represents the gap (char) - Default: 'N'
-b /--blast-path			Blast+ package path (only makeblastdb and blastn are needed, version 2.2.28+ or higher) - Default: ''
-l /--blast-alignment-parameters	BLAST alignment parameters (opengap,extendgap,match,mismatch,wordsize) - Default: '1,1,1,-3,15'
-r /--blast-max-results			Max results from BLAST for each query (integer) - Default: 200
-t /--threads				Number of threads (integer) - Default: 1
-m /--more-output	More output files with gap regions after and before gap closing (integer [0-1]) - Default: 0
-o /--output-prefix	Output prefix [File or folder - Ex: 'out' or 'out_folder/out' ] - Default: 'output_fgap'
-h /--help		This help message
```

## Metadata
- **Skill**: generated
