cwlVersion: v1.2
class: CommandLineTool
baseCommand: hilive
label: hilive
doc: "Realtime Alignment of Illumina Reads\n\nTool homepage: https://github.com/wtv-filipa/AppHiLives"
inputs:
  - id: bc_dir
    type: Directory
    doc: Illumina BaseCalls directory of the sequencing run to analyze
    inputBinding:
      position: 1
  - id: index
    type: File
    doc: Path to k-mer index file (*.kix)
    inputBinding:
      position: 2
  - id: cycles
    type: int
    doc: Total number of sequencing cycles
    inputBinding:
      position: 3
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 4
  - id: barcode_errors
    type:
      - 'null'
      - type: array
        items: int
    doc: Enumerate the number of tolerated errors (only SNPs) for each barcode 
      fragment, e.g. -E 2 2
    inputBinding:
      position: 105
      prefix: --barcode-errors
  - id: barcodes
    type:
      - 'null'
      - type: array
        items: string
    doc: Enumerate barcodes (must have same length) for demultiplexing, e.g. -b 
      AGGATC -b CCCTTT
    inputBinding:
      position: 105
      prefix: --barcodes
  - id: block_size
    type:
      - 'null'
      - string
    doc: Block size for the alignment input/output stream in Bytes. Append 'K' 
      or 'M' to specify in Kilobytes or Megabytes, respectively (e.g. 
      '--block-size 64M' for 64 Megabytes)
    inputBinding:
      position: 105
      prefix: --block-size
  - id: compression
    type:
      - 'null'
      - int
    doc: 'Compress alignment files. 0: no compression 1: Deflate (smaller) 2: LZ4
      (faster; default)'
    inputBinding:
      position: 105
      prefix: --compression
  - id: continue_run
    type:
      - 'null'
      - int
    doc: Continue an interrupted HiLive run from a specified cycle. We strongly 
      recommend to load the settings from the previous run using the -s option.
    inputBinding:
      position: 105
      prefix: --continue
  - id: create_bam
    type:
      - 'null'
      - boolean
    doc: Create BAM files instead of SAM files
    inputBinding:
      position: 105
      prefix: --bam
  - id: disable_ohw_filter
    type:
      - 'null'
      - boolean
    doc: Disable the One-Hit Wonder filter
    inputBinding:
      position: 105
      prefix: --disable-ohw-filter
  - id: extended_cigar
    type:
      - 'null'
      - boolean
    doc: Activate extended CIGAR format (= and X instead of only M) in output 
      files
    inputBinding:
      position: 105
      prefix: --extended-cigar
  - id: force_resort
    type:
      - 'null'
      - boolean
    doc: If set, the align files are always sorted before output. Existing 
      sorted align files are overwritten
    inputBinding:
      position: 105
      prefix: --force-resort
  - id: keep_all_barcodes
    type:
      - 'null'
      - boolean
    doc: Align and output all barcodes
    inputBinding:
      position: 105
      prefix: --keep-all-barcodes
  - id: keep_all_files
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate alignment files
    inputBinding:
      position: 105
      prefix: --keep-all-files
  - id: keep_cycles
    type:
      - 'null'
      - int
    doc: Keep intermediate alignment files for these cycles. The last cycle is 
      always kept.
    inputBinding:
      position: 105
      prefix: --keep-files
  - id: lanes
    type:
      - 'null'
      - string
    doc: Select lane
    inputBinding:
      position: 105
      prefix: --lanes
  - id: min_as_ratio
    type:
      - 'null'
      - float
    doc: Minimum alignment score (relative to the current read length) for 
      alignments to be reported (0-1)
    inputBinding:
      position: 105
      prefix: --min-as-ratio
  - id: min_errors
    type:
      - 'null'
      - int
    doc: Number of errors tolerated in read alignment
    inputBinding:
      position: 105
      prefix: --min-errors
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum allowed basecall quality
    inputBinding:
      position: 105
      prefix: --min-quality
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Alignment mode. [ALL|A]: Report all alignments; [BESTN#|N#]: Report alignments
      of the best # scores; [ALLBEST|H]: Report all alignments with the best score
      (similar to N1); [UNIQUE|U]: Report only unique alignments; [ANYBEST|B]: Report
      one best alignment (default)'
    inputBinding:
      position: 105
      prefix: --mode
  - id: num_out_threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use for output if threads are not idle
    inputBinding:
      position: 105
      prefix: --num-out-threads
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to spawn
    inputBinding:
      position: 105
      prefix: --num-threads
  - id: output_cycles
    type:
      - 'null'
      - int
    doc: Cycles for alignment output. The respective temporary files are kept.
    inputBinding:
      position: 105
      prefix: --output-cycles
  - id: reads
    type:
      - 'null'
      - string
    doc: 'Enumerate read lengths and type. Example: -r 101R 8B 8B 101R equals paired-end
      sequencing with 2x101bp reads and 2x8bp barcodes. Overwrites information of
      runInfo.xml.'
    inputBinding:
      position: 105
      prefix: --reads
  - id: runinfo
    type:
      - 'null'
      - File
    doc: Path to runInfo.xml for parsing read and index lengths
    inputBinding:
      position: 105
      prefix: --runinfo
  - id: settings
    type:
      - 'null'
      - File
    doc: Load settings from file. If command line arguments are given 
      additionally, they are prefered.
    inputBinding:
      position: 105
      prefix: --settings
  - id: start_ohw
    type:
      - 'null'
      - int
    doc: First cycle to apply One-Hit Wonder filter
    inputBinding:
      position: 105
      prefix: --start-ohw
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temporary directory for the alignment files
    inputBinding:
      position: 105
      prefix: --temp
  - id: tiles
    type:
      - 'null'
      - string
    doc: Select tile numbers
    inputBinding:
      position: 105
      prefix: --tiles
  - id: window
    type:
      - 'null'
      - int
    doc: Set the window size to search for alignment extension, i.e. maximum 
      total insertion/deletion size
    inputBinding:
      position: 105
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hilive:v1.1-2-deb_cv1
stdout: hilive.out
