# catch CWL Generation Report

## catch_design.py

### Tool Description
Design probes for targeted sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/catch
- **Package**: https://anaconda.org/channels/bioconda/packages/catch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/catch/overview
- **Total Downloads**: 27.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/catch
- **Stars**: N/A
### Original Help Text
```text
usage: design.py [-h] -o OUTPUT_PROBES [--write-taxid-acc WRITE_TAXID_ACC]
                 [-pl PROBE_LENGTH] [-ps PROBE_STRIDE] [-m MISMATCHES]
                 [-l LCF_THRES]
                 [--island-of-exact-match ISLAND_OF_EXACT_MATCH]
                 [--custom-hybridization-fn CUSTOM_HYBRIDIZATION_FN CUSTOM_HYBRIDIZATION_FN]
                 [-c COVERAGE] [-e COVER_EXTENSION] [-i]
                 [--avoid-genomes AVOID_GENOMES [AVOID_GENOMES ...]]
                 [-mt MISMATCHES_TOLERANT] [-lt LCF_THRES_TOLERANT]
                 [--island-of-exact-match-tolerant ISLAND_OF_EXACT_MATCH_TOLERANT]
                 [--custom-hybridization-fn-tolerant CUSTOM_HYBRIDIZATION_FN_TOLERANT CUSTOM_HYBRIDIZATION_FN_TOLERANT]
                 [--print-analysis]
                 [--write-analysis-to-tsv WRITE_ANALYSIS_TO_TSV]
                 [--write-sliding-window-coverage WRITE_SLIDING_WINDOW_COVERAGE]
                 [--write-probe-map-counts-to-tsv WRITE_PROBE_MAP_COUNTS_TO_TSV]
                 [--filter-from-fasta FILTER_FROM_FASTA] [--skip-set-cover]
                 [--add-adapters] [--adapter-a ADAPTER_A ADAPTER_A]
                 [--adapter-b ADAPTER_B ADAPTER_B]
                 [--filter-polya FILTER_POLYA FILTER_POLYA]
                 [--add-reverse-complements] [--expand-n [EXPAND_N]]
                 [--limit-target-genomes LIMIT_TARGET_GENOMES]
                 [--limit-target-genomes-randomly-with-replacement LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACEMENT]
                 [--cluster-and-design-separately CLUSTER_AND_DESIGN_SEPARATELY]
                 [--cluster-and-design-separately-method {choose,simple,hierarchical}]
                 [--cluster-from-fragments CLUSTER_FROM_FRAGMENTS]
                 [--filter-with-lsh-hamming FILTER_WITH_LSH_HAMMING]
                 [--filter-with-lsh-minhash FILTER_WITH_LSH_MINHASH]
                 [--small-seq-skip SMALL_SEQ_SKIP]
                 [--small-seq-min SMALL_SEQ_MIN]
                 [--max-num-processes MAX_NUM_PROCESSES]
                 [--kmer-probe-map-k KMER_PROBE_MAP_K]
                 [--use-native-dict-when-finding-tolerant-coverage]
                 [--ncbi-api-key NCBI_API_KEY] [--debug] [--verbose] [-V]
                 dataset [dataset ...]

positional arguments:
  dataset               One or more target datasets (e.g., one per species).
                        Each dataset can be specified in one of two ways. (1)
                        If dataset is in the format 'download:TAXID', then
                        CATCH downloads from NCBI all whole genomes for the
                        NCBI taxonomy with id TAXID, and uses these sequences
                        as input. (2) If dataset is a path to a FASTA file,
                        then its sequences are read and used as input. For
                        segmented viruses, the format for NCBI downloads can
                        also be 'download:TAXID-SEGMENT'.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_PROBES, --output-probes OUTPUT_PROBES
                        The file to which all final probes should be written;
                        they are written in FASTA format (default: None)
  --write-taxid-acc WRITE_TAXID_ACC
                        If 'download:' labels are used in datasets, write
                        downloaded accessions to a file in this directory.
                        Accessions are written to WRITE_TAXID_ACC/TAXID.txt
                        (default: None)
  -pl PROBE_LENGTH, --probe-length PROBE_LENGTH
                        Make probes be PROBE_LENGTH nt long (default: 100)
  -ps PROBE_STRIDE, --probe-stride PROBE_STRIDE
                        Generate candidate probes from the input that are
                        separated by PROBE_STRIDE nt (default: 50)
  -m MISMATCHES, --mismatches MISMATCHES
                        Allow for MISMATCHES mismatches when determining
                        whether a probe covers a sequence (default: 0)
  -l LCF_THRES, --lcf-thres LCF_THRES
                        (Optional) Say that a portion of a probe covers a
                        portion of a sequence if the two share a substring
                        with at most MISMATCHES mismatches that has length >=
                        LCF_THRES nt; if unspecified, this is set to
                        PROBE_LENGTH (default: None)
  --island-of-exact-match ISLAND_OF_EXACT_MATCH
                        (Optional) When determining whether a probe covers a
                        sequence, require that there be an exact match (i.e.,
                        no mismatches) of length at least
                        ISLAND_OF_EXACT_MATCH nt between a portion of the
                        probe and a portion of the sequence (default: 0)
  --custom-hybridization-fn CUSTOM_HYBRIDIZATION_FN CUSTOM_HYBRIDIZATION_FN
                        (Optional) Args: <PATH> <FUNC>; PATH is a path to a
                        Python module (.py file) and FUNC is a string giving
                        the name of a function in that module. FUNC provides a
                        custom model of hybridization between a probe and
                        target sequence to use in the probe set design. If
                        this is set, the arguments --mismatches, --lcf-thres,
                        and --island-of-exact-match are not used because these
                        are meant for the default model of hybridization. The
                        function FUNC in PATH is dynamically loaded to use
                        when determining whether a probe hybridizes to a
                        target sequence (and, if so, what portion). FUNC must
                        accept the following arguments in order, though it may
                        choose to ignore some values: (1) array giving
                        sequence of a probe; (2) str giving subsequence of
                        target sequence to which the probe may hybridize, of
                        the same length as the given probe sequence; (3) int
                        giving the position in the probe (equivalently, the
                        target subsequence) of the start of a k-mer around
                        which the probe and target subsequence are anchored
                        (the probe and target subsequence are aligned using
                        this k-mer as an anchor); (4) int giving the end
                        position (exclusive) of the anchor k-mer; (5) int
                        giving the full length of the probe (the probe
                        provided in (1) may be cutoff on an end if it extends
                        further than where the target sequence ends); (6) int
                        giving the full length of the target sequence of which
                        the subsequence in (2) is part. FUNC must return None
                        if it deems that the probe does not hybridize to the
                        target subsequence; otherwise, it must return a tuple
                        (start, end) where start is an int giving the start
                        position in the probe (equivalently, in the target
                        subsequence) at which the probe will hybridize to the
                        target subsequence, and end is an int (exclusive)
                        giving the end position of the hybridization.
                        (default: None)
  -c COVERAGE, --coverage COVERAGE
                        If this is a float in [0,1], it gives the fraction of
                        each target genome that must be covered by the
                        selected probes; if this is an int > 1, it gives the
                        number of bp of each target genome that must be
                        covered by the selected probes (default: 1.0)
  -e COVER_EXTENSION, --cover-extension COVER_EXTENSION
                        Extend the coverage of each side of a probe by
                        COVER_EXTENSION nt. That is, a probe covers a region
                        that consists of the portion of a sequence it
                        hybridizes to, as well as this number of nt on each
                        side of that portion. This is useful in modeling
                        hybrid selection, where a probe hybridizes toa
                        fragment that includes the region targeted by the
                        probe, along with surrounding portions of the
                        sequence. Increasing its value should reduce the
                        number of probes required to achieve the desired
                        coverage. (default: 0)
  -i, --identify        Design probes meant to make it possible to identify
                        nucleic acid from a particular input dataset against
                        the other datasets; when set, the coverage should
                        generally be small (default: False)
  --avoid-genomes AVOID_GENOMES [AVOID_GENOMES ...]
                        One or more genomes to avoid; penalize probes based on
                        how much of each of these genomes they cover. The
                        value is a path to a FASTA file. (default: None)
  -mt MISMATCHES_TOLERANT, --mismatches-tolerant MISMATCHES_TOLERANT
                        (Optional) A more tolerant value for 'mismatches';
                        this should be greater than the value of MISMATCHES.
                        Allows for capturing more possible hybridizations
                        (i.e., more sensitivity) when designing probes for
                        identification or when genomes are avoided. (default:
                        None)
  -lt LCF_THRES_TOLERANT, --lcf-thres-tolerant LCF_THRES_TOLERANT
                        (Optional) A more tolerant value for 'lcf_thres'; this
                        should be less than LCF_THRES. Allows for capturing
                        more possible hybridizations (i.e., more sensitivity)
                        when designing probes for identification or when
                        genomes are avoided. (default: None)
  --island-of-exact-match-tolerant ISLAND_OF_EXACT_MATCH_TOLERANT
                        (Optional) A more tolerant value for
                        'island_of_exact_match'; this should be less than
                        ISLAND_OF_ EXACT_MATCH. Allows for capturing more
                        possible hybridizations (i.e., more sensitivity) when
                        designing probes for identification or when genomes
                        are avoided. (default: 0)
  --custom-hybridization-fn-tolerant CUSTOM_HYBRIDIZATION_FN_TOLERANT CUSTOM_HYBRIDIZATION_FN_TOLERANT
                        (Optional) A more tolerant model than the one
                        implemented in custom_hybridization_fn. This should
                        capture more possible hybridizations (i.e., be more
                        sensitive) when designing probes for identification or
                        when genomes are avoided. See --custom-hybridization-
                        fn for details of how this function should be
                        implemented and provided. (default: None)
  --print-analysis      Print analysis of the probe set's coverage (default:
                        False)
  --write-analysis-to-tsv WRITE_ANALYSIS_TO_TSV
                        (Optional) The file to which to write a TSV-formatted
                        matrix of the probe set's coverage analysis (default:
                        None)
  --write-sliding-window-coverage WRITE_SLIDING_WINDOW_COVERAGE
                        (Optional) The file to which to write the average
                        coverage achieved by the probe set within sliding
                        windows of each target genome (default: None)
  --write-probe-map-counts-to-tsv WRITE_PROBE_MAP_COUNTS_TO_TSV
                        (Optional) The file to which to write a TSV-formatted
                        list of the number of sequences each probe maps to.
                        This explicitly does not count reverse complements.
                        (default: None)
  --filter-from-fasta FILTER_FROM_FASTA
                        (Optional) A FASTA file from which to select candidate
                        probes. Before running any other filters, keep only
                        the candidate probes that are equal to sequences in
                        the file and remove all probes not equal to any of
                        these sequences. This, by default, ignores sequences
                        in the file whose header contains the string 'reverse
                        complement'; that is, if there is some probe with
                        sequence S, it may be filtered out (even if there is a
                        sequence S in the file) if the header of S in the file
                        contains 'reverse complement'. This is useful if we
                        already have probes decided by the set cover filter,
                        but simply want to process them further by, e.g.,
                        adding adapters or running a coverage analysis. For
                        example, if we have already run the time-consuming set
                        cover filter and have a FASTA containing those probes,
                        we can provide a path to that FASTA file for this
                        argument, and also provide the --skip-set-cover
                        argument, in order to add adapters to those probes
                        without having to re-run the set cover filter.
                        (default: None)
  --skip-set-cover      Skip the set cover filter; this is useful when we wish
                        to see the probes generated from only the duplicate
                        and reverse complement filters, to gauge the effects
                        of the set cover filter (default: False)
  --add-adapters        Add adapters to the ends of probes; to specify adapter
                        sequences, use --adapter-a and --adapter-b (default:
                        False)
  --adapter-a ADAPTER_A ADAPTER_A
                        (Optional) Args: <X> <Y>; Custom A adapter to use; two
                        ordered where X is the A adapter sequence to place on
                        the 5' end of a probe and Y is the A adapter sequence
                        to place on the 3' end of a probe (default: None)
  --adapter-b ADAPTER_B ADAPTER_B
                        (Optional) Args: <X> <Y>; Custom B adapter to use; two
                        ordered where X is the B adapter sequence to place on
                        the 5' end of a probe and Y is the B adapter sequence
                        to place on the 3' end of a probe (default: None)
  --filter-polya FILTER_POLYA FILTER_POLYA
                        (Optional) Args: <X> <Y> (integers); do not output any
                        probe that contains a stretch of X or more 'A' bases,
                        tolerating up to Y mismatches (and likewise for 'T'
                        bases) (default: None)
  --add-reverse-complements
                        Add to the output the reverse complement of each probe
                        (default: False)
  --expand-n [EXPAND_N]
                        Expand each probe so that 'N' bases are replaced by
                        real bases; for example, the probe 'ANA' would be
                        replaced with the probes 'AAA', 'ATA', 'ACA', and
                        'AGA'; this is done combinatorially across all 'N'
                        bases in a probe, and thus the number of new probes
                        grows exponentially with the number of 'N' bases in a
                        probe. If followed by a command- line argument (INT),
                        this only expands at most INT randomly selected N
                        bases, and the rest are replaced with random
                        unambiguous bases (default INT is 3). (default: None)
  --limit-target-genomes LIMIT_TARGET_GENOMES
                        (Optional) Use only the first LIMIT_TARGET_GENOMES
                        target genomes in the dataset (default: None)
  --limit-target-genomes-randomly-with-replacement LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACEMENT
                        (Optional) Randomly select
                        LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACMENT target
                        genomes in the dataset with replacement (default:
                        None)
  --cluster-and-design-separately CLUSTER_AND_DESIGN_SEPARATELY
                        (Optional) If set, cluster all input sequences using
                        their MinHash signatures, design probes separately on
                        each cluster, and combine the resulting probes. This
                        can significantly lower runtime and memory usage, but
                        may lead to a suboptimal solution. The value
                        CLUSTER_AND_DESIGN_SEPARATELY gives the distance
                        threshold for determining clusters in terms of average
                        nucleotide dissimilarity (1-ANI, where ANI is average
                        nucleotide identity; see --cluster-and-design-
                        separately-method for details); higher values result
                        in fewer clusters, and thus longer runtime. Values
                        must be in (0,0.5], and generally should be around 0.1
                        to 0.2. When used, this creates a separate genome for
                        each input sequence -- it collapses all sequences,
                        across both groups and genomes, into one list of
                        sequences in one group. Therefore, genomes will not be
                        grouped as specified in the input and sequences will
                        not be grouped by genome, and differential
                        identification is not supported (default: None)
  --cluster-and-design-separately-method {choose,simple,hierarchical}
                        (Optional) Method for clustering input sequences,
                        which is only used if --cluster-and-design-separately
                        is set. If 'simple', clusters are connected components
                        of a graph in which each sequence is a vertex and two
                        sequences are adjacent if their estimated nucleotide
                        dissimilarity is within the value
                        CLUSTER_AND_DESIGN_SEPARATELY. If 'hierarchical',
                        clusters are determined by agglomerative hierarchical
                        clustering and the the value
                        CLUSTER_AND_DESIGN_SEPARATELY is the inter-cluster
                        distance threshold to merge clusters. If 'choose', use
                        a heuristic to decide among 'simple' and
                        'hierarchical' based on the input. This option can
                        affect performance and the heuristic does not always
                        make the right choice, so trying both choices 'simple'
                        and 'hierarchical' can sometimes be helpful if needed.
                        (default: choose)
  --cluster-from-fragments CLUSTER_FROM_FRAGMENTS
                        (Optional) If set, break all sequences into sequences
                        of length CLUSTER_FROM_FRAGMENTS nt, and cluster these
                        fragments. This can be useful for improving runtime on
                        input with especially large genomes, in which probes
                        for different fragments can be designed separately.
                        Values should generally be around 50,000. For this to
                        be used, --cluster-and-design-separately must also be
                        set. (default: None)
  --filter-with-lsh-hamming FILTER_WITH_LSH_HAMMING
                        (Optional) If set, filter candidate probes for near-
                        duplicates using LSH with a family of hash functions
                        that works with Hamming distance.
                        FILTER_WITH_LSH_HAMMING gives the maximum Hamming
                        distance at which to call near-duplicates; it should
                        be commensurate with (but not greater than)
                        MISMATCHES. Using this may significantly improve
                        runtime and reduce memory usage by reducing the number
                        of candidate probes to consider, but may lead to a
                        slightly sub-optimal solution. It may also,
                        particularly with relatively high values of
                        FILTER_WITH_LSH_HAMMING, cause coverage obtained for
                        each genome to be slightly less than the desired
                        coverage (COVERAGE) when that desired coverage is the
                        complete genome; using --print-analysis or --write-
                        analysis-to-tsv will provide the obtained coverage.
                        (default: None)
  --filter-with-lsh-minhash FILTER_WITH_LSH_MINHASH
                        (Optional) If set, filter candidate probes for near-
                        duplicates using LSH with a MinHash family.
                        FILTER_WITH_LSH_MINHASH gives the maximum Jaccard
                        distance (1 minus Jaccard similarity) at which to call
                        near-duplicates; the Jaccard similarity is calculated
                        by treating each probe as a set of overlapping
                        10-mers. Its value should be commensurate with
                        parameter values determining whether a probe
                        hybridizes to a target sequence, but this can be
                        difficult to measure compared to the input for
                        --filter-with-lsh-hamming. This argument allows more
                        sensitivity in near-duplicate detection than --filter-
                        with-lsh-hamming (e.g., if near-duplicates should
                        involve probes shifted relative to each other) and,
                        therefore, greater improvement in runtime and memory
                        usage. Values should generally be around 0.5 to 0.7.
                        The same caveat mentioned in the help message for
                        --filter-with-lsh-hamming also applies here; namely,
                        it can cause the coverage obtained for each genome to
                        be slightly less than the desired coverage (COVERAGE),
                        and especially so with low values of MISMATCHES (~0,
                        1, or 2). Values of FILTER_WITH_LSH_MINHASH above ~0.7
                        may start to require significant memory and runtime
                        for near-duplicate detection and are usually not
                        recommended. (default: None)
  --small-seq-skip SMALL_SEQ_SKIP
                        (Optional) Do not create candidate probes from
                        sequences whose length is <= SMALL_SEQ_SKIP. If set to
                        (PROBE_LENGTH - 1), this avoids the error raised when
                        sequences are less than the probe length (default:
                        None)
  --small-seq-min SMALL_SEQ_MIN
                        (Optional) If set, allow sequences as input that are
                        shorter than PROBE_LENGTH (when not set, the program
                        will error on such input). SMALL_SEQ_MIN is the
                        minimum sequence length that should be accepted as
                        input. When a sequence is less than PROBE_LENGTH, a
                        candidate probe is created that is equal to the
                        sequence; thus, the output probes may have different
                        lengths. Note that, when this is set, it might be a
                        good idea to also set LCF_THRES to be a value smaller
                        than PROBE_LENGTH -- e.g., the length of the shortest
                        input sequence; otherwise, when a probe of length p_l
                        is mapped to a sequence of length s_l, then lcf_thres
                        is treated as being min(LCF_THRES, p_l, s_l) so that a
                        probe is able to 'cover' a sequence shorter than the
                        probe and so that a probe shorter than lcf_thres is
                        able to 'cover' a sequence (default: None)
  --max-num-processes MAX_NUM_PROCESSES
                        (Optional) An int >= 1 that gives the maximum number
                        of processes to use in multiprocessing pools; uses
                        min(number of CPUs in the system, MAX_NUM_PROCESSES)
                        processes (default: None)
  --kmer-probe-map-k KMER_PROBE_MAP_K
                        (Optional) Use this value (KMER_PROBE_LENGTH_K) as the
                        k-mer length when constructing a map of k-mers to the
                        probes that contain these k-mers. This map is used
                        when mapping candidate probes to target sequences and
                        the k-mers serve as seeds for calculating whether a
                        candidate probe 'covers' a subsequence. The value
                        should be sufficiently less than PROBE_LENGTH so that
                        it can find mappings even when the candidate probe and
                        target sequence are divergent. In particular, CATCH
                        will try to find a value k >= KMER_PROBE_LENGTH_K (by
                        default, >=20) such that k divides PROBE_LENGTH and k
                        < PROBE_LENGTH / MISMATCHES (if MISMATCHES=0, then
                        k=PROBE_LENGTH). It will then use this k as the k-mer
                        length in mappings; if no such k exists, it will use a
                        randomized approach with KMER_PROBE_LENGTH_K as the
                        k-mer length. If --custom-hybridization-fn is set, it
                        will always use the randomized approach with
                        KMER_PROBE_LENGTH_K (by default, 20) as the k-mer
                        length. (default: None)
  --use-native-dict-when-finding-tolerant-coverage
                        When finding probe coverage for avoiding genomes and
                        identification (i.e., when using tolerant parameters),
                        use a native Python dict as the kmer_probe_map across
                        processes, rather than the primitives in
                        SharedKmerProbeMap that are more suited to sharing
                        across processes. Depending on the input (particularly
                        if there are many candidate probes) this may result in
                        substantial memory usage; but it may provide an
                        improvement in runtime when there are relatively few
                        candidate probes and a very large avoided genomes
                        input (default: False)
  --ncbi-api-key NCBI_API_KEY
                        API key to use for NCBI e-utils. Using this increases
                        the limit on requests/second and may prevent an IP
                        address from being blocked due to too many requests
                        (default: None)
  --debug               Debug output (default: 30)
  --verbose             Verbose output (default: None)
  -V, --version         show program's version number and exit
```


## catch_design_large.py

### Tool Description
Design probes for target genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/catch
- **Package**: https://anaconda.org/channels/bioconda/packages/catch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design_large.py [-h] -o OUTPUT_PROBES
                       [--write-taxid-acc WRITE_TAXID_ACC] [-pl PROBE_LENGTH]
                       [-ps PROBE_STRIDE] [-m MISMATCHES] [-l LCF_THRES]
                       [--island-of-exact-match ISLAND_OF_EXACT_MATCH]
                       [--custom-hybridization-fn CUSTOM_HYBRIDIZATION_FN CUSTOM_HYBRIDIZATION_FN]
                       [-c COVERAGE] [-e COVER_EXTENSION] [-i]
                       [--avoid-genomes AVOID_GENOMES [AVOID_GENOMES ...]]
                       [-mt MISMATCHES_TOLERANT] [-lt LCF_THRES_TOLERANT]
                       [--island-of-exact-match-tolerant ISLAND_OF_EXACT_MATCH_TOLERANT]
                       [--custom-hybridization-fn-tolerant CUSTOM_HYBRIDIZATION_FN_TOLERANT CUSTOM_HYBRIDIZATION_FN_TOLERANT]
                       [--print-analysis]
                       [--write-analysis-to-tsv WRITE_ANALYSIS_TO_TSV]
                       [--write-sliding-window-coverage WRITE_SLIDING_WINDOW_COVERAGE]
                       [--write-probe-map-counts-to-tsv WRITE_PROBE_MAP_COUNTS_TO_TSV]
                       [--filter-from-fasta FILTER_FROM_FASTA]
                       [--skip-set-cover] [--add-adapters]
                       [--adapter-a ADAPTER_A ADAPTER_A]
                       [--adapter-b ADAPTER_B ADAPTER_B]
                       [--filter-polya FILTER_POLYA FILTER_POLYA]
                       [--add-reverse-complements] [--expand-n [EXPAND_N]]
                       [--limit-target-genomes LIMIT_TARGET_GENOMES]
                       [--limit-target-genomes-randomly-with-replacement LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACEMENT]
                       [--cluster-and-design-separately CLUSTER_AND_DESIGN_SEPARATELY]
                       [--cluster-and-design-separately-method {choose,simple,hierarchical}]
                       [--cluster-from-fragments CLUSTER_FROM_FRAGMENTS]
                       [--filter-with-lsh-hamming FILTER_WITH_LSH_HAMMING]
                       [--filter-with-lsh-minhash FILTER_WITH_LSH_MINHASH]
                       [--small-seq-skip SMALL_SEQ_SKIP]
                       [--small-seq-min SMALL_SEQ_MIN]
                       [--max-num-processes MAX_NUM_PROCESSES]
                       [--kmer-probe-map-k KMER_PROBE_MAP_K]
                       [--use-native-dict-when-finding-tolerant-coverage]
                       [--ncbi-api-key NCBI_API_KEY] [--debug] [--verbose]
                       [-V]
                       dataset [dataset ...]

positional arguments:
  dataset               One or more target datasets (e.g., one per species).
                        Each dataset can be specified in one of two ways. (1)
                        If dataset is in the format 'download:TAXID', then
                        CATCH downloads from NCBI all whole genomes for the
                        NCBI taxonomy with id TAXID, and uses these sequences
                        as input. (2) If dataset is a path to a FASTA file,
                        then its sequences are read and used as input. For
                        segmented viruses, the format for NCBI downloads can
                        also be 'download:TAXID-SEGMENT'.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_PROBES, --output-probes OUTPUT_PROBES
                        The file to which all final probes should be written;
                        they are written in FASTA format (default: None)
  --write-taxid-acc WRITE_TAXID_ACC
                        If 'download:' labels are used in datasets, write
                        downloaded accessions to a file in this directory.
                        Accessions are written to WRITE_TAXID_ACC/TAXID.txt
                        (default: None)
  -pl PROBE_LENGTH, --probe-length PROBE_LENGTH
                        Make probes be PROBE_LENGTH nt long (default: 100)
  -ps PROBE_STRIDE, --probe-stride PROBE_STRIDE
                        Generate candidate probes from the input that are
                        separated by PROBE_STRIDE nt (default: 50)
  -m MISMATCHES, --mismatches MISMATCHES
                        Allow for MISMATCHES mismatches when determining
                        whether a probe covers a sequence (default: 5)
  -l LCF_THRES, --lcf-thres LCF_THRES
                        (Optional) Say that a portion of a probe covers a
                        portion of a sequence if the two share a substring
                        with at most MISMATCHES mismatches that has length >=
                        LCF_THRES nt; if unspecified, this is set to
                        PROBE_LENGTH (default: None)
  --island-of-exact-match ISLAND_OF_EXACT_MATCH
                        (Optional) When determining whether a probe covers a
                        sequence, require that there be an exact match (i.e.,
                        no mismatches) of length at least
                        ISLAND_OF_EXACT_MATCH nt between a portion of the
                        probe and a portion of the sequence (default: 0)
  --custom-hybridization-fn CUSTOM_HYBRIDIZATION_FN CUSTOM_HYBRIDIZATION_FN
                        (Optional) Args: <PATH> <FUNC>; PATH is a path to a
                        Python module (.py file) and FUNC is a string giving
                        the name of a function in that module. FUNC provides a
                        custom model of hybridization between a probe and
                        target sequence to use in the probe set design. If
                        this is set, the arguments --mismatches, --lcf-thres,
                        and --island-of-exact-match are not used because these
                        are meant for the default model of hybridization. The
                        function FUNC in PATH is dynamically loaded to use
                        when determining whether a probe hybridizes to a
                        target sequence (and, if so, what portion). FUNC must
                        accept the following arguments in order, though it may
                        choose to ignore some values: (1) array giving
                        sequence of a probe; (2) str giving subsequence of
                        target sequence to which the probe may hybridize, of
                        the same length as the given probe sequence; (3) int
                        giving the position in the probe (equivalently, the
                        target subsequence) of the start of a k-mer around
                        which the probe and target subsequence are anchored
                        (the probe and target subsequence are aligned using
                        this k-mer as an anchor); (4) int giving the end
                        position (exclusive) of the anchor k-mer; (5) int
                        giving the full length of the probe (the probe
                        provided in (1) may be cutoff on an end if it extends
                        further than where the target sequence ends); (6) int
                        giving the full length of the target sequence of which
                        the subsequence in (2) is part. FUNC must return None
                        if it deems that the probe does not hybridize to the
                        target subsequence; otherwise, it must return a tuple
                        (start, end) where start is an int giving the start
                        position in the probe (equivalently, in the target
                        subsequence) at which the probe will hybridize to the
                        target subsequence, and end is an int (exclusive)
                        giving the end position of the hybridization.
                        (default: None)
  -c COVERAGE, --coverage COVERAGE
                        If this is a float in [0,1], it gives the fraction of
                        each target genome that must be covered by the
                        selected probes; if this is an int > 1, it gives the
                        number of bp of each target genome that must be
                        covered by the selected probes (default: 1.0)
  -e COVER_EXTENSION, --cover-extension COVER_EXTENSION
                        Extend the coverage of each side of a probe by
                        COVER_EXTENSION nt. That is, a probe covers a region
                        that consists of the portion of a sequence it
                        hybridizes to, as well as this number of nt on each
                        side of that portion. This is useful in modeling
                        hybrid selection, where a probe hybridizes toa
                        fragment that includes the region targeted by the
                        probe, along with surrounding portions of the
                        sequence. Increasing its value should reduce the
                        number of probes required to achieve the desired
                        coverage. (default: 50)
  -i, --identify        Design probes meant to make it possible to identify
                        nucleic acid from a particular input dataset against
                        the other datasets; when set, the coverage should
                        generally be small (default: False)
  --avoid-genomes AVOID_GENOMES [AVOID_GENOMES ...]
                        One or more genomes to avoid; penalize probes based on
                        how much of each of these genomes they cover. The
                        value is a path to a FASTA file. (default: None)
  -mt MISMATCHES_TOLERANT, --mismatches-tolerant MISMATCHES_TOLERANT
                        (Optional) A more tolerant value for 'mismatches';
                        this should be greater than the value of MISMATCHES.
                        Allows for capturing more possible hybridizations
                        (i.e., more sensitivity) when designing probes for
                        identification or when genomes are avoided. (default:
                        None)
  -lt LCF_THRES_TOLERANT, --lcf-thres-tolerant LCF_THRES_TOLERANT
                        (Optional) A more tolerant value for 'lcf_thres'; this
                        should be less than LCF_THRES. Allows for capturing
                        more possible hybridizations (i.e., more sensitivity)
                        when designing probes for identification or when
                        genomes are avoided. (default: None)
  --island-of-exact-match-tolerant ISLAND_OF_EXACT_MATCH_TOLERANT
                        (Optional) A more tolerant value for
                        'island_of_exact_match'; this should be less than
                        ISLAND_OF_ EXACT_MATCH. Allows for capturing more
                        possible hybridizations (i.e., more sensitivity) when
                        designing probes for identification or when genomes
                        are avoided. (default: 0)
  --custom-hybridization-fn-tolerant CUSTOM_HYBRIDIZATION_FN_TOLERANT CUSTOM_HYBRIDIZATION_FN_TOLERANT
                        (Optional) A more tolerant model than the one
                        implemented in custom_hybridization_fn. This should
                        capture more possible hybridizations (i.e., be more
                        sensitive) when designing probes for identification or
                        when genomes are avoided. See --custom-hybridization-
                        fn for details of how this function should be
                        implemented and provided. (default: None)
  --print-analysis      Print analysis of the probe set's coverage (default:
                        False)
  --write-analysis-to-tsv WRITE_ANALYSIS_TO_TSV
                        (Optional) The file to which to write a TSV-formatted
                        matrix of the probe set's coverage analysis (default:
                        None)
  --write-sliding-window-coverage WRITE_SLIDING_WINDOW_COVERAGE
                        (Optional) The file to which to write the average
                        coverage achieved by the probe set within sliding
                        windows of each target genome (default: None)
  --write-probe-map-counts-to-tsv WRITE_PROBE_MAP_COUNTS_TO_TSV
                        (Optional) The file to which to write a TSV-formatted
                        list of the number of sequences each probe maps to.
                        This explicitly does not count reverse complements.
                        (default: None)
  --filter-from-fasta FILTER_FROM_FASTA
                        (Optional) A FASTA file from which to select candidate
                        probes. Before running any other filters, keep only
                        the candidate probes that are equal to sequences in
                        the file and remove all probes not equal to any of
                        these sequences. This, by default, ignores sequences
                        in the file whose header contains the string 'reverse
                        complement'; that is, if there is some probe with
                        sequence S, it may be filtered out (even if there is a
                        sequence S in the file) if the header of S in the file
                        contains 'reverse complement'. This is useful if we
                        already have probes decided by the set cover filter,
                        but simply want to process them further by, e.g.,
                        adding adapters or running a coverage analysis. For
                        example, if we have already run the time-consuming set
                        cover filter and have a FASTA containing those probes,
                        we can provide a path to that FASTA file for this
                        argument, and also provide the --skip-set-cover
                        argument, in order to add adapters to those probes
                        without having to re-run the set cover filter.
                        (default: None)
  --skip-set-cover      Skip the set cover filter; this is useful when we wish
                        to see the probes generated from only the duplicate
                        and reverse complement filters, to gauge the effects
                        of the set cover filter (default: False)
  --add-adapters        Add adapters to the ends of probes; to specify adapter
                        sequences, use --adapter-a and --adapter-b (default:
                        False)
  --adapter-a ADAPTER_A ADAPTER_A
                        (Optional) Args: <X> <Y>; Custom A adapter to use; two
                        ordered where X is the A adapter sequence to place on
                        the 5' end of a probe and Y is the A adapter sequence
                        to place on the 3' end of a probe (default: None)
  --adapter-b ADAPTER_B ADAPTER_B
                        (Optional) Args: <X> <Y>; Custom B adapter to use; two
                        ordered where X is the B adapter sequence to place on
                        the 5' end of a probe and Y is the B adapter sequence
                        to place on the 3' end of a probe (default: None)
  --filter-polya FILTER_POLYA FILTER_POLYA
                        (Optional) Args: <X> <Y> (integers); do not output any
                        probe that contains a stretch of X or more 'A' bases,
                        tolerating up to Y mismatches (and likewise for 'T'
                        bases) (default: None)
  --add-reverse-complements
                        Add to the output the reverse complement of each probe
                        (default: False)
  --expand-n [EXPAND_N]
                        Expand each probe so that 'N' bases are replaced by
                        real bases; for example, the probe 'ANA' would be
                        replaced with the probes 'AAA', 'ATA', 'ACA', and
                        'AGA'; this is done combinatorially across all 'N'
                        bases in a probe, and thus the number of new probes
                        grows exponentially with the number of 'N' bases in a
                        probe. If followed by a command- line argument (INT),
                        this only expands at most INT randomly selected N
                        bases, and the rest are replaced with random
                        unambiguous bases (default INT is 3). (default: None)
  --limit-target-genomes LIMIT_TARGET_GENOMES
                        (Optional) Use only the first LIMIT_TARGET_GENOMES
                        target genomes in the dataset (default: None)
  --limit-target-genomes-randomly-with-replacement LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACEMENT
                        (Optional) Randomly select
                        LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACMENT target
                        genomes in the dataset with replacement (default:
                        None)
  --cluster-and-design-separately CLUSTER_AND_DESIGN_SEPARATELY
                        (Optional) If set, cluster all input sequences using
                        their MinHash signatures, design probes separately on
                        each cluster, and combine the resulting probes. This
                        can significantly lower runtime and memory usage, but
                        may lead to a suboptimal solution. The value
                        CLUSTER_AND_DESIGN_SEPARATELY gives the distance
                        threshold for determining clusters in terms of average
                        nucleotide dissimilarity (1-ANI, where ANI is average
                        nucleotide identity; see --cluster-and-design-
                        separately-method for details); higher values result
                        in fewer clusters, and thus longer runtime. Values
                        must be in (0,0.5], and generally should be around 0.1
                        to 0.2. When used, this creates a separate genome for
                        each input sequence -- it collapses all sequences,
                        across both groups and genomes, into one list of
                        sequences in one group. Therefore, genomes will not be
                        grouped as specified in the input and sequences will
                        not be grouped by genome, and differential
                        identification is not supported (default: 0.15)
  --cluster-and-design-separately-method {choose,simple,hierarchical}
                        (Optional) Method for clustering input sequences,
                        which is only used if --cluster-and-design-separately
                        is set. If 'simple', clusters are connected components
                        of a graph in which each sequence is a vertex and two
                        sequences are adjacent if their estimated nucleotide
                        dissimilarity is within the value
                        CLUSTER_AND_DESIGN_SEPARATELY. If 'hierarchical',
                        clusters are determined by agglomerative hierarchical
                        clustering and the the value
                        CLUSTER_AND_DESIGN_SEPARATELY is the inter-cluster
                        distance threshold to merge clusters. If 'choose', use
                        a heuristic to decide among 'simple' and
                        'hierarchical' based on the input. This option can
                        affect performance and the heuristic does not always
                        make the right choice, so trying both choices 'simple'
                        and 'hierarchical' can sometimes be helpful if needed.
                        (default: choose)
  --cluster-from-fragments CLUSTER_FROM_FRAGMENTS
                        (Optional) If set, break all sequences into sequences
                        of length CLUSTER_FROM_FRAGMENTS nt, and cluster these
                        fragments. This can be useful for improving runtime on
                        input with especially large genomes, in which probes
                        for different fragments can be designed separately.
                        Values should generally be around 50,000. For this to
                        be used, --cluster-and-design-separately must also be
                        set. (default: 50000)
  --filter-with-lsh-hamming FILTER_WITH_LSH_HAMMING
                        (Optional) If set, filter candidate probes for near-
                        duplicates using LSH with a family of hash functions
                        that works with Hamming distance.
                        FILTER_WITH_LSH_HAMMING gives the maximum Hamming
                        distance at which to call near-duplicates; it should
                        be commensurate with (but not greater than)
                        MISMATCHES. Using this may significantly improve
                        runtime and reduce memory usage by reducing the number
                        of candidate probes to consider, but may lead to a
                        slightly sub-optimal solution. It may also,
                        particularly with relatively high values of
                        FILTER_WITH_LSH_HAMMING, cause coverage obtained for
                        each genome to be slightly less than the desired
                        coverage (COVERAGE) when that desired coverage is the
                        complete genome; using --print-analysis or --write-
                        analysis-to-tsv will provide the obtained coverage.
                        (default: None)
  --filter-with-lsh-minhash FILTER_WITH_LSH_MINHASH
                        (Optional) If set, filter candidate probes for near-
                        duplicates using LSH with a MinHash family.
                        FILTER_WITH_LSH_MINHASH gives the maximum Jaccard
                        distance (1 minus Jaccard similarity) at which to call
                        near-duplicates; the Jaccard similarity is calculated
                        by treating each probe as a set of overlapping
                        10-mers. Its value should be commensurate with
                        parameter values determining whether a probe
                        hybridizes to a target sequence, but this can be
                        difficult to measure compared to the input for
                        --filter-with-lsh-hamming. This argument allows more
                        sensitivity in near-duplicate detection than --filter-
                        with-lsh-hamming (e.g., if near-duplicates should
                        involve probes shifted relative to each other) and,
                        therefore, greater improvement in runtime and memory
                        usage. Values should generally be around 0.5 to 0.7.
                        The same caveat mentioned in the help message for
                        --filter-with-lsh-hamming also applies here; namely,
                        it can cause the coverage obtained for each genome to
                        be slightly less than the desired coverage (COVERAGE),
                        and especially so with low values of MISMATCHES (~0,
                        1, or 2). Values of FILTER_WITH_LSH_MINHASH above ~0.7
                        may start to require significant memory and runtime
                        for near-duplicate detection and are usually not
                        recommended. (default: 0.6)
  --small-seq-skip SMALL_SEQ_SKIP
                        (Optional) Do not create candidate probes from
                        sequences whose length is <= SMALL_SEQ_SKIP. If set to
                        (PROBE_LENGTH - 1), this avoids the error raised when
                        sequences are less than the probe length (default:
                        None)
  --small-seq-min SMALL_SEQ_MIN
                        (Optional) If set, allow sequences as input that are
                        shorter than PROBE_LENGTH (when not set, the program
                        will error on such input). SMALL_SEQ_MIN is the
                        minimum sequence length that should be accepted as
                        input. When a sequence is less than PROBE_LENGTH, a
                        candidate probe is created that is equal to the
                        sequence; thus, the output probes may have different
                        lengths. Note that, when this is set, it might be a
                        good idea to also set LCF_THRES to be a value smaller
                        than PROBE_LENGTH -- e.g., the length of the shortest
                        input sequence; otherwise, when a probe of length p_l
                        is mapped to a sequence of length s_l, then lcf_thres
                        is treated as being min(LCF_THRES, p_l, s_l) so that a
                        probe is able to 'cover' a sequence shorter than the
                        probe and so that a probe shorter than lcf_thres is
                        able to 'cover' a sequence (default: None)
  --max-num-processes MAX_NUM_PROCESSES
                        (Optional) An int >= 1 that gives the maximum number
                        of processes to use in multiprocessing pools; uses
                        min(number of CPUs in the system, MAX_NUM_PROCESSES)
                        processes (default: 20)
  --kmer-probe-map-k KMER_PROBE_MAP_K
                        (Optional) Use this value (KMER_PROBE_LENGTH_K) as the
                        k-mer length when constructing a map of k-mers to the
                        probes that contain these k-mers. This map is used
                        when mapping candidate probes to target sequences and
                        the k-mers serve as seeds for calculating whether a
                        candidate probe 'covers' a subsequence. The value
                        should be sufficiently less than PROBE_LENGTH so that
                        it can find mappings even when the candidate probe and
                        target sequence are divergent. In particular, CATCH
                        will try to find a value k >= KMER_PROBE_LENGTH_K (by
                        default, >=20) such that k divides PROBE_LENGTH and k
                        < PROBE_LENGTH / MISMATCHES (if MISMATCHES=0, then
                        k=PROBE_LENGTH). It will then use this k as the k-mer
                        length in mappings; if no such k exists, it will use a
                        randomized approach with KMER_PROBE_LENGTH_K as the
                        k-mer length. If --custom-hybridization-fn is set, it
                        will always use the randomized approach with
                        KMER_PROBE_LENGTH_K (by default, 20) as the k-mer
                        length. (default: None)
  --use-native-dict-when-finding-tolerant-coverage
                        When finding probe coverage for avoiding genomes and
                        identification (i.e., when using tolerant parameters),
                        use a native Python dict as the kmer_probe_map across
                        processes, rather than the primitives in
                        SharedKmerProbeMap that are more suited to sharing
                        across processes. Depending on the input (particularly
                        if there are many candidate probes) this may result in
                        substantial memory usage; but it may provide an
                        improvement in runtime when there are relatively few
                        candidate probes and a very large avoided genomes
                        input (default: False)
  --ncbi-api-key NCBI_API_KEY
                        API key to use for NCBI e-utils. Using this increases
                        the limit on requests/second and may prevent an IP
                        address from being blocked due to too many requests
                        (default: None)
  --debug               Debug output (default: 30)
  --verbose             Verbose output (default: None)
  -V, --version         show program's version number and exit
```


## catch_pool.py

### Tool Description
Optimizes parameter values for probe design based on probe counts and constraints.

### Metadata
- **Docker Image**: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/broadinstitute/catch
- **Package**: https://anaconda.org/channels/bioconda/packages/catch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pool.py [-h] [--round-params ROUND_PARAMS ROUND_PARAMS] [--use-nd]
               [--loss-coeffs LOSS_COEFFS [LOSS_COEFFS ...]]
               [--dataset-weights DATASET_WEIGHTS_TSV] [--debug] [--verbose]
               [--version]
               probe_count_tsv target_probe_count param_vals_tsv

positional arguments:
  probe_count_tsv       Path to TSV file that contains probe counts for each
                        dataset and combination of parameters; the first row
                        must be a header, the first column must give a dataset
                        ('dataset'), the last column must list a number of
                        probes ('num_probes'), and the intermediary columns
                        give parameter values
  target_probe_count    Constraint on the total number of probes in the
                        design; generally, parameters will be selected such
                        that the number of probes, when pooled across
                        datasets, is just below this number
  param_vals_tsv        Path to TSV file in which to output optimal parameter
                        values

options:
  -h, --help            show this help message and exit
  --round-params ROUND_PARAMS ROUND_PARAMS
                        <m> <e>; round mismatches parameter to the nearest
                        multiple of m and cover_extension parameter to the
                        nearest multiple of e
  --use-nd              Use the higher dimensional (n > 2) interpolation and
                        search functions for optimizing parameters. This is
                        required if the input table of probe counts contains
                        more than 2 parameters. This does not round parameters
                        to integers or to be placed on a grid -- i.e., they
                        will be output as fractional values (from which probe
                        counts were interpolated). When using this, --loss-
                        coeffs should also be set (default is 1 for all
                        parameters).
  --loss-coeffs LOSS_COEFFS [LOSS_COEFFS ...]
                        Coefficients on parameters in the loss function. These
                        must be specified in the same order as the parameter
                        columns in the input table. Default is 1 for
                        mismatches and 1/100 for cover_extension (or, when
                        --use-nd is specified, 1 for all parameters).
  --dataset-weights DATASET_WEIGHTS_TSV
                        Path to TSV file that contains a weight for each
                        dataset to use in the loss function. The first row
                        must be a header, the first column must provide the
                        dataset ('dataset') and the second column must provide
                        the weight of the dataset ('weight'). If not provided,
                        the default is a weight of 1 for each dataset.
  --debug               Debug output
  --verbose             Verbose output
  --version, -V         show program's version number and exit
```


## Metadata
- **Skill**: generated
