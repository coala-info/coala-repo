# hybran CWL Generation Report

## hybran

### Tool Description
Annotate genomes using reference annotations and ab initio gene prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://lpcdrp.gitlab.io/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2026-02-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: hybran annotate [-h] -g GENOMES [GENOMES ...] -r REFERENCES
                       [REFERENCES ...] [-s ORGANISM] [-e DATABASE_DIR]
                       [-t FIRST_GBK] [-o OUTPUT] [-n NPROC] [-d] [-f]
                       [--filter-ratt] [-p ORF_PREFIX] [--dedupe-references]
                       [--onegene-identity-threshold ONEGENE_IDENTITY_THRESHOLD]
                       [--onegene-coverage-threshold ONEGENE_COVERAGE_THRESHOLD]
                       [-i BLAST_MIN_IDENTITY] [-c BLAST_MIN_COVERAGE]
                       [-I MCL_INFLATION] [--verbose | -q] [-v]
                       [--ratt-transfer-type {Assembly,Assembly.Repetitive,Strain,Strain.Repetitive,Strain.global,Strain.global.Repetitive,Species,Species.Repetitive,Species.global,Species.global.Repetitive,Pacbio,Pacbio.Repetitive,PacbioG,Falciparum,Falciparum.Repetitive,Multiple,Free}]
                       [--ratt-splice-sites RATT_SPLICE_SITES]
                       [--ratt-correct-splice | --no-ratt-correct-splice]
                       [--ratt-correct-pseudogenes | --no-ratt-correct-pseudogenes]
                       [--kingdom {Archaea,Bacteria,Mitochondria,Viruses}]
                       [--genus GENUS] [--species SPECIES] [--strain STRAIN]
                       [--plasmid PLASMID] [--gram {+,pos,-,neg}]
                       [--prodigaltf PRODIGALTF] [--hmms HMMS] [--metagenome]
                       [--evalue EVALUE]

options:
  -h, --help            show this help message and exit

Required:
  -g GENOMES [GENOMES ...], --genomes GENOMES [GENOMES ...]
                        Directory, a space-separated list of FASTAs, or a FOFN
                        containing all genomes desired to be annotated. FASTA
                        format required. (default: None)
  -r REFERENCES [REFERENCES ...], --references REFERENCES [REFERENCES ...]
                        Directory, a space-separated list of GBKs, or a FOFN
                        containing Genbank files of reference annotations to
                        transfer. (default: None)

Optional:
  -s ORGANISM, --organism ORGANISM
                        genus only or binomial name (default: None)
  -e DATABASE_DIR, --eggnog-databases DATABASE_DIR
                        Directory of the eggnog databases downloaded using
                        download_eggnog_data.py -y bactNOG. Full path only
                        (default: None)
  -t FIRST_GBK, --first-reference FIRST_GBK
                        Reference name or file name whose locus tags should be
                        used as unified names for conserved copies in the
                        others. Default is the annotation with the most named
                        CDSs. If you specify a file here that is not in your
                        input list, it will be added. (default: None)
  -o OUTPUT, --output OUTPUT
                        Directory to output all new annotation files.
                        (default: .)
  -n NPROC, --nproc NPROC
                        Number of processors/CPUs to use (default: 1)
  -d, --debug           Don't delete temporary files created by Hybran.
                        (default: False)
  -f, --force           Force overwrite intermediate files (does not overwrite
                        annotation files already annotated using hybran.
                        (default: False)
  --filter-ratt         Enforce identity/coverage thresholds on RATT-
                        transferred annotations. (default: False)
  -p ORF_PREFIX, --orf-prefix ORF_PREFIX
                        prefix for generic gene names (*not* locus tags)
                        (default: HYBRA)
  --dedupe-references   Identify duplicate genes in the reference annotations
                        and assign one name to all copies.This option is
                        deprecated and has no effect.If name unification is
                        not desired, consider running `hybran standardize`
                        afterwards. (default: False)
  --verbose             Verbose output (default: False)
  -q, --quiet           No logging output when flagged (default: False)
  -v, --version         Print version and exit

Main Parameters Affecting the Inference of Gene Homologs:
  BLAST is used (for bidirectional best hits) in matching ab initio
  predicted genes to reference genes, as well as in preparing the input all
  vs. all hit matrix for MCL.

  --onegene-identity-threshold ONEGENE_IDENTITY_THRESHOLD
                        Minimum percent sequence identity threshold to use for
                        identifying redundant sequences. (default: 99)
  --onegene-coverage-threshold ONEGENE_COVERAGE_THRESHOLD
                        Minimum percent sequence coverage threshold to use for
                        identifying redundant sequences. (default: 99)
  -i BLAST_MIN_IDENTITY, --blast-min-identity BLAST_MIN_IDENTITY, --identity-threshold BLAST_MIN_IDENTITY
                        Minimum percent sequence identity threshold to use for
                        inferring homologs. (default: 95)
  -c BLAST_MIN_COVERAGE, --blast-min-coverage BLAST_MIN_COVERAGE, --coverage-threshold BLAST_MIN_COVERAGE
                        Minimum percent query and subject alignment coverage
                        threshold to use for inferring homologs. (default: 95)
  -I MCL_INFLATION, --mcl-inflation MCL_INFLATION
                        MCL inflation value. Higher value results in more
                        fine-grained clusters (fewer genes in common). See
                        <https://micans.org/mcl/man/mcl.html#opt-I> for
                        details. (default: 1.5)

RATT Options:
  See <https://ratt.sourceforge.net/documentation.html> and
  <https://github.com/ThomasDOtto/ratt> for more details.

  --ratt-transfer-type {Assembly,Assembly.Repetitive,Strain,Strain.Repetitive,Strain.global,Strain.global.Repetitive,Species,Species.Repetitive,Species.global,Species.global.Repetitive,Pacbio,Pacbio.Repetitive,PacbioG,Falciparum,Falciparum.Repetitive,Multiple,Free}
                        Presets for nucmer alignment settings to determine
                        synteny.Automatically set to 'Multiple' when multiple
                        references are provided unless 'Free' is specified.
                        (default: Strain)
  --ratt-splice-sites RATT_SPLICE_SITES
                        splice donor and acceptor sequences. example: GT..AG
                        (default: XX..XX)
  --ratt-correct-splice, --no-ratt-correct-splice
                        whether RATT should attempt splice site corrections
                        (default: False)
  --ratt-correct-pseudogenes, --no-ratt-correct-pseudogenes
                        whether RATT should attempt correction of reference
                        pseudogenes in your samples (default: False)

Prokka Options:
  See https://github.com/tseemann/prokka for more details.

  --kingdom {Archaea,Bacteria,Mitochondria,Viruses}
                        Determines which UniProtKB databases Prokka searches
                        against. (default: Bacteria)
  --genus GENUS         Genus name. Deprecated -- use hybran -s/--organism
                        instead (default: None)
  --species SPECIES     Species name. Deprecated -- use hybran -s/--organism
                        instead (default: None)
  --strain STRAIN       Strain name. Deprecated -- use hybran -s/--organism
                        instead (default: None)
  --plasmid PLASMID     Plasmid name or identifier (default: None)
  --gram {+,pos,-,neg}  Gram (default: None)
  --prodigaltf PRODIGALTF
                        Prodigal training file (default: None)
  --hmms HMMS           Trusted HMM to first annotate from (default: None)
  --metagenome          Improve gene predictions for highly fragmented genomes
                        (default: False)
  --evalue EVALUE       Similarity e-value cut-off (default: 1e-09)
```

