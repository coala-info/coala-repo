# psytrans CWL Generation Report

## psytrans_psytrans.py

### Tool Description
Perform SVM Classification of Host and Symbiont (or Parasite) Sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/psytrans:2.0.0--hdfd78af_1
- **Homepage**: https://github.com/rivera10/psytrans
- **Package**: https://anaconda.org/channels/bioconda/packages/psytrans/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psytrans/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rivera10/psytrans
- **Stars**: N/A
### Original Help Text
```text
usage: psytrans.py [-h] [-A SPECIES1] [-B SPECIES2] [-b BLASTRESULTS]
                   [-T {blastx,blastn,tblastx}] [-p NBTHREADS]
                   [-e MAXBESTEVALUE] [-n NUMBEROFSEQ] [-s MINSEQSIZE]
                   [-c MINWORDSIZE] [-k MAXWORDSIZE] [-r] [-v] [-t TEMPDIR]
                   [-o OUTDIR] [-X] [-z {db,runBlast,parseBlast,kmers,SVM}]
                   [-R] [-V]
                   queries

Perform SVM Classification of Host and Symbiont (or Parasite) Sequences

positional arguments:
  queries               The input queries sequences

optional arguments:
  -h, --help            show this help message and exit
  -A SPECIES1, --species1 SPECIES1
                        Reference sequences for the first species
  -B SPECIES2, --species2 SPECIES2
                        Reference sequences for the second species
  -b BLASTRESULTS, --blastResults BLASTRESULTS
                        Blast results obtained
  -T {blastx,blastn,tblastx}, --blastType {blastx,blastn,tblastx}
                        Type of blast search to be performed
  -p NBTHREADS, --nbThreads NBTHREADS
                        Number of threads to run the BLAST search and SVM
  -e MAXBESTEVALUE, --maxBestEvalue MAXBESTEVALUE
                        Maximum e-value
  -n NUMBEROFSEQ, --numberOfSeq NUMBEROFSEQ
                        Maximum number of sequences for training and testing
  -s MINSEQSIZE, --minSeqSize MINSEQSIZE
                        Minimum sequence size for training and testing
  -c MINWORDSIZE, --minWordSize MINWORDSIZE
                        Minimum value of DNA word length
  -k MAXWORDSIZE, --maxWordSize MAXWORDSIZE
                        Maxmimum value of DNA word length
  -r, --bothStrands     Compute kmers for the forward and reverse strands
  -v, --verbose         Turn Verbose mode on?
  -t TEMPDIR, --tempDir TEMPDIR
                        Location (prefix) of the temporary directory
  -o OUTDIR, --outDir OUTDIR
                        Name of optional output directory
  -X, --clearTemp       Clear all temporary data upon completion
  -z {db,runBlast,parseBlast,kmers,SVM}, --stopAfter {db,runBlast,parseBlast,kmers,SVM}
                        Optional exit upon completion of stage.
  -R, --restart         Continue process from last exit stage
  -V, --version         show program's version number and exit
```

