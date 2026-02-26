# genoflu CWL Generation Report

## genoflu_genoflu.py

### Tool Description
FASTA files with formated headers are used to build BLAST database. The input FASTA is BLASTed against the database. The top hit for each segment is used to determine the genotype. The genotype is determined by cross-referencing the top hits to a excel file. If the top hit for each segment matches a genotype, then the genotype is assigned. If the top hit for each segment does not match a genotype, then the genotype is not assigned. If the top hit for each segment matches a genotype, but the genotype is not complete (i.e. only 7 segments match), then the genotype is not assigned. If the top hit for each segment matches a genotype, and the genotype is complete (i.e. all 8 segments match), then the genotype is assigned.

### Metadata
- **Docker Image**: quay.io/biocontainers/genoflu:1.06--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/GenoFLU
- **Package**: https://anaconda.org/channels/bioconda/packages/genoflu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genoflu/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/USDA-VS/GenoFLU
- **Stars**: N/A
### Original Help Text
```text
usage: PROG [-h] -f FASTA [-i FASTA_DIR] [-p PIDENT_THRESHOLD]
            [-c CROSS_REFERENCE] [-n SAMPLE_NAME] [-d] [-v]

---------------------------------------------------------
Usage:
    genoflu.py -f sample.fasta # -i and -c are optional and default to genoflu/dependencies
-f is the input FASTA file which the genotype will be determined
-i is the directory containing FASTAs to BLAST against.  Headers must follow specific format.  "genotype<space>sample<space>gene"
-c is the excel file to cross-reference BLAST findings and identification to genotyping results.  Default genoflu/dependencies
-n is the sample name to force output files to this sample name versus taking the name to be anything before [_.]

Summary:
    FASTA files with formated headers are used to build BLAST database.  The input FASTA is BLASTed against the database.  The top hit for each segment is used to determine the genotype.  The genotype is determined by cross-referencing the top hits to a excel file.  If the top hit for each segment matches a genotype, then the genotype is assigned.  If the top hit for each segment does not match a genotype, then the genotype is not assigned.  If the top hit for each segment matches a genotype, but the genotype is not complete (i.e. only 7 segments match), then the genotype is not assigned.  If the top hit for each segment matches a genotype, and the genotype is complete (i.e. all 8 segments match), then the genotype is assigned.  

optional arguments:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Assembled FASTA
  -i FASTA_DIR, --FASTA_dir FASTA_DIR
                        Directory containing FASTAs to BLAST against. Headers
                        must follow specific format.
                        genoflu/dependencies/fastas
  -p PIDENT_THRESHOLD, --pident_threshold PIDENT_THRESHOLD
                        BLAST result greater than or equal to this number gets
                        genotype calls
  -c CROSS_REFERENCE, --cross_reference CROSS_REFERENCE
                        Excel file to cross-reference BLAST findings and
                        identification to genotyping results. Default
                        genoflu/dependencies. 9 column Excel file, first
                        column Genotype, followed by 8 columns for each
                        segment and what those calls are for that genotype.
  -n SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Force output files to this sample name
  -d, --debug           keep temp file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

