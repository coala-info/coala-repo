# emblmygff3 CWL Generation Report

## emblmygff3_EMBLmyGFF3

### Tool Description
Converts GFF3 and FASTA files to EMBL format.

### Metadata
- **Docker Image**: quay.io/biocontainers/emblmygff3:2.4--pyhdfd78af_1
- **Homepage**: https://github.com/NBISweden/EMBLmyGFF3
- **Package**: https://anaconda.org/channels/bioconda/packages/emblmygff3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emblmygff3/overview
- **Total Downloads**: 13.8K
- **Last updated**: 2025-08-01
- **GitHub**: https://github.com/NBISweden/EMBLmyGFF3
- **Stars**: N/A
### Original Help Text
```text
usage: EMBLmyGFF3 [-h] [-a] [-c CREATED]
                  [-d {CON,PAT,EST,GSS,HTC,HTG,MGA,WGS,TSA,STS,STD}]
                  [-g ORGANELLE] [-i LOCUS_TAG] [-k KEYWORD [KEYWORD ...]]
                  [-l CLASSIFICATION]
                  [-m {genomic DNA,genomic RNA,mRNA,tRNA,rRNA,other RNA,other DNA,transcribed RNA,viral cRNA,unassigned DNA,unassigned RNA}]
                  [-o OUTPUT] [-p PROJECT_ID] [-q]
                  [-r {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}]
                  [-s SPECIES] [-t {linear,circular}] [-v]
                  [-x {PHG,ENV,FUN,HUM,INV,MAM,VRT,MUS,PLN,PRO,ROD,SYN,TGN,UNC,VRL}]
                  [-z] [--ah {One of the parameters above}] [--de DE]
                  [--ra RA [RA ...]] [--rc RC] [--rg RG] [--rl RL] [--rt RT]
                  [--rx RX] [--email EMAIL] [--expose_translations]
                  [--force_unknown_features] [--force_uncomplete_features]
                  [--interleave_genes] [--keep_duplicates]
                  [--keep_short_sequences]
                  [--locus_numbering_start LOCUS_NUMBERING_START]
                  [--locus_zero_padding] [--no_progress] [--no_wrap_qualifier]
                  [--shame] [--translate]
                  [--use_attribute_value_as_locus_tag USE_ATTRIBUTE_VALUE_AS_LOCUS_TAG]
                  [--uncompressed_log] [--version VERSION] [--strain STRAIN]
                  [--environmental_sample]
                  [--isolation_source ISOLATION_SOURCE] [--isolate ISOLATE]
                  gff_file fasta

positional arguments:
  gff_file              Input gff-file.
  fasta                 Input fasta sequence.

options:
  -h, --help            show this help message and exit
  -a, --accession       Bolean. Accession number(s) for the entry. Default
                        value: XXX. The proper value is automatically filled
                        up by ENA during the submission by a unique accession
                        number they will assign. The accession number is used
                        to set up the AC line and the first token of the ID
                        line as well. Please visit [this
                        page](https://www.ebi.ac.uk/ena/submit/accession-
                        number-formats) and [this
                        one](https://www.ebi.ac.uk/ena/submit/sequence-
                        submission) to learn more about it. Activating the
                        option will set the Accession number with the fasta
                        sequence identifier.
  -c, --created CREATED
                        Creation time of the original entry. The default value
                        is the date of the day.
  -d, --data_class {CON,PAT,EST,GSS,HTC,HTG,MGA,WGS,TSA,STS,STD}
                        Data class of the sample. Default value 'XXX'. This
                        option is used to set up the 5th token of the ID line.
  -g, --organelle ORGANELLE
                        Sample organelle. No default value.
  -i, --locus_tag LOCUS_TAG
                        Locus tag prefix used to set up the prefix of the
                        locus_tag qualifier. The locus tag has to be
                        registered at ENA prior any submission. More
                        information
                        [here](https://www.ebi.ac.uk/ena/submit/locus-tags).
  -k, --keyword KEYWORD [KEYWORD ...]
                        Keywords for the entry. No default value.
  -l, --classification CLASSIFICATION
                        Organism classification e.g 'Eukaryota; Opisthokonta;
                        Metazoa'. The default value is the classification
                        found in the NCBI taxonomy DB from the species/taxid
                        given as --species parameter. If none is found, 'Life'
                        will be the default value.
  -m, --molecule_type {genomic DNA,genomic RNA,mRNA,tRNA,rRNA,other RNA,other DNA,transcribed RNA,viral cRNA,unassigned DNA,unassigned RNA}
                        Molecule type of the sample. No default value.
  -o, --output OUTPUT   Output filename.
  -p, --project_id PROJECT_ID
                        Project ID. Default is 'XXX' (This is used to set up
                        the PR line).
  -q, --quiet           Decrease verbosity.
  -r, --transl_table {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
                        Translation table. No default. (This is used to set up
                        the translation table qualifier transl_table of the
                        CDS features.) Please visit [NCBI genetic code](https:
                        //www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)
                        for more information.
  -s, --species SPECIES
                        Sample species, formatted as 'Genus species' or taxid.
                        No default. (This is used to set up the OS line.)
  -t, --topology {linear,circular}
                        Sequence topology. No default. (This is used to set up
                        the Topology that is the 3rd token of the ID line.)
  -v, --verbose         Increase verbosity.
  -x, --taxonomy {PHG,ENV,FUN,HUM,INV,MAM,VRT,MUS,PLN,PRO,ROD,SYN,TGN,UNC,VRL}
                        Source taxonomy. Default value 'XXX'. This option is
                        used to set the taxonomic division within ID line (6th
                        token).
  -z, --gzip            Gzip output file.
  --ah, --advanced_help {One of the parameters above}
                        Display advanced information of the parameter
                        specified or of all parameters if none specified.
  --de DE               Description. Default value 'XXX'.
  --ra, --author RA [RA ...]
                        Author for the reference. No default value.
  --rc RC               Reference Comment. No default value.
  --rg RG               Reference Group, the working groups/consortia that
                        produced the record. Default value 'XXX'.
  --rl RL               Reference publishing location. No default value.
  --rt RT               Reference Title. No default value.
  --rx RX               Reference cross-reference. No default value
  --email EMAIL         Email used to fetch information from NCBI taxonomy
                        database. Default value 'EMBLmyGFF3@tool.org'.
  --expose_translations
                        Copy feature and attribute mapping files to the
                        working directory. They will be used as mapping files
                        instead of the default internal JSON files. You may
                        modify them as it suits you.
  --force_unknown_features
                        Force to keep feature types not accepted by EMBL. /!\
                        Option not suitable for submission purpose.
  --force_uncomplete_features
                        Force to keep features whithout all the mandatory
                        qualifiers. /!\ Option not suitable for submission
                        purpose.
  --interleave_genes    Print gene features with interleaved mRNA and CDS
                        features.
  --keep_duplicates     Do not remove duplicate features during the process.
                        /!\ Option not suitable for submission purpose.
  --keep_short_sequences
                        Do not skip short sequences (<100bp). /!\ Option not
                        suitable for submission purpose.
  --locus_numbering_start LOCUS_NUMBERING_START
                        Start locus numbering with the provided value.
  --locus_zero_padding  Pad locus tag number with zero using the total amount
                        of features. i.e 0001 instead of 1
  --no_progress         Hide conversion progress counter.
  --no_wrap_qualifier   By default there is a line wrapping at 80 characters.
                        The cut is at the world level. Activating this option
                        will avoid the line-wrapping for the qualifiers.
  --shame               Suppress the shameless plug.
  --translate           Include translation in CDS features.
  --use_attribute_value_as_locus_tag USE_ATTRIBUTE_VALUE_AS_LOCUS_TAG
                        Use the value of the defined attribute as locus_tag.
  --uncompressed_log    Some logs can be compressed for better lisibility,
                        they won't.
  --version VERSION     Sequence version number. The default value is 1.
  --strain STRAIN       Strain from which sequence was obtained. May be needed
                        when organism belongs to Bacteria.
  --environmental_sample
                        Bolean. Identifies sequences derived by direct
                        molecular isolation from a bulk environmental DNA
                        sample with no reliable identification of the source
                        organism. May be needed when organism belongs to
                        Bacteria.
  --isolation_source ISOLATION_SOURCE
                        Describes the physical, environmental and/or local
                        geographical source of the biological sample from
                        which the sequence was derived. Mandatory when
                        environmental_sample option used.
  --isolate ISOLATE     Individual isolate from which the sequence was
                        obtained. May be needed when organism belongs to
                        Bacteria.
```

