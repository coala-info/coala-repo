# adapterremoval CWL Generation Report

## adapterremoval_AdapterRemoval

### Tool Description
Searches for and removes remnant adapter sequences from read data, supporting both single-end and paired-end data.

### Metadata
- **Docker Image**: quay.io/biocontainers/adapterremoval:2.3.4--pl5321haf24da9_2
- **Homepage**: https://github.com/MikkelSchubert/adapterremoval
- **Package**: https://anaconda.org/channels/bioconda/packages/adapterremoval/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/adapterremoval/overview
- **Total Downloads**: 190.2K
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/MikkelSchubert/adapterremoval
- **Stars**: N/A
### Original Help Text
```text
AdapterRemoval ver. 2.3.4

This program searches for and removes remnant adapter sequences from
your read data.  The program can analyze both single end and paired end
data.  For detailed explanation of the parameters, please refer to the
man page.  For comments, suggestions and feedback please use
https://github.com/MikkelSchubert/adapterremoval/issues/new

If you use the program, please cite the paper:
    Schubert, Lindgreen, and Orlando (2016). AdapterRemoval v2: rapid
    adapter trimming, identification, and read merging.
    BMC Research Notes, 12;9(1):88.

    http://bmcresnotes.biomedcentral.com/articles/10.1186/s13104-016-1900-2


OPTIONS:
    --help  
        Display this message.

    --version  
        Print the version string.


    --file1 FILE [FILE ...]
        Input files containing mate 1 reads or single-ended reads; one or
        more files may be listed [REQUIRED].

    --file2 [FILE ...]
        Input files containing mate 2 reads; if used, then the same number of
        files as --file1 must be listed [OPTIONAL].

    --identify-adapters  
        Attempt to identify the adapter pair of PE reads, by searching for
        overlapping mate reads [default: off].

    --threads THREADS
        Maximum number of threads [default: 1]


FASTQ OPTIONS:
    --qualitybase BASE
        Quality base used to encode Phred scores in input; either 33, 64, or
        solexa [default: 33].

    --qualitybase-output BASE
        Quality base used to encode Phred scores in output; either 33, 64, or
        solexa. By default, reads will be written in the same format as the
        that specified using --qualitybase.

    --qualitymax BASE
        Specifies the maximum Phred score expected in input files, and used
        when writing output. ASCII encoded values are limited to the
        characters '!' (ASCII = 33) to '~' (ASCII = 126), meaning that
        possible scores are 0 - 93 with offset 33, and 0 - 62 for offset 64
        and Solexa scores [default: 41].

    --mate-separator CHAR
        Character separating the mate number (1 or 2) from the read name in
        FASTQ records [default: '/'].

    --interleaved  
        This option enables both the --interleaved-input option and the
        --interleaved-output option [default: off].

    --interleaved-input  
        The (single) input file provided contains both the mate 1 and mate 2
        reads, one pair after the other, with one mate 1 reads followed by
        one mate 2 read. This option is implied by the --interleaved option
        [default: off].

    --interleaved-output  
        If set, trimmed paired-end reads are written to a single file
        containing mate 1 and mate 2 reads, one pair after the other. This
        option is implied by the --interleaved option [default: off].

    --combined-output  
        If set, all reads are written to the same file(s), specified by
        --output1 and --output2 (--output1 only if --interleaved-output is
        not set). Discarded reads are replaced with a single 'N' with Phred
        score 0 [default: off].

    --mask-degenerate-bases  
        Mask degenerate/ambiguous bases (B/D/H/K/M/N/R/S/V/W/Y) in input by
        replacing them with an 'N'; if this option is not used,
        AdapterRemoval will abort upon encountering degenerate bases.

    --convert-uracils  
        Convert uracils (U) to thymine (T) in input reads; if this option is
        not used, AdapterRemoval will abort upon encountering uracils.


OUTPUT FILES:
    --basename BASENAME
        Default prefix for all output files for which no filename was
        explicitly set [default: your_output].

    --settings FILE
        Output file containing information on the parameters used in the run
        as well as overall statistics on the reads after trimming [default:
        BASENAME.settings]

    --output1 FILE
        Output file containing trimmed mate1 reads [default:
        BASENAME.pair1.truncated (PE), BASENAME.truncated (SE), or
        BASENAME.paired.truncated (interleaved PE)]

    --output2 FILE
        Output file containing trimmed mate 2 reads [default:
        BASENAME.pair2.truncated (only used in PE mode, but not if
        --interleaved-output is enabled)]

    --singleton FILE
        Output file to which containing paired reads for which the mate has
        been discarded [default: BASENAME.singleton.truncated]

    --outputcollapsed FILE
        If --collapsed is set, contains overlapping mate-pairs which have
        been merged into a single read (PE mode) or reads for which the
        adapter was identified by a minimum overlap, indicating that the
        entire template molecule is present. This does not include which have
        subsequently been trimmed due to low-quality or ambiguous nucleotides
        [default: BASENAME.collapsed]

    --outputcollapsedtruncated FILE
        Collapsed reads (see --outputcollapsed) which were trimmed due the
        presence of low-quality or ambiguous nucleotides [default:
        BASENAME.collapsed.truncated]

    --discarded FILE
        Contains reads discarded due to the --minlength, --maxlength or
        --maxns options [default: BASENAME.discarded]


OUTPUT COMPRESSION:
    --gzip  
        Enable gzip compression [default: off]

    --gzip-level LEVEL
        Compression level, 0 - 9 [default: 6]

    --bzip2  
        Enable bzip2 compression [default: off]

    --bzip2-level LEVEL
        Compression level, 0 - 9 [default: 9]


TRIMMING SETTINGS:
    --adapter1 SEQUENCE
        Adapter sequence expected to be found in mate 1 reads [default:
        AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG].

    --adapter2 SEQUENCE
        Adapter sequence expected to be found in mate 2 reads [default:
        AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT].

    --adapter-list FILENAME
        Read table of white-space separated adapters pairs, used as if the
        first column was supplied to --adapter1, and the second column was
        supplied to --adapter2; only the first adapter in each pair is
        required SE trimming mode [default: <not set>].


    --minadapteroverlap LENGTH
        In single-end mode, reads are only trimmed if the overlap between
        read and the adapter is at least X bases long, not counting ambiguous
        nucleotides (N); this is independent of the --minalignmentlength when
        using --collapse, allowing a conservative selection of putative
        complete inserts while ensuring that all possible adapter
        contamination is trimmed [default: 0].

    --mm MISMATCH_RATE
        Max error-rate when aligning reads and/or adapters. If > 1, the max
        error-rate is set to 1 / MISMATCH_RATE; if < 0, the defaults are
        used, otherwise the user-supplied value is used directly [default:
        1/3 for trimming; 1/10 when identifying adapters].

    --shift N
        Consider alignments where up to N nucleotides are missing from the 5'
        termini [default: 2].


    --trim5p N [N]
        Trim the 5' of reads by a fixed amount after removing adapters, but
        before carrying out quality based trimming. Specify one value to trim
        mate 1 and mate 2 reads the same amount, or two values separated by a
        space to trim each mate different amounts [default: no trimming].

    --trim3p N [N]
        Trim the 3' of reads by a fixed amount. See --trim5p.

    --trimns  
        If set, trim ambiguous bases (N) at 5'/3' termini [default: off]

    --maxns MAX
        Reads containing more ambiguous bases (N) than this number after
        trimming are discarded [default: 1000].

    --trimqualities  
        If set, trim bases at 5'/3' termini with quality scores <= to
        --minquality value [default: off]

    --trimwindows INT
        If set, quality trimming will be carried out using window based
        approach, where windows with an average quality less than
        --minquality will be trimmed. If >= 1, this value will be used as the
        window size. If the value is < 1, the value will be multiplied with
        the read length to determine a window size per read. If the resulting
        window size is 0 or larger than the read length, the read length is
        used as the window size. This option implies --trimqualities
        [default: <not set>].

    --minquality PHRED
        Inclusive minimum; see --trimqualities for details [default: 2]

    --preserve5p  
        If set, bases at the 5p will not be trimmed by --trimns,
        --trimqualities, and --trimwindows. Collapsed reads will not be
        quality trimmed when this option is enabled [default: 5p bases are
        trimmed]


    --minlength LENGTH
        Reads shorter than this length are discarded following trimming
        [default: 15].

    --maxlength LENGTH
        Reads longer than this length are discarded following trimming
        [default: 4294967295].


READ MERGING:
    --collapse  
        When set, paired ended read alignments of --minalignmentlength or
        more bases are combined into a single consensus sequence,
        representing the complete insert, and written to either
        basename.collapsed or basename.collapsed.truncated (if trimmed due to
        low-quality bases following collapse); for single-ended reads,
        putative complete inserts are identified as having at least
        --minalignmentlength bases overlap with the adapter sequence, and are
        written to the the same files [default: off].

    --collapse-deterministic  
        In standard --collapse mode, AdapterRemoval will randomly select one
        of two different overlapping bases if these have the same quality
        (otherwise it picks the highest quality base). With
        --collapse-deterministic, AdapterRemoval will instead set such bases
        to N. Setting this option also sets --collapse [default: off].

    --collapse-conservatively  
        Enables a more conservative merging algorithm inspired by fastq-join,
        in which the higher quality score is picked for matching bases and
        the max score minus the min score is picked for mismatching bases.
        For more details, see the documentation. --seed and
        --collapse-deterministic have no effect when this is enabled. Setting
        this option also sets --collapse [default: off].

    --minalignmentlength LENGTH
        If --collapse is set, paired reads must overlap at least this number
        of bases to be collapsed, and single-ended reads must overlap at
        least this number of bases with the adapter to be considered complete
        template molecules [default: 11].

    --seed SEED
        Sets the RNG seed used when choosing between bases with equal Phred
        scores when --collapse is enabled. This option is not available if
        more than one thread is used. If not specified, aseed is generated
        using the current time.


DEMULTIPLEXING:
    --barcode-list FILENAME
        List of barcodes or barcode pairs for single or double-indexed
        demultiplexing. Note that both indexes should be specified for both
        single-end and paired-end trimming, if double-indexed multiplexing
        was used, in order to ensure that the demultiplexed reads can be
        trimmed correctly [default: <not set>].

    --barcode-mm N
        Maximum number of mismatches allowed when counting mismatches in both
        the mate 1 and the mate 2 barcode for paired reads [default: 0].

    --barcode-mm-r1 N
        Maximum number of mismatches allowed for the mate 1 barcode; if not
        set, this value is equal to the '--barcode-mm' value; cannot be
        higher than the '--barcode-mm value'.

    --barcode-mm-r2 N
        Maximum number of mismatches allowed for the mate 2 barcode; if not
        set, this value is equal to the '--barcode-mm' value; cannot be
        higher than the '--barcode-mm value'.

    --demultiplex-only  
        Only carry out demultiplexing using the list of barcodes supplied
        with --barcode-list. No other processing is done.
```

