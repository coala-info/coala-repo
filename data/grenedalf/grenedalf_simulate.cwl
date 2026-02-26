cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grenedalf
  - simulate
label: grenedalf_simulate
doc: "Create a file with simulated random frequency data.\n\nTool homepage: https://github.com/lczech/grenedalf"
inputs:
  - id: allow_file_overwriting
    type:
      - 'null'
      - boolean
    doc: Allow to overwrite existing output files instead of aborting the 
      command. By default, we abort if any output file already exists, to avoid 
      overwriting by mistake.
    inputBinding:
      position: 101
      prefix: --allow-file-overwriting
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Name of the chromosome. This is simply used as the first column in the 
      output file. At the moment, only one chromosome is supported.
    default: A
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: compress
    type:
      - 'null'
      - boolean
    doc: If set, compress the output files using gzip. Output file extensions 
      are automatically extended by `.gz`.
    inputBinding:
      position: 101
      prefix: --compress
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: File prefix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-prefix
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: File suffix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-suffix
  - id: format
    type:
      - 'null'
      - string
    doc: Select the output file format, either (m)pileup, or PoPoolation2 sync.
    default: pileup
    inputBinding:
      position: 101
      prefix: --format
  - id: length
    type: int
    doc: Total length of the chromosome to simulate. Mutations are spread across
      this length.
    inputBinding:
      position: 101
      prefix: --length
  - id: log_file
    type:
      - 'null'
      - File
    doc: Write all output to a log file, in addition to standard output to the 
      terminal.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: max_phred_score
    type:
      - 'null'
      - int
    doc: Maximum phred score to use when simulating an (m)pileup file. Ignored 
      otherwise.
    default: 40
    inputBinding:
      position: 101
      prefix: --max-phred-score
  - id: min_phred_score
    type:
      - 'null'
      - int
    doc: Minimum phred score to use when simulating an (m)pileup file. Ignored 
      otherwise.
    default: 10
    inputBinding:
      position: 101
      prefix: --min-phred-score
  - id: mutation_count
    type:
      - 'null'
      - int
    doc: Number of mutations to simulate in total across the chromosome, spread 
      across the `--length`.
    default: 0
    inputBinding:
      position: 101
      prefix: --mutation-count
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate to simulate. This rate times the `--length` is used as 
      the number of mutations to generate in total (which can alternatively be 
      directly provided via `--mutation-count`).
    default: '1e-08'
    inputBinding:
      position: 101
      prefix: --mutation-rate
  - id: omit_invariant_positions
    type:
      - 'null'
      - boolean
    doc: If set, only write the mutated positions in the output file. Note that 
      these are not standard (m)pileup or sync files any more; still this option
      might be useful.
    inputBinding:
      position: 101
      prefix: --omit-invariant-positions
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write files to
    default: .
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set the random seed for generating values, which allows reproducible 
      results. If not provided, the system clock is used to obtain a random 
      seed.
    default: 0
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: read_depths
    type: string
    doc: Read depths of the samples to simulate, as a comma- or tab-separated 
      list. The read depth of each sample is used at the total count per 
      position to randomly distribute across nucleotides. Per sample, the list 
      can either contain a single number, which will be used as the read depth 
      for that sample at each position, or it can be two numbers separated by a 
      slash, which will be used as min/max to generate random read depth at each
      position. The length of this list is also used to determine the number of 
      samples to simulate.
    inputBinding:
      position: 101
      prefix: --read-depths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for calculations. If not set, we guess a 
      reasonable number of threads, by looking at the environmental variables 
      (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as 
      well as (3) the hardware concurrency (number of CPU cores), taking 
      hyperthreads into account, in the given order of precedence.
    default: 14
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce more verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: with_quality_scores
    type:
      - 'null'
      - boolean
    doc: If set, phred-scaled quality scores are written when simulating an 
      (m)pileup file, using the `--min-phred-score` and `--max-phred-score` 
      settings. Ignored otherwise.
    inputBinding:
      position: 101
      prefix: --with-quality-scores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
stdout: grenedalf_simulate.out
