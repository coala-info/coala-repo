# eukulele CWL Generation Report

## eukulele_EUKulele

### Tool Description
EUKulele is a standalone taxonomic annotation software designed primarily for marine microbial eukaryotes.

### Metadata
- **Docker Image**: quay.io/biocontainers/eukulele:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/AlexanderLabWHOI/EUKulele
- **Package**: https://anaconda.org/channels/bioconda/packages/eukulele/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eukulele/overview
- **Total Downloads**: 22.4K
- **Last updated**: 2025-05-09
- **GitHub**: https://github.com/AlexanderLabWHOI/EUKulele
- **Stars**: N/A
### Original Help Text
```text
Running EUKulele with command line arguments, as no valid configuration file was provided.
usage: eukulele [subroutine] --mets_or_mags [dataset_type] --sample_dir [sample_directory] --reference_dir [reference_database_location] [all other options]

Thanks for using EUKulele! EUKulele is a standalone taxonomic annotation
software. EUKulele is designed primarily for marine microbial eukaryotes.
Check the README for further information.

positional arguments:
  subroutine            Choice of subroutine to run.

options:
  -h, --help            show this help message and exit
  -v, --version
  -m METS_OR_MAGS, --mets_or_mags METS_OR_MAGS
  --n_ext NUCLEOTIDE_EXTENSION, --nucleotide_extension NUCLEOTIDE_EXTENSION
  --p_ext PROTEIN_EXTENSION, --protein_extension PROTEIN_EXTENSION
  -x PROTEINS_OR_NT, --proteins_or_nt PROTEINS_OR_NT
  -f, --force_rerun
  --scratch SCRATCH     The scratch location to store intermediate files.
  --config_file CONFIG_FILE
  --perc_mem PERC_MEM   The percentage of the total available memory which
                        should be targeted for use by processes.
  --use_salmon_counts
  --salmon_dir SALMON_DIR
                        Salmon directory is required if use_salmon_counts is
                        true.
  --names_to_reads NAMES_TO_READS
                        A file to be created or used if it exists that relates
                        transcript names to salmon counts from the salmon
                        directory.
  -d DATABASE, --database DATABASE
                        The name of the database to be used to assess the
                        reads.
  -o OUT_DIR, --out_dir OUT_DIR, --output_dir OUT_DIR
                        Folder where the output will be written.
  -s SAMPLE_DIR, --sample_dir SAMPLE_DIR
                        Folder where the input data is located (the protein or
                        peptide files to be assessed).
  --reference_dir REFERENCE_DIR
                        Folder containing the reference files for the chosen
                        database.
  --ref_fasta REF_FASTA
                        Either a file in the reference directory where the
                        fasta file for the database is located, or a directory
                        containing multiple fasta files that constitute the
                        database.
  --tax_table TAX_TABLE
  --protein_map PROTEIN_MAP
  --alignment_choice {diamond,blast}
  --busco_file BUSCO_FILE
                        If specified, the following two arguments ('--
                        organisms' and '--taxonomy_organisms' are overwritten
                        by the two columns of this tab-separated file.
  --individual_or_summary {summary,individual}
                        These arguments are used if 'individual' is specified.
  -i, --individual
  --organisms ORGANISMS [ORGANISMS ...]
                        List of organisms to check BUSCO completeness on.
  --taxonomy_organisms TAXONOMY_ORGANISMS [TAXONOMY_ORGANISMS ...]
                        Taxonomic level of organisms specified in organisms
                        tag.
  --cutoff_file CUTOFF_FILE
  --consensus_proportion CONSENSUS_PROPORTION
  --filter_metric {pid,evalue,bitscore}
  --consensus_cutoff CONSENSUS_CUTOFF
  --transdecoder_orfsize TRANSDECODER_ORFSIZE
  --CPUs CPUS
  --busco_threshold BUSCO_THRESHOLD
  --no_busco            When true, BUSCO steps are not run.
  --create_euk_fasta    Whether to create FASTA files containing sequences
                        identified to be eukaryotic.
  --create_fasta        Whether to create FASTA files containing ID'd
                        transcripts during BUSCO analysis.
  --run_transdecoder    Whether TransDecoder should be run on
                        metatranscriptomic samples. Otherwise, BLASTp is run
                        if protein translated samples are providedotherwise
                        BLASTx is run on nucleotide samples.
  --test                Whether we're just running a test and should not
                        execute downloads.
```

