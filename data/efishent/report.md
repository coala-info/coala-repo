# efishent CWL Generation Report

## efishent

### Tool Description
1meFISHent 🎣 🧬 to design all your probes.

### Metadata
- **Docker Image**: quay.io/biocontainers/efishent:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/bbquercus/eFISHent/
- **Package**: https://anaconda.org/channels/bioconda/packages/efishent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/efishent/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bbquercus/eFISHent
- **Stars**: N/A
### Original Help Text
```text
usage: eFISHent -g REFERENCE_GENOME [-a REFERENCE_ANNOTATION] [-t THREADS]
                [-o OUTPUT_DIR] [-idx BUILD_INDICES] [-ap ANALYZE_PROBESET]
                [-int SAVE_INTERMEDIATES] [-om OPTIMIZATION_METHOD]
                [-otl OPTIMIZATION_TIME_LIMIT] [-seq SEQUENCE_FILE]
                [-id ENSEMBL_ID] [-gen GENE_NAME] [-org ORGANISM_NAME]
                [-plus IS_PLUS_STRAND] [-endo IS_ENDOGENOUS] [-l MIN_LENGTH]
                [-L MAX_LENGTH] [-sp SPACING] [-tm MIN_TM] [-TM MAX_TM]
                [-gc MIN_GC] [-GC MAX_GC] [-f FORMAMIDE_CONCENTRATION]
                [-na NA_CONCENTRATION] [-ot MAX_OFF_TARGETS]
                [-ct ENCODE_COUNT_TABLE] [-ep MAX_EXPRESSION_PERCENTAGE]
                [-kl KMER_LENGTH] [-km MAX_KMERS] [-dg MAX_DELTAG]
                [-sim SEQUENCE_SIMILARITY] [-h] [-V] [-s]

[1meFISHent 🎣 🧬 to design all your probes.[0m

[34m General options[0m:
  General configuration that will be used for all tasks.

  -g REFERENCE_GENOME, --reference-genome REFERENCE_GENOME
                        Path to reference genome fasta/fa file. [default: -,
                        required: True]
  -a REFERENCE_ANNOTATION, --reference-annotation REFERENCE_ANNOTATION
                        Path to reference genome annotation (gene transfer
                        format / gtf) file. [default: -, required: False]
  -t THREADS, --threads THREADS
                        Number of threads to launch. [default: 2, required:
                        False]
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Path to output directory. If not specified, will use
                        the current directory. [default: -, required: False]

[32m Run options[0m:
  Options that change the behavior of the workflow.

  -idx BUILD_INDICES, --build-indices BUILD_INDICES
                        Build indices for reference genome only. [default:
                        False, required: False]
  -ap ANALYZE_PROBESET, --analyze-probeset ANALYZE_PROBESET
                        Path to the workflow's output fasta file. Will analyze
                        the probe set in more detail and create a PDF. Note:
                        reference genome, target gene of interest, and
                        (optional) count table will still have to be provided!
                        [default: -, required: False]
  -int SAVE_INTERMEDIATES, --save-intermediates SAVE_INTERMEDIATES
                        Save intermediate files? [default: False, required:
                        False]
  -om OPTIMIZATION_METHOD, --optimization-method OPTIMIZATION_METHOD
                        Optimization method to use. Greedy will procedurally
                        select the next longest probe. Optimal will optimize
                        probes for maximum gene coverage - slow if many
                        overlaps are present (typically with non-stringent
                        parameter settings). [options: optimal, greedy].
                        [default: greedy, required: False]
  -otl OPTIMIZATION_TIME_LIMIT, --optimization-time-limit OPTIMIZATION_TIME_LIMIT
                        Time limit for optimization in seconds. Only used if
                        optimization method is set to 'optimal'. [default: 60,
                        required: False]

[31m Sequence options[0m:
  Details about the sequences the probe design will be performed on.

  -seq SEQUENCE_FILE, --sequence-file SEQUENCE_FILE
                        Path to the gene's sequence file. Use this if the
                        sequence can't be easily downloaded or if only certain
                        regions should be targeted. [default: -, required:
                        False]
  -id ENSEMBL_ID, --ensembl-id ENSEMBL_ID
                        Ensembl ID of the gene of interest. Can be used
                        instead of gene and organism name to download the gene
                        of interest. Used to filter out the gene of interest
                        from FPKM based filtering - will do an automated
                        blast-based filtering if not passed. [default: -,
                        required: False]
  -gen GENE_NAME, --gene-name GENE_NAME
                        Gene name. [default: -, required: False]
  -org ORGANISM_NAME, --organism-name ORGANISM_NAME
                        Latin name of the organism. Can be passed together
                        with `ensembl_id` to narrow search. [default: -,
                        required: False]
  -plus IS_PLUS_STRAND, --is-plus-strand IS_PLUS_STRAND
                        Is the probe targeting the plus strand? Note: Entrez
                        downloads will download the gene 5'-3'. Specifying the
                        strand is therefore not required. [default: True,
                        required: False]
  -endo IS_ENDOGENOUS, --is-endogenous IS_ENDOGENOUS
                        Is the probe endogenous? [default: True, required:
                        False]

[35m Probe options[0m:
  Probe filtering and design options.

  -l MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum probe length in nucleotides. [default: 21,
                        required: False]
  -L MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum probe length in nucleotides. [default: 25,
                        required: False]
  -sp SPACING, --spacing SPACING
                        Minimum distance in nucleotides between probes.
                        [default: 2, required: False]
  -tm MIN_TM, --min-tm MIN_TM
                        Minimum melting temperature in degrees C. Formamide
                        and Na concentration will affect melting temperature!
                        [default: 40.0, required: False]
  -TM MAX_TM, --max-tm MAX_TM
                        Maximum melting temperature in degrees C (see
                        minimum). [default: 60.0, required: False]
  -gc MIN_GC, --min-gc MIN_GC
                        Minimum GC content in percentage. [default: 20.0,
                        required: False]
  -GC MAX_GC, --max-gc MAX_GC
                        Maximum GC content in percentage. [default: 80.0,
                        required: False]
  -f FORMAMIDE_CONCENTRATION, --formamide-concentration FORMAMIDE_CONCENTRATION
                        Formamide concentration as a percentage of the total
                        buffer. [default: 10.0, required: False]
  -na NA_CONCENTRATION, --na-concentration NA_CONCENTRATION
                        Na concentration in mM. [default: 330.0, required:
                        False]
  -ot MAX_OFF_TARGETS, --max-off-targets MAX_OFF_TARGETS
                        Maximum number of off-targets binding anywhere BUT the
                        gene of interest in the genome. [default: 0, required:
                        False]
  -ct ENCODE_COUNT_TABLE, --encode-count-table ENCODE_COUNT_TABLE
                        Path to the ENCODE RNAseq count table provided as TSV,
                        CSV, or TXT format. The first two columns have to be
                        `gene_id` and `normalized_value` respectively.
                        Specific column names are not required. `gene_id` have
                        to be ensemble IDs of the respective genes.
                        `normalized_value` have to be normalized count values
                        (RPKM, FPKM, TPM, DeSeq2-norm, etc). [default: -,
                        required: False]
  -ep MAX_EXPRESSION_PERCENTAGE, --max-expression-percentage MAX_EXPRESSION_PERCENTAGE
                        Remove any off-target genes expressed more highly than
                        `max-expression-percentage` percentage of all genes.
                        Genes to remove are based on ENCODE RNAseq count table
                        provided in `encode-count-table`. Only used if
                        `encode-count-table` and `reference-annotation` are
                        provided. [default: 50.0, required: False]
  -kl KMER_LENGTH, --kmer-length KMER_LENGTH
                        Length of k-mer used to filter probe sequences.
                        [default: 15, required: False]
  -km MAX_KMERS, --max-kmers MAX_KMERS
                        Highest count of sub-k-mers found in reference genome.
                        [default: 5, required: False]
  -dg MAX_DELTAG, --max-deltag MAX_DELTAG
                        Maximum predicted deltaG in kcal/mol. Note: deltaGs
                        range from 0 (no secondary structures) to increasingly
                        negative values! [default: -10.0, required: False]
  -sim SEQUENCE_SIMILARITY, --sequence-similarity SEQUENCE_SIMILARITY
                        Maximum percentage probes can be similar. Applied to
                        their complements and reverse complements only.
                        Ensures probes don't falsely bind to eachother.
                        Setting any value above 0 could add multiple minute of
                        runtime! The lower the value (above 0) the fewer
                        potential probes. [default: 0, required: False]

[36mGeneral utilities[0m:
  -h, --help            Show this message.
  -V, --version         Show eFISHent's version number.
  -s, --silent          Change the program output to silent hiding information
                        on progress.

See the online wiki at "https://github.com/BBQuercus/eFISHent/wiki" for an
overview. We hope you enjoy using eFISHent 🥳!
```

