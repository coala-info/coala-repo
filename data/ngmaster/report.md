# ngmaster CWL Generation Report

## ngmaster

### Tool Description
In silico multi-antigen sequence typing for Neisseria gonorrhoeae (NG-MAST) and Neisseria gonorrhoeae Sequence Typing for Antimicrobial Resistance (NG-STAR)

### Metadata
- **Docker Image**: quay.io/biocontainers/ngmaster:1.1.1--pyhdfd78af_1
- **Homepage**: https://github.com/MDU-PHL/ngmaster
- **Package**: https://anaconda.org/channels/bioconda/packages/ngmaster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngmaster/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/MDU-PHL/ngmaster
- **Stars**: N/A
### Original Help Text
```text
usage: 
  ngmaster [OPTIONS] <fasta1> <fasta2> <fasta3> ... <fastaN>

In silico multi-antigen sequence typing for Neisseria gonorrhoeae (NG-MAST)
and Neisseria gonorrhoeae Sequence Typing for Antimicrobial Resistance (NG-STAR)

Please cite as:
  Kwong JC, Gonçalves da Silva A, Dyet K, Williamson DA, Stinear TP, Howden BP and Seemann T.
  NGMASTER: in silico multi-antigen sequence typing for Neisseria gonorrhoeae.
  Microbial Genomics 2016; doi: 10.1099/mgen.0.000076
  GitHub: https://github.com/MDU-PHL/ngmaster

positional arguments:
  FASTA            input FASTA files eg. fasta1, fasta2, fasta3 ... fastaN

options:
  -h, --help       show this help message and exit
  --db DB          specify custom directory containing allele databases
                   directory must contain database sequence files (.tfa) and allele profile files (ngmast.txt / ngstar.txt)
                   in mlst format (see <https://github.com/tseemann/mlst#adding-a-new-scheme>)
  --csv            output comma-separated format (CSV) rather than tab-separated
  --printseq FILE  specify filename to save allele sequences to
  --minid MINID    DNA percent identity of full allele to consider 'similar' [~]
  --mincov MINCOV  DNA percent coverage to report partial allele at [?]
  --updatedb       update NG-MAST and NG-STAR allele databases from <https://rest.pubmlst.org/db/pubmlst_neisseria_seqdef>
  --assumeyes      assume you are certain you wish to update db
  --test           run test example
  --comments       Include NG-STAR comments for each allele in output
  --version        show program's version number and exit
```

