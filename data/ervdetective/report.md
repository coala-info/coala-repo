# ervdetective CWL Generation Report

## ervdetective

### Tool Description
An efficient pipeline for identification and annotation of endogenous retroviruses.

### Metadata
- **Docker Image**: quay.io/biocontainers/ervdetective:1.0.9--pyhdfd78af_1
- **Homepage**: https://github.com/ZhijianZhou01/ervdetective
- **Package**: https://anaconda.org/channels/bioconda/packages/ervdetective/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ervdetective/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/ZhijianZhou01/ervdetective
- **Stars**: N/A
### Original Help Text
```text
-------------------------------------------------
  Name: Endogenous retroviruses detective (ERVdetective)
  Description: An efficient pipeline for identification and annotation of endogenous retroviruses.
  Version: 1.0.9 (2024-05-01)
  Author: Zhi-Jian Zhou
-------------------------------------------------

usage: ervdetective [-h] [-i HOST] [-n THREAD] [-p PREFIX] [-o OUTPUT]
                    [-eb EBLAST] [-f FLANK] [-l1 MINLTR] [-l2 MAXLTR]
                    [-s LTRSIMILAR] [-d1 MINDISTLTR] [-d2 MAXDISTLTR]
                    [-t1 MINTSD] [-t2 MAXTSD] [-motif MOTIF] [-mis MISMOTIF]
                    [-ed EHMMER] [--gag GAG_LENGTH] [--pro PRO_LENGTH]
                    [--rt RT_LENGTH] [--rh RNASEH_LENGTH] [--int INT_LENGTH]
                    [--env ENV_LENGTH]

options:
  -h, --help          show this help message and exit
  -i HOST             The file-path of host genome sequence, the suffix is
                      generally *.fna, *.fas, *.fasta.
  -n THREAD           Specify the number of threads used, default: 1.
  -p PREFIX           The prefix of output file, default character: 'host'.
  -o OUTPUT           The path of output folder to store all the results.
  -eb EBLAST          Specify threshold of e-value for BLAST search, default:
                      1e-5.
  -f FLANK            The length of extended flank sequence on either side of
                      the blast hit-site, default: 15000.
  -l1 MINLTR          Specify minimum length of LTR, default: 100.
  -l2 MAXLTR          Specify maximum length of LTR, default: 1000.
  -s LTRSIMILAR       Specify threshold(%) of the similarity of paired LTRs,
                      default: 80.
  -d1 MINDISTLTR      The minimum interval of paired-LTRs start-positions,
                      default: 1000.
  -d2 MAXDISTLTR      The maximum interval of paired-LTRs start-positions,
                      default: 15000.
  -t1 MINTSD          The minimum length for each TSD site, default: 4.
  -t2 MAXTSD          The maximum length for each TSD site, default: 6.
  -motif MOTIF        Specify start-motif (2 nucleotides) and end-motif (2
                      nucleotides), default string: TGCA.
  -mis MISMOTIF       The maximum number of mismatches nucleotides in motif,
                      default: 1.
  -ed EHMMER          Specify threshold of e-value using for HMMER search,
                      default: 1e-6.
  --gag GAG_LENGTH    The threshold of length of GAG protein in HMMER search,
                      default: 250 aa.
  --pro PRO_LENGTH    The threshold of length of PRO protein in HMMER search,
                      default: 50 aa.
  --rt RT_LENGTH      The threshold of length of RT protein in HMMER search,
                      default: 150 aa.
  --rh RNASEH_LENGTH  The threshold of length of RNaseH protein in HMMER
                      search, default: 65 aa.
  --int INT_LENGTH    The threshold of length of INT protein in HMMER search,
                      default: 150 aa.
  --env ENV_LENGTH    The threshold of length of ENV protein in HMMER search,
                      default: 250 aa.

----------------☆ Example of use ☆-----------------

ervdetective -i myotis_lucifugus.fna -p myotis_lucifugus -n 10 -o output
  
----------------------☆  End  ☆---------------------
```

