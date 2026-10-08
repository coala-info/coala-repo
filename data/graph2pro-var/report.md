# graph2pro-var CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| graph2pro-var_DBGraph2Pro | PASS |  |
| graph2pro-var_DBGraphPep2Pro | PASS | synthetic data: peptide table built from DBGraph2Pro output on the repo test assembly graph (no real search result in the repo); option -n is accepted but writes no file |

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


## graph2pro-var_DBGraphPep2Pro

### Tool Description
Map identified peptides to an assembly graph and extend them to protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/graph2pro-var:1.0.0--0
- **Homepage**: https://github.com/COL-IU/graph2pro-var
- **Package**: https://anaconda.org/channels/bioconda/packages/graph2pro-var/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Graph file not specified
DBGraphPep2Pro version 0.1
Usage: DBGraphPep2Pro -e edgefile -s edgeseqfile -p PeptideSeqFile -n TranscriptOutFile -o ProteinOutFile -k kmersize -u -c #-mis-cleavage -L Max_Seq_len -d Max_Depth -m Max_Pep_per_Edge
-e edgeFile: The input edge file name
-s edgeSeqFile: The input edge sequence (contig) file name
-p PepSeqFile: The input sequence (identified peptides) file name
-o ProteinOutFile(base name only): The output protein Sequences file name
-n TranscriptSeqFile: The output transcript sequences file name
-L Max_Seq_len: maximum protein sequence length (for memory allocation, default 3000)
-k kmersize: default 31
-c mis-cleavage: default 0
-d max_depth: default 10
-m Max_Pep_per_Edge: default 100
-u (SOAP when set; default off for SOAP2)
-f (FastG when set; default off for SOAP2)
```

## Metadata
- **Skill**: generated
