# transannot CWL Generation Report

## transannot_easytransannot

### Tool Description
By Mariia Zelenskaia mariia.zelenskaia@mpinat.mpg.de & Yazhini A. yazhini@mpinat.mpg.de

### Metadata
- **Docker Image**: quay.io/biocontainers/transannot:4.0.0--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/transannot
- **Package**: https://anaconda.org/channels/bioconda/packages/transannot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transannot/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/soedinglab/transannot
- **Stars**: N/A
### Original Help Text
```text
usage: transannot easytransannot <i:fast(a|q)File[.gz|bz]> | <i:fastqFile1_1[.gz]> ... <i:fastqFileN_1[.gz]> <i:targetDB> <i:targetDB> <i:targetDB> <o:outFile> <tmpDir> [options]
 By Mariia Zelenskaia mariia.zelenskaia@mpinat.mpg.de & Yazhini A. yazhini@mpinat.mpg.de 

options: prefilter:              
 -s FLOAT                 Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
align:                  
 -c FLOAT                 List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --min-seq-id FLOAT       List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.300]
misc:                   
 --createdb-mode INT      Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [1]
common:                 
 --compressed INT         Write compressed output [0]
 --remove-tmp-files BOOL  Delete temporary files [0]
 --threads INT            Number of CPU-cores used (all by default) [20]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --simple-output BOOL     Provide only query, target IDs and information from UniProt in the output file. No information about alignment (eg. sequence identity and bit score) [0]
 --no-run-clust BOOL      Per default there is linclust of mmseqs performed for the redundancy reduction. If you don't want it, provide this tag [0]
```

