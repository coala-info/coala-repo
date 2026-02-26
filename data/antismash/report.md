# antismash CWL Generation Report

## antismash

### Tool Description
antiSMASH 8.0.4

### Metadata
- **Docker Image**: quay.io/biocontainers/antismash:8.0.4--pyhdfd78af_0
- **Homepage**: http://antismash.secondarymetabolites.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/antismash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/antismash/overview
- **Total Downloads**: 62.6K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/antismash/antismash
- **Stars**: N/A
### Original Help Text
```text
########### antiSMASH 8.0.4 #############

usage: antismash [-h] [options ..] sequence


arguments:
  SEQUENCE  GenBank/EMBL/FASTA file(s) containing DNA.

--------
Options
--------
Help options:

  -h, --help            Show basic help text.
  --help-showall        Show full list of arguments.

Basic analysis options:

  -t {bacteria,fungi}, --taxon {bacteria,fungi}
                        Taxonomic classification of input sequence. (default:
                        bacteria)
  -c CPUS, --cpus CPUS  How many CPUs to use in parallel. (default for this
                        machine: 20)
  --databases PATH      Root directory of the databases (default:
                        /usr/local/lib/python3.11/site-
                        packages/antismash/databases).

Output options:

  --output-dir OUTPUT_DIR
                        Directory to write results to.
  --output-basename OUTPUT_BASENAME
                        Base filename to use for output files within the
                        output directory.
  --html-title HTML_TITLE
                        Custom title for the HTML output page (default is
                        input filename).
  --html-description HTML_DESCRIPTION
                        Custom description to add to the output.
  --html-start-compact  Use compact view by default for overview page.
  --html-ncbi-context, --no-html-ncbi-context
                        Show NCBI genomic context links for genes (default:
                        False).

Additional analysis:

  --fullhmmer           Run a whole-genome HMMer analysis using Pfam profiles.
  --cassis              Motif based prediction of SM gene cluster regions.
  --clusterhmmer        Run a cluster-limited HMMer analysis using Pfam
                        profiles.
  --genefunctions-mite-version GENEFUNCTIONS_MITE_VERSION
                        MITE database version number to use (e.g. 1.3)
                        (default: latest).
  --tigrfam             Annotate clusters using TIGRFam profiles.
  --asf                 Run active site finder analysis.
  --cc-mibig            Run a comparison against the MIBiG dataset
  --cb-general          Compare identified clusters against a database of
                        antiSMASH-predicted clusters.
  --cb-subclusters      Compare identified clusters against known subclusters
                        responsible for synthesising precursors.
  --cb-knownclusters    Compare identified clusters against known gene
                        clusters from the MIBiG database.
  --pfam2go             Run Pfam to Gene Ontology mapping module.
  --rre                 Run RREFinder precision mode on all RiPP gene
                        clusters.
  --smcog-trees         Generate phylogenetic trees of sec. met. cluster
                        orthologous groups.
  --tfbs                Run TFBS finder on all gene clusters.
  --tta-threshold TTA_THRESHOLD
                        Lowest GC content to annotate TTA codons at (default:
                        0.65).

Gene finding options (ignored when ORFs are annotated):

  --genefinding-tool {prodigal,prodigal-m,none,error}
                        Specify algorithm used for gene finding: Prodigal,
                        Prodigal Metagenomic/Anonymous mode, or none. The
                        'error' option will raise an error if genefinding is
                        attempted. The 'none' option will not run genefinding.
                        (default: error).
  --genefinding-gff3 GFF3_FILE
                        Specify GFF3 file to extract features from.
```

