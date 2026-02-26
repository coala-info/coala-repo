# nextalign CWL Generation Report

## nextalign_completions

### Tool Description
Align sequences to a reference or gene map.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
- **Homepage**: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
- **Package**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Total Downloads**: 145.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nextstrain/nextclade
- **Stars**: N/A
### Original Help Text
```text
_nextalign() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            "$1")
                cmd="nextalign"
                ;;
            completions)
                cmd+="__completions"
                ;;
            help)
                cmd+="__help"
                ;;
            run)
                cmd+="__run"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        nextalign)
            opts="-h -V -v -q --help --version --verbosity --silent --verbose --quiet completions run help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --verbosity)
                    COMPREPLY=($(compgen -W "off error warn info debug trace" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        nextalign__completions)
            opts="-h -v -q --help --verbosity --silent --verbose --quiet bash elvish fish fig powershell zsh"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --verbosity)
                    COMPREPLY=($(compgen -W "off error warn info debug trace" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        nextalign__help)
            opts="-v -q --verbosity --silent --verbose --quiet <SUBCOMMAND>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --verbosity)
                    COMPREPLY=($(compgen -W "off error warn info debug trace" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        nextalign__run)
            opts="-i -r -m -g -O -n -s -o -P -I -e -j -h -v -q --sequences --input-fasta --reference --input-ref --input-gene-map --genes --output-dir --output-all --output-basename --output-selection --output-fasta --output-translations --output-insertions --output-errors --include-reference --in-order --replace-unknown --min-length --penalty-gap-extend --penalty-gap-open --penalty-gap-open-in-frame --penalty-gap-open-out-of-frame --penalty-mismatch --score-match --max-indel --seed-length --mismatches-allowed --min-seeds --min-match-rate --seed-spacing --retry-reverse-complement --no-translate-past-stop --excess-bandwidth --terminal-bandwidth --gap-alignment-side --jobs --help --verbosity --silent --verbose --quiet <INPUT_FASTAS>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --input-fasta)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --sequences)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --input-ref)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reference)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -r)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --input-gene-map)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -m)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --genes)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -g)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-all)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -O)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-basename)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -n)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-selection)
                    COMPREPLY=($(compgen -W "all fasta translations insertions errors" -- "${cur}"))
                    return 0
                    ;;
                -s)
                    COMPREPLY=($(compgen -W "all fasta translations insertions errors" -- "${cur}"))
                    return 0
                    ;;
                --output-fasta)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -o)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-translations)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-insertions)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -I)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-errors)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -e)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --min-length)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --penalty-gap-extend)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --penalty-gap-open)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --penalty-gap-open-in-frame)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --penalty-gap-open-out-of-frame)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --penalty-mismatch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --score-match)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-indel)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed-length)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --mismatches-allowed)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --min-seeds)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --min-match-rate)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --seed-spacing)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --retry-reverse-complement)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-translate-past-stop)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --excess-bandwidth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --terminal-bandwidth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --gap-alignment-side)
                    COMPREPLY=($(compgen -W "left right" -- "${cur}"))
                    return 0
                    ;;
                --jobs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -j)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --verbosity)
                    COMPREPLY=($(compgen -W "off error warn info debug trace" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

complete -F _nextalign -o bashdefault -o default nextalign
```


## nextalign_Generate

### Tool Description
Nextalign is a tool for aligning sequences to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
- **Homepage**: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
- **Package**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'Generate' which wasn't expected, or isn't valid in this context

USAGE:
    nextalign [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## nextalign_run

### Tool Description
Run alignment and translation.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
- **Homepage**: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
- **Package**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Validation**: PASS

### Original Help Text
```text
nextalign-run 
Run alignment and translation.

For short help type: `nextclade -h`, for extended help type: `nextclade --help`. Each subcommand has
its own help, for example: `nextclade run --help`.

USAGE:
    nextalign run [OPTIONS] --input-ref <INPUT_REF> [--] [INPUT_FASTAS]...

OPTIONS:
    -h, --help
            Print help information

  Inputs:
    -r, --input-ref <INPUT_REF>
            Path to a FASTA file containing reference sequence. This file should contain exactly 1
            sequence.
            
            Supports the following compression formats: "gz", "bz2", "xz", "zstd". Use "-" to read
            uncompressed data from standard input (stdin).
            
            [aliases: reference]

    <INPUT_FASTAS>...
            Path to one or multiple FASTA files with input sequences
            
            Supports the following compression formats: "gz", "bz2", "xz", "zstd". If no files
            provided, the plain fasta input is read from standard input (stdin).
            
            See: https://en.wikipedia.org/wiki/FASTA_format

    -m, --input-gene-map <INPUT_GENE_MAP>
            Path to a .gff file containing the gene map (genome annotation).
            
            Gene map (sometimes also called 'genome annotation') is used to find coding regions. If
            not supplied, coding regions will not be translated, amino acid sequences will not be
            output, and nucleotide sequence alignment will not be informed by codon boundaries
            
            List of genes can be restricted using `--genes` flag. Otherwise all genes found in the
            gene map will be used.
            
            Learn more about Generic Feature Format Version 3 (GFF3):
            https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
            
            Supports the following compression formats: "gz", "bz2", "xz", "zstd". Use "-" to read
            uncompressed data from standard input (stdin).

    -g, --genes <GENES>...
            Comma-separated list of names of genes to use.
            
            This defines which peptides will be written into outputs, and which genes will be taken
            into account during codon-aware alignment. Must only contain gene names present in the
            gene map. If this flag is not supplied or its value is an empty string, then all genes
            found in the gene map will be used.
            
            Requires `--input-gene-map` to be specified.

  Outputs:
    -O, --output-all <OUTPUT_ALL>
            Produce all of the output files into this directory, using default basename and
            predefined suffixes and extensions. This is equivalent to specifying each of the
            individual `--output-*` flags. Convenient when you want to receive all or most of output
            files into the same directory and don't care about their filenames.
            
            Output files can be optionally included or excluded using `--output-selection` flag. The
            base filename can be set using `--output-basename` flag.
            
            If both the `--output-all` and individual `--output-*` flags are provided, each
            individual flag overrides the corresponding default output path.
            
            At least one of the output flags is required: `--output-all`, `--output-fasta`,
            `--output-translations`, `--output-insertions`, `--output-errors`
            
            If the required directory tree does not exist, it will be created.

    -n, --output-basename <OUTPUT_BASENAME>
            Set the base filename to use for output files.
            
            By default the base filename is extracted from the input sequences file (provided with
            `--input-fasta`).
            
            Only valid together with `--output-all` flag.

    -s, --output-selection <OUTPUT_SELECTION>...
            Restricts outputs for `--output-all` flag.
            
            Should contain a comma-separated list of names of output files to produce.
            
            If 'all' is present in the list, then all other entries are ignored and all outputs are
            produced.
            
            Only valid together with `--output-all` flag.
            
            [possible values: all, fasta, translations, insertions, errors]

    -o, --output-fasta <OUTPUT_FASTA>
            Path to output FASTA file with aligned sequences.
            
            Takes precedence over paths configured with `--output-all`, `--output-basename` and
            `--output-selection`.
            
            If the provided file path ends with one of the supported extensions: "gz", "bz2", "xz",
            "zstd", then the file will be written compressed. Use "-" to write the uncompressed to
            standard output (stdout).
            
            If the required directory tree does not exist, it will be created.

    -P, --output-translations <OUTPUT_TRANSLATIONS>
            Template string for path to output fasta files containing translated and aligned
            peptides. A separate file will be generated for every gene. The string should contain
            template variable `{gene}`, where the gene name will be substituted. Make sure you
            properly quote and/or escape the curly braces, so that your shell, programming language
            or pipeline manager does not attempt to substitute the variables.
            
            Takes precedence over paths configured with `--output-all`, `--output-basename` and
            `--output-selection`.
            
            If the provided file path ends with one of the supported extensions: "gz", "bz2", "xz",
            "zstd", then the file will be written compressed. Use "-" to write the uncompressed to
            standard output (stdout).
            
            If the required directory tree does not exist, it will be created.
            
            Example for bash shell:
            
            --output-translations='output_dir/gene_{gene}.translation.fasta'

    -I, --output-insertions <OUTPUT_INSERTIONS>
            Path to output CSV file that contain insertions stripped from the reference alignment.
            
            Takes precedence over paths configured with `--output-all`, `--output-basename` and
            `--output-selection`.
            
            If the provided file path ends with one of the supported extensions: "gz", "bz2", "xz",
            "zstd", then the file will be written compressed. Use "-" to write the uncompressed to
            standard output (stdout).
            
            If the required directory tree does not exist, it will be created.

    -e, --output-errors <OUTPUT_ERRORS>
            Path to output CSV file containing errors and warnings occurred during processing
            
            Takes precedence over paths configured with `--output-all`, `--output-basename` and
            `--output-selection`.
            
            If the provided file path ends with one of the supported extensions: "gz", "bz2", "xz",
            "zstd", then the file will be written compressed. Use "-" to write the uncompressed to
            standard output (stdout).
            
            If the required directory tree does not exist, it will be created.

        --include-reference
            Whether to include aligned reference nucleotide sequence into output nucleotide sequence
            FASTA file and reference peptides into output peptide FASTA files

        --in-order
            Emit output sequences in-order.
            
            With this flag the program will wait for results from the previous sequences to be
            written to the output files before writing the results of the next sequences, preserving
            the same order as in the input file. Due to variable sequence processing times, this
            might introduce unnecessary waiting times, but ensures that the resulting sequences are
            written in the same order as they occur in the inputs (except for sequences which have
            errors). By default, without this flag, processing might happen out of order, which is
            faster, due to the elimination of waiting, but might also lead to results written out of
            order - the order of results is not specified and depends on thread scheduling and
            processing times of individual sequences.
            
            This option is only relevant when `--jobs` is greater than 1 or is omitted.
            
            Note: the sequences which trigger errors during processing will be omitted from outputs,
            regardless of this flag.

        --replace-unknown
            Replace unknown nucleotide characters with 'N'
            
            By default, the sequences containing unknown nucleotide nucleotide characters are
            skipped with a warning - they are not aligned and not included into results. If this
            flag is provided, then before the alignment, all unknown characters are replaced with
            'N'. This replacement allows to align these sequences.
            
            The following characters are considered known:  '-', 'A', 'B', 'C', 'D', 'G', 'H', 'K',
            'M', 'N', 'R', 'S', 'T', 'V', 'W', 'Y'

  Alignment parameters:
        --min-length <MIN_LENGTH>
            Minimum length of nucleotide sequence to consider for alignment.
            
            If a sequence is shorter than that, alignment will not be attempted and a warning will
            be emitted. When adjusting this parameter, note that alignment of short sequences can be
            unreliable.

        --penalty-gap-extend <PENALTY_GAP_EXTEND>
            Penalty for extending a gap in alignment. If zero, all gaps regardless of length incur
            the same penalty

        --penalty-gap-open <PENALTY_GAP_OPEN>
            Penalty for opening of a gap in alignment. A higher penalty results in fewer gaps and
            more mismatches. Should be less than `--penalty-gap-open-in-frame` to avoid gaps in
            genes

        --penalty-gap-open-in-frame <PENALTY_GAP_OPEN_IN_FRAME>
            As `--penalty-gap-open`, but for opening gaps at the beginning of a codon. Should be
            greater than `--penalty-gap-open` and less than `--penalty-gap-open-out-of-frame`, to
            avoid gaps in genes, but favor gaps that align with codons

        --penalty-gap-open-out-of-frame <PENALTY_GAP_OPEN_OUT_OF_FRAME>
            As `--penalty-gap-open`, but for opening gaps in the body of a codon. Should be greater
            than `--penalty-gap-open-in-frame` to favor gaps that align with codons

        --penalty-mismatch <PENALTY_MISMATCH>
            Penalty for aligned nucleotides or amino acids that differ in state during alignment.
            Note that this is redundantly parameterized with `--score-match`

        --score-match <SCORE_MATCH>
            Score for matching states in nucleotide or amino acid alignments

        --max-indel <MAX_INDEL>
            Maximum length of insertions or deletions allowed to proceed with alignment. Alignments
            with long indels are slow to compute and require substantial memory in the current
            implementation. Alignment of sequences with indels longer that this value, will not be
            attempted and a warning will be emitted

        --seed-length <SEED_LENGTH>
            k-mer length to determine approximate alignments between query and reference and
            determine the bandwidth of the banded alignment

        --mismatches-allowed <MISMATCHES_ALLOWED>
            Maximum number of mismatching nucleotides allowed for a seed to be considered a match

        --min-seeds <MIN_SEEDS>
            Minimum number of seeds to search for during nucleotide alignment. Relevant for short
            sequences. In long sequences, the number of seeds is determined by `--seed-spacing`

        --min-match-rate <MIN_MATCH_RATE>
            Minimum seed mathing rate (a ratio of seed matches to total number of attempted seeds)

        --seed-spacing <SEED_SPACING>
            Spacing between seeds during nucleotide alignment

        --retry-reverse-complement <RETRY_REVERSE_COMPLEMENT>
            Retry seed matching step with a reverse complement if the first attempt failed

        --no-translate-past-stop <NO_TRANSLATE_PAST_STOP>
            If this flag is present, the amino acid sequences will be truncated at the first stop
            codon, if mutations or sequencing errors cause premature stop codons to be present. No
            amino acid mutations in the truncated region will be recorded

        --excess-bandwidth <EXCESS_BANDWIDTH>
            Excess bandwidth for internal stripes

        --terminal-bandwidth <TERMINAL_BANDWIDTH>
            Excess bandwidth for terminal stripes

        --gap-alignment-side <GAP_ALIGNMENT_SIDE>
            Whether to align gaps on the left or right side if equally parsimonious. Left aligning
            gaps is the convention, right align is Nextclade's historic default
            
            [possible values: left, right]

  Other:
    -j, --jobs <JOBS>
            Number of processing jobs. If not specified, all available CPU threads will be used
            
            [default: 20]

  Verbosity:
        --verbosity <VERBOSITY>
            Set verbosity level of console output [default: warn]
            
            [possible values: off, error, warn, info, debug, trace]

        --silent
            Disable all console output. Same as `--verbosity=off`

    -v, --verbose
            Make console output more verbose. Add multiple occurrences to increase verbosity further

    -q, --quiet
            Make console output more quiet. Add multiple occurrences to make output even more quiet
```


## nextalign_Run

### Tool Description
nextalign is a command-line tool for aligning sequences to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
- **Homepage**: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
- **Package**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'Run' which wasn't expected, or isn't valid in this context

USAGE:
    nextalign [OPTIONS] <SUBCOMMAND>

For more information try --help
```


## nextalign_Print

### Tool Description
nextalign is a tool for aligning Nextclade outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
- **Homepage**: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
- **Package**: https://anaconda.org/channels/bioconda/packages/nextalign/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'Print' which wasn't expected, or isn't valid in this context

USAGE:
    nextalign [OPTIONS] <SUBCOMMAND>

For more information try --help
```

