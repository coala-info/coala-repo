# viroconstrictor CWL Generation Report

## viroconstrictor

### Tool Description
a pipeline for analysing Viral targeted
(amplicon) sequencing data in order to generate a biologically valid consensus
sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/viroconstrictor:1.6.4--pyhdfd78af_0
- **Homepage**: https://rivm-bioinformatics.github.io/ViroConstrictor/
- **Package**: https://anaconda.org/channels/bioconda/packages/viroconstrictor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viroconstrictor/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/RIVM-bioinformatics/ViroConstrictor
- **Stars**: N/A
### Original Help Text
```text
usage: ViroConstrictor [required arguments] [optional arguments]

ViroConstrictor: a pipeline for analysing Viral targeted
(amplicon) sequencing data in order to generate a biologically valid consensus
sequence.

Required arguments:
  --input, -i DIR                       The input directory with raw
                                        fastq(.gz) files
  --output, -o DIR                      Output directory
                                          (default: /)
  --platform ['nanopore'/'illumina'/'iontorrent']
                                        Define the sequencing platform that
                                        was used to generate the dataset,
                                        either being 'nanopore', 'illumina' or
                                        'iontorrent', see the docs for more
                                        info
                                          (default:
                                          nanopore)
  --amplicon-type, -at ['end-to-end'/'end-to-mid'/'fragmented']
                                        Define the amplicon-type, either being
                                        'end-to-end', 'end-to-mid', or
                                        'fragmented'. See the docs for more
                                        info
                                          (default: end-to-
                                          end)

Optional arguments:
  --samplesheet, -samples File          Sample sheet information file
  --reference, -ref File                Input Reference sequence genome in
                                        FASTA format
  --primers, -pr File                   Used primer sequences in FASTA or BED
                                        format. If no primers should be
                                        removed, supply the value NONE to this
                                        flag.
  --target, --preset Str                Define the specific target for the
                                        pipeline, if the target matches a
                                        certain preset then pre-defined
                                        analysis settings will be used, see
                                        the docs for more info
  --match-ref, -mr                      Match your data to the best reference
                                        available in the given reference fasta
                                        file.
                                          (default:
                                          False)
  --segmented, -seg                     Use this flag in combination with
                                        match-ref to indicate that the match-
                                        ref process should take segmented
                                        reference information into account.
                                        Please note that specific formatting
                                        is required for the reference fasta
                                        file, see the docs for more info.
                                          (default:
                                          False)
  --min-coverage, -mc N                 Minimum coverage for the consensus
                                        sequence.
                                          (default: 30)
  --features, -gff File                 GFF file containing the Open Reading
                                        Frame (ORF) information of the
                                        reference. Supplying NONE will let
                                        ViroConstrictor use prodigal to
                                        determine coding regions
  --primer-mismatch-rate, -pmr N        Maximum number of mismatches allowed
                                        in the primer sequences during primer
                                        coordinate search. Use 0 for exact
                                        primer matches Default is 3.
  --unidirectional, -uni                Use this flag to indicate that the
                                        (illumina) sequencing data is
                                        unidirectional (i.e. only R1 reads are
                                        available). This will cause the
                                        pipeline to not consider R2 reads for
                                        the analysis. Can only be combined
                                        with the illumina platform.
                                          (default:
                                          False)
  --disable-presets, -dp                Disable the use of presets, this will
                                        cause all analysis settings to be set
                                        to default values
  --fragment-lookaround-size, -fls N    Size of the fragment lookaround region
                                        (in bp) for the AmpliGone tool.
  --threads, -t N                       Number of local threads that are
                                        available to use. Default is the
                                        number of available threads in your
                                        system (20)
  --scheduler, -s Str                   The scheduler to use for the workflow,
                                        either 'auto', 'none', or any in the
                                        following list: ['LOCAL', 'SLURM',
                                        'LSF', 'DRYRUN', 'AUTO']. Default is
                                        'auto', which will try to determine
                                        the scheduler automatically.
  --version, -v                         Show the ViroConstrictor version and
                                        exit
  --help, -h                            Show this help message and exit
  --dryrun                              Run the workflow without actually
                                        doing anything
                                          (default:
                                          False)
  --skip-updates                        Skip the update check
                                          (default:
                                          False)
  --verbose, --debug                    Adds extra information to the log file
                                          (default:
                                          False)
```


## Metadata
- **Skill**: generated
