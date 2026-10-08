# dpcstruct CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dpcstruct_postfilters | PASS |  |
| dpcstruct_prefilters | PASS |  |
| dpcstruct_primarycluster | PASS |  |
| dpcstruct_secondarycluster_classify | PASS |  |
| dpcstruct_secondarycluster_distance | PASS |  |
| dpcstruct_traceback | PASS |  |

## dpcstruct_prefilters

### Tool Description
Filters alignments based on quality metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Total Downloads**: 505
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/RitAreaSciencePark/DPCstruct
- **Stars**: N/A
### Original Help Text
```text
Usage: 
	dpcstruct prefilters -i ALIGNMENTS -o OUTPUT -m PROTS-LOOKUP -p PLDDTS -q PLDDT-THRESHOLD -t TM-THRESHOLD -l LDDT-THRESHOLD -g GAPS-THRESHOLD 

Options:
	-i ALIGNMENTS		path to alignments file

	-o OUTPUT		output directory

	-m PROTS-LOOKUP		protein lookup file

	-p PLDDTS		path to PLDDTs directory

	-q PLDDT-THRESHOLD		PLDDT threshold (default: 60.0)

	-t TM-THRESHOLD		TM-score threshold (default: 0.4)

	-l LDDT-THRESHOLD		LDDT threshold (default: 0.4)

	-g GAPS-THRESHOLD		Gaps threshold (default: 0.2)

Description:
	Filters alignments based on quality metrics.
```


## dpcstruct_primarycluster

### Tool Description
Identifies primary clusters given a set of query proteins.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
	dpcstruct primarycluster -i INPUT -o OUTPUT -t THREADS 

Options:
	-i INPUT		input filename

	-o OUTPUT		output filename

	-t THREADS		number of threads

Description:
	Identifies primary clusters given a set of query proteins.
```


## dpcstruct_traceback

### Tool Description
Assign a metacluster label to each domain inside a primary cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
	dpcstruct traceback INPUT -l MC_LABELS -o OUTDIR -n NUM_OUTPUT 

Options:
	INPUT			input files containing all primary cluster domains

	-l MC_LABELS		file containing a metacluster label for each primary cluster

	-o OUTDIR		output path (optional, default is ./)

	-n NUM_OUTPUT		estimated number of output files (optional)

Description:
	Assign a metacluster label to each domain inside a primary cluster.
```


## dpcstruct_postfilters

### Tool Description
filters the results produced by traceback.cc.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
	dpcstruct postfilters -i INPUT -o OUTPUT 

Options:
	-i INPUT		input filename

	-o OUTPUT		output filename

Description:
	filters the results produced by traceback.cc.
```


## dpcstruct_secondarycluster_distance

### Tool Description
Calculate distances between primary clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
	dpcstruct secondarycluster distance -i INPUTA -j INPUTB -o OUTPUT -p PRODUCERS -c CONSUMERS 

Options:
	-i INPUTA		input file A

	-j INPUTB		input file B

	-o OUTPUT		output file for the distance matrix

	-p PRODUCERS		producer threads

	-c CONSUMERS		consumer threads

Description:
	Calculate distances between primary clusters.
```


## dpcstruct_secondarycluster_classify

### Tool Description
Classify primary clusters into secondary clusters or metaclusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
- **Homepage**: https://github.com/RitAreaSciencePark/DPCstruct
- **Package**: https://anaconda.org/channels/bioconda/packages/dpcstruct/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
	dpcstruct secondarycluster classify INPUT -o OUTPUT -t THREADS 

Options:
	INPUT			list of space-separated files

	-o OUTPUT		output file containing the classified primary clusters

	-t THREADS		number of threads (TBI)

Description:
	Classify primary clusters into secondary clusters or metaclusters.
```


## Metadata
- **Skill**: generated
