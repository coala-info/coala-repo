# anvio-minimal CWL Generation Report

## anvio-minimal

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It appears to be a log of a failed container build process due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Total Downloads**: 45.3K
- **Last updated**: 2026-01-21
- **GitHub**: https://github.com/merenlab/anvio
- **Stars**: 504
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-2914446236/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```


## Metadata
- **Skill**: generated

## anvio-minimal_anvi-gen-contigs-database

### Tool Description
Generate a new anvi'o contigs database

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: anvi-gen-contigs-database [-h] -f FASTA [-n PROJECT_NAME]
                                 [-T NUM_THREADS] [-o DB_FILE_PATH]
                                 [--db-variant VARIANT]
                                 [--description TEXT_FILE] [-L INT]
                                 [--skip-mindful-splitting] [-K INT]
                                 [--skip-gene-calling]
                                 [--prodigal-single-mode]
                                 [--prodigal-translation-table INT]
                                 [--full-gene-calling-report FILE]
                                 [--external-gene-calls GENE-CALLS]
                                 [--ignore-internal-stop-codons]
                                 [--skip-predict-frame]

options:
  -h, --help            show this help message and exit

MANDATORY INPUTS:
  Things you really need to provide to be in business.

  -f FASTA, --contigs-fasta FASTA
                        The FASTA file that contains reference sequences you
                        mapped your samples against. This could be a reference
                        genome, or contigs from your assembler. Contig names
                        in this file must match to those in other input files.
                        If there is a problem anvi'o will gracefully complain
                        about it. (default: None)
  -n PROJECT_NAME, --project-name PROJECT_NAME
                        Name of the project. Please choose a short but
                        descriptive name (so anvi'o can use it whenever she
                        needs to name an output file, or add a new table in a
                        database, or name her first born). (default: None)

PERFORMANCE:
  You have multiple cores? WELL, USE THEM MAYBE?.

  -T NUM_THREADS, --num-threads NUM_THREADS
                        Maximum number of threads to use for multithreading
                        whenever possible. Very conservatively, the default is
                        1. It is a good idea to not exceed the number of CPUs
                        / cores on your system. Plus, please be careful with
                        this option if you are running your commands on a SGE
                        --if you are clusterizing your runs, and asking for
                        multiple threads to use, you may deplete your
                        resources very fast. (default: 1)

OPTIONAL INPUTS:
  Things you may want to tweak.

  -o DB_FILE_PATH, --output-db-path DB_FILE_PATH
                        Output file path for the new database. (default:
                        CONTIGS.db)
  --db-variant VARIANT  A free-form text variable to associate a database with
                        a variant for power users and/or programmers. Please
                        leave this blank unless you are certain that you need
                        to set a db variant since it may influence downstream
                        processes. In an ideal world a variant would be a
                        single-word, without any capitalized letters or
                        special characters. (default: unknown)
  --description TEXT_FILE
                        A plain text file that contains some description about
                        the project. You can use Markdown syntax. The
                        description text will be rendered and shown in all
                        relevant interfaces, including the anvi'o interactive
                        interface, or anvi'o summary outputs. (default: None)
  -L INT, --split-length INT
                        Anvi'o splits very long contigs into smaller pieces,
                        without actually splitting them for real. These
                        'virtual' splits improve the efficacy of the
                        visualization step, and changing the split size gives
                        freedom to the user to adjust the resolution of their
                        display when necessary. The default value is (20000).
                        If you are planning to use your contigs database for
                        metagenomic binning, we advise you to not go below
                        10,000 (since the lower the split size is, the more
                        items to show in the display, and decreasing the split
                        size does not really help much to binning). But if you
                        are thinking about using this parameter for ad hoc
                        investigations other than binning, you should ignore
                        our advice, and set the split size as low as you want.
                        If you do not want your contigs to be split, you can
                        set the split size to '0' or any other negative
                        integer (lots of unnecessary freedom here, enjoy!).
  --skip-mindful-splitting
                        By default, anvi'o attempts to prevent soft-splitting
                        large contigs by cutting proper gene calls to make
                        sure a single gene is not broken into multiple splits.
                        This requires a careful examination of where genes
                        start and end, and to find best locations to split
                        contigs with respect to this information. So, when the
                        user asks for a split size of, say, 1,000, it serves
                        as a mere suggestion. When this flag is used, anvi'o
                        does what the user wants and creates splits at desired
                        lengths (although some functionality may become
                        unavailable for the projects that rely on a contigs
                        database that is initiated this way). (default: False)
  -K INT, --kmer-size INT
                        K-mer size for k-mer frequency calculations. The
                        default k-mer size for composition-based analyses is
                        4, historically. Although tetra-nucleotide frequencies
                        seem to offer the the sweet spot of sensitivity,
                        information density, and manageable number of
                        dimensions for clustering approaches, you are welcome
                        to experiment (but maybe you should leave it as is for
                        your first set of analyses). Note that the maximum
                        k-mer size is 5 (unless you can increase the column
                        limit in `sqlite3` to 32k, in which case the max is
                        7). (default: 4)

GENES IN CONTIGS:
  Expert thingies.

  --skip-gene-calling   By default, generating an anvi'o contigs database
                        includes the identification of open reading frames in
                        contigs by running a bacterial gene caller. Declaring
                        this flag will by-pass that process. If you prefer,
                        you can later import your own gene calling results
                        into the database. (default: False)
  --prodigal-single-mode
                        By default, anvi'o will use pyrodigal-gv for gene
                        calling (unless you skipped gene calling, or provided
                        anvi'o with external gene calls). One of the flags
                        anvi'o includes in pyrodigal-gv run is `-p meta`,
                        which optimizes pyrodigal-gv's ability to identify
                        genes in metagenomic assemblies. In some rare cases,
                        for a given set of contigs pyrodigal-gv will yield a
                        segmentation fault error due to one or more genes in
                        your collections will confuse the program when it is
                        used with the `-p meta` flag. While anvi'o developers
                        are not quite sure under what circumstances this
                        happens, we realized that removal of this flag often
                        solves this issue. If you are dealing with such
                        cyrptic errors, the inclusion of `--skip-prodigal-
                        meta-flag` will instruct anvi'o to run pyrodigal-gv
                        without the `-meta` flag, and may resolve this issue
                        for you. (default: False)
  --prodigal-translation-table INT
                        This is a parameter to pass to the Pyrodigal-gv for a
                        specific translation table. This parameter corresponds
                        to the parameter `-g` in Prodigal, the default value
                        of which is 11 (so if you do not set anything, it will
                        be set to 11 in Pyrodigal-gv runtime. Please refer to
                        the Prodigal documentation to determine what is the
                        right translation table for you if you think you need
                        it.) (default: None)
  --full-gene-calling-report FILE
                        When anvi'o is done with gene calling using pyrodigal,
                        it only stores some data about individual gene calls.
                        Using this parameter you can pass an output file to
                        report most comprehensive data on gene calls as a TAB-
                        delimited text file with gene caller ids matching to
                        those that are stored in the contigs-db. (default:
                        None)
  --external-gene-calls GENE-CALLS
                        A TAB-delimited file to define external gene calls.
                        The file must have these columns: 'gene_callers_id' (a
                        unique integer number for each gene call, start from
                        1), 'contig' (the contig name the gene call is found),
                        'start' (start position, integer), 'stop' (stop
                        position, integer), 'direction' (the direction of the
                        gene open reading frame; can be 'f' or 'r'), 'partial'
                        (whether it is a complete gene call, or a partial one;
                        must be 1 for partial calls, and 0 for complete
                        calls), 'call_type' (1 if it is coding, 2 if it is
                        noncoding, or 3 if it is unknown (only gene calls with
                        call_type = 1 will have amino acid sequences
                        translated)), 'source' (the gene caller), and
                        'version' (the version of the gene caller, i.e.,
                        v2.6.7 or v1.0). An additional 'optional' column is
                        'aa_sequence' to explicitly define the amino acid
                        seqeuence of a gene call so anvi'o does not attempt to
                        translate the DNA sequence itself. An EXAMPLE FILE
                        (with the optional 'aa_sequence' column (so feel free
                        to take it out for your own case)) can be found at the
                        URL https://bit.ly/2qEEHuQ. If you are providing
                        external gene calls, please also see the flag `--skip-
                        predict-frame`. (default: None)
  --ignore-internal-stop-codons
                        This is only relevant when you have an external gene
                        calls file. If anvi'o figures out that your custom
                        gene calls result in amino acid sequences with stop
                        codons in the middle, it will complain about it. You
                        can use this flag to tell anvi'o to don't check for
                        internal stop codons, Even though this shouldn't
                        happen in theory, we understand that it almost always
                        does. In these cases, anvi'o understands that
                        sometimes we don't want to care, and will not judge
                        you. Instead, it will replace every stop codon residue
                        in the amino acid sequence with an 'X' character.
                        Please let us know if you used this and things failed,
                        so we can tell you that you shouldn't have really used
                        it if you didn't like failures at the first place
                        (smiley). (default: False)
  --skip-predict-frame  When you provide an external gene calls file, anvi'o
                        will predict the correct frame for each gene as best
                        as it can by using a previously-generated Markov model
                        that is trained using the uniprot50 database (see this
                        for details:
                        https://github.com/merenlab/anvio/pull/1428), UNLESS
                        there is an `aa_sequence` entry for a given gene call
                        in the external gene calls file. Please note that
                        PREDICTING FRAMES MAY CHANGE START/STOP POSITIONS OF
                        YOUR GENE CALLS SLIGHTLY, if start/stop positions in
                        the external gene calls file are not describing proper
                        gene calls according to the model. If you use this
                        flag, anvi'o will not rely on any model and will
                        attempt to translate your DNA sequences by solely
                        relying upon start/stop positions in the file, but it
                        will complain about sequences start/stop positions of
                        which are not divisible by 3. (default: False)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔥 Program description:

   Generate a new anvi'o contigs database


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
## anvio-minimal_anvi-run-hmms

### Tool Description
The provided text does not contain help information for the tool, but rather a system error log indicating a failure to build/extract a container image due to lack of disk space. No command-line arguments could be extracted from this text.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-1973015000/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-run-ncbi-cogs

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log from a container runtime (Singularity/Apptainer) indicating a failure to build the image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-2208663780/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-run-kegg-kofams

### Tool Description
Run KofamScan on an anvi'o contigs database. Note: The provided help text appears to be a container execution error (no space left on device) and does not contain usage information or argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-3649362210/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-profile

### Tool Description
The provided text does not contain help information for the tool. It appears to be an error log from a container runtime (Singularity/Apptainer) indicating a failure to build the image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-3098721344/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-merge

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log indicating a failure to build or extract a container image due to lack of disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-2014966734/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-gen-genomes-storage

### Tool Description
Generate an anvi'o genomes storage file.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-3827429758/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-pan-genome

### Tool Description
The provided text does not contain help documentation. It is an error log indicating a failure to build or extract the container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-2956151540/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-interactive

### Tool Description
The provided text does not contain help information for the tool. It contains system log messages indicating a failure to build a container image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-3657622856/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-db-info

### Tool Description
The provided text does not contain help information for the tool. It contains error logs related to a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-1025652340/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-refine

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-2619130894/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

## anvio-minimal_anvi-summarize

### Tool Description
The provided text does not contain help information for the tool. It contains error logs related to a container runtime (Apptainer/Singularity) failure due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
- **Homepage**: http://merenlab.org/software/anvio/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/anvio-minimal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:53882c191fa6790c0131c6e3b1598df44efa6e873bcda8a4895baec6a0076f9d: unpack entry: usr/local/lib/libLLVM.so.20.1: unpack to regular file: short write: write /tmp/build-temp-3003828032/rootfs/usr/local/lib/libLLVM.so.20.1: no space left on device
```

