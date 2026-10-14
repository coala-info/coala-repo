# pgdspider CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pgdspider_PGDSpider2-cli | PASS |  |

## pgdspider_PGDSpider2-cli

### Tool Description
PGDSpider is a data conversion tool for population genetic and genomics programs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgdspider:2.1.1.5--hdfd78af_1
- **Homepage**: http://www.cmpg.unibe.ch/software/PGDSpider/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgdspider/overview
- **Validation**: PASS

### Original Help Text
```text

--------------------------------------------------------------------------------------
 PGDSpider 2.1.1.5 Copyright (c) 2007 - 2018 by Heidi Lischer, University of Bern

 Citation:
  Lischer HEL and Excoffier L (2012) PGDSpider: An automated data conversion tool for
  connecting population genetics and genomics programs. Bioinformatics 28: 298-299.
--------------------------------------------------------------------------------------

Usage: PGDSpiderCli <options...>

Options:
-? or -h               For this page.
-inputfile <file>      The input file for the conversion (mandatory).
-inputformat <format>  Format of the input file. Mandatory if not defined
                       in the answer (SPID) file.
                       Possible input formats:
                       PGD, ARLEQUIN, BAM, BAPS, BATWING, BCF, CONVERT, EIGENSOFT, FASTA,
                       FASTQ, FSTAT, GDA, GENELAND, GENEPOP, GENETIX, HGDP, HGDP_CEPH,
                       IMMANC, IM, IMA2, MAF, MEGA, MIGRATE, MSA, NEWHYBRIDS, NEXUS,
                       ONESAMP, PED, PHYLIP, SAM, STRUCTURE, VCF, XMFA
-outputfile <file>     The output file for the conversion (mandatory).
-outputformat <format> Format of the output file. Mandatory if not defined
                       in the answer (SPID) file.
                       Possible output formats:
                       PGD, ARLEQUIN, BAM, BAMOVA, BAPS, BATWING, BAYENV, BCF, EIGENSOFT,
                       FASTA, FASTQ, FDIST2, FSTAT, GDA, GENELAND, GENEPOP,
                       GENETIX,GESTE_BAYE_SCAN, IMMANC, IM, IMA2, KML, MEGA, MIGRATE, MSA,
                       MSVAR, NEWHYBRIDS, NEXUS, ONESAMP, PED, PHYLIP, SAM, STRUCTURAMA,
                       STRUCTURE, VCF, XMFA
-spid <file>           SPID file containing preanswered conversion questions
                       (mandatory).
```

## Metadata
- **Skill**: generated

