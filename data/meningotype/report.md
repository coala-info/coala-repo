# meningotype CWL Generation Report

## meningotype

### Tool Description
In silico typing for Neisseria meningitidis

### Metadata
- **Docker Image**: quay.io/biocontainers/meningotype:0.8.5--pyhdfd78af_1
- **Homepage**: https://github.com/MDU-PHL/meningotype
- **Package**: https://anaconda.org/channels/bioconda/packages/meningotype/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meningotype/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2026-02-22
- **GitHub**: https://github.com/MDU-PHL/meningotype
- **Stars**: N/A
### Original Help Text
```text
usage: 
  meningotype [OPTIONS] <fasta1> <fasta2> <fasta3> ... <fastaN>

In silico typing for Neisseria meningitidis
Default: Serotyping, MLST and ctrA PCR

PCR Serotyping Ref: Mothershed et al, J Clin Microbiol 2004; 42(1): 320-328
PorA and FetA typing Ref: Jolley et al, FEMS Microbiol Rev 2007; 31: 89-96
Bexsero antigen sequence typing (BAST) Ref: Brehony et al, Vaccine 2016; 34(39): 4690-4697
See also http://www.neisseria.org/nm/typing/

positional arguments:
  FASTA           input FASTA files eg. fasta1, fasta2, fasta3 ... fastaN

options:
  -h, --help      show this help message and exit
  --finetype      perform porA and fetA fine typing (default=off)
  --porB          perform porB sequence typing (NEIS2020) (default=off)
  --bast          perform Bexsero antigen sequence typing (BAST) (default=off)
  --mlst          perform MLST (default=off)
  --all           perform MLST, porA, fetA, porB, BAST typing (default=off)
  --db DB         specify custom directory containing allele databases for porA/fetA typing
                  directory must contain database files: "FetA_VR.fas", "PorA_VR1.fas", "PorA_VR2.fas"
                  for Bexsero typing: "fHbp_peptide.fas", "NHBA_peptide.fas", "NadA_peptide.fas", "BASTalleles.txt"
  --printseq DIR  specify directory to save extracted porA/fetA/porB or BAST allele sequences (default=off)
  --cpus CPUS     number of cpus to use in BLAST search (default=1)
  --updatedb      update allele database from <pubmlst.org>
  --test          run test example
  --checkdeps     check dependencies are installed and exit
  --version       show program's version number and exit
```

