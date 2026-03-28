# graph2pro-var CWL Generation Report

## graph2pro-var_install

### Tool Description
Copy files and set attributes

### Metadata
- **Docker Image**: quay.io/biocontainers/graph2pro-var:1.0.0--0
- **Homepage**: https://github.com/COL-IU/graph2pro-var
- **Package**: https://anaconda.org/channels/bioconda/packages/graph2pro-var/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graph2pro-var/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COL-IU/graph2pro-var
- **Stars**: N/A
### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: install [-cdDsp] [-o USER] [-g GRP] [-m MODE] [SOURCE]... DEST

Copy files and set attributes

	-c	Just copy (default)
	-d	Create directories
	-D	Create leading target directories
	-s	Strip symbol table
	-p	Preserve date
	-o USER	Set ownership
	-g GRP	Set group ownership
	-m MODE	Set permissions
```


## graph2pro-var_DBGraph2Pro

### Tool Description
DBGraph2Pro version 0.1

### Metadata
- **Docker Image**: quay.io/biocontainers/graph2pro-var:1.0.0--0
- **Homepage**: https://github.com/COL-IU/graph2pro-var
- **Package**: https://anaconda.org/channels/bioconda/packages/graph2pro-var/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Graph file not specified
DBGraph2Pro version 0.1
Usage: DBGraph2Pro -e edgefile -s edgeseqfile -o outfile -p min_peptide_len -m max_peptide_len -l min_contig_len -k kmersize -u -c #-mis-cleavage -L Max_Seq_len -d Max_Depth
-e edgeFile: The input edge file name
-s edgeSeqFile: The input edge sequence (contig) file name
-o OutFile(base name only): Protein Sequences files
-p min_peptide_len: minimum peptide length to be output (default 6)
-m max_peptide_len: maximum peptide length to be output (default 50)
-l min_contig_len: minimum contig length to be explored (longer contigs will be executed by FGS)
-L Max_Seq_len: maximum sequence length (for memory allocation, default 3000)
-k kmersize: default 31
-c mis-cleavage: default 0
-d max_depth: default 10
-u (SOAP when set; default off for SOAP2)
-f (FastG when set; default off for SOAP2)
-S (FastG output by MetaSPaDes when set; default off for SOAP2)
```


## Metadata
- **Skill**: generated
