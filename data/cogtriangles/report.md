# cogtriangles CWL Generation Report

## cogtriangles

### Tool Description
FAIL to generate CWL: cogtriangles not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
- **Homepage**: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/
- **Package**: https://anaconda.org/channels/bioconda/packages/cogtriangles/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/cogtriangles/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-06-11
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: cogtriangles not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: cogtriangles not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## cogtriangles_COGmakehash

### Tool Description
Create a hash file from a list of IDs for COG processing

### Metadata
- **Docker Image**: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
- **Homepage**: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/
- **Package**: https://anaconda.org/channels/bioconda/packages/cogtriangles/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: COGmakehash [Options]

where:

-i=flst		input file (list of IDs, default data.csv)

-o=dout		output directory (creates hash.csv, default ./conv)

-s=sepchar	separator character (default ,)

-n=nblock	index of the name field in the input file (1-based, default 1)
```

## cogtriangles_COGreadblast

### Tool Description
Processes and filters BLAST results for COG analysis, including options for handling non-contiguous blocks and reciprocal hits.

### Metadata
- **Docker Image**: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
- **Homepage**: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/
- **Package**: https://anaconda.org/channels/bioconda/packages/cogtriangles/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: COGreadblast [Options]

Otptions:

-d=dconv	directory for converted data (must contain hash.csv; default ./conv)

-u=dunfilt	directory with the unfiltered BLAST results (default ./blan)

-f=dfilt	directory with the filtered BLAST results (default ./blaf)

-s=dself	directory with the self-BLAST results (default ./blan)

-e=evalue	e-value threshold for BLAST hits (default 10)

-q=nblock	index of the sequence ID field for the BLAST query (default 2)

-t=nblock	index of the sequence ID field for the BLAST target (default 2)

-a		append/aggregate mode (use if BLAST hits from one query do not form 
		a contiguous block in the BLAST output files)

-r		symmetrize reciprocal hits (use when BLAST search has not been run 
		in a fully symmetrical all-against-all manner)

-v		verbose mode (mostly debugging output to STDOUT)
```

