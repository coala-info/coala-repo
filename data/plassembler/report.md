# plassembler CWL Generation Report

## plassembler_assembled

### Tool Description
Runs assembled mode

### Metadata
- **Docker Image**: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/plassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2026-01-05
- **GitHub**: https://github.com/gbouras13/plassembler
- **Stars**: N/A
### Original Help Text
```text
Usage: plassembler assembled [OPTIONS]

  Runs assembled mode

Options:
  -h, --help                Show this message and exit.
  -V, --version             Show the version and exit.
  -d, --database PATH       Directory of PLSDB database.  [required]
  -l, --longreads PATH      FASTQ file of long reads.
  -1, --short_one PATH      R1 short read FASTQ file.
  -2, --short_two PATH      R2 short read FASTQ file.
  -c, --chromosome INTEGER  Approximate lower-bound chromosome length of
                            bacteria (in base pairs).  [default: 1000000]
  -o, --outdir PATH         Directory to write the output to.  [default:
                            plassembler.output/]
  -m, --min_length TEXT     minimum length for filtering long reads with
                            chopper.  [default: 500]
  -q, --min_quality TEXT    minimum quality q-score for filtering long reads
                            with chopper.  [default: 9]
  -t, --threads TEXT        Number of threads.  [default: 1]
  -f, --force               Force overwrites the output directory.
  -p, --prefix TEXT         Prefix for output files. This is not required.
                            [default: plassembler]
  --skip_qc                 Skips qc (chopper and fastp).
  --pacbio_model TEXT       Pacbio model for Flye.  Must be one of pacbio-raw,
                            pacbio-corr or pacbio-hifi.  Use pacbio-raw for
                            PacBio regular CLR reads (<20 percent error),
                            pacbio-corr for PacBio reads that were corrected
                            with other methods (<3 percent error) or pacbio-
                            hifi for PacBio HiFi reads (<1 percent error).
  --flye_directory PATH     Directory containing Flye long read assembly.
                            Needs to contain assembly_info.txt and
                            assembly_info.fasta. Allows Plassembler to Skip
                            Flye assembly step.
  --depth_filter FLOAT      Filters all contigs low than this fraction of the
                            chromosome read depth. Will apply on both long-
                            and short-read sets for plassembler run.
  --unicycler_options TEXT  Extra Unicycler options - must be encapsulated by
                            quotation marks if multiple "--no_rotate --mode
                            conservative"
  --spades_options TEXT     Extra spades options for Unicycler - must be
                            encapsulated by quotation marks "--tmp-dir /tmp"
  --skip_mash               Skips mash search vs Plassembler PLSDB database
  --input_chromosome TEXT   Input FASTA file consisting of already assembled
                            chromosome with assembled mode.  Must be 1
                            complete contig.
  --input_plasmids TEXT     Input FASTA file consisting of already assembled
                            plasmids with assembled mode.  Requires FASTQ file
                            input (short only, long only or long + short).
  --no_copy_numbers         Only run the PLSDB mash screen, not copy number
                            estimation
```


## plassembler_citation

### Tool Description
Please cite plassembler in your paper using:

### Metadata
- **Docker Image**: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/plassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Validation**: PASS

### Original Help Text
```text
Please cite plassembler in your paper using:

Bouras, G., Sheppard A.E., Mallawaarachchi, V., Vreugde S. (2023) Plassembler: an automated bacterial plasmid assembly tool, Bioinformatics, Volume 39, Issue 7, July 2023, btad409, https://doi.org/10.1093/bioinformatics/btad409
```


## plassembler_download

### Tool Description
Downloads Plassembler DB

### Metadata
- **Docker Image**: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/plassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plassembler download [OPTIONS]

  Downloads Plassembler DB

Options:
  -h, --help           Show this message and exit.
  -V, --version        Show the version and exit.
  -d, --database PATH  Directory where database will be stored.  [required]
  -f, --force          Force overwrites the database directory.
```


## plassembler_long

### Tool Description
Plassembler with long reads only

### Metadata
- **Docker Image**: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/plassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plassembler long [OPTIONS]

  Plassembler with long reads only

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -d, --database PATH           Directory of PLSDB database.
  -l, --longreads PATH          FASTQ file of long reads.  [required]
  -c, --chromosome INTEGER      Approximate lower-bound chromosome length of
                                bacteria (in base pairs).  [default: 1000000]
  -o, --outdir PATH             Directory to write the output to.  [default:
                                plassembler.output/]
  -m, --min_length TEXT         minimum length for filtering long reads with
                                chopper.  [default: 500]
  -q, --min_quality TEXT        minimum quality q-score for filtering long
                                reads with chopper.  [default: 9]
  -t, --threads TEXT            Number of threads.  [default: 1]
  -f, --force                   Force overwrites the output directory.
  -p, --prefix TEXT             Prefix for output files. This is not required.
                                [default: plassembler]
  --skip_qc                     Skips qc (chopper and fastp).
  --pacbio_model TEXT           Pacbio model for Flye.  Must be one of pacbio-
                                raw, pacbio-corr or pacbio-hifi.  Use pacbio-
                                raw for PacBio regular CLR reads (<20 percent
                                error), pacbio-corr for PacBio reads that were
                                corrected with other methods (<3 percent
                                error) or pacbio-hifi for PacBio HiFi reads
                                (<1 percent error).
  -r, --raw_flag                Use --nano-raw for Flye.  Designed for Guppy
                                fast configuration reads.  By default, Flye
                                will assume SUP or HAC reads and use --nano-
                                hq.
  --keep_fastqs                 Whether you want to keep FASTQ files
                                containing putative plasmid reads  and long
                                reads that map to multiple contigs (plasmid
                                and chromosome).
  --keep_chromosome             If you want to keep the chromosome assembly.
  --canu_flag                   Runs canu instead of Unicycler (aka replicates
                                v1.2.0). As of v1.3.0, Unicycler is the
                                assembler for long reads. Canu is only
                                recommended if you have low quality reads
                                (e.g. ONT R9).
  --corrected_error_rate FLOAT  Corrected error rate parameter for canu
                                -correct. For advanced users only.
  --depth_filter FLOAT          Filters all contigs low than this fraction of
                                the chromosome read depth. Will apply on both
                                long- and short-read sets for plassembler run.
  --unicycler_options TEXT      Extra Unicycler options - must be encapsulated
                                by quotation marks if multiple "--no_rotate
                                --mode conservative"
  --spades_options TEXT         Extra spades options for Unicycler - must be
                                encapsulated by quotation marks "--tmp-dir
                                /tmp"
  --skip_mash                   Skips mash search vs Plassembler PLSDB
                                database
  --flye_directory PATH         Directory containing Flye long read assembly.
                                Needs to contain assembly_info.txt and
                                assembly_info.fasta. Allows Plassembler to
                                Skip Flye assembly step.
  --flye_assembly PATH          Path to file containing Flye long read
                                assembly FASTA. Allows Plassembler to Skip
                                Flye assembly step in conjunction with
                                --flye_info.
  --flye_info PATH              Path to file containing Flye long read
                                assembly info text file. Allows Plassembler to
                                Skip Flye assembly step in conjunction with
                                --flye_assembly.
  --no_chromosome               Run Plassembler assuming no chromosome can be
                                assembled. Use this if your reads only contain
                                plasmids that you would like to assemble.
```


## plassembler_run

### Tool Description
Runs Plassembler

### Metadata
- **Docker Image**: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/plassembler
- **Package**: https://anaconda.org/channels/bioconda/packages/plassembler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plassembler run [OPTIONS]

  Runs Plassembler

Options:
  -h, --help                Show this message and exit.
  -V, --version             Show the version and exit.
  -d, --database PATH       Directory of PLSDB database.
  -l, --longreads PATH      FASTQ file of long reads.  [required]
  -1, --short_one PATH      R1 short read FASTQ file.  [required]
  -2, --short_two PATH      R2 short read FASTQ file.  [required]
  -c, --chromosome INTEGER  Approximate lower-bound chromosome length of
                            bacteria (in base pairs).  [default: 1000000]
  -o, --outdir PATH         Directory to write the output to.  [default:
                            plassembler.output/]
  -m, --min_length TEXT     minimum length for filtering long reads with
                            chopper.  [default: 500]
  -q, --min_quality TEXT    minimum quality q-score for filtering long reads
                            with chopper.  [default: 9]
  -t, --threads TEXT        Number of threads.  [default: 1]
  -f, --force               Force overwrites the output directory.
  -p, --prefix TEXT         Prefix for output files. This is not required.
                            [default: plassembler]
  --skip_qc                 Skips qc (chopper and fastp).
  --pacbio_model TEXT       Pacbio model for Flye.  Must be one of pacbio-raw,
                            pacbio-corr or pacbio-hifi.  Use pacbio-raw for
                            PacBio regular CLR reads (<20 percent error),
                            pacbio-corr for PacBio reads that were corrected
                            with other methods (<3 percent error) or pacbio-
                            hifi for PacBio HiFi reads (<1 percent error).
  --flye_directory PATH     Directory containing Flye long read assembly.
                            Needs to contain assembly_info.txt and
                            assembly_info.fasta. Allows Plassembler to Skip
                            Flye assembly step.
  --depth_filter FLOAT      Filters all contigs low than this fraction of the
                            chromosome read depth. Will apply on both long-
                            and short-read sets for plassembler run.
  --unicycler_options TEXT  Extra Unicycler options - must be encapsulated by
                            quotation marks if multiple "--no_rotate --mode
                            conservative"
  --spades_options TEXT     Extra spades options for Unicycler - must be
                            encapsulated by quotation marks "--tmp-dir /tmp"
  --skip_mash               Skips mash search vs Plassembler PLSDB database
  -r, --raw_flag            Use --nano-raw for Flye.  Designed for Guppy fast
                            configuration reads.  By default, Flye will assume
                            SUP or HAC reads and use --nano-hq.
  --keep_fastqs             Whether you want to keep FASTQ files containing
                            putative plasmid reads  and long reads that map to
                            multiple contigs (plasmid and chromosome).
  --keep_chromosome         If you want to keep the chromosome assembly.
  --use_raven               Uses Raven instead of Flye for long read assembly.
                            May be useful if you want to reduce runtime.
  --flye_directory PATH     Directory containing Flye long read assembly.
                            Needs to contain assembly_info.txt and
                            assembly_info.fasta. Allows Plassembler to Skip
                            Flye assembly step.
  --flye_assembly PATH      Path to file containing Flye long read assembly
                            FASTA. Allows Plassembler to Skip Flye assembly
                            step in conjunction with  --flye_info.
  --flye_info PATH          Path to file containing Flye long read assembly
                            info text file. Allows Plassembler to Skip Flye
                            assembly step in conjunction with
                            --flye_assembly.
  --no_chromosome           Run Plassembler assuming no chromosome can be
                            assembled. Use this if your reads only contain
                            plasmids that you would like to assemble.
```

