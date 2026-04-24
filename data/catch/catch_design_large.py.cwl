cwlVersion: v1.2
class: CommandLineTool
baseCommand: design_large.py
label: catch_design_large.py
doc: "Design probes for target genomes.\n\nTool homepage: https://github.com/broadinstitute/catch"
inputs:
  - id: dataset
    type:
      type: array
      items: string
    doc: One or more target datasets (e.g., one per species). Each dataset can 
      be specified in one of two ways. (1) If dataset is in the format 
      'download:TAXID', then CATCH downloads from NCBI all whole genomes for the
      NCBI taxonomy with id TAXID, and uses these sequences as input. (2) If 
      dataset is a path to a FASTA file, then its sequences are read and used as
      input. For segmented viruses, the format for NCBI downloads can also be 
      'download:TAXID-SEGMENT'.
    inputBinding:
      position: 1
  - id: adapter_a
    type:
      - 'null'
      - type: array
        items: string
    doc: Custom A adapter to use; two ordered where X is the A adapter sequence 
      to place on the 5' end of a probe and Y is the A adapter sequence to place
      on the 3' end of a probe
    inputBinding:
      position: 102
      prefix: --adapter-a
  - id: adapter_b
    type:
      - 'null'
      - type: array
        items: string
    doc: Custom B adapter to use; two ordered where X is the B adapter sequence 
      to place on the 5' end of a probe and Y is the B adapter sequence to place
      on the 3' end of a probe
    inputBinding:
      position: 102
      prefix: --adapter-b
  - id: add_adapters
    type:
      - 'null'
      - boolean
    doc: Add adapters to the ends of probes; to specify adapter sequences, use 
      --adapter-a and --adapter-b
    inputBinding:
      position: 102
      prefix: --add-adapters
  - id: add_reverse_complements
    type:
      - 'null'
      - boolean
    doc: Add to the output the reverse complement of each probe
    inputBinding:
      position: 102
      prefix: --add-reverse-complements
  - id: avoid_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more genomes to avoid; penalize probes based on how much of each
      of these genomes they cover. The value is a path to a FASTA file.
    inputBinding:
      position: 102
      prefix: --avoid-genomes
  - id: cluster_and_design_separately
    type:
      - 'null'
      - float
    doc: If set, cluster all input sequences using their MinHash signatures, 
      design probes separately on each cluster, and combine the resulting 
      probes. This can significantly lower runtime and memory usage, but may 
      lead to a suboptimal solution. The value CLUSTER_AND_DESIGN_SEPARATELY 
      gives the distance threshold for determining clusters in terms of average 
      nucleotide dissimilarity (1-ANI, where ANI is average nucleotide identity;
      see --cluster-and-design-separately-method for details); higher values 
      result in fewer clusters, and thus longer runtime. Values must be in 
      (0,0.5], and generally should be around 0.1 to 0.2. When used, this 
      creates a separate genome for each input sequence -- it collapses all 
      sequences, across both groups and genomes, into one list of sequences in 
      one group. Therefore, genomes will not be grouped as specified in the 
      input and sequences will not be grouped by genome, and differential 
      identification is not supported
    inputBinding:
      position: 102
      prefix: --cluster-and-design-separately
  - id: cluster_and_design_separately_method
    type:
      - 'null'
      - string
    doc: Method for clustering input sequences, which is only used if 
      --cluster-and-design-separately is set. If 'simple', clusters are 
      connected components of a graph in which each sequence is a vertex and two
      sequences are adjacent if their estimated nucleotide dissimilarity is 
      within the value CLUSTER_AND_DESIGN_SEPARATELY. If 'hierarchical', 
      clusters are determined by agglomerative hierarchical clustering and the 
      the value CLUSTER_AND_DESIGN_SEPARATELY is the inter-cluster distance 
      threshold to merge clusters. If 'choose', use a heuristic to decide among 
      'simple' and 'hierarchical' based on the input. This option can affect 
      performance and the heuristic does not always make the right choice, so 
      trying both choices 'simple' and 'hierarchical' can sometimes be helpful 
      if needed.
    inputBinding:
      position: 102
      prefix: --cluster-and-design-separately-method
  - id: cluster_from_fragments
    type:
      - 'null'
      - int
    doc: If set, break all sequences into sequences of length 
      CLUSTER_FROM_FRAGMENTS nt, and cluster these fragments. This can be useful
      for improving runtime on input with especially large genomes, in which 
      probes for different fragments can be designed separately. Values should 
      generally be around 50,000. For this to be used, 
      --cluster-and-design-separately must also be set.
    inputBinding:
      position: 102
      prefix: --cluster-from-fragments
  - id: cover_extension
    type:
      - 'null'
      - int
    doc: Extend the coverage of each side of a probe by COVER_EXTENSION nt. That
      is, a probe covers a region that consists of the portion of a sequence it 
      hybridizes to, as well as this number of nt on each side of that portion. 
      This is useful in modeling hybrid selection, where a probe hybridizes toa 
      fragment that includes the region targeted by the probe, along with 
      surrounding portions of the sequence. Increasing its value should reduce 
      the number of probes required to achieve the desired coverage.
    inputBinding:
      position: 102
      prefix: --cover-extension
  - id: coverage
    type:
      - 'null'
      - float
    doc: If this is a float in [0,1], it gives the fraction of each target 
      genome that must be covered by the selected probes; if this is an int > 1,
      it gives the number of bp of each target genome that must be covered by 
      the selected probes
    inputBinding:
      position: 102
      prefix: --coverage
  - id: custom_hybridization_fn
    type:
      - 'null'
      - type: array
        items: string
    doc: 'PATH is a path to a Python module (.py file) and FUNC is a string giving
      the name of a function in that module. FUNC provides a custom model of hybridization
      between a probe and target sequence to use in the probe set design. If this
      is set, the arguments --mismatches, --lcf-thres, and --island-of-exact-match
      are not used because these are meant for the default model of hybridization.
      The function FUNC in PATH is dynamically loaded to use when determining whether
      a probe hybridizes to a target sequence (and, if so, what portion). FUNC must
      accept the following arguments in order, though it may choose to ignore some
      values: (1) array giving sequence of a probe; (2) str giving subsequence of
      target sequence to which the probe may hybridize, of the same length as the
      given probe sequence; (3) int giving the position in the probe (equivalently,
      the target subsequence) of the start of a k-mer around which the probe and target
      subsequence are anchored (the probe and target subsequence are aligned using
      this k-mer as an anchor); (4) int giving the end position (exclusive) of the
      anchor k-mer; (5) int giving the full length of the probe (the probe provided
      in (1) may be cutoff on an end if it extends further than where the target sequence
      ends); (6) int giving the full length of the target sequence of which the subsequence
      in (2) is part. FUNC must return None if it deems that the probe does not hybridize
      to the target subsequence; otherwise, it must return a tuple (start, end) where
      start is an int giving the start position in the probe (equivalently, in the
      target subsequence) at which the probe will hybridize to the target subsequence,
      and end is an int (exclusive) giving the end position of the hybridization.'
    inputBinding:
      position: 102
      prefix: --custom-hybridization-fn
  - id: custom_hybridization_fn_tolerant
    type:
      - 'null'
      - type: array
        items: string
    doc: A more tolerant model than the one implemented in 
      custom_hybridization_fn. This should capture more possible hybridizations 
      (i.e., be more sensitive) when designing probes for identification or when
      genomes are avoided. See --custom-hybridization-fn for details of how this
      function should be implemented and provided.
    inputBinding:
      position: 102
      prefix: --custom-hybridization-fn-tolerant
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: expand_n
    type:
      - 'null'
      - int
    doc: Expand each probe so that 'N' bases are replaced by real bases; for 
      example, the probe 'ANA' would be replaced with the probes 'AAA', 'ATA', 
      'ACA', and 'AGA'; this is done combinatorially across all 'N' bases in a 
      probe, and thus the number of new probes grows exponentially with the 
      number of 'N' bases in a probe. If followed by a command- line argument 
      (INT), this only expands at most INT randomly selected N bases, and the 
      rest are replaced with random unambiguous bases (default INT is 3).
    inputBinding:
      position: 102
      prefix: --expand-n
  - id: filter_from_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file from which to select candidate probes. Before running any 
      other filters, keep only the candidate probes that are equal to sequences 
      in the file and remove all probes not equal to any of these sequences. 
      This, by default, ignores sequences in the file whose header contains the 
      string 'reverse complement'; that is, if there is some probe with sequence
      S, it may be filtered out (even if there is a sequence S in the file) if 
      the header of S in the file contains 'reverse complement'. This is useful 
      if we already have probes decided by the set cover filter, but simply want
      to process them further by, e.g., adding adapters or running a coverage 
      analysis. For example, if we have already run the time-consuming set cover
      filter and have a FASTA containing those probes, we can provide a path to 
      that FASTA file for this argument, and also provide the --skip-set-cover 
      argument, in order to add adapters to those probes without having to 
      re-run the set cover filter.
    inputBinding:
      position: 102
      prefix: --filter-from-fasta
  - id: filter_polya
    type:
      - 'null'
      - type: array
        items: int
    doc: do not output any probe that contains a stretch of X or more 'A' bases,
      tolerating up to Y mismatches (and likewise for 'T' bases)
    inputBinding:
      position: 102
      prefix: --filter-polya
  - id: filter_with_lsh_hamming
    type:
      - 'null'
      - int
    doc: If set, filter candidate probes for near-duplicates using LSH with a 
      family of hash functions that works with Hamming distance. 
      FILTER_WITH_LSH_HAMMING gives the maximum Hamming distance at which to 
      call near-duplicates; it should be commensurate with (but not greater 
      than) MISMATCHES. Using this may significantly improve runtime and reduce 
      memory usage by reducing the number of candidate probes to consider, but 
      may lead to a slightly sub-optimal solution. It may also, particularly 
      with relatively high values of FILTER_WITH_LSH_HAMMING, cause coverage 
      obtained for each genome to be slightly less than the desired coverage 
      (COVERAGE) when that desired coverage is the complete genome; using 
      --print-analysis or --write-analysis-to-tsv will provide the obtained 
      coverage.
    inputBinding:
      position: 102
      prefix: --filter-with-lsh-hamming
  - id: filter_with_lsh_minhash
    type:
      - 'null'
      - float
    doc: If set, filter candidate probes for near-duplicates using LSH with a 
      MinHash family. FILTER_WITH_LSH_MINHASH gives the maximum Jaccard distance
      (1 minus Jaccard similarity) at which to call near-duplicates; the Jaccard
      similarity is calculated by treating each probe as a set of overlapping 
      10-mers. Its value should be commensurate with parameter values 
      determining whether a probe hybridizes to a target sequence, but this can 
      be difficult to measure compared to the input for 
      --filter-with-lsh-hamming. This argument allows more sensitivity in 
      near-duplicate detection than --filter-with-lsh-hamming (e.g., if 
      near-duplicates should involve probes shifted relative to each other) and,
      therefore, greater improvement in runtime and memory usage. Values should 
      generally be around 0.5 to 0.7. The same caveat mentioned in the help 
      message for --filter-with-lsh-hamming also applies here; namely, it can 
      cause the coverage obtained for each genome to be slightly less than the 
      desired coverage (COVERAGE), and especially so with low values of 
      MISMATCHES (~0, 1, or 2). Values of FILTER_WITH_LSH_MINHASH above ~0.7 may
      start to require significant memory and runtime for near-duplicate 
      detection and are usually not recommended.
    inputBinding:
      position: 102
      prefix: --filter-with-lsh-minhash
  - id: identify
    type:
      - 'null'
      - boolean
    doc: Design probes meant to make it possible to identify nucleic acid from a
      particular input dataset against the other datasets; when set, the 
      coverage should generally be small
    inputBinding:
      position: 102
      prefix: -i
  - id: island_of_exact_match
    type:
      - 'null'
      - int
    doc: When determining whether a probe covers a sequence, require that there 
      be an exact match (i.e., no mismatches) of length at least 
      ISLAND_OF_EXACT_MATCH nt between a portion of the probe and a portion of 
      the sequence
    inputBinding:
      position: 102
      prefix: --island-of-exact-match
  - id: island_of_exact_match_tolerant
    type:
      - 'null'
      - int
    doc: A more tolerant value for 'island_of_exact_match'; this should be less 
      than ISLAND_OF_ EXACT_MATCH. Allows for capturing more possible 
      hybridizations (i.e., more sensitivity) when designing probes for 
      identification or when genomes are avoided.
    inputBinding:
      position: 102
      prefix: --island-of-exact-match-tolerant
  - id: kmer_probe_map_k
    type:
      - 'null'
      - int
    doc: Use this value (KMER_PROBE_LENGTH_K) as the k-mer length when 
      constructing a map of k-mers to the probes that contain these k-mers. This
      map is used when mapping candidate probes to target sequences and the 
      k-mers serve as seeds for calculating whether a candidate probe 'covers' a
      subsequence. The value should be sufficiently less than PROBE_LENGTH so 
      that it can find mappings even when the candidate probe and target 
      sequence are divergent. In particular, CATCH will try to find a value k >=
      KMER_PROBE_LENGTH_K (by default, >=20) such that k divides PROBE_LENGTH 
      and k < PROBE_LENGTH / MISMATCHES (if MISMATCHES=0, then k=PROBE_LENGTH). 
      It will then use this k as the k-mer length in mappings; if no such k 
      exists, it will use a random approach with KMER_PROBE_LENGTH_K as the 
      k-mer length. If --custom-hybridization-fn is set, it will always use the 
      randomized approach with KMER_PROBE_LENGTH_K (by default, 20) as the k-mer
      length.
    inputBinding:
      position: 102
      prefix: --kmer-probe-map-k
  - id: lcf_thres
    type:
      - 'null'
      - int
    doc: Allow that a portion of a probe covers a portion of a sequence if the 
      two share a substring with at most MISMATCHES mismatches that has length 
      >= LCF_THRES nt; if unspecified, this is set to PROBE_LENGTH
    inputBinding:
      position: 102
      prefix: --lcf-thres
  - id: lcf_thres_tolerant
    type:
      - 'null'
      - int
    doc: A more tolerant value for 'lcf_thres'; this should be less than 
      LCF_THRES. Allows for capturing more possible hybridizations (i.e., more 
      sensitivity) when designing probes for identification or when genomes are 
      avoided.
    inputBinding:
      position: 102
      prefix: --lcf-thres-tolerant
  - id: limit_target_genomes
    type:
      - 'null'
      - int
    doc: Use only the first LIMIT_TARGET_GENOMES target genomes in the dataset
    inputBinding:
      position: 102
      prefix: --limit-target-genomes
  - id: limit_target_genomes_randomly_with_replacement
    type:
      - 'null'
      - int
    doc: Randomly select LIMIT_TARGET_GENOMES_RANDOMLY_WITH_REPLACMENT target 
      genomes in the dataset with replacement
    inputBinding:
      position: 102
      prefix: --limit-target-genomes-randomly-with-replacement
  - id: max_num_processes
    type:
      - 'null'
      - int
    doc: An int >= 1 that gives the maximum number of processes to use in 
      multiprocessing pools; uses min(number of CPUs in the system, 
      MAX_NUM_PROCESSES) processes
    inputBinding:
      position: 102
      prefix: --max-num-processes
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Allow for MISMATCHES mismatches when determining whether a probe covers
      a sequence
    inputBinding:
      position: 102
      prefix: --mismatches
  - id: mismatches_tolerant
    type:
      - 'null'
      - int
    doc: A more tolerant value for 'mismatches'; this should be greater than the
      value of MISMATCHES. Allows for capturing more possible hybridizations 
      (i.e., more sensitivity) when designing probes for identification or when 
      genomes are avoided.
    inputBinding:
      position: 102
      prefix: --mismatches-tolerant
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: API key to use for NCBI e-utils. Using this increases the limit on 
      requests/second and may prevent an IP address from being blocked due to 
      too many requests
    inputBinding:
      position: 102
      prefix: --ncbi-api-key
  - id: output_probes
    type: File
    doc: The file to which all final probes should be written; they are written 
      in FASTA format
    inputBinding:
      position: 102
      prefix: --output-probes
  - id: print_analysis
    type:
      - 'null'
      - boolean
    doc: Print analysis of the probe set's coverage
    inputBinding:
      position: 102
      prefix: --print-analysis
  - id: probe_length
    type:
      - 'null'
      - int
    doc: Make probes be PROBE_LENGTH nt long
    inputBinding:
      position: 102
      prefix: --probe-length
  - id: probe_stride
    type:
      - 'null'
      - int
    doc: Generate candidate probes from the input that are separated by 
      PROBE_STRIDE nt
    inputBinding:
      position: 102
      prefix: --probe-stride
  - id: skip_set_cover
    type:
      - 'null'
      - boolean
    doc: Skip the set cover filter; this is useful when we wish to see the 
      probes generated from only the duplicate and reverse complement filters, 
      to gauge the effects of the set cover filter
    inputBinding:
      position: 102
      prefix: --skip-set-cover
  - id: small_seq_min
    type:
      - 'null'
      - int
    doc: If set, allow sequences as input that are shorter than PROBE_LENGTH 
      (when not set, the program will error on such input). SMALL_SEQ_MIN is the
      minimum sequence length that should be accepted as input. When a sequence 
      is less than PROBE_LENGTH, a candidate probe is created that is equal to 
      the sequence; thus, the output probes may have different lengths. Note 
      that, when this is set, it might be a good idea to also set LCF_THRES to 
      be a value smaller than PROBE_LENGTH -- e.g., the length of the shortest 
      input sequence; otherwise, when a probe of length p_l is mapped to a 
      sequence of length s_l, then lcf_thres is treated as being min(LCF_THRES, 
      p_l, s_l) so that a probe is able to 'cover' a sequence shorter than the 
      probe and so that a probe shorter than lcf_thres is able to 'cover' a 
      sequence
    inputBinding:
      position: 102
      prefix: --small-seq-min
  - id: small_seq_skip
    type:
      - 'null'
      - int
    doc: Do not create candidate probes from sequences whose length is <= 
      SMALL_SEQ_SKIP. If set to (PROBE_LENGTH - 1), this avoids the error raised
      when sequences are less than the probe length
    inputBinding:
      position: 102
      prefix: --small-seq-skip
  - id: use_native_dict_when_finding_tolerant_coverage
    type:
      - 'null'
      - boolean
    doc: When finding probe coverage for avoiding genomes and identification 
      (i.e., when using tolerant parameters), use a native Python dict as the 
      kmer_probe_map across processes, rather than the primitives in 
      SharedKmerProbeMap that are more suited to sharing across processes. 
      Depending on the input (particularly if there are many candidate probes) 
      this may result in substantial memory usage; but it may provide an 
      improvement in runtime when there are relatively few candidate probes and 
      a very large avoided genomes input
    inputBinding:
      position: 102
      prefix: --use-native-dict-when-finding-tolerant-coverage
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_analysis_to_tsv
    type:
      - 'null'
      - File
    doc: The file to which to write a TSV-formatted matrix of the probe set's 
      coverage analysis
    inputBinding:
      position: 102
      prefix: --write-analysis-to-tsv
  - id: write_probe_map_counts_to_tsv
    type:
      - 'null'
      - File
    doc: The file to which to write a TSV-formatted list of the number of 
      sequences each probe maps to. This explicitly does not count reverse 
      complements.
    inputBinding:
      position: 102
      prefix: --write-probe-map-counts-to-tsv
  - id: write_sliding_window_coverage
    type:
      - 'null'
      - File
    doc: The file to which to write the average coverage achieved by the probe 
      set within sliding windows of each target genome
    inputBinding:
      position: 102
      prefix: --write-sliding-window-coverage
  - id: write_taxid_acc
    type:
      - 'null'
      - Directory
    doc: If 'download:' labels are used in datasets, write downloaded accessions
      to a file in this directory. Accessions are written to 
      WRITE_TAXID_ACC/TAXID.txt
    inputBinding:
      position: 102
      prefix: --write-taxid-acc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch_design_large.py.out
