cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit bam
label: seqkit_bam
doc: "monitoring and online histograms of BAM record features\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
  - id: bins
    type:
      - 'null'
      - int
    doc: number of histogram bins
    inputBinding:
      position: 101
      prefix: --bins
  - id: bundle
    type:
      - 'null'
      - int
    doc: partition BAM file into loci (-1) or bundles with this minimum size
    inputBinding:
      position: 101
      prefix: --bundle
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
  - id: count_file
    type:
      - 'null'
      - string
    doc: count reads per reference and save to this file
    inputBinding:
      position: 101
      prefix: --count
  - id: delay
    type:
      - 'null'
      - int
    doc: sleep this many seconds after plotting
    inputBinding:
      position: 101
      prefix: --delay
  - id: dump
    type:
      - 'null'
      - boolean
    doc: print histogram data to stderr instead of plotting
    inputBinding:
      position: 101
      prefix: --dump
  - id: exclude_ids_file
    type:
      - 'null'
      - string
    doc: exclude records with IDs contained in this file
    inputBinding:
      position: 101
      prefix: --exclude-ids
  - id: exec_after
    type:
      - 'null'
      - string
    doc: execute command after reporting
    inputBinding:
      position: 101
      prefix: --exec-after
  - id: exec_before
    type:
      - 'null'
      - string
    doc: execute command before reporting
    inputBinding:
      position: 101
      prefix: --exec-before
  - id: field
    type:
      - 'null'
      - string
    doc: target fields
    inputBinding:
      position: 101
      prefix: --field
  - id: grep_ids_file
    type:
      - 'null'
      - string
    doc: only keep records with IDs contained in this file
    inputBinding:
      position: 101
      prefix: --grep-ids
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2| Pseud...
    inputBinding:
      position: 101
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    inputBinding:
      position: 101
  - id: idx_count
    type:
      - 'null'
      - boolean
    doc: fast read per reference counting based on the BAM index
    inputBinding:
      position: 101
      prefix: --idx-count
  - id: idx_stat
    type:
      - 'null'
      - boolean
    doc: fast statistics based on the BAM index
    inputBinding:
      position: 101
      prefix: --idx-stat
  - id: infile_list
    type:
      - 'null'
      - type: array
        items: File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: list all available BAM record features
    inputBinding:
      position: 101
      prefix: --list-fields
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: log10(x+1) transform numeric values
    inputBinding:
      position: 101
      prefix: --log
  - id: map_qual
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 101
      prefix: --map-qual
  - id: pass
    type:
      - 'null'
      - boolean
    doc: passthrough mode (forward filtered BAM to output)
    inputBinding:
      position: 101
      prefix: --pass
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: pretty print certain TSV outputs
    inputBinding:
      position: 101
      prefix: --pretty
  - id: prim_only
    type:
      - 'null'
      - boolean
    doc: filter out non-primary alignment records
    inputBinding:
      position: 101
      prefix: --prim-only
  - id: print_freq
    type:
      - 'null'
      - int
    doc: print/report after this many records (-1 for print after EOF)
    inputBinding:
      position: 101
      prefix: --print-freq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: supress all plotting to stderr
    inputBinding:
      position: 101
      prefix: --quiet-mode
  - id: range_max
    type:
      - 'null'
      - float
    doc: discard record with field (-f) value greater than this flag
    inputBinding:
      position: 101
      prefix: --range-max
  - id: range_min
    type:
      - 'null'
      - float
    doc: discard record with field (-f) value less than this flag
    inputBinding:
      position: 101
      prefix: --range-min
  - id: reset
    type:
      - 'null'
      - boolean
    doc: reset histogram after every report
    inputBinding:
      position: 101
      prefix: --reset
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: supress TSV output to stderr
    inputBinding:
      position: 101
      prefix: --silent-mode
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given a file list if you believe these 
      files do exist
    inputBinding:
      position: 101
  - id: stat
    type:
      - 'null'
      - boolean
    doc: print BAM satistics of the input files
    inputBinding:
      position: 101
      prefix: --stat
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    inputBinding:
      position: 101
      prefix: --threads
  - id: tool
    type:
      - 'null'
      - string
    doc: invoke toolbox in YAML format (see documentation)
    inputBinding:
      position: 101
      prefix: --tool
  - id: top_size
    type:
      - 'null'
      - int
    doc: size of the top-mode buffer
    inputBinding:
      position: 101
      prefix: --top-size
outputs:
  - id: img_file
    type:
      - 'null'
      - File
    doc: save histogram to this PDF/image file
    outputBinding:
      glob: $(inputs.img_file)
  - id: top_bam_file
    type:
      - 'null'
      - File
    doc: save the top -? records to this bam file
    outputBinding:
      glob: $(inputs.top_bam_file)
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
