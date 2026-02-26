# zarp CWL Generation Report

## zarp

### Tool Description
Command-line argument parser class.

### Metadata
- **Docker Image**: quay.io/biocontainers/zarp:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/zavolanlab/zarp-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/zarp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zarp/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zavolanlab/zarp-cli
- **Stars**: N/A
### Original Help Text
```text
usage: zarp [--config-file PATH]
            [--verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--init] [-h]
            [--version] [--adapter-3p STR] [--adapter-5p STR]
            [--adapter-poly-3p STR] [--adapter-poly-5p STR]
            [--annotations PATH] [--fragment-length-distribution-mean FLOAT]
            [--fragment-length-distribution-sd FLOAT] [--read-orientation STR]
            [--reference-seqs PATH] [--source INT|STR] [--trim-polya]
            [--star-sjdb-overhang INT] [--salmon-kmer-size INT] [--cores INT]
            [--dependency-embedding {CONDA,SINGULARITY}] [--description STR]
            [--execution-mode {DRY_RUN,PREPARE_RUN,RUN}]
            [--genome-assemblies-map PATH] [--identifier STR] [--profile PATH]
            [--resources-version INT] [--rule-config PATH]
            [--working-directory PATH] [--zarp-directory PATH] [--author STR]
            [--email STR] [--logo STR] [--url STR]
            [REF ...]

Command-line argument parser class.

general parameters:
  REF                   references to individual sequencing libraries by local
                        file path or read archive identifiers OR paths to ZARP
                        sample tables; seedocumentation for details (default:
                        None)
  --config-file PATH    override user-specific default configuration file
                        (default: /root/.zarp/user.yaml)
  --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        logging verbosity level (default: INFO)

run modes:
  When specifying any of the options in this group, ZARP-cli will ignore all
  other parameters and will not start a ZARP run.

  --init                add or edit user-specific default configuration and
                        exit (default: False)
  -h, --help            show this help message and exit
  --version             show version information and exit

sample-related options:
  Specify the arguments for any sample-related parameters. If provided via
  the command line, the same values will applied to all samples. When
  analyzing multiple samples, and samples either originate different sources
  and/or shall be processed with different genome resources, these values
  should be specified in a sample table instead. Alternatively, you can make
  use of the inference functionality to infer the sample source and use or
  retrieve the corresponding genome resources as per your ZARP-cli
  configuration. In that case, do not specify any arguments to the
  parameters in this section and/or leave the corresponding sample table
  fields empty.

  --adapter-3p STR      adapter sequence to be truncated from the 3'-ends of
                        reads; for paired-end libraries, two sequences can be
                        specified, separated by a comma; these are used to
                        truncate the the 3'-ends of first and second mates,
                        respectively (default: None)
  --adapter-5p STR      adapter sequence to be truncated from the 5'-ends of
                        reads; for paired-end libraries, two sequences can be
                        specified, separated by a comma; these are used to
                        truncate the the 5'-ends of first and second mates,
                        respectively (default: None)
  --adapter-poly-3p STR
                        polynucleotide sequence to be truncated from the
                        3'-ends of reads, e.g. a stretch of A's; for paired-
                        end libraries, two sequences can be specified,
                        separated by a comma; these are used to truncate the
                        the 3'-ends of first and second mates, respectively
                        (default: None)
  --adapter-poly-5p STR
                        polynucleotide sequence to be truncated from the
                        3'-ends of reads, e.g. a stretch of A's; for paired-
                        end libraries, two sequences can be specified,
                        separated by a comma; these are used to truncate the
                        the 5'-ends of first and second mates, respectively
                        (default: None)
  --annotations PATH    path to file annotating genes of the sample source; in
                        GTF format (default: None)
  --fragment-length-distribution-mean FLOAT
                        mean of fragment length distribution (default: None)
  --fragment-length-distribution-sd FLOAT
                        standard deviation of fragment length distribution
                        (default: None)
  --read-orientation STR
                        orientation of reads in sequencing library; one of
                        'stranded_forward', 'stranded_reverse', 'unstranded',
                        'inward_stranded_forward', 'inward_stranded_reverse',
                        'inward_unstranded'; cf. https://salmon.readthedocs.io
                        /en/latest/library_type.html (default: None)
  --reference-seqs PATH
                        path to file containing reference sequences of the
                        sample source; in FASTA format (default: None)
  --source INT|STR      origin of the sample as either a NCBI taxonomy
                        database identifier, e.g, 9606 for humans, or the
                        corresponding full name, e.g., 'Homo sapiens'.
                        (default: None)
  --trim-polya          remove poly-A tails from reads (default: None)
  --star-sjdb-overhang INT
                        overhang length for splice junctions in STAR
                        (parameter `sjdbOverhang`); ideally the maximum read
                        length minus 1. Lower values may result in decreased
                        mapping accuracy, while higher values may result in
                        longer processing times. Cf. https://github.com/alexdo
                        bin/STAR/blob/3ae0966bc604a944b1993f49aaeb597e809eb5c9
                        /doc/STARmanual.pdf (default: None)
  --salmon-kmer-size INT
                        size of k-mers for building the Salmon index; the
                        default value typically works fine for reads of 75 bp
                        or longer; consider using lower values if dealing with
                        shorter reads; Cf. https://salmon.readthedocs.io/en/la
                        test/salmon.html#preparing-transcriptome-indices-
                        mapping-based-mode (default: None)

run-specific parameters:
  Options in this group influence how the ZARP workflow is executed. When
  specified on the command line, they will override the defaults set during
  initialization. If you find yourself specifying any of these options
  repeatedly, consider updating defaults by running `zarp --init`.

  --cores INT           maximum number of cores that Snakemake is allowed to
                        use; note that this is different from the number of
                        cores that may be used for each individual workflow
                        step/rule (default: None)
  --dependency-embedding {CONDA,SINGULARITY}
                        strategy for embedding dependencies for the execution
                        of individual workflow steps/rules (default: None)
  --description STR     brief description of the workflow run (default: None)
  --execution-mode {DRY_RUN,PREPARE_RUN,RUN}
                        whether to trigger a full ZARP-cli run, a dry run
                        (external tools are not run, for testing),or prepare a
                        ZARP run (input data creation only) (default: None)
  --genome-assemblies-map PATH
                        Path to genome assemblies mapping file (default: None)
  --identifier STR      run identifier; if not provided a random string will
                        be generated (default: None)
  --profile PATH        Snakemake profile for ZARP workflow; refer to ZARP
                        documentation for details (default: None)
  --resources-version INT
                        version of Ensembl genome resources to use when
                        resources are not explicitly provided; uses latest
                        version by default (default: None)
  --rule-config PATH    ZARP rule configuration; refer to ZARP documentation
                        for details (default: None)
  --working-directory PATH
                        directory in which the ZARP run is executed (default:
                        None)
  --zarp-directory PATH
                        root directory of the ZARP repository (default: None)

user-specific parameters:
  Options in this group will be used by ZARP to generate reports. When
  specified on the command line, they will override the defaults set during
  initialization. If you find yourself specifying any of these options
  repeatedly, consider updating defaults by running `zarp --init`.

  --author STR          your name (default: None)
  --email STR           your email address (default: None)
  --logo STR            path or URL pointing to your organization's logo
                        (default: None)
  --url STR             a relevant URL pointing to, e.g., your personal or
                        organization's websites (default: None)

zarp v1.0.0-rc.1, (c) 2021 by Zavolab (zavolab-biozentrum@unibas.ch)
```

