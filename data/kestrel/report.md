# kestrel CWL Generation Report

## kestrel

### Tool Description
Kestrel is a variant caller for DNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/kestrel:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/paudano/kestrel
- **Package**: https://anaconda.org/channels/bioconda/packages/kestrel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kestrel/overview
- **Total Downloads**: 225
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/paudano/kestrel
- **Stars**: N/A
### Original Help Text
```text
kestrel -f <INPUT_FORMAT> -i <INTERVAL_FILE> -k <KSIZE> -m <OUT_FORMAT>
    -o <OUT_FILE> -p <OUT_FILE> -r <REF_SEQUENCE> -s[<SAMPLE_NAME>]
    -w <WEIGHT_VEC> --alpha=<ALPHA> --ambiregions --ambivar --anchorboth
    --autoflank --byreference --byregion --charset=<CHARSET> --countrev
    --decaymin=<MIN_PROPORTION> --diffq=<QUANTILE> --filespersample=<N_FILES>
    --flank=<LENGTH> --free --hapfmt=<OUT_FORMAT> --lib=<LIB_FILE>
    --liburl=<LIB_URL> --logfile=<LOG_FILE> --loglevel=<LOG_LEVEL> --logstderr
    --logstdout --maxalignstates=<STATES> --maxhapstates=<STATES>
    --maxrepeat=<COUNT> --memcount --mincount=<MIN_COUNT> --mindiff=<COUNT_DIFF>
    --minmask=<MIN_MASK> --minsize=<MIN_SIZE> --noambigregions --noambivar
    --noanchorboth --nocountrev --nofree --nomemcount --norevregion --normikc
    --normrefdesc --noseqfilter --peakscan=<LENGTH> --quality=<SEQ_FILTER>
    --revregion --rmikc --rmrefdesc --scanlimitfactor=<FACTOR>
    --seqfilter=<SEQ_FILTER> --stdout --temploc=<TEMP> --varfilter=<FILTER_SPEC>
    SEQ_FILE [SEQ_FILE...]
kestrel -h[<TOPIC>]

-f --format <INPUT_FORMAT> (Default = auto)
    Set the input sequence format type. This option determines how the format
    files are read. This option may be set multiple times when reading files
    with different formats. See "count -hreader" for a full list of readers.

-h --help [<TOPIC>]
    Get command-line help. If "TOPIC" is specified, then help on a specific
    topic is shown. Try "--help=topics" (or "-htopics") for a list of topics

-i --interval <INTERVAL_FILE>
    Reads a file of intervals defining the regions over the reference sequences
    where variants should be detected. If no intervals are specified, variants
    are detected over the full length of each reference sequence. The file type
    is determined by the file name, such as "intervals.bed". BED files are
    supported by Kestrel, and others may be added.

-k --ksize <KSIZE> (Default = 31)
    Size of k-mers sequence data is translated to during analysis. If unsure,
    use the default value. If the sequencing error rate is very high, or if the
    reference is very short, a small (e.g. a single short gene), then a smaller
    k-mer size, such as 21, may be useful if the defalt value does not produce
    meaningful results.

-m --outfmt <OUT_FORMAT> (Default = vcf)
    Set output format.

-o --out <OUT_FILE>
    Set output file name.

-p --hapout <OUT_FILE>
    Set haplotype output file name.

-r --ref <REF_SEQUENCE>
    Add reference sequences variants will be called against. This can be any
    file that Kestrel can read. The format and character-set options apply to
    reference sequences, but not filters.

-s --sample [<SAMPLE_NAME>]
    Set the name of the sample that the next sample files are assigned to. If
    the argument (SAMPLE_NAME) is given, the name of the sample is set to this
    name. If the argument is not given, then the sample name is assigned from
    the name of the first file after this option. Any files on the command-line
    appearing before this option are assigned to a sample and will not be part
    of this sample. If --filespersample was used on the command-line before this
    option, it is reset and files are no longer automatically grouped.

-w --weight <WEIGHT_VEC> (Default = (10.0, -10.0, -40.0, -4.0, 0.0))
    Set the alignment weights as a comma-separated list of values. The order of
    weights is match, mismatch, gap-open, gap-extend, and initial score. If
    values are blank or the list has fewer than 5 elements, the missing values
    are assigned their default weight. Each value is a floating-point number,
    and it may be represented in exponential form (e.g. 1.0e2) or as an integer
    in hexadecimal or octal format. Optionally, the list may be surrounded by
    parenthesis or braces (angle, square, or curly).

--alpha <ALPHA> (Default = 0.80)
    Set the exponential decay alpha, which controls how quickly the recovery
    threshold declines to its minimum value (see --decaymin) in an active region
    search. Alpha is defined as the rate of decay for every k bases. At k bases
    from the left anchor, the threshold will have declined to alpha * range. At
    every k bases, the threshold will continue to decline at this rate.

--ambiregions (Default)
    Allow active regions to cover ambiguous bases, such as N.

--ambivar (Default)
    Allow variants over ambiguous bases, such as N.

--anchorboth (Default)
    Both ends of an active region (region with variants) must be bordered by
    unaltered k-mers or variants will not be called in it. This option may miss
    variants near the ends of a reference sequence, but it forces stronger
    evidence for the variants that are called.

--autoflank (Default)
    When extracting intervals from reference sequences, some bases are extracted
    on both sides of the interval whenever possible. This gives Kestrel more
    bases for active region detection, but it does not otherwise affect variant
    calls. This option tells Kestrel to pick the flank by multiplying 3.50 with
    the k-mer size.

--byreference (Default)
    If variant call regions were defined, variant call locations are still
    relative to the reference sequence and not the region.

--byregion
    If variant call regions were defined, variant call locations are relative to
    the region and not the reference sequence.

--charset <CHARSET> (Default = UTF-8)
    Character set encoding of input files. This option specifies the character
    set of all files following it. The default, "UTF-8", properly handles ASCII
    files, which is a safe assumption for most files. Latin-1 files with values
    greater than 127 will not be properly parsed.

--countrev (Default)
    Count reverse complement k-mers in region statistics. This should be set for
    most sequencing protocols.

--decaymin <MIN_PROPORTION> (Default = 0.55)
    Set the minimum value (asymptotic lower bound) of the exponential decay
    function used in active region detection as a proportion of the anchor k-mer
    count. If this value is 0.0, k-mer count recovery threshold may decline to
    1. If this value is 1.0, the decay function is not used and the detector
    falls back to finding a k-mer with a count within the difference threshold
    of the anchor k-mer count.

--diffq <QUANTILE> (Default = 0.9000)
    If set to a value greater than 0.0, then the k-mer count difference between
    two k-mers that triggers a correction attempt is found dynamically. The
    difference in k-mer counts between each pair of neighboring k-mers over an
    uncorrected reference region is found, and this quantile of is computed over
    those differences. For example, a value of 0.85 means that at most 15% (100%
    - 85%) of the k-mer count differences will be high enough. If this computed
    value is less than the minimum k-mer count difference (--mindiff), then that
    minimum is the difference threshold. This value may not be 1.0 or greater,
    and it may not be negative. If 0.0, the minimum count difference is always
    the minimum threshold (--mindiff).

--filespersample <N_FILES> (Default = 0)
    Set the number of input files per sample. For example, reading paired-end
    FASTQ files (2 files per sample) can be simplified by setting this value to
    2. Alternatively, samples can be separated by multiple -s (--sample)
    arguments. The default value, 0, will not automatically group input files.
    If -s (--sample) is read on the command-line, this value is set back to 0.
    Any sequence files found on the command-line before this option are assigned
    to a group.

--flank <LENGTH> (Default = k * 3.50)
    When extracting intervals from reference sequences, this many bases are
    extracted on both sides of the interval whenever possible. This gives
    Kestrel more bases for active region detection, but it does not otherwise
    affect variant calls. Set to 0 to disable flanks. If this option is not set,
    Kestrel will determine the appropriate length of flank by multiplying 3.50
    with the k-mer size.

--free
    Free resources between processing samples. This may reduce the memory
    footprint of Kestrel, but it may force expensive resources to be recreated
    and impact performance.

--hapfmt <OUT_FORMAT> (Default = sam)
    Set haplotype output format. Ignored if a haplotype output file is not set.

--lib <LIB_FILE>
    Load a library file. Kestrel can accept external components, and they must
    be packaged on a JAR file.

--liburl <LIB_URL>
    Load a library by its URL. Kestrel can accept external components, and they
    must be packaged on a JAR file. This option can access JAR files on the
    local system or stored anywhere the program can access and that can be
    represented as a URL.

--logfile <LOG_FILE> (Default = <STDERR>)
    Set log file name.

--loglevel <LOG_LEVEL> (Default = WARN)
    Set the log level. Valid levels are ALL, TRACE, DEBUG, INFO, WARN, ERROR,
    and OFF.

--logstderr
    Write log messages to standard error instead of a file. Unless redirected,
    this output is written to the the screen.

--logstdout
    Write log messages to standard output instead of a file. Unless redirected,
    this output is written to the the screen.

--maxalignstates <STATES> (Default = 10)
    Set the maximum number of alignment states. When haplotype assembly branches
    into more than one possible sequence, the state of one is saved while
    another is built. When the maximum number of saved states reaches this
    value, the least likely one is discarded.

--maxhapstates <STATES> (Default = 15)
    Set the maximum number of haplotypes for an active region. Alignments can
    generate more than one haplotype, and with noisy sequence data or
    paralogues, many haplotypes may be found. This options limits the amount of
    memory that can be consumed in these cases.

--maxrepeat <COUNT> (Default = 0)
    Cycles in the k-mer graph produce unreliable local assemblies. The default
    value for this option (0) will terminate any local assembly that contains
    the same k-mer more than once. For most applications, 0 is the recommended
    value. To attempt assemblies in reptitive regions, this value can be
    increased, but the results may be variant calls on haplotypes that do not
    exist in the sequence data.

--memcount
    K-mer counts from each sample will be stored in memory. This option assumes
    that samples are relatively small or the machine has enough memory to handle
    the counts. Note that the JVM might need to be run with additional memory
    (-Xmx option) to support this option.

--mincount <MIN_COUNT> (Default = 5)
    Set the minimum k-mer count for processing samples. K-mers with a count less
    than this value will be discarded. Sequence read errors produce many
    erroneous k-mers, and this slows the process of variant calling
    significantly.

--mindiff <COUNT_DIFF> (Default = 5)
    Set the minimum k-mer count difference for identifying active regions. When
    the count between neighboring k-mer counts is this or greater, Kestrel will
    treat it as a region where a variant may occur.

--minmask <MIN_MASK> (Default = 0)
    Size of k-mer minimizers or 0 to disable processing by minimizers. The
    minimizer of a k-mer is determined by taking all sub-k-mers of a given size
    (set by this option) from a k-mer and its reverse complement and choosing
    the lesser of the sub-k-mers. Sub-k-mers are XORed with this mask while
    comparing them, but the minimizer is not XORed (it is still a sub-k-mer of
    the original k-mer). This option can be used to break up large minimizer
    groups due to low-complexity k-mers when minimizers are used.

--minsize <MIN_SIZE> (Default = 15)
    Minimizers group k-mers in the indexed k-mer count (IKC) file generated by
    Kestrel when reading sequences, and this parameter controls the size of the
    minimizer.

--noambigregions
    An active region may not span any base that is not A, C, G, T, or U.

--noambivar
    A variant may not span any base that is not A, C, G, T, or U.

--noanchorboth
    An active region (region with variants) must be bordered on at least one
    side by an unaltered k-mers, but it may extend to the end of the sequence.
    This will allow Kestrel to find variants less than a k-mer from the ends,
    but the evidence supporting these variants is weaker.

--nocountrev
    Do not include the reverse complement of k-mers in read depth estimates. If
    all sequence reads are in the same orientation as the reference, then this
    option should be used.

--nofree (Default)
    Retain resources between samples. This may use more memory, but it will
    avoid re-creating expensive resources between samples.

--nomemcount (Default)
    K-mer counts for each sample are offloaded to an indexed k-mer count file.
    This option reduces the memory demand of Kestrel.

--norevregion
    When set, regions variants are called on are always in the same orientation
    as the reference sequence. The stranded-ness of defined intervals is
    ignored.

--normikc
    Do not remove the indexed k-mer count (IKC) file for each sample.

--normrefdesc
    Use the full sequence name as it appears in the reference sequence file.
    FASTA files often include a description after the sequence name, and with
    this option, it becomes part of the full sequence name. If using an interval
    file, the full sequence name and description must match the sequence file.

--noseqfilter (Default)
    Turn off sequence filtering for all files following this option. If
    --seqfilter or --quality was specified, this option disables sequence
    filtering. These options together make it possible to specify filtering for
    some files and disable filtering for others.

--peakscan <LENGTH> (Default = 7)
    Reference regions with sequence homology in other regions of the genome may
    contain k-mers with artificially high frequencies from adding counts for
    k-mers that appear in both regions. This causes a peak in the k-mer
    frequencies over the reference, and it can trigger an erroneous
    active-region scan for variants. When encountering a difference, Kestrel
    will scan forward this number of k-mers looking for a peak in the k-mer
    frequencies. If the frequencies drop back down to the original range, the
    active-region scan is not performed. This keeps Kestrel from erroneously
    searching large regions of the reference. Setting this value to 0 disables
    peak detection.

--quality <SEQ_FILTER>
    This option is an alias for "seqfilter"

--revregion
    When set, reverse complement reference regions that occur on the negative
    strand. Only itervals defined with on the negative strand are altered.

--rmikc (Default)
    Remove the indexed k-mer count (IKC) for each sample after kestrel runs.

--rmrefdesc (Default)
    When set, remove the description from reference sequence names. The
    descirption is everything that occurs after the first whitespace character.
    FASTA files often have a sequence name and a long description separated by
    whitespace. This option ensures that the sequence name matches in the FASTA
    and an interval file, if used.

--scanlimitfactor <FACTOR> (Default = 7.0)
    Set a limit on how long an active region may be. This is computed by
    multiplying the k-mer size by this factor and adding the maximum length of a
    gap. The computed limit will be adjusted so that active regions are at least
    large enough to capture a SNP in cases where the maximum gap length is 0.
    Setting this to a low value or "min" will set the limit so that it is just
    large enough to catch SNPs and deletions, but it will miss large deletions
    if another variant is within the k-mer size window. Setting this to a high
    value or "max" lifts the restrictions on active region lengths, and this may
    cause the program to take an excessive amount of time and memory trying to
    solve arbitrarily long active regions.

--seqfilter <SEQ_FILTER>
    Filter sequences as they are read and before k-mers are extracted from them.
    Some sequence readers can filter or alter reads at runtime. The most common
    filter is a quality filter where low-quality bases are removed. The filter
    specification is a filter name followed by a colon (:) and arguments to the
    filter. If a filter name is not specified, then the "sanger" quality filter
    is assumed. For example, "sanger:10" and "10" will filter k-mers with any
    base quality score less than 10. The sequence filter specification is set
    for all files appearing on the command-line after this option. To turn off
    filtering once it has been set, files following --noseqfilter will have no
    filter specification.

--stdout (Default)
    Write output to standard output instead of a file. Unless redirected, this
    output is written to the the screen.

--temploc <TEMP> (Default = Output location)
    The location where segments are offloaded. This argument must be a directory
    or the location for a new directory. Parent directories will be created as
    needed.

--varfilter <FILTER_SPEC>
    Add a variant filter specification. The argument should be the name of the
    filter, a colon, and the filter arguments. The correct filter is loaded by
    name and the filter arguments are passed to it.

SEQ_FILE
    Input sequence file.

kestrel version: 1.0.2
```

