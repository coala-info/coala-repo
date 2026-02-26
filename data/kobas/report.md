# kobas CWL Generation Report

## kobas_kobas-annotate

### Tool Description
Annotate input sequences with functional information.

### Metadata
- **Docker Image**: quay.io/biocontainers/kobas:3.0.3--py27_1
- **Homepage**: http://kobas.cbi.pku.edu.cn
- **Package**: https://anaconda.org/channels/bioconda/packages/kobas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kobas/overview
- **Total Downloads**: 17.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: kobas-annotate [-l] -i infile [-t intype] -s species [-o outfile] [-e evalue] [-r rank] [-n nCPUs] [-c coverage] [-z ortholog] [-k kobas_home] [-v blast_home] [-y blastdb] [-q kobasdb] [-p blastp] [-x blastx]

Options:
  -h, --help            show this help message and exit
  -l, --list            list available species, or list available databases
                        for a specific species
  -i INFILE, --infile=INFILE
                        input data file
  -t INTYPE, --intype=INTYPE
                        input type (fasta:pro, fasta:nuc, blastout:xml,
                        blastout:tab, id:refseqpro, id:uniprot, id:ensembl,
                        id:ncbigene), default fasta:pro
  -s SPECIES, --species=SPECIES
                        species abbreviation (for example: ko for KEGG
                        Orthology, hsa for Homo sapiens, mmu for Mus musculus,
                        dme for Drosophila melanogaster, ath for Arabidopsis
                        thaliana, sce for Saccharomyces cerevisiae and eco for
                        Escherichia coli K-12 MG1655)
  -o OUTFILE, --outfile=OUTFILE
                        output file for annotation result, default stdout
  -e EVALUE, --evalue=EVALUE
                        expect threshold for BLAST, default 1e-5
  -r RANK, --rank=RANK  rank cutoff for valid hits from BLAST result, default
                        5
  -n NCPUS, --nCPUs=NCPUS
                        number of CPUs to be used by BLAST, default 1
  -c COVERAGE, --coverage=COVERAGE
                        subject coverage cutoff for BLAST, default 0
  -z ORTHOLOG, --ortholog=ORTHOLOG
                        whether only use orthologs for cross-species
                        annotation or not, default NO (if only use orthologs,
                        please provide the species abbreviation of your input)
  -k KOBAS_HOME, --kobashome=KOBAS_HOME
                        Optional parameter. To set path to kobas_home, which
                        is parent directory of sqlite3/ and seq_pep/ , default
                        value is read from ~/.kobasrcwhere you set before
                        running kobas. If you set this parameter, it means you
                        set "kobasdb" and "blastdb" in this following
                        directory. e.g. "-k /home/user/kobas/", means that you
                        set kobasdb = /home/user/kobas/sqlite3/ and blastdb =
                        /home/user/kobas/seq_pep/
  -v BLAST_HOME, --blasthome=BLAST_HOME
                        Optional parameter. To set parent directory of blastx
                        and blastp. If you set this parameter, it means you
                        set "blastx" and "blastp" in this following directory.
                        Default value is read from ~/.kobasrc where you set
                        before running kobas
  -y BLASTDB, --blastdb=BLASTDB
                        Optional parameter. To set path to sep_pep/, default
                        value is read from ~/.kobasrc where you set before
                        running kobas
  -q KOBASDB, --kobasdb=KOBASDB
                        Optional parameter. To set path to sqlite3/, default
                        value is read from ~/.kobasrc where you set before
                        running kobas, e.g. "-q /kobas_home/sqlite3/"
  -p BLASTP, --blastp=BLASTP
                        Optional parameter. To set path to blastp program,
                        default value is read from ~/.kobasrc where you set
                        before running kobas
  -x BLASTX, --blastx=BLASTX
                        Optional parameter. To set path to  blasx program,
                        default value is read from ~/.kobasrc where you set
                        before running kobas
```


## kobas_kobas-identify

### Tool Description
Identify enriched biological terms from foreground and background gene lists.

### Metadata
- **Docker Image**: quay.io/biocontainers/kobas:3.0.3--py27_1
- **Homepage**: http://kobas.cbi.pku.edu.cn
- **Package**: https://anaconda.org/channels/bioconda/packages/kobas/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kobas-identify -f fgfile [-b bgfile] [-d databases] [-m test] [-n fdr] [-o outfile] [-c cutoff] [-k kobas_home] [-v blast_home] [-y blastdb] [-q kobasdb] [-p blastp] [-x blastx]

Options:
  -h, --help            show this help message and exit
  -f FGFILE, --fgfile=FGFILE
                        foreground file, the output of annotate
  -b BGFILE, --bgfile=BGFILE
                        background file, the output of annotate (3 or 4-letter
                        file name is not allowed), or species abbreviation
                        (for example: hsa for Homo sapiens, mmu for Mus
                        musculus, dme for Drosophila melanogaster, ath for
                        Arabidopsis thaliana, sce for Saccharomyces cerevisiae
                        and eco for Escherichia coli K-12 MG1655), default
                        same species as annotate
  -d DB, --db=DB        databases for selection, 1-letter abbreviation
                        separated by "/": K for KEGG PATHWAY, R for Reactome,
                        B for BioCyc, p for PANTHER, o for OMIM, k for KEGG
                        DISEASE, N for NHGRI GWAS Catalog, G for Gene
                        Ontology,  S for Gene Ontology Slim(GOslim), default
                        K/R/B/p/o/k/N/G/S
  -m METHOD, --method=METHOD
                        choose statistical test method: b for binomial test, c
                        for chi-square test, h for hypergeometric test /
                        Fisher's exact test, and x for frequency list, default
                        hypergeometric test / Fisher's exact test
  -n FDR, --fdr=FDR     choose false discovery rate (FDR) correction method:
                        BH for Benjamini and Hochberg, BY for Benjamini and
                        Yekutieli, QVALUE, and None, default BH
  -o OUTFILE, --outfile=OUTFILE
                        output file for identification result, default stdout
  -c CUTOFF, --cutoff=CUTOFF
                        terms with less than cutoff number of genes are not
                        used for statistical tests, default 5
  -k KOBAS_HOME, --kobashome=KOBAS_HOME
                        Optional parameter. To set path to kobas_home, which
                        is parent directory of sqlite3/ and seq_pep/ , default
                        value is read from ~/.kobasrcwhere you set before
                        running kobas. If you set this parameter, it means you
                        set "kobasdb" and "blastdb" in this following
                        directory. e.g. "-k /home/user/kobas/", means that you
                        set kobasdb = /home/user/kobas/sqlite3/ and blastdb =
                        /home/user/kobas/seq_pep/
  -v BLAST_HOME, --blasthome=BLAST_HOME
                        Optional parameter. To set parent directory of blastx
                        and blastp. If you set this parameter, it means you
                        set "blastx" and "blastp" in this following directory.
                        Default value is read from ~/.kobasrc where you set
                        before running kobas
  -y BLASTDB, --blastdb=BLASTDB
                        Optional parameter. To set path to sep_pep/, default
                        value is read from ~/.kobasrc where you set before
                        running kobas
  -q KOBASDB, --kobasdb=KOBASDB
                        Optional parameter. To set path to sqlite3/, default
                        value is read from ~/.kobasrc where you set before
                        running kobas, e.g. "-q /kobas_home/sqlite3/"
  -p BLASTP, --blastp=BLASTP
                        Optional parameter. To set path to blastp program,
                        default value is read from ~/.kobasrc where you set
                        before running kobas
  -x BLASTX, --blastx=BLASTX
                        Optional parameter. To set path to  blasx program,
                        default value is read from ~/.kobasrc where you set
                        before running kobas
```

