# metav CWL Generation Report

## metav

### Tool Description
Metagenomics virus detection

### Metadata
- **Docker Image**: quay.io/biocontainers/metav:2.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ZhijianZhou01/metav
- **Package**: https://anaconda.org/channels/bioconda/packages/metav/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metav/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-12-14
- **GitHub**: https://github.com/ZhijianZhou01/metav
- **Stars**: N/A
### Original Help Text
```text
███╗   ███╗███████╗████████╗ █████╗  ██╗   ██╗
    ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗ ██║   ██║
    ██╔████╔██║█████╗     ██║   ███████║ ██║   ██║
    ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║ ██║   ██║
    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║  ╚████╔╝ 
    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═══╝  
    
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃      MetaV - Metagenomics virus detection      ┃
┃            Version 2.0.0 (2025-11-20)           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


usage: metav [-h] [-pe] [-se] [-i1 FORWARD] [-i2 REVERSE] [-u UNPAIRED]
             [-q QUALITIES] [-xml PROFILES] [-ne NR_E_VALUE] [-oe OUT_E_VALUE]
             [-len LENGTH] [-s IDENTITY] [-r1] [-r2] [-t THREAD] [-o OUTDIR]

options:
  -h, --help       show this help message and exit
  -pe              paired-end sequencing.
  -se              single-end sequencing.
  -i1 FORWARD      forward reads (*.fq) using paired-end sequencing.
  -i2 REVERSE      reverse reads (*.fq) using paired-end sequencing.
  -u UNPAIRED      reads file using single-end sequencing (unpaired reads).
  -q QUALITIES     the qualities (phred33 or phred64) of sequenced reads,
                   default: phred33.
  -xml PROFILES    the *.xml file with parameters of dependent software and
                   databases.
  -ne NR_E_VALUE   specify two e-values threshold used to retain viral hits
                   and exclude non-viral hits using nr database, default:
                   0.1,1e-5.
  -oe OUT_E_VALUE  specify three e-values threshold used to output the viral
                   reads (or contigs), default: 1e-10,1e-5,1e-1.
  -len LENGTH      threshold of length of aa alignment for diamond output
                   filtering, default: 10.
  -s IDENTITY      threshold of identity(%) of alignment aa for diamond output
                   filtering, default: 20.
  -r1              run the sub-pipeline 1 (reads blastx [viral-nr and nr db]).
  -r2              run the sub-pipeline 2 (reads → contigs blastx [viral-nr
                   and nr db]).
  -t THREAD        number of used threads, default: 10.
  -o OUTDIR        output directory to store all results.

----------------☆ Example of use ☆-----------------
 
  (i) paired-end sequencing:
  metav -pe -i1 reads_R1.fq -i2 reads_R2.fq -xml profiles.xml -r1 -r2 -t 10 -o outdir
  
  
  (ii) single-end sequencing:
  metav -se -u reads.fq -xml profiles.xml -r1 -r2 -t 10 -o outdir
  
----------------------☆  End  ☆---------------------
```

