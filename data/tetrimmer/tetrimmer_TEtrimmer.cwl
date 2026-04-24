cwlVersion: v1.2
class: CommandLineTool
baseCommand: TEtrimmer.py
label: tetrimmer_TEtrimmer
doc: "TEtrimmer is designed to automate the manual curation of transposable elements
  (TEs).\n\nTool homepage: https://github.com/qjiangzhao/TETrimmer.git"
inputs:
  - id: classify_all
    type:
      - 'null'
      - boolean
    doc: 'Use RepeatClassifier to classify every consensus sequence. WARNING: This
      may take a long time.'
    inputBinding:
      position: 101
      prefix: --classify_all
  - id: classify_unknown
    type:
      - 'null'
      - boolean
    doc: Use RepeatClassifier to classify the consensus sequence if the input 
      sequence is not classified or is unknown or the processed sequence length 
      by TEtrimmer is 2000 bp longer or shorter than the query sequence.
    inputBinding:
      position: 101
      prefix: --classify_unknown
  - id: cons_thr
    type:
      - 'null'
      - float
    doc: Threshold used to generate final consensus sequences from MSAs.
    inputBinding:
      position: 101
      prefix: --cons_thr
  - id: continue_analysis
    type:
      - 'null'
      - boolean
    doc: Continue from previous unfinished TEtrimmer run and would use the same 
      output directory.
    inputBinding:
      position: 101
      prefix: --continue_analysis
  - id: crop_end_div_thr
    type:
      - 'null'
      - float
    doc: The crop end by divergence function will convert each nucleotide in the
      multiple sequence alignment into a proportion value. This function will 
      iteratively choose a sliding window from each end of each sequence of the 
      MSA and sum up the proportion numbers in this window. The cropping will 
      continue until the sum of proportions is larger than <--crop_end_div_thr>.
      Cropped nucleotides will be converted to -.
    inputBinding:
      position: 101
      prefix: --crop_end_div_thr
  - id: crop_end_div_win
    type:
      - 'null'
      - int
    doc: Window size used for the end-cropping process. Used with the 
      <--crop_end_div_thr> option.
    inputBinding:
      position: 101
      prefix: --crop_end_div_win
  - id: crop_end_gap_thr
    type:
      - 'null'
      - float
    doc: The crop end by gap function will iteratively choose a sliding window 
      from each end of each sequence of the MSA and calculate the gap proportion
      in this window. The cropping will continue until the sum of gap 
      proportions is smaller than <--crop_end_gap_thr>. Cropped nucleotides will
      be converted to -.
    inputBinding:
      position: 101
      prefix: --crop_end_gap_thr
  - id: crop_end_gap_win
    type:
      - 'null'
      - int
    doc: Define window size used to crop end by gap. Used with the 
      <--crop_end_gap_thr> option.
    inputBinding:
      position: 101
      prefix: --crop_end_gap_win
  - id: curatedlib
    type:
      - 'null'
      - File
    doc: Path to manually curated high-quality TE consensus library file. 
      TEtrimmer eliminates TE consensus sequence from "--input_file" if the 
      sequence shares more than 95% identity with sequences from "--curatedlib".
    inputBinding:
      position: 101
      prefix: --curatedlib
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'debug mode. This will keep all raw files. WARNING: Many files will be generated.'
    inputBinding:
      position: 101
      prefix: --debug
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: Remove duplicate sequences in the input file.
    inputBinding:
      position: 101
      prefix: --dedup
  - id: define_perfect
    type:
      - 'null'
      - int
    doc: Define the minimum copy number that the output TE consensus sequence 
      can be evaluated as "Perfect".
    inputBinding:
      position: 101
      prefix: --define_perfect
  - id: export_coverage
    type:
      - 'null'
      - boolean
    doc: Export the genome blast coverage file.
    inputBinding:
      position: 101
      prefix: --export_coverage
  - id: ext_check_win
    type:
      - 'null'
      - int
    doc: the check windows size during defining start and end of the consensus 
      sequence based on the multiple sequence alignment. Used with <ext_thr>. If
      <ext_check_win> bp at the end of multiple sequence alignment has “N” 
      present (ie. positions have similarity proportion smaller than <ext_thr>),
      the extension will stop, which defines the edge of the consensus sequence.
    inputBinding:
      position: 101
      prefix: --ext_check_win
  - id: ext_step
    type:
      - 'null'
      - int
    doc: the number of nucleotides to be added to the left and right ends of the
      multiple sequence alignment in each extension step. TE_Trimmer will 
      iteratively add <ext_step> nucleotides until finding the TE boundary or 
      reaching <max_ext>.
    inputBinding:
      position: 101
      prefix: --ext_step
  - id: ext_thr
    type:
      - 'null'
      - float
    doc: The threshold to call “N” at a position. For example, if the most 
      conserved nucleotide in a MSA columnhas proportion smaller than <ext_thr>,
      a “N” will be called at this position. Used with <ext_check_win>. The 
      lower the value of <ext_thr>, the more likely to get longer the extensions
      on both ends. You can try reducing <ext_thr> if TEtrimmer fails to find 
      full-length TEs.
    inputBinding:
      position: 101
      prefix: --ext_thr
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: Reduce running time at the cost of lower accuracy and specificity.
    inputBinding:
      position: 101
      prefix: --fast_mode
  - id: gap_nul_thr
    type:
      - 'null'
      - float
    doc: The nucleotide proportion threshold for keeping the column of the 
      multiple sequence alignment. Used with the <gap_thr> option. i.e. if this 
      column has <40% gap and the portion of T (or any other) nucleotide is >70%
      in this particular column, this column will be kept.
    inputBinding:
      position: 101
      prefix: --gap_nul_thr
  - id: gap_thr
    type:
      - 'null'
      - float
    doc: If a single column in the multiple sequence alignment has a gap 
      proportion larger than <gap_thr> and the proportion of the most common 
      nucleotide in this column is less than <gap_nul_thr>, this column will be 
      removed from the consensus.
    inputBinding:
      position: 101
      prefix: --gap_thr
  - id: genome_anno
    type:
      - 'null'
      - boolean
    doc: Perform genome TE annotation using RepeatMasker with the TEtrimmer 
      curated TE libraries.
    inputBinding:
      position: 101
      prefix: --genome_anno
  - id: genome_file
    type: File
    doc: Path to genome FASTA file (FASTA format).
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: helitron_end_patterns
    type:
      - 'null'
      - string
    doc: 'LTR elements always end with a conserved sequence pattern. TEtrimmer searches
      the end of the consensus sequence for these patterns. If the pattern is not
      found, TEtrimmer will extend the search of <--helitron_end_patterns> from -15
      to +15 nucleotides of the end of the consensus sequence and redefine the end
      of the consensus sequence if the pattern is found. Note: The user can provide
      multiple Helitron end patterns in a comma-separated list, like: CTAAT，CTAGT，CTGAT
      (no spaces; the order of patterns determines the priority for the search). If
      the identified pattern end with the nucleotide "T", this "T" will be removed
      from the final consensus sequence.'
    inputBinding:
      position: 101
      prefix: --helitron_end_patterns
  - id: helitron_start_patterns
    type:
      - 'null'
      - string
    doc: 'Helitron elements could start with a conserved sequence pattern. TEtrimmer
      searches the beginning of the consensus sequence for these patterns. If the
      pattern is not found, TEtrimmer will extend the search of <--helitron_start_patterns>
      from -15 to +15 nucleotides of the beginning of the consensus sequence and redefine
      the start of the consensus sequence if the pattern is found. Note: The user
      can provide multiple Helitron start patterns in a comma-separated list, like:
      ATC,ATT (no spaces; the order of patterns determines the priority for the search).
      If the identified pattern begins with the nucleotide "A", this "A" will be removed
      from the final consensus sequence.'
    inputBinding:
      position: 101
      prefix: --helitron_start_patterns
  - id: hmm
    type:
      - 'null'
      - boolean
    doc: Generate HMM files for each processed consensus sequence.
    inputBinding:
      position: 101
      prefix: --hmm
  - id: input_file
    type: File
    doc: Path to TE consensus library file (FASTA format). Use the output from 
      RepeatModeler, EDTA, REPET, et al.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: logfile
    type:
      - 'null'
      - File
    doc: Path to log file.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Log level. [INFO, WARNING, ERROR, CRITICAL]
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: ltr_end_patterns
    type:
      - 'null'
      - string
    doc: 'LTR elements always end with a conserved sequence pattern. TEtrimmer searches
      the end of the consensus sequence for these patterns. If the pattern is not
      found, TEtrimmer will extend the search of <--ltr_end_patterns> from -15 to
      +15 nucleotides of the end of the consensus sequence and redefine the end of
      the consensus sequence if the pattern is found. Note: The user can provide multiple
      LTR end patterns in a comma-separated list, like: CA,TA,GA (no spaces; the order
      of patterns determines the priority for the search).'
    inputBinding:
      position: 101
      prefix: --ltr_end_patterns
  - id: ltr_start_patterns
    type:
      - 'null'
      - string
    doc: 'LTR elements always start with a conserved sequence pattern. TEtrimmer searches
      the beginning of the consensus sequence for these patterns. If the pattern is
      not found, TEtrimmer will extend the search of <--ltr_start_patterns> from -15
      to +15 nucleotides of the beginning of the consensus sequence and redefine the
      start of the consensus sequence if the pattern is found. Note: The user can
      provide multiple LTR start patterns in a comma-separated list, like: TG,TA,TC
      (no spaces; the order of patterns determines the priority for the search).'
    inputBinding:
      position: 101
      prefix: --ltr_start_patterns
  - id: max_cluster_num
    type:
      - 'null'
      - int
    doc: 'The maximum number of clusters assigned in each multiple sequence alignment.
      Each multiple sequence alignment can be grouped into different clusters based
      on alignment patterns WARNING: using a larger number will potentially result
      in more accurate consensus results but will also increase the running time.'
    inputBinding:
      position: 101
      prefix: --max_cluster_num
  - id: max_ext
    type:
      - 'null'
      - int
    doc: The maximum extension in nucleotides at each ends of the multiple 
      sequence alignment.
    inputBinding:
      position: 101
      prefix: --max_ext
  - id: max_msa_lines
    type:
      - 'null'
      - int
    doc: Set the maximum number of sequences to be included in a multiple 
      sequence alignment.
    inputBinding:
      position: 101
      prefix: --max_msa_lines
  - id: min_blast_len
    type:
      - 'null'
      - int
    doc: The minimum sequence length for blast hits to be included for further 
      analysis.
    inputBinding:
      position: 101
      prefix: --min_blast_len
  - id: min_seq_num
    type:
      - 'null'
      - int
    doc: The minimum blast hit number required for the input sequence. We do not
      recommend decreasing this number.
    inputBinding:
      position: 101
      prefix: --min_seq_num
  - id: mini_orf
    type:
      - 'null'
      - int
    doc: Define the minimum ORF length to be predicted by TEtrimmer.
    inputBinding:
      position: 101
      prefix: --mini_orf
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Thread number used for TEtrimmer.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: pfam_dir
    type:
      - 'null'
      - Directory
    doc: Pfam database directory. TEtrimmer checks the existence of Pfam 
      database in the provided path and downloads it automatically when it is 
      not found. By default, Pfam will be downloaded to TEtrimmer source code 
      folder. For "singularity" user, please use this option to define a local 
      path, TEtrimmer will download the database to the provided path if Pfam 
      database is not found. If the automatic download fails, you candownload 
      Pfam database by yourself.
    inputBinding:
      position: 101
      prefix: --pfam_dir
  - id: poly_len
    type:
      - 'null'
      - int
    doc: Define the minimum length requirement of the poly pattern from the 
      parameter --poly_patterns.
    inputBinding:
      position: 101
      prefix: --poly_len
  - id: poly_patterns
    type:
      - 'null'
      - string
    doc: "The 3' end of LINE and SINE elements often contains characteristic sequences
      such as poly(A), poly(T), or short tandem repeats. TEtrimmer identifies the
      presence of those feature sequences to help to define the 3' end boundary of
      LINE or SINE elements. You can provide multiple end patterns in a comma-separate
      list, like: A,T,TA (No space; the order of patterns determines the priority
      for the search)."
    inputBinding:
      position: 101
      prefix: --poly_patterns
  - id: preset
    type:
      - 'null'
      - string
    doc: Choose one preset config (conserved or divergent).
    inputBinding:
      position: 101
      prefix: --preset
  - id: top_msa_lines
    type:
      - 'null'
      - int
    doc: If the sequence number of multiple sequence alignment (MSA) is greater 
      than <max_msa_lines>, TEtrimmer will first sort sequences by length and 
      choose <top_msa_lines> number of sequences. Then, TEtrimmer will randomly 
      select sequences from all remaining BLAST hits until 
      <max_msa_lines>sequences are found for the multiple sequence alignment.
    inputBinding:
      position: 101
      prefix: --top_msa_lines
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetrimmer:1.6.2--hdfd78af_0
stdout: tetrimmer_TEtrimmer.out
