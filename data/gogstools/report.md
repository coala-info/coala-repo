# gogstools CWL Generation Report

## gogstools_ogs_merge

### Tool Description
Merges two GFF files to create a new OGS annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
- **Homepage**: https://github.com/genouest/ogs-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gogstools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gogstools/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genouest/ogs-tools
- **Stars**: N/A
### Original Help Text
```text
usage: ogs_merge [-h] [-p PREVIOUS_GFF] [-d DELETED] [-o OUT_PREFIX]
                 genome ogs_name id_regex id_syntax base_gff apollo_gff

positional arguments:
  genome                Genome file (fasta)
  ogs_name              Name of the new OGS
  id_regex              Regex with a capturing group around the incremental
                        part of gene ids, and a second one around the version
                        suffix (e.g.
                        'GSSPF[GPT]([0-9]{8})[0-9]{3}(\.[0-9]+)?')
  id_syntax             String representing a gene id, with {id} where the
                        incremental part of the id should be placed (e.g.
                        'GSSPFG{id}001')
  base_gff              The gff from the base annotation (usually automatic
                        annotation)
  apollo_gff            The gff from the new Apollo valid annotation

options:
  -h, --help            show this help message and exit
  -p PREVIOUS_GFF, --previous_gff PREVIOUS_GFF
                        The gff from the previous annotation version (if
                        different than <base_gff>)
  -d DELETED, --deleted DELETED
                        File containing a list of mRNAs to remove
  -o OUT_PREFIX, --out_prefix OUT_PREFIX
                        Prefix for output files (default=<ogs_name>_<today's
                        date>)
```


## gogstools_gff2embl

### Tool Description
Convert GFF3 to EMBL format for ENA submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
- **Homepage**: https://github.com/genouest/ogs-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gogstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gff2embl [-h] -g GENOME -p PROTEINS -s SPECIES -d DESCRIPTION -e EMAIL
                -j PROJECT [--ref_title REF_TITLE] [--ref_journal REF_JOURNAL]
                [--ref_authors REF_AUTHORS] [--ref_pubmed_id REF_PUBMED_ID]
                [--ref_consortium REF_CONSORTIUM] [--no_stop_codon]
                [--no_empty_seq]
                [--division {PHG,ENV,FUN,HUM,INV,MAM,VRT,MUS,PLN,PRO,ROD,SYN,TGN,UNC,VRL}]
                [--out-format {embl-standard,embl-ebi-submit}]
                [gff] [out]

positional arguments:
  gff                   The gff to read from
  out                   The output embl file, ready for submission to EBI ENA

options:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        A fasta file containing genome sequence
  -p PROTEINS, --proteins PROTEINS
                        A fasta file containing protein sequences
  -s SPECIES, --species SPECIES
                        The name of the species
  -d DESCRIPTION, --description DESCRIPTION
                        Description of the project
  -e EMAIL, --email EMAIL
                        A valid email address
  -j PROJECT, --project PROJECT
                        A valid EBI study ID (PRJXXXXXXX)
  --ref_title REF_TITLE
                        Title of the reference
  --ref_journal REF_JOURNAL
                        Journal of the reference
  --ref_authors REF_AUTHORS
                        Authors of the reference
  --ref_pubmed_id REF_PUBMED_ID
                        PubMed ID of the reference
  --ref_consortium REF_CONSORTIUM
                        Consortium name of the reference
  --no_stop_codon       Add this option if the protein sequences don't contain
                        trailing stop codons even for complete sequences
  --no_empty_seq        Write only sequences having features
  --division {PHG,ENV,FUN,HUM,INV,MAM,VRT,MUS,PLN,PRO,ROD,SYN,TGN,UNC,VRL}
                        The taxonomic division (INV=invertebrate)
  --out-format {embl-standard,embl-ebi-submit}
                        Flavor of EMBL output format: embl-standard=standard
                        EMBL format; embl-ebi-submit=EMBL ready to submit to
                        EBI (some special formating for automatic EBI post-
                        processing)
```


## Metadata
- **Skill**: generated
