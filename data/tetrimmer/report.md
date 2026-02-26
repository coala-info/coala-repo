# tetrimmer CWL Generation Report

## tetrimmer_TEtrimmer

### Tool Description
TEtrimmer is designed to automate the manual curation of transposable elements (TEs).

### Metadata
- **Docker Image**: quay.io/biocontainers/tetrimmer:1.6.2--hdfd78af_0
- **Homepage**: https://github.com/qjiangzhao/TETrimmer.git
- **Package**: https://anaconda.org/channels/bioconda/packages/tetrimmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tetrimmer/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/qjiangzhao/TETrimmer
- **Stars**: N/A
### Original Help Text
```text
Usage: TEtrimmer.py [OPTIONS]

  ##########################################################################################
  
   ████████\ ████████\ ██\               ██\
   \__██  __|██  _____|██ |              \__|
      ██ |   ██ |    ██████\    ██████\  ██\ ██████\████\  ██████\████\   ██████\   ██████\
      ██ |   █████\  \_██  _|  ██  __██\ ██ |██  _██  _██\ ██  _██  _██\ ██  __██\ ██  __██\
      ██ |   ██  __|   ██ |    ██ |  \__|██ |██ / ██ / ██ |██ / ██ / ██ |████████ |██ |  \__|
      ██ |   ██ |      ██ |██\ ██ |      ██ |██ | ██ | ██ |██ | ██ | ██ |██   ____|██ |
      ██ |   ████████\ \████  |██ |      ██ |██ | ██ | ██ |██ | ██ | ██ |\███████\ ██ |
      \__|   \________| \____/ \__|      \__|\__| \__| \__|\__| \__| \__| \_______|\__|

   Version: 1.6.2

   Github: https://github.com/qjiangzhao/TEtrimmer

   Developers:

   Jiangzhao Qian;      RWTH Aachen University;                Email:
   jqian@bio1.rwth-aachen.de

   Hang Xue;            University of California, Berkeley;    Email:
   hang_xue@berkeley.edu

   Stefan Kusch;        Research Center Juelich;               Email:
   s.kusch@fz-juelich.de

   Funding source:  Ralph Panstruga Lab; RWTH Aachen University;
   Email: panstruga@bio1.rwth-aachen.de  Website: https://www.bio1.rwth-
   aachen.de/PlantMolCellBiology/index.html

   ###########################################################################
   ###############

   python ./path_to_TEtrimmer_folder/TEtrimmer.py -i <TE_consensus_file> -g
   <genome_file>

   TEtrimmer is designed to automate the manual curation of transposable
   elements (TEs).

   Two mandatory arguments are required, including  <genome file>, the genome
   FASTA file, and  <TE consensus file> from TE discovery software like
   RepeatModeler, EDTA, or REPET.  TEtrimmer can do BLAST, sequence extension,
   multiple sequence alignment (MSA), MSA clustering,  MSA cleaning, TE
   boundaries definition, and MSA visualization.

Options:
  -i, --input_file TEXT           Path to TE consensus library file (FASTA
                                  format). Use the output from RepeatModeler,
                                  EDTA, REPET, et al.  [required]
  -g, --genome_file TEXT          Path to genome FASTA file (FASTA format).
                                  [required]
  -o, --output_dir TEXT           Path to output directory. Default: current
                                  working directory.
  -s, --preset [conserved|divergent]
                                  Choose one preset config (conserved or
                                  divergent).
  -t, --num_threads INTEGER       Thread number used for TEtrimmer. Default: 1
  --classify_unknown              Use RepeatClassifier to classify the
                                  consensus sequence if the input sequence is
                                  not classified or is unknown or the
                                  processed sequence length by TEtrimmer is
                                  2000 bp longer or shorter than the query
                                  sequence.
  --classify_all                  Use RepeatClassifier to classify every
                                  consensus sequence. WARNING: This may take a
                                  long time.
  -ca, --continue_analysis        Continue from previous unfinished TEtrimmer
                                  run and would use the same output directory.
  --dedup                         Remove duplicate sequences in the input
                                  file.
  --curatedlib TEXT               Path to manually curated high-quality TE
                                  consensus library file. TEtrimmer eliminates
                                  TE consensus sequence from "--input_file" if
                                  the sequence shares more than 95% identity
                                  with sequences from "--curatedlib".
  -ga, --genome_anno              Perform genome TE annotation using
                                  RepeatMasker with the TEtrimmer curated TE
                                  libraries.
  --hmm                           Generate HMM files for each processed
                                  consensus sequence.
  --debug                         debug mode. This will keep all raw files.
                                  WARNING: Many files will be generated.
  --fast_mode                     Reduce running time at the cost of lower
                                  accuracy and specificity.
  -pd, --pfam_dir TEXT            Pfam database directory. TEtrimmer checks
                                  the existence of Pfam database in the
                                  provided path and downloads it automatically
                                  when it is not found. By default, Pfam will
                                  be downloaded to TEtrimmer source code
                                  folder. For "singularity" user, please use
                                  this option to define a local path,
                                  TEtrimmer will download the database to the
                                  provided path if Pfam database is not found.
                                  If the automatic download fails, you
                                  candownload Pfam database by yourself.
  --cons_thr FLOAT                Threshold used to generate final consensus
                                  sequences from MSAs. Default: 0.8
  --mini_orf INTEGER              Define the minimum ORF length to be
                                  predicted by TEtrimmer. Default: 200
  --max_msa_lines INTEGER         Set the maximum number of sequences to be
                                  included in a multiple sequence alignment.
                                  Default: 100
  --top_msa_lines INTEGER         If the sequence number of multiple sequence
                                  alignment (MSA) is greater than
                                  <max_msa_lines>, TEtrimmer will first sort
                                  sequences by length and choose
                                  <top_msa_lines> number of sequences. Then,
                                  TEtrimmer will randomly select sequences
                                  from all remaining BLAST hits until
                                  <max_msa_lines>sequences are found for the
                                  multiple sequence alignment. Default: 100
  --min_seq_num INTEGER           The minimum blast hit number required for
                                  the input sequence. We do not recommend
                                  decreasing this number. Default: 10
  --min_blast_len INTEGER         The minimum sequence length for blast hits
                                  to be included for further analysis.
                                  Default: 50 for SINE and MITE; 150 for
                                  others
  --max_cluster_num INTEGER       The maximum number of clusters assigned in
                                  each multiple sequence alignment. Each
                                  multiple sequence alignment can be grouped
                                  into different clusters based on alignment
                                  patterns WARNING: using a larger number will
                                  potentially result in more accurate
                                  consensus results but will also increase the
                                  running time. Default: 5
  --ext_thr FLOAT                 The threshold to call “N” at a position. For
                                  example, if the most conserved nucleotide in
                                  a MSA columnhas proportion smaller than
                                  <ext_thr>, a “N” will be called at this
                                  position. Used with <ext_check_win>. The
                                  lower the value of <ext_thr>, the more
                                  likely to get longer the extensions on both
                                  ends. You can try reducing <ext_thr> if
                                  TEtrimmer fails to find full-length TEs.
                                  Default: 0.7
  --ext_check_win INTEGER         the check windows size during defining start
                                  and end of the consensus sequence based on
                                  the multiple sequence alignment. Used with
                                  <ext_thr>. If <ext_check_win> bp at the end
                                  of multiple sequence alignment has “N”
                                  present (ie. positions have similarity
                                  proportion smaller than <ext_thr>), the
                                  extension will stop, which defines the edge
                                  of the consensus sequence. Default: 150
  --ext_step INTEGER              the number of nucleotides to be added to the
                                  left and right ends of the multiple sequence
                                  alignment in each extension step. TE_Trimmer
                                  will iteratively add <ext_step> nucleotides
                                  until finding the TE boundary or reaching
                                  <max_ext>. Default: 1000
  --max_ext INTEGER               The maximum extension in nucleotides at each
                                  ends of the multiple sequence alignment.
                                  Default: 7000
  --gap_thr FLOAT                 If a single column in the multiple sequence
                                  alignment has a gap proportion larger than
                                  <gap_thr> and the proportion of the most
                                  common nucleotide in this column is less
                                  than <gap_nul_thr>, this column will be
                                  removed from the consensus. Default: 0.4
  --gap_nul_thr FLOAT             The nucleotide proportion threshold for
                                  keeping the column of the multiple sequence
                                  alignment. Used with the <gap_thr> option.
                                  i.e. if this column has <40% gap and the
                                  portion of T (or any other) nucleotide is
                                  >70% in this particular column, this column
                                  will be kept. Default: 0.7
  --crop_end_div_thr FLOAT        The crop end by divergence function will
                                  convert each nucleotide in the multiple
                                  sequence alignment into a proportion value.
                                  This function will iteratively choose a
                                  sliding window from each end of each
                                  sequence of the MSA and sum up the
                                  proportion numbers in this window. The
                                  cropping will continue until the sum of
                                  proportions is larger than
                                  <--crop_end_div_thr>. Cropped nucleotides
                                  will be converted to -. Default: 0.7
  --crop_end_div_win INTEGER      Window size used for the end-cropping
                                  process. Used with the <--crop_end_div_thr>
                                  option. Default: 40
  --crop_end_gap_thr FLOAT        The crop end by gap function will
                                  iteratively choose a sliding window from
                                  each end of each sequence of the MSA and
                                  calculate the gap proportion in this window.
                                  The cropping will continue until the sum of
                                  gap proportions is smaller than
                                  <--crop_end_gap_thr>. Cropped nucleotides
                                  will be converted to -. Default: 0.1
  --crop_end_gap_win INTEGER      Define window size used to crop end by gap.
                                  Used with the <--crop_end_gap_thr> option.
                                  Default: 250
  --ltr_start_patterns TEXT       LTR elements always start with a conserved
                                  sequence pattern. TEtrimmer searches the
                                  beginning of the consensus sequence for
                                  these patterns. If the pattern is not found,
                                  TEtrimmer will extend the search of
                                  <--ltr_start_patterns> from -15 to +15
                                  nucleotides of the beginning of the
                                  consensus sequence and redefine the start of
                                  the consensus sequence if the pattern is
                                  found. Note: The user can provide multiple
                                  LTR start patterns in a comma-separated
                                  list, like: TG,TA,TC (no spaces; the order
                                  of patterns determines the priority for the
                                  search). Default: TG
  --ltr_end_patterns TEXT         LTR elements always end with a conserved
                                  sequence pattern. TEtrimmer searches the end
                                  of the consensus sequence for these
                                  patterns. If the pattern is not found,
                                  TEtrimmer will extend the search of
                                  <--ltr_end_patterns> from -15 to +15
                                  nucleotides of the end of the consensus
                                  sequence and redefine the end of the
                                  consensus sequence if the pattern is found.
                                  Note: The user can provide multiple LTR end
                                  patterns in a comma-separated list, like:
                                  CA,TA,GA (no spaces; the order of patterns
                                  determines the priority for the search).
                                  Default: CA
  --helitron_start_patterns TEXT  Helitron elements could start with a
                                  conserved sequence pattern. TEtrimmer
                                  searches the beginning of the consensus
                                  sequence for these patterns. If the pattern
                                  is not found, TEtrimmer will extend the
                                  search of <--helitron_start_patterns> from
                                  -15 to +15 nucleotides of the beginning of
                                  the consensus sequence and redefine the
                                  start of the consensus sequence if the
                                  pattern is found. Note: The user can provide
                                  multiple Helitron start patterns in a comma-
                                  separated list, like: ATC,ATT (no spaces;
                                  the order of patterns determines the
                                  priority for the search). If the identified
                                  pattern begins with the nucleotide "A", this
                                  "A" will be removed from the final consensus
                                  sequence. Default: ATC
  --helitron_end_patterns TEXT    LTR elements always end with a conserved
                                  sequence pattern. TEtrimmer searches the end
                                  of the consensus sequence for these
                                  patterns. If the pattern is not found,
                                  TEtrimmer will extend the search of
                                  <--helitron_end_patterns> from -15 to +15
                                  nucleotides of the end of the consensus
                                  sequence and redefine the end of the
                                  consensus sequence if the pattern is found.
                                  Note: The user can provide multiple Helitron
                                  end patterns in a comma-separated list,
                                  like: CTAAT，CTAGT，CTGAT (no spaces; the
                                  order of patterns determines the priority
                                  for the search). If the identified pattern
                                  end with the nucleotide "T", this "T" will
                                  be removed from the final consensus
                                  sequence.Default:CTAAT，CTAGT，CTGAT，CTGGT
                                  (CTRRT)
  --poly_patterns TEXT            The 3' end of LINE and SINE elements often
                                  contains characteristic sequences such as
                                  poly(A), poly(T), or short tandem repeats.
                                  TEtrimmer identifies the presence of those
                                  feature sequences to help to define the 3'
                                  end boundary of LINE or SINE elements. You
                                  can provide multiple end patterns in a
                                  comma-separate list, like: A,T,TA (No space;
                                  the order of patterns determines the
                                  priority for the search). Default: A
  --poly_len INTEGER              Define the minimum length requirement of the
                                  poly pattern from the parameter
                                  --poly_patterns. Default: 10
  --define_perfect INTEGER        Define the minimum copy number that the
                                  output TE consensus sequence can be
                                  evaluated as "Perfect". Default: 30
  --export_coverage               Export the genome blast coverage file.
  -l, --logfile TEXT              Path to log file.
  -ll, --loglevel TEXT            Log level. [INFO, WARNING, ERROR, CRITICAL]
  --version                       Show the version and exit.
  --help                          Show this message and exit.
```

