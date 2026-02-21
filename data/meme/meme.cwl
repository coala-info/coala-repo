cwlVersion: v1.2
class: CommandLineTool
baseCommand: meme
label: meme
doc: "A tool for discovering motifs in a group of related DNA or protein sequences.\n
  \nTool homepage: https://meme-suite.org"
inputs:
  - id: dataset
    type: File
    doc: file containing sequences in FASTA format
    inputBinding:
      position: 1
  - id: all_widths
    type:
      - 'null'
      - boolean
    doc: test starts of all widths from minw to maxw
    inputBinding:
      position: 102
      prefix: -allw
  - id: alphabet_file
    type:
      - 'null'
      - File
    doc: sequences use custom alphabet
    inputBinding:
      position: 102
      prefix: -alph
  - id: background_file
    type:
      - 'null'
      - File
    doc: name of background Markov model file
    inputBinding:
      position: 102
      prefix: -bfile
  - id: brief_output
    type:
      - 'null'
      - int
    doc: omit sites and sequence tables in output if more than <n> primary sequences
    inputBinding:
      position: 102
      prefix: -brief
  - id: ce_fraction
    type:
      - 'null'
      - float
    doc: fraction sequence length for CE region
    default: 0.25
    inputBinding:
      position: 102
      prefix: -cefrac
  - id: consensus_start
    type:
      - 'null'
      - string
    doc: consensus sequence to start EM from
    inputBinding:
      position: 102
      prefix: -cons
  - id: csites
    type:
      - 'null'
      - int
    doc: maximum number of sites for EM in Classic mode
    inputBinding:
      position: 102
      prefix: -csites
  - id: distance_criterion
    type:
      - 'null'
      - float
    doc: EM convergence criterion
    inputBinding:
      position: 102
      prefix: -distance
  - id: distribution_mode
    type:
      - 'null'
      - string
    doc: distribution of motifs (oops|zoops|anr)
    inputBinding:
      position: 102
      prefix: -mod
  - id: dna
    type:
      - 'null'
      - boolean
    doc: sequences use DNA alphabet
    inputBinding:
      position: 102
      prefix: -dna
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: stop if motif E-value greater than <evt>
    inputBinding:
      position: 102
      prefix: -evt
  - id: gap_extension_cost
    type:
      - 'null'
      - int
    doc: gap extension cost for multiple alignments
    inputBinding:
      position: 102
      prefix: -ws
  - id: gap_opening_cost
    type:
      - 'null'
      - int
    doc: gap opening cost for multiple alignments
    inputBinding:
      position: 102
      prefix: -wg
  - id: holdout_fraction
    type:
      - 'null'
      - float
    doc: fraction of primary sequences in holdout set
    default: 0.5
    inputBinding:
      position: 102
      prefix: -hsfrac
  - id: markov_order
    type:
      - 'null'
      - int
    doc: (maximum) order of Markov model to use or create
    inputBinding:
      position: 102
      prefix: -markov_order
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: maximum EM iterations to run
    inputBinding:
      position: 102
      prefix: -maxiter
  - id: max_sites
    type:
      - 'null'
      - int
    doc: maximum number of sites for each motif
    inputBinding:
      position: 102
      prefix: -maxsites
  - id: max_size
    type:
      - 'null'
      - int
    doc: maximum dataset size in characters
    inputBinding:
      position: 102
      prefix: -maxsize
  - id: max_width
    type:
      - 'null'
      - int
    doc: maximum motif width
    inputBinding:
      position: 102
      prefix: -maxw
  - id: min_sites
    type:
      - 'null'
      - int
    doc: minimum number of sites for each motif
    inputBinding:
      position: 102
      prefix: -minsites
  - id: min_width
    type:
      - 'null'
      - int
    doc: minimum motif width
    inputBinding:
      position: 102
      prefix: -minw
  - id: neg_dataset
    type:
      - 'null'
      - File
    doc: file containing control sequences
    inputBinding:
      position: 102
      prefix: -neg
  - id: no_end_gaps
    type:
      - 'null'
      - boolean
    doc: do not count end gaps in multiple alignments
    inputBinding:
      position: 102
      prefix: -noendgaps
  - id: no_matrim
    type:
      - 'null'
      - boolean
    doc: do not adjust motif width using multiple alignment
    inputBinding:
      position: 102
      prefix: -nomatrim
  - id: no_randomize
    type:
      - 'null'
      - boolean
    doc: do not randomize the order of the input sequences with -searchsize
    inputBinding:
      position: 102
      prefix: -norand
  - id: no_status
    type:
      - 'null'
      - boolean
    doc: do not print progress reports to terminal
    inputBinding:
      position: 102
      prefix: -nostatus
  - id: num_motifs
    type:
      - 'null'
      - int
    doc: maximum number of motifs to find
    inputBinding:
      position: 102
      prefix: -nmotifs
  - id: num_sites
    type:
      - 'null'
      - int
    doc: number of sites for each motif
    inputBinding:
      position: 102
      prefix: -nsites
  - id: objective_function
    type:
      - 'null'
      - string
    doc: objective function (classic|de|se|cd|ce)
    default: classic
    inputBinding:
      position: 102
      prefix: -objfun
  - id: pal
    type:
      - 'null'
      - boolean
    doc: force palindromes (requires -dna)
    inputBinding:
      position: 102
      prefix: -pal
  - id: prior_lib
    type:
      - 'null'
      - File
    doc: name of Dirichlet prior file
    inputBinding:
      position: 102
      prefix: -plib
  - id: prior_strength
    type:
      - 'null'
      - float
    doc: strength of the prior
    inputBinding:
      position: 102
      prefix: -b
  - id: prior_type
    type:
      - 'null'
      - string
    doc: type of prior to use (dirichlet|dmix|mega|megap|addone)
    inputBinding:
      position: 102
      prefix: -prior
  - id: processors
    type:
      - 'null'
      - int
    doc: use parallel version with <np> processors
    inputBinding:
      position: 102
      prefix: -p
  - id: protein
    type:
      - 'null'
      - boolean
    doc: sequences use protein alphabet
    inputBinding:
      position: 102
      prefix: -protein
  - id: psp_file
    type:
      - 'null'
      - File
    doc: name of positional priors file
    inputBinding:
      position: 102
      prefix: -psp
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: allow sites on + or - DNA strands
    inputBinding:
      position: 102
      prefix: -revcomp
  - id: rna
    type:
      - 'null'
      - boolean
    doc: sequences use RNA alphabet
    inputBinding:
      position: 102
      prefix: -rna
  - id: search_size
    type:
      - 'null'
      - int
    doc: maximum portion of primary dataset to use for motif search (in characters)
    inputBinding:
      position: 102
      prefix: -searchsize
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for shuffling and sampling
    inputBinding:
      position: 102
      prefix: -seed
  - id: sequence_file_name
    type:
      - 'null'
      - string
    doc: print <sf> as name of sequence file
    inputBinding:
      position: 102
      prefix: -sf
  - id: shuf_kmer
    type:
      - 'null'
      - int
    doc: preserve frequencies of k-mers of size <kmer> when shuffling
    default: 2
    inputBinding:
      position: 102
      prefix: -shuf
  - id: spfuzz
    type:
      - 'null'
      - float
    doc: fuzziness of sequence to theta mapping
    inputBinding:
      position: 102
      prefix: -spfuzz
  - id: spmap
    type:
      - 'null'
      - string
    doc: starting point seq to theta mapping type (uni|pam)
    inputBinding:
      position: 102
      prefix: -spmap
  - id: test_type
    type:
      - 'null'
      - string
    doc: statistical test type (mhg|mbn|mrs)
    default: mhg
    inputBinding:
      position: 102
      prefix: -test
  - id: text_format
    type:
      - 'null'
      - boolean
    doc: output in text format (default is HTML)
    inputBinding:
      position: 102
      prefix: -text
  - id: time_limit
    type:
      - 'null'
      - int
    doc: quit before <t> seconds have elapsed
    inputBinding:
      position: 102
      prefix: -time
  - id: use_llr
    type:
      - 'null'
      - boolean
    doc: use LLR in search for starts in Classic mode
    inputBinding:
      position: 102
      prefix: -use_llr
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: -V
  - id: weight_nsites
    type:
      - 'null'
      - float
    doc: weight on expected number of sites
    inputBinding:
      position: 102
      prefix: -wnsites
  - id: width
    type:
      - 'null'
      - int
    doc: motif width
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: name of directory for output files; will not replace existing directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_replace
    type:
      - 'null'
      - Directory
    doc: name of directory for output files; will replace existing directory
    outputBinding:
      glob: $(inputs.output_dir_replace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
