cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_organelle_from_reads.py
label: getorganelle_get_organelle_from_reads.py
doc: "GetOrganelle v1.7.7.1 get_organelle_from_reads.py assembles organelle genomes
  from genome skimming data.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: anti_seed
    type:
      - 'null'
      - File
    doc: Anti-seed(s). Not suggested unless what you really know what you are 
      doing. Input fasta format file as anti-seed, where the extension process 
      stop. Typically serves as excluding plastid reads when extending 
      mitochondrial reads, or the other way around. You should be cautious about
      using this option, because if the anti-seed includes some word in the 
      target but not in the seed, the result would have gaps. For example, use 
      the embplant_mt and embplant_pt from the same plant-species as seed and 
      anti-seed.
    inputBinding:
      position: 101
      prefix: -a
  - id: bowtie2_options
    type:
      - 'null'
      - string
    doc: "Bowtie2 options, such as '--ma 3 --mp 5,2 --very-fast -t'. Default: --very-fast
      -t."
    inputBinding:
      position: 101
      prefix: --bowtie2-options
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: "The directory where the configuration file and default databases were placed.
      The default value also can be changed by adding 'export GETORG_PATH=your_favor'
      to the shell script (e.g. ~/.bash_profile or ~/.bashrc) Default: /root/.GetOrganelle"
    inputBinding:
      position: 101
      prefix: --config-dir
  - id: contamination_depth
    type:
      - 'null'
      - float
    doc: 'Depth factor for confirming contamination in parallel contigs. Default:
      3.0'
    inputBinding:
      position: 101
      prefix: --contamination-depth
  - id: contamination_similarity
    type:
      - 'null'
      - float
    doc: 'Similarity threshold for confirming contaminating contigs. Default: 0.9'
    inputBinding:
      position: 101
      prefix: --contamination-similarity
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: Several check points based on files produced, rather than on the log 
      file, so keep in mind that this script will NOT detect the difference 
      between this input parameters and the previous ones.
    inputBinding:
      position: 101
      prefix: --continue
  - id: degenerate_depth
    type:
      - 'null'
      - float
    doc: 'Depth factor for confirming parallel contigs. Default: 1.5'
    inputBinding:
      position: 101
      prefix: --degenerate-depth
  - id: degenerate_similarity
    type:
      - 'null'
      - float
    doc: 'Similarity threshold for confirming parallel contigs. Default: 0.98'
    inputBinding:
      position: 101
      prefix: --degenerate-similarity
  - id: disentangle_df
    type:
      - 'null'
      - float
    doc: 'Depth factor for differentiate genome type of contigs. The genome type of
      contigs are determined by blast. Default: 10.0'
    inputBinding:
      position: 101
      prefix: --disentangle-df
  - id: disentangle_time_limit
    type:
      - 'null'
      - int
    doc: 'Time limit (second) for each try of disentangling a graph file as a circular
      genome. Disentangling a graph as contigs is not limited. Default: 1800'
    inputBinding:
      position: 101
      prefix: --disentangle-time-limit
  - id: exclude_genes
    type:
      - 'null'
      - File
    doc: This is optional and Not suggested, since non-target contigs could 
      contribute information for better downstream coverage-based clustering. 
      Followed with a customized database (a fasta file or the base name of a 
      blast database) containing or made of protein coding genes and ribosomal 
      RNAs extracted from reference genome(s) that you want to exclude. Could be
      a list of databases split by comma(s) but NOT required to have the same 
      list length to organelle_type (followed by '-F'). The default value will 
      become invalid when '--genes' or '--ex-genes' is used.
    inputBinding:
      position: 101
      prefix: --ex-genes
  - id: expected_max_size
    type:
      - 'null'
      - string
    doc: "Expected maximum target genome size(s) for disentangling. Should be a list
      of INTEGER numbers split by comma(s) on a multi-organelle mode, with the same
      list length to organelle_type (followed by '-F'). Default: 250000 (-F embplant_pt/fungus_mt),
      25000 (-F embplant_nr/animal_mt/fungus_nr), 1000000 (-F embplant_mt/other_pt),1000000,1000000,250000
      (-F other_pt,embplant_mt,fungus_mt)"
    inputBinding:
      position: 101
      prefix: --expected-max-size
  - id: expected_min_size
    type:
      - 'null'
      - string
    doc: "Expected minimum target genome size(s) for disentangling. Should be a list
      of INTEGER numbers split by comma(s) on a multi-organelle mode, with the same
      list length to organelle_type (followed by '-F'). Default: 10000 for all."
    inputBinding:
      position: 101
      prefix: --expected-min-size
  - id: fast
    type:
      - 'null'
      - boolean
    doc: '"-R 10 -t 4 -J 5 -M 7 --max-n-words 3E7 --larger- auto-ws --disentangle-time-limit
      360" This option is suggested for homogeneously and highly covered data (very
      fine data). You can overwrite the value of a specific option listed above by
      adding that option along with the "--fast" flag. You could try GetOrganelle
      with this option for a list of samples and run a second time without this option
      for the rest with incomplete results.'
    inputBinding:
      position: 101
      prefix: --fast
  - id: flush_step
    type:
      - 'null'
      - string
    doc: 'Flush step (INTEGER OR INF) for presenting progress. For running in the
      background, you could set this to inf, which would disable this. Default: 54321'
    inputBinding:
      position: 101
      prefix: --flush-step
  - id: forward_reads
    type: File
    doc: 'Input file with forward paired-end reads (format: fastq/fastq.gz/fastq.tar.gz).'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: genes
    type:
      - 'null'
      - File
    doc: Followed with a customized database (a fasta file or the base name of a
      blast database) containing or made of ONE set of protein coding genes and 
      ribosomal RNAs extracted from ONE reference genome that you want to 
      assemble. Should be a list of databases split by comma(s) on a 
      multi-organelle mode, with the same list length to organelle_type 
      (followed by '-F'). This is optional for any organelle mentioned in '-F' 
      but required for 'anonym'. By default, certain database(s) in 
      /root/.GetOrganelle/LabelDatabase would be used contingent on the 
      organelle types chosen (-F). The default value become invalid when 
      '--genes' or '--ex- genes' is used.
    inputBinding:
      position: 101
      prefix: --genes
  - id: ignore_kmer_res
    type:
      - 'null'
      - int
    doc: 'A kmer threshold below which, no slimming/disentangling would be executed
      on the result. Default: 40'
    inputBinding:
      position: 101
      prefix: --ignore-k
  - id: index_in_memory
    type:
      - 'null'
      - boolean
    doc: Keep index in memory. Choose save index in memory than in disk.
    inputBinding:
      position: 101
      prefix: --index-in-memory
  - id: jump_step
    type:
      - 'null'
      - int
    doc: 'The length of step for checking words in reads during extending process
      (integer >= 1). When you have reads of high quality, the larger the number is,
      the faster the extension will be, the more risk of missing reads in low coverage
      area. Choose 1 to choose the slowest but safest extension strategy. Default:
      3'
    inputBinding:
      position: 101
      prefix: -J
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Choose to keep the running temp/index files.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: larger_auto_ws
    type:
      - 'null'
      - boolean
    doc: By using this flag, the empirical function for estimating W would tend 
      to produce a relative larger W, which would speed up the matching in 
      extending, reduce the memory cost in extending, but increase the risk of 
      broken final graph. Suggested when the data is good with high and 
      homogenous coverage.
    inputBinding:
      position: 101
      prefix: --larger-auto-ws
  - id: max_extending_len
    type:
      - 'null'
      - string
    doc: "Maximum extending length(s) derived from the seed(s). A single value could
      be a non-negative number, or inf (infinite) or auto (automatic estimation).
      This is designed for properly stopping the extending from getting too long and
      saving computational resources. However, empirically, a maximum extending length
      value larger than 6000 would not be helpful for saving computational resources.
      This value would not be precise in controlling output size, especially when
      pre-group (followed by '-P') is turn on.In the auto mode, the maximum extending
      length is estimated based on the sizes of the gap regions that not covered in
      the seed sequences. A sequence of a closely related species would be preferred
      for estimating a better maximum extending length value. If you are using limited
      loci, e.g. rbcL gene as the seed for assembling the whole plastome (with extending
      length ca. 75000 >> 6000), you should set maximum extending length to inf. Should
      be a list of numbers/auto/inf split by comma(s) on a multi-organelle mode, with
      the same list length to organelle_type (followed by '-F'). Default: inf."
    inputBinding:
      position: 101
      prefix: --max-extending-len
  - id: max_ignore_percent
    type:
      - 'null'
      - float
    doc: 'The maximum percent of bases to be ignore in extension, due to low quality.
      Default: 0.01'
    inputBinding:
      position: 101
      prefix: --max-ignore-percent
  - id: max_n_words
    type:
      - 'null'
      - string
    doc: 'Maximum number of words to be used in total.Default: 4E8 (-F embplant_pt),
      2E8 (-F embplant_nr/fungus_mt/fungus_nr/animal_mt), 2E9 (-F embplant_mt/other_pt)'
    inputBinding:
      position: 101
      prefix: --max-n-words
  - id: max_paths_num
    type:
      - 'null'
      - int
    doc: 'Repeats would dramatically increase the number of potential isomers (paths).
      This option was used to export a certain amount of paths out of all possible
      paths per assembly graph. Default: 1000'
    inputBinding:
      position: 101
      prefix: --max-paths-num
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'Hard bound for maximum number of reads to be used per file. A input larger
      than 536870911 will be treated as infinity (INF). Default: 1.5E7 (-F embplant_pt/embplant_nr/fungus_mt/fungus_nr);
      7.5E7 (-F embplant_mt/other_pt/anonym); 3E8 (-F animal_mt)'
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: max_rounds
    type:
      - 'null'
      - string
    doc: 'Maximum number of extending rounds (suggested: >=2). Default: 15 (-F embplant_pt),
      30 (-F embplant_mt/other_pt), 10 (-F embplant_nr/animal_mt/fungus_mt/fungus_nr),
      inf (-P 0).'
    inputBinding:
      position: 101
      prefix: --max-rounds
  - id: memory_save
    type:
      - 'null'
      - boolean
    doc: "\"--out-per-round -P 0 --remove-duplicates 0\" You can overwrite the value
      of a specific option listed above by adding that option along with the \"--memory-save\"\
      \ flag. A larger '-R' value is suggested when \"--memory- save\" is chosen."
    inputBinding:
      position: 101
      prefix: --memory-save
  - id: memory_unlimited
    type:
      - 'null'
      - boolean
    doc: '"-P 1E7 --index-in-memory --remove-duplicates 2E8 --min-quality-score -5
      --max-ignore-percent 0" You can overwrite the value of a specific option listed
      above by adding that option along with the "--memory- unlimited" flag.'
    inputBinding:
      position: 101
      prefix: --memory-unlimited
  - id: mesh_size
    type:
      - 'null'
      - int
    doc: '(Beta parameter) The length of step for building words from seeds during
      extending process (integer >= 1). When you have reads of high quality, the larger
      the number is, the faster the extension will be, the more risk of missing reads
      in low coverage area. Another usage of this mesh size is to choose a larger
      mesh size coupled with a smaller word size, which makes smaller word size feasible
      when memory is limited.Choose 1 to choose the slowest but safest extension strategy.
      Default: 2'
    inputBinding:
      position: 101
      prefix: -M
  - id: min_quality_score
    type:
      - 'null'
      - int
    doc: "Minimum quality score in extension. This value would be automatically decreased
      to prevent ignoring too much raw data (see --max-ignore-percent).Default: 1
      ('\"' in Phred+33; 'A' in Phred+64/Solexa+64)"
    inputBinding:
      position: 101
      prefix: --min-quality-score
  - id: no_degenerate
    type:
      - 'null'
      - boolean
    doc: Disable making consensus from parallel contig based on nucleotide 
      degenerate table.
    inputBinding:
      position: 101
      prefix: --no-degenerate
  - id: no_spades
    type:
      - 'null'
      - boolean
    doc: Disable SPAdes.
    inputBinding:
      position: 101
      prefix: --no-spades
  - id: organelle_type
    type:
      - 'null'
      - string
    doc: "This flag should be followed with embplant_pt (embryophyta plant plastome),
      other_pt (non-embryophyta plant plastome), embplant_mt (plant mitogenome), embplant_nr
      (plant nuclear ribosomal RNA), animal_mt (animal mitogenome), fungus_mt (fungus
      mitogenome), fungus_nr (fungus nuclear ribosomal RNA)or embplant_mt,other_pt,fungus_mt
      (the combination of any of above organelle genomes split by comma(s), which
      might be computationally more intensive than separate runs), or anonym (uncertain
      organelle genome type). The anonym should be used with customized seed and label
      databases ('-s' and '--genes'). For easy usage and compatibility of old versions,
      following redirection would be automatically fulfilled without warning: plant_cp->embplant_pt;
      plant_pt->embplant_pt; plant_mt->embplant_mt; plant_nr->embplant_nr"
    inputBinding:
      position: 101
      prefix: -F
  - id: out_per_round
    type:
      - 'null'
      - boolean
    doc: Enable output per round. Choose to save memory but cost more time per 
      round.
    inputBinding:
      position: 101
      prefix: --out-per-round
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous file if existed.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: phred_offset
    type:
      - 'null'
      - string
    doc: 'Phred offset for spades-hammer. Default: GetOrganelle-autodetect'
    inputBinding:
      position: 101
      prefix: --phred-offset
  - id: pre_group_word_size
    type:
      - 'null'
      - string
    doc: 'Word size (W) for pre-grouping. Used to reproduce result when word size
      is a certain value during pregrouping process and later changed during reads
      extending process. Similar to word size. Default: the same to word size.'
    inputBinding:
      position: 101
      prefix: --pre-w
  - id: pre_grouped
    type:
      - 'null'
      - string
    doc: The maximum number (integer) of high-covered reads to be pre-grouped 
      before extending process. pre_grouping is suggested when the whole genome 
      coverage is shallow but the organ genome coverage is deep. The default 
      value is 2E5. For personal computer with 8G memory, we suggest no more 
      than 3E5. A larger number (ex. 6E5) would run faster but exhaust memory in
      the first few minutes. Choose 0 to disable this process.
    inputBinding:
      position: 101
      prefix: -P
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add extra prefix to resulting files under the output directory.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Default: 12345'
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: reduce_reads_for_coverage
    type:
      - 'null'
      - float
    doc: 'Soft bound for maximum number of reads to be used according to target-hitting
      base coverage. If the estimated target-hitting base coverage is too high and
      over this VALUE, GetOrganelle automatically reduce the number of reads to generate
      a final assembly with base coverage close to this VALUE. This design could greatly
      save computational resources in many situations. A mean base coverage over 500
      is extremely sufficient for most cases. This VALUE must be larger than 10. Set
      this VALUE to inf to disable reducing. Default: 500.'
    inputBinding:
      position: 101
      prefix: --reduce-reads-for-coverage
  - id: remove_duplicates
    type:
      - 'null'
      - string
    doc: 'By default this script use unique reads to extend. Choose the number of
      duplicates (integer) to be saved in memory. A larger number (ex. 2E7) would
      run faster but exhaust memory in the first few minutes. Choose 0 to disable
      this process. Note that whether choose or not will not disable the calling of
      replicate reads. Default: 10000000.0.'
    inputBinding:
      position: 101
      prefix: --remove-duplicates
  - id: reverse_lsc
    type:
      - 'null'
      - boolean
    doc: For '-F embplant_pt' with complete circular result, by default, the 
      direction of the starting contig (usually the LSC region) is determined as
      the direction with less ORFs. Choose this option to reverse the direction 
      of the starting contig when result is circular. Actually, both directions 
      are biologically equivalent to each other. The reordering of the direction
      is only for easier downstream analysis.
    inputBinding:
      position: 101
      prefix: --reverse-lsc
  - id: reverse_reads
    type: File
    doc: 'Input file with reverse paired-end reads (format: fastq/fastq.gz/fastq.tar.gz).'
    inputBinding:
      position: 101
      prefix: '-2'
  - id: seed_file
    type:
      - 'null'
      - File
    doc: "Seed sequence(s). Input fasta format file as initial seed. A seed sequence
      in GetOrganelle is only used for identifying initial organelle reads. The assembly
      process is purely de novo. Should be a list of files split by comma(s) on a
      multi-organelle mode, with the same list length to organelle_type (followed
      by '-F'). Default: '/root/.GetOrganelle/SeedDatabase/*.fasta' (* depends on
      the value followed with flag '-F')"
    inputBinding:
      position: 101
      prefix: -s
  - id: spades_kmer
    type:
      - 'null'
      - string
    doc: 'SPAdes kmer settings. Use the same format as in SPAdes. illegal kmer values
      would be automatically discarded by GetOrganelle. Default: 21,55,85,115'
    inputBinding:
      position: 101
      prefix: -k
  - id: spades_options
    type:
      - 'null'
      - string
    doc: Other SPAdes options. Use double quotation marks to include all the 
      arguments and parameters.
    inputBinding:
      position: 101
      prefix: --spades-options
  - id: target_genome_size
    type:
      - 'null'
      - string
    doc: "Hypothetical value(s) of target genome size. This is only used for estimating
      word size when no '-w word_size' is given. Should be a list of INTEGER numbers
      split by comma(s) on a multi-organelle mode, with the same list length to organelle_type
      (followed by '-F'). Default: 130000 (-F embplant_pt) or 390000 (-F embplant_mt)
      or 13000 (-F embplant_nr) or 39000 (-F other_pt) or 13000 (-F animal_mt) or
      65000 (-F fungus_mt) or 13000 (-F fungus_nr) or 39000,390000,65000 (-F other_pt,embplant_mt,fungus_mt)"
    inputBinding:
      position: 101
      prefix: --target-genome-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads to use.
    inputBinding:
      position: 101
      prefix: -t
  - id: unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input file(s) with unpaired (single-end) reads (format: fastq/fastq.gz/fastq.tar.gz).
      files could be comma-separated lists such as 'seq1.fq,seq2.fq'."
    inputBinding:
      position: 101
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output. Choose to enable verbose running log_handler.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: which_bandage
    type:
      - 'null'
      - string
    doc: 'Assign the path to bandage binary file if not added to the path. Default:
      try $PATH'
    inputBinding:
      position: 101
      prefix: --which-bandage
  - id: which_blast
    type:
      - 'null'
      - string
    doc: 'Assign the path to BLAST binary files if not added to the path. Default:
      try "/usr/local/lib/python3.10/site- packages/GetOrganelleDep/linux/ncbi-blast"
      first, then $PATH'
    inputBinding:
      position: 101
      prefix: --which-blast
  - id: which_bowtie2
    type:
      - 'null'
      - string
    doc: 'Assign the path to Bowtie2 binary files if not added to the path. Default:
      try "/usr/local/lib/python3.10/site- packages/GetOrganelleDep/linux/bowtie2"
      first, then $PATH'
    inputBinding:
      position: 101
      prefix: --which-bowtie2
  - id: which_spades
    type:
      - 'null'
      - string
    doc: 'Assign the path to SPAdes binary files if not added to the path. Default:
      try "/usr/local/lib/python3.10/site- packages/GetOrganelleDep/linux/SPAdes"
      first, then $PATH'
    inputBinding:
      position: 101
      prefix: --which-spades
  - id: word_size
    type:
      - 'null'
      - string
    doc: "Word size (W) for pre-grouping (if not assigned by '-- pre-w') and extending
      process. This script would try to guess (auto-estimate) a proper W using an
      empirical function based on average read length, reads quality, target genome
      coverage, and other variables that might influence the extending process. You
      could assign the ratio (1>input>0) of W to read_length, based on which this
      script would estimate the W for you; or assign an absolute W value (read length>input>=35).
      Default: auto-estimated."
    inputBinding:
      position: 101
      prefix: -w
  - id: zip_files
    type:
      - 'null'
      - boolean
    doc: Choose to compress fq/sam files using gzip.
    inputBinding:
      position: 101
      prefix: --zip-files
outputs:
  - id: output_base
    type: Directory
    doc: Output directory. Overwriting files if directory exists.
    outputBinding:
      glob: $(inputs.output_base)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
