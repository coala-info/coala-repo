# hybran CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hybran | PASS |  |
| hybran_compare | Failed | tool bug: crashes with a TypeError (None joined in a report line) when the two annotations differ; works only on identical annotations |
| hybran_defuse | PASS |  |
| hybran_onegene | PASS | ran on a single reference (no duplicate genes), so the unifications table is empty and the annotation is copied unchanged |
| hybran_standardize | PASS |  |
| hybran_synergize | Failed | tool bug: on a hybran output directory it crashes with AttributeError 'function' object has no attribute 'glob'; the GenBank mode fails with KeyError 'gene' on hybran's own reference files |

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

## hybran_standardize

### Tool Description
Apply standard naming conventions to Hybran output.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://gitlab.com/LPCDRP/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hybran standardize [-h] [-p ORF_PREFIX] [-o OUTPUT]
                          [-u UNIFICATIONS_FILE] [-r]
                          annotations [annotations ...]

positional arguments:
  annotations           Directory, space-separated list of GBKs, or a FOFN
                        containing all annotated genomes. If you pass a hybran
                        output directory here, no other arguments will be
                        required. Otherwise, you will need to provide the
                        location of the unifications file via
                        -u/--unifications-file.

options:
  -h, --help            show this help message and exit
  -p ORF_PREFIX, --orf-prefix ORF_PREFIX
                        prefix for generic gene names (*not* locus tags)
                        (default: HYBRA)
  -o OUTPUT, --output OUTPUT
                        Directory to output all new annotation files.
                        (default: .)
  -u UNIFICATIONS_FILE, --unifications-file UNIFICATIONS_FILE
                        reference annotation's unifications.tsv file produced
                        by hybran onegene. (default: None)
  -r, --ref-names-only  Do not use gene names supplied by the ab initio
                        caller. (default: False)
```

## hybran_onegene

### Tool Description
Unify names of gene duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://gitlab.com/LPCDRP/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hybran onegene [-h] [-p ORF_PREFIX] [-o OUTPUT] [-i IDENTITY_THRESHOLD]
                      [-c COVERAGE_THRESHOLD] [-t FIRST_GBK]
                      annotations [annotations ...]

positional arguments:
  annotations           Directory, space-separated list of GBKs, or a FOFN
                        containing all annotated genomes.

options:
  -h, --help            show this help message and exit
  -p ORF_PREFIX, --orf-prefix ORF_PREFIX
                        prefix for unifying gene names (*not* locus tags).
                        Such names will be applied to all sets of highly
                        conserved genes if they don't already have a name or
                        if they have discrepant names. Whatever you pass here
                        will be sandwiched by REF and X. (i.e., the default
                        HYBRA will be transformed into REFHYBRAX and then
                        used). (default: HYBRA)
  -o OUTPUT, --output OUTPUT
                        Directory to output all new annotation files.
                        (default: .)
  -i IDENTITY_THRESHOLD, --identity-threshold IDENTITY_THRESHOLD
                        Percent sequence identity threshold to use for
                        considering sequences as redundant. (default: 99)
  -c COVERAGE_THRESHOLD, --coverage-threshold COVERAGE_THRESHOLD
                        Percent alignment coverage threshold to use for
                        considering sequences as redundant. (default: 99)
  -t FIRST_GBK, --first-reference FIRST_GBK
                        Reference name or file name whose locus tags should be
                        used as unified names for conserved copies in the
                        others. Default is the annotation with the most named
                        CDSs. If you specify a file here that is not in your
                        input list, it will be added. (default: None)
```

## hybran_compare

### Tool Description
Compare two annotations of the same genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://gitlab.com/LPCDRP/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hybran compare [-h] [-o OUTDIR] annotations annotations

positional arguments:
  annotations           The two annotation files to compare, in genbank
                        format.

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Directory to output the results of the comparison.
                        (default: .)
```

## hybran_synergize

### Tool Description
Correct annotations using hints from discordant synteny (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://gitlab.com/LPCDRP/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hybran synergize [-h] [-r [REFERENCES ...]] [-s SEQ_DIR] [-o OUTDIR]
                        [-n NPROC] [-d] [-i BLAST_MIN_IDENTITY]
                        [-c BLAST_MIN_COVERAGE]
                        annotations [annotations ...]

positional arguments:
  annotations           hybran output directory, blocks_coords BED file,
                        Genbank annotation files, or the directory/directories
                        containing them.If you pass a hybran output directory,
                        you will not need to pass -r/--references, -s/--seq-
                        dir, or --genetic-code.

options:
  -h, --help            show this help message and exit
  -r [REFERENCES ...], --references [REFERENCES ...]
                        Directory, a space-separated list of GBKs, or a FOFN
                        containing Genbank files of reference
                        annotations.Required if not using hybran output
                        directory. (default: None)
  -s SEQ_DIR, --seq-dir SEQ_DIR
                        Directory containing corresponding genome sequence
                        files in fasta format. (default: None)
  -o OUTDIR, --outdir OUTDIR
                        Directory to output the results of the correction.
                        (default: .)
  -n NPROC, --nproc NPROC
                        number of parallel processes to use (default: 1)
  -d, --debug           write debug logs (default: False)
  -i BLAST_MIN_IDENTITY, --blast-min-identity BLAST_MIN_IDENTITY
                        Minimum percent sequence identity for matching genes
                        (default: 80)
  -c BLAST_MIN_COVERAGE, --blast-min-coverage BLAST_MIN_COVERAGE
                        Minimum percent sequence alignment coverage for
                        matching genes (default: 80)
```

## hybran_defuse

### Tool Description
Separate gene fusion annotations into single gene annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
- **Homepage**: https://gitlab.com/LPCDRP/hybran
- **Package**: https://anaconda.org/channels/bioconda/packages/hybran/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hybran defuse [-h] [-o OUTPUT] annotations_dir

positional arguments:
  annotations_dir       Results directory from the Hybran run whose gene
                        fusions you wish to defuse.

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Directory to output all new annotation files.
                        (default: .)
```
