# hapsolo CWL Generation Report

## hapsolo_preprocessfasta.py

### Tool Description
Preprocess FASTA file and outputs a clean FASTA and seperates contigs based on unique headers. Removes special chars

### Metadata
- **Docker Image**: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
- **Homepage**: https://github.com/esolares/HapSolo
- **Package**: https://anaconda.org/channels/bioconda/packages/hapsolo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hapsolo/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/esolares/HapSolo
- **Stars**: N/A
### Original Help Text
```text
usage: preprocessfasta.py [-h] -i INPUT [-m MAXCONTIG]

Preprocess FASTA file and outputs a clean FASTA and seperates contigs based on
unique headers. Removes special chars

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input FASTA file
  -m MAXCONTIG, --maxcontig MAXCONTIG
                        Max size of contig in Mb to output in contigs folder.
```


## hapsolo_hapsolo.py

### Tool Description
Process alignments and BUSCO"s for selecting reduced assembly candidates

### Metadata
- **Docker Image**: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
- **Homepage**: https://github.com/esolares/HapSolo
- **Package**: https://anaconda.org/channels/bioconda/packages/hapsolo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hapsolo.py [-h] -i INPUT (-p PSL | -a PAF) [--mode MODE] -b BUSCOS
                  [-m MAXZEROS] [-t THREADS] [-n NITERATIONS] [-B BESTN]
                  [-S THETAS] [-D THETAD] [-F THETAF] [-M THETAM] [-P MINPID]
                  [-Q MINQ] [-R MINQR] [--min MIN]

Process alignments and BUSCO"s for selecting reduced assembly candidates

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input Fasta file
  -p PSL, --psl PSL     BLAT PSL alignnment file
  -a PAF, --paf PAF     Minimap2 PAF alignnment file. Note. paf file
                        functionality is currently experimental
  --mode MODE           HapSolo run mode. 0 = Random walking, 1 = No
                        optimization with defaults, 2 = Optimized walking,
                        Default = 0
  -b BUSCOS, --buscos BUSCOS
                        Location BUSCO output directories. i.e. buscoN/
  -m MAXZEROS, --maxzeros MAXZEROS
                        Max # of times cost function delta can consecutively
                        be 0. Default = 10
  -t THREADS, --threads THREADS
                        # of threads. Multiplies iterations by threads.
                        Default = 1
  -n NITERATIONS, --niterations NITERATIONS
                        # of total iterations to run per gradient descent.
                        Default = 1000
  -B BESTN, --Bestn BESTN
                        # of best candidate assemblies to return using
                        gradient descent. Default = 1
  -S THETAS, --thetaS THETAS
                        Weight for single BUSCOs in linear fxn. Default = 1.0
  -D THETAD, --thetaD THETAD
                        Weight for duplicate BUSCOs in linear fxn. Default =
                        1.0
  -F THETAF, --thetaF THETAF
                        Weight for fragmented BUSCOs in linear fxn. Default =
                        0.0
  -M THETAM, --thetaM THETAM
                        Weight for missing BUSCOs in linear fxn. Default = 1.0
  -P MINPID, --minPID MINPID
                        Restrict values of PID to be >= the value set here.
                        Default = 0.2
  -Q MINQ, --minQ MINQ  Restrict values of Q to be >= the value set here.
                        Default = 0.2
  -R MINQR, --minQR MINQR
                        Restrict values of QR to be >= the value set here.
                        Cannot be 0. Default = 0.2
  --min MIN             Minimum size of contigs for Primary assembly. Default
                        = 1000

-p/--psl and -a/--paf are mutually exclusive
```

