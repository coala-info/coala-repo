# cenote-taker3 CWL Generation Report

## cenote-taker3_cenotetaker3

### Tool Description
Cenote-Taker 3 is a pipeline for virus discovery and thorough annotation of viral contigs and genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/cenote-taker3:3.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/mtisza1/Cenote-Taker3
- **Package**: https://anaconda.org/channels/bioconda/packages/cenote-taker3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cenote-taker3/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/mtisza1/Cenote-Taker3
- **Stars**: N/A
### Original Help Text
```text
this script dir: /usr/local/lib/python3.13/site-packages/cenote
usage: cenotetaker3 [-h] -c ORIGINAL_CONTIGS -r RUN_TITLE -p PROPHAGE [-t CPU]
                    [--version] [-am ANNOTATION_MODE] [-wd C_WORKDIR]
                    [--template_file TEMPLATE_FILE]
                    [--reads READS [READS ...]]
                    [--minimum_length_circular CIRC_LENGTH_CUTOFF]
                    [--minimum_length_linear LINEAR_LENGTH_CUTOFF]
                    [-db {virion,rdrp,dnarep} [{virion,rdrp,dnarep} ...]]
                    [--lin_minimum_hallmark_genes LIN_MINIMUM_DOMAINS]
                    [--circ_minimum_hallmark_genes CIRC_MINIMUM_DOMAINS]
                    [-hh {none,hhblits,hhsearch}]
                    [--caller {prodigal-gv,prodigal,phanotate,adaptive}]
                    [--isolation_source ISOLATION_SOURCE]
                    [--collection_date COLLECTION_DATE]
                    [--metagenome_type METAGENOME_TYPE]
                    [--srr_number SRR_NUMBER] [--srx_number SRX_NUMBER]
                    [--biosample BIOSAMPLE] [--bioproject BIOPROJECT]
                    [--assembler ASSEMBLER] [--molecule_type MOLECULE_TYPE]
                    [--data_source DATA_SOURCE] [--cenote-dbs C_DBS]
                    [--hmmscan_dbs HMM_DBS] [--wrap WRAP] [--genbank GENBANK]
                    [--taxdb {refseq,hallmark}] [--seqtech SEQTECH]
                    [--max_dtr_assess MAXDTR] [--circ-file CIRCF]

Cenote-Taker 3 is a pipeline for virus discovery and thorough annotation of
viral contigs and genomes. Visit https://github.com/mtisza1/Cenote-Taker3 for
help. Version 3.4.4

options:
  -h, --help            show this help message and exit

 REQUIRED ARGUMENTS for Cenote-Taker 3 :
  -c, --contigs ORIGINAL_CONTIGS
                        Contig file with .fasta extension in fasta format.
                        Each header must be unique before the first space
                        character
  -r, --run_title RUN_TITLE
                        Name of this run. A directory of this name will be
                        created. Must be unique from older runs or older run
                        will be renamed. Must be less than 18 characters,
                        using ONLY letters, numbers and underscores (_)
  -p, --prune_prophage PROPHAGE
                        True or False. Attempt to identify and remove flanking
                        chromosomal regions from non-circular contigs with
                        viral hallmarks (True is highly recommended for
                        sequenced material not enriched for viruses. Virus-
                        enriched samples probably should be False (you might
                        check enrichment with ViromeQC). Also, please use
                        False if --lin_minimum_hallmark_genes is set to 0)

 OPTIONAL ARGUMENTS for Cenote-Taker 3. See                                             https://www.ncbi.nlm.nih.gov/Sequin/sequin.hlp.html#ModifiersPage for more                                             information on GenBank metadata fields:
  -t, --cpu CPU         Default: 20 -- Example: 32 -- Number of CPUs available
                        for Cenote-Taker 3.
  --version             show program's version number and exit
  -am, --annotation_mode ANNOTATION_MODE
                        Default: False -- Annotate sequences only (skip
                        discovery). Only use if you believe each provided
                        sequence is viral
  -wd, --working_directory C_WORKDIR
                        Default: / -- Set working directory with absolute or
                        relative path. run directory will be created within.
  --template_file TEMPLATE_FILE
                        Template file with some metadata. Real one required
                        for GenBank submission. Takes a couple minutes to
                        generate: https://submit.ncbi.nlm.nih.gov/genbank/temp
                        late/submission/
  --reads READS [READS ...]
                        read file(s) in .fastq format. You can specify more
                        than one separated by a space
  --minimum_length_circular CIRC_LENGTH_CUTOFF
                        Default: 1000 -- Minimum length of contigs to be
                        checked for circularity. Bare minimun is 1000 nts
  --minimum_length_linear LINEAR_LENGTH_CUTOFF
                        Default: 1000 -- Minimum length of non-circualr
                        contigs to be checked for viral hallmark genes.
  -db, --virus_domain_db {virion,rdrp,dnarep} [{virion,rdrp,dnarep} ...]
                        default: virion rdrp -- Hits to which domain types
                        should count as hallmark genes? 'virion' database:
                        genes encoding virion structural proteins, packaging
                        proteins, or capsid maturation proteins (DNA and RNA
                        genomes) with LOWEST false discovery rate. 'rdrp'
                        database: For RNA virus-derived RNA-dependent RNA
                        polymerase. 'dnarep' database: replication genes of
                        DNA viruses. mostly useful for small DNA viruses, e.g.
                        CRESS viruses
  --lin_minimum_hallmark_genes LIN_MINIMUM_DOMAINS
                        Default: 1 -- Number of detected viral hallmark genes
                        on a non-circular contig to be considered viral and
                        recieve full annotation. '2' might be more suitable,
                        yielding a false positive rate near 0.
  --circ_minimum_hallmark_genes CIRC_MINIMUM_DOMAINS
                        Default:1 -- Number of detected viral hallmark genes
                        on a circular contig to be considered viral and
                        recieve full annotation. For samples physically
                        enriched for virus particles, '0' can be used, but
                        please treat circular contigs without known viral
                        domains cautiously. For unenriched samples, '1' might
                        be more suitable.
  -hh, --hhsuite_tool {none,hhblits,hhsearch}
                        default: none -- hhblits: query any of PDB, pfam, and
                        CDD (depending on what is installed) to annotate ORFs
                        escaping identification via upstream methods.
                        hhsearch: a more sensitive tool, will query PDB, pfam,
                        and CDD (depending on what is installed) to annotate
                        ORFs. (WARNING: hhsearch takes much, much longer than
                        hhblits and can extend the duration of the run many
                        times over. Do not use on large input contig files).
                        'none': forgoes annotation of ORFs with hhsuite.
                        Fastest way to complete a run.
  --caller {prodigal-gv,prodigal,phanotate,adaptive}
                        ORF caller for viruses. default: prodigal-gv prodigal-
                        gv: prodigal-gv only (prodigal with extra models for
                        unusual viruses) (meta mode) prodigal: prodigal
                        classic only (meta mode). phanotate: phanotate only
                        Note: phanotate takes longer than prodigal,
                        exponentially so for LONG input contigs. adaptive:
                        will choose based on preliminary taxonomy call (phages
                        = phanotate, others = prodigal-gv)
  --isolation_source ISOLATION_SOURCE
                        Default: unknown -- Describes the local geographical
                        source of the organism from which the sequence was
                        derived
  --collection_date COLLECTION_DATE
                        Default: unknown -- Date of collection. this format:
                        01-Jan-2019, i.e. DD-Mmm-YYYY
  --metagenome_type METAGENOME_TYPE
                        Default: unknown -- a.k.a. metagenome_source
  --srr_number SRR_NUMBER
                        Default: unknown -- For read data on SRA, run number,
                        usually beginning with 'SRR' or 'ERR'
  --srx_number SRX_NUMBER
                        Default: unknown -- For read data on SRA, experiment
                        number, usually beginning with 'SRX' or 'ERX'
  --biosample BIOSAMPLE
                        Default: unknown -- For read data on SRA, sample
                        number, usually beginning with 'SAMN' or 'SAMEA' or
                        'SRS'
  --bioproject BIOPROJECT
                        Default: unknown -- For read data on SRA, project
                        number, usually beginning with 'PRJNA' or 'PRJEB'
  --assembler ASSEMBLER
                        Default: unknown_assembler -- Assembler used to
                        generate contigs, if applicable. Specify version of
                        assembler software, if possible.
  --molecule_type MOLECULE_TYPE
                        Default: DNA -- viable options are DNA - OR - RNA
  --data_source DATA_SOURCE
                        default: original -- original data is not taken from
                        other researchers' public or private database.
                        'tpa_assembly': data is taken from other researchers'
                        public or private database. Please be sure to specify
                        SRA metadata.
  --cenote-dbs C_DBS    DB path. If not set here, Cenote-Taker looks for
                        environmental variable CENOTE_DBS. Then, if this
                        variable is unset, DB path is assumed to be
                        /usr/local/lib/python3.13
  --hmmscan_dbs HMM_DBS
                        HMMscan DB version. looks in
                        cenote_db_path/hmmscan_DBs/
  --wrap WRAP           Default: True -- Wrap/rotate DTR/circular contigs so
                        the start codon of an ORF is the first nucleotide in
                        the contig/genome
  --genbank GENBANK     Default: True -- Make GenBank files (.gbf, .sqn, .fsa,
                        .tbl, .cmt, etc)?
  --taxdb {refseq,hallmark}
                        Default: hallmark -- Which taxonomy database to use,
                        just refseq virus OR virus hallmark genes from nr
                        virus containing genus, family, and class taxonomy
                        labels and clustered at 90 percent AAI plus all
                        hallmark genes from refseq virus
  --seqtech SEQTECH     Default: Illumina -- Which sequencing technology
                        produced the reads? Common options: Illumina,
                        Nanopore, PacBio, Onso, Aviti
  --max_dtr_assess MAXDTR
                        Default: 1000000 -- maximum sequence length to assess
                        DTRs. Extra long contigs with DTRs are likely to be
                        bacterial chromosomes, not virus genomes.
  --circ-file CIRCF     Provide a file with the names of contigs (header line
                        sans ">") you believe are circular, one per line. If
                        using this option, CT3 will treat listed contigs as
                        circular but will not search for DTRs in sequences.
                        Useful for long read assembly outputs (flye, myloasm)
                        that report circular contigs. --max_dtr_assess will
                        still be considered.
```


## cenote-taker3_get_ct3_dbs

### Tool Description
Update and/or download databases associated with Cenote-Taker 3. HMM (hmmer) databases: updated January 10th, 2024. RefSeq Virus taxonomy DB compiled July 31, 2023. hallmark taxonomy database added March 19th, 2024

### Metadata
- **Docker Image**: quay.io/biocontainers/cenote-taker3:3.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/mtisza1/Cenote-Taker3
- **Package**: https://anaconda.org/channels/bioconda/packages/cenote-taker3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get_ct3_dbs [-h] -o C_DBS [--hmm HMM_DB] [--refseq_tax REFSEQ_TAX]
                   [--hallmark_tax HALLMARK_TAX] [--mmseqs_cdd MMSEQS_CDD]
                   [--domain_list DOM_LIST] [--hhCDD HHCDD] [--hhPFAM HHPFAM]
                   [--hhPDB HHPDB]

Update and/or download databases associated with Cenote-Taker 3. HMM (hmmer)
databases: updated January 10th, 2024. RefSeq Virus taxonomy DB compiled July
31, 2023. hallmark taxonomy database added March 19th, 2024

options:
  -h, --help            show this help message and exit

 REQUIRED ARGUMENTS:
  -o C_DBS              output directory when database will be downloaded

Use options to pick databases to update.:
  --hmm HMM_DB          Default: False -- choose: True -or- False
  --refseq_tax REFSEQ_TAX
                        Default: False -- choose: True -or- False
  --hallmark_tax HALLMARK_TAX
                        Default: False -- choose: True -or- False
  --mmseqs_cdd MMSEQS_CDD
                        Default: False -- choose: True -or- False
  --domain_list DOM_LIST
                        Default: False -- choose: True -or- False
  --hhCDD HHCDD         Default: False -- choose: True -or- False
  --hhPFAM HHPFAM       Default: False -- choose: True -or- False
  --hhPDB HHPDB         Default: False -- choose: True -or- False
```

