# dfast CWL Generation Report

## dfast

### Tool Description
DDBJ Fast Annotation and Submission Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/dfast:1.3.8--h5ca1c30_0
- **Homepage**: https://dfast.nig.ac.jp
- **Package**: https://anaconda.org/channels/bioconda/packages/dfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dfast/overview
- **Total Downloads**: 59.5K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/nigyta/dfast_core
- **Stars**: N/A
### Original Help Text
```text
usage: dfast -g your_genome.fna [options]

DFAST: DDBJ Fast Annotation and Submission Tool version 1.3.8.

Basic options:
  -g, --genome PATH     Genomic FASTA file for input. Can be gzipped.
  -o, --out PATH        Output directory (default:OUT)
  -c, --config PATH     Configuration file (default config will be used if not
                        specified)
  --organism STR        Organism name
  --strain STR          Strain name

Genome settings:
  --complete BOOL       Treat the query as a complete genome. Not required
                        unless you need INSDC submission files.
                        [t|f(=default)]
  --use_original_name BOOL
                        Use original sequence names in a query FASTA file
                        [t|f(=default)]
  --sort_sequence BOOL  Sort sequences by length [t(=default)|f]
  --minimum_length INT  Minimum sequence length (default:200)
  --fix_origin          Rotate/flip the chromosome so that the dnaA gene comes
                        first. (ONLY FOR A FINISHED GENOME)
  --offset INT          Offset from the start codon of the dnaA gene. (for
                        --fix_origin option, default=0)

Locus_tag settings:
  --locus_tag_prefix STR
                        Locus tag prefix (defaut:LOCUS)
  --step INT            Increment step of locus tag (default:10)
  --use_separate_tags BOOL
                        Use separate tags according to feature types
                        [t(=default)|f]

Workflow options:
  --threshold STR       Thresholds for default database search (format:
                        "pident,q_cov,s_cov,e_value", default: "0,75,75,1e-6")
  --database PATH       Additional reference database to be searched against
                        prior to the default database. (format:
                        db_path[,db_name[,pident,q_cov,s_cov,e_value]])
  --references PATH     Reference file(s) for OrthoSearch. Use semicolons for
                        multiple files, e.g. 'genome1.faa;genome2.gbk'
  --aligner STR         Aligner to use [ghostx(=default)|blastp|diamond]
  --use_prodigal        Use Prodigal to predict CDS instead of MGA
  --use_genemarks2 STR  Use GeneMarkS2 to predict CDS instead of MGA.
                        [auto|bact|arch]
  --use_trnascan STR    Use tRNAscan-SE to predict tRNA instead of Aragorn.
                        [bact|arch]
  --use_rnammer STR     Use RNAmmer to predict rRNA instead of Barrnap.
                        [bact|arch]
  --gcode INT           Genetic code [11(=default),4(=Mycoplasma)]
  --no_func_anno        Disable all functional annotation steps
  --no_hmm              Disable HMMscan
  --no_cdd              Disable CDDsearch
  --no_cds              Disable CDS prediction
  --no_rrna             Disable rRNA prediction
  --no_trna             Disable tRNA prediction
  --no_crispr           Disable CRISPR prediction
  --metagenome          Set options of MGA/Prodigal for metagenome contigs
  --amr                 [Preliminary implementation] Enable AMR/VFG annotation
                        and identification of plasmid-derived contigs
  --gff GFF             [Preliminary implementation] Read GFF to import
                        structural annotation. Ignores --use_original_name,
                        --sort_sequence, --fix_origin.

Genome source modifiers and metadata [advanced]:
  These values are only used to create INSDC submission files and do not
  affect the annotation result. See documents for more detail.

  --seq_names STR       Sequence names for each sequence (for complete genome)
  --seq_types STR       Sequence types for each sequence (chromosome/plasmid,
                        for complete genome)
  --seq_topologies STR  Sequence topologies for each sequence
                        (linear/circular, for complete genome)
  --additional_modifiers STR
                        Additional modifiers for source features
  --metadata_file PATH  Path to a metadata file (optional for DDBJ submission
                        file)

Run options:
  --cpu INT             Number of CPUs to use
  --use_locustag_as_gene_id
                        Use locustag as gene ID for FASTA and GFF. (Useful
                        when providing DFAST results to other tools such as
                        Roary)
  --dbroot PATH         DB root directory (default:APP_ROOT/db
  --force               Force overwriting output
  --debug               Run in debug mode (Extra logging and retaining
                        temporary files)
  --show_config         Show pipeline configuration and exit
  --version             Show program version
  -h, --help            Show this help message
```

