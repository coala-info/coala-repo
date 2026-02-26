cwlVersion: v1.2
class: CommandLineTool
baseCommand: AdapterRemoval
label: adapterremoval_AdapterRemoval
doc: "Searches for and removes remnant adapter sequences from read data, supporting
  both single-end and paired-end data.\n\nTool homepage: https://github.com/MikkelSchubert/adapterremoval"
inputs:
  - id: adapter1
    type:
      - 'null'
      - string
    doc: Adapter sequence expected to be found in mate 1 reads
    default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG
    inputBinding:
      position: 101
      prefix: --adapter1
  - id: adapter2
    type:
      - 'null'
      - string
    doc: Adapter sequence expected to be found in mate 2 reads
    default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT
    inputBinding:
      position: 101
      prefix: --adapter2
  - id: adapter_list
    type:
      - 'null'
      - File
    doc: Read table of white-space separated adapters pairs
    inputBinding:
      position: 101
      prefix: --adapter-list
  - id: barcode_list
    type:
      - 'null'
      - File
    doc: List of barcodes or barcode pairs for single or double-indexed 
      demultiplexing.
    inputBinding:
      position: 101
      prefix: --barcode-list
  - id: barcode_mm
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed in both mate 1 and mate 2 
      barcodes.
    default: 0
    inputBinding:
      position: 101
      prefix: --barcode-mm
  - id: barcode_mm_r1
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed for the mate 1 barcode.
    inputBinding:
      position: 101
      prefix: --barcode-mm-r1
  - id: barcode_mm_r2
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed for the mate 2 barcode.
    inputBinding:
      position: 101
      prefix: --barcode-mm-r2
  - id: basename
    type:
      - 'null'
      - string
    doc: Default prefix for all output files for which no filename was 
      explicitly set
    default: your_output
    inputBinding:
      position: 101
      prefix: --basename
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: Enable bzip2 compression
    inputBinding:
      position: 101
      prefix: --bzip2
  - id: bzip2_level
    type:
      - 'null'
      - int
    doc: Compression level, 0 - 9
    default: 9
    inputBinding:
      position: 101
      prefix: --bzip2-level
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: When set, paired ended read alignments are combined into a single 
      consensus sequence.
    inputBinding:
      position: 101
      prefix: --collapse
  - id: collapse_conservatively
    type:
      - 'null'
      - boolean
    doc: Enables a more conservative merging algorithm. Sets --collapse.
    inputBinding:
      position: 101
      prefix: --collapse-conservatively
  - id: collapse_deterministic
    type:
      - 'null'
      - boolean
    doc: AdapterRemoval will set overlapping bases with equal quality to N. Sets
      --collapse.
    inputBinding:
      position: 101
      prefix: --collapse-deterministic
  - id: combined_output
    type:
      - 'null'
      - boolean
    doc: If set, all reads are written to the same file(s), specified by 
      --output1 and --output2.
    inputBinding:
      position: 101
      prefix: --combined-output
  - id: convert_uracils
    type:
      - 'null'
      - boolean
    doc: Convert uracils (U) to thymine (T) in input reads.
    inputBinding:
      position: 101
      prefix: --convert-uracils
  - id: demultiplex_only
    type:
      - 'null'
      - boolean
    doc: Only carry out demultiplexing using the list of barcodes supplied with 
      --barcode-list.
    inputBinding:
      position: 101
      prefix: --demultiplex-only
  - id: file1
    type:
      type: array
      items: File
    doc: Input files containing mate 1 reads or single-ended reads; one or more 
      files may be listed.
    inputBinding:
      position: 101
      prefix: --file1
  - id: file2
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files containing mate 2 reads; if used, then the same number of 
      files as --file1 must be listed.
    inputBinding:
      position: 101
      prefix: --file2
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Enable gzip compression
    inputBinding:
      position: 101
      prefix: --gzip
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: Compression level, 0 - 9
    default: 6
    inputBinding:
      position: 101
      prefix: --gzip-level
  - id: identify_adapters
    type:
      - 'null'
      - boolean
    doc: Attempt to identify the adapter pair of PE reads, by searching for 
      overlapping mate reads.
    inputBinding:
      position: 101
      prefix: --identify-adapters
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: This option enables both the --interleaved-input option and the 
      --interleaved-output option
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: The (single) input file provided contains both the mate 1 and mate 2 
      reads, one pair after the other.
    inputBinding:
      position: 101
      prefix: --interleaved-input
  - id: interleaved_output
    type:
      - 'null'
      - boolean
    doc: If set, trimmed paired-end reads are written to a single file 
      containing mate 1 and mate 2 reads.
    inputBinding:
      position: 101
      prefix: --interleaved-output
  - id: mask_degenerate_bases
    type:
      - 'null'
      - boolean
    doc: Mask degenerate/ambiguous bases (B/D/H/K/M/N/R/S/V/W/Y) in input by 
      replacing them with an 'N'.
    inputBinding:
      position: 101
      prefix: --mask-degenerate-bases
  - id: mate_separator
    type:
      - 'null'
      - string
    doc: Character separating the mate number (1 or 2) from the read name in 
      FASTQ records
    default: /
    inputBinding:
      position: 101
      prefix: --mate-separator
  - id: maxlength
    type:
      - 'null'
      - int
    doc: Reads longer than this length are discarded following trimming
    default: 4294967295
    inputBinding:
      position: 101
      prefix: --maxlength
  - id: maxns
    type:
      - 'null'
      - int
    doc: Reads containing more ambiguous bases (N) than this number after 
      trimming are discarded
    default: 1000
    inputBinding:
      position: 101
      prefix: --maxns
  - id: minadapteroverlap
    type:
      - 'null'
      - int
    doc: In single-end mode, reads are only trimmed if the overlap between read 
      and the adapter is at least X bases long.
    default: 0
    inputBinding:
      position: 101
      prefix: --minadapteroverlap
  - id: minalignmentlength
    type:
      - 'null'
      - int
    doc: Minimum overlap length for collapsing paired reads or identifying 
      complete SE template molecules.
    default: 11
    inputBinding:
      position: 101
      prefix: --minalignmentlength
  - id: minlength
    type:
      - 'null'
      - int
    doc: Reads shorter than this length are discarded following trimming
    default: 15
    inputBinding:
      position: 101
      prefix: --minlength
  - id: minquality
    type:
      - 'null'
      - int
    doc: Inclusive minimum quality score for trimming.
    default: 2
    inputBinding:
      position: 101
      prefix: --minquality
  - id: mismatch_rate
    type:
      - 'null'
      - float
    doc: Max error-rate when aligning reads and/or adapters.
    inputBinding:
      position: 101
      prefix: --mm
  - id: preserve5p
    type:
      - 'null'
      - boolean
    doc: If set, bases at the 5p will not be trimmed by --trimns, 
      --trimqualities, and --trimwindows.
    inputBinding:
      position: 101
      prefix: --preserve5p
  - id: qualitybase
    type:
      - 'null'
      - string
    doc: Quality base used to encode Phred scores in input; either 33, 64, or 
      solexa
    default: '33'
    inputBinding:
      position: 101
      prefix: --qualitybase
  - id: qualitybase_output
    type:
      - 'null'
      - string
    doc: Quality base used to encode Phred scores in output; either 33, 64, or 
      solexa.
    inputBinding:
      position: 101
      prefix: --qualitybase-output
  - id: qualitymax
    type:
      - 'null'
      - int
    doc: Specifies the maximum Phred score expected in input files, and used 
      when writing output.
    default: 41
    inputBinding:
      position: 101
      prefix: --qualitymax
  - id: seed
    type:
      - 'null'
      - int
    doc: Sets the RNG seed used when choosing between bases with equal Phred 
      scores.
    inputBinding:
      position: 101
      prefix: --seed
  - id: shift
    type:
      - 'null'
      - int
    doc: Consider alignments where up to N nucleotides are missing from the 5' 
      termini
    default: 2
    inputBinding:
      position: 101
      prefix: --shift
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim3p
    type:
      - 'null'
      - type: array
        items: int
    doc: Trim the 3' of reads by a fixed amount. See --trim5p.
    inputBinding:
      position: 101
      prefix: --trim3p
  - id: trim5p
    type:
      - 'null'
      - type: array
        items: int
    doc: Trim the 5' of reads by a fixed amount after removing adapters. Specify
      one value for both or two for each mate.
    inputBinding:
      position: 101
      prefix: --trim5p
  - id: trimns
    type:
      - 'null'
      - boolean
    doc: If set, trim ambiguous bases (N) at 5'/3' termini
    inputBinding:
      position: 101
      prefix: --trimns
  - id: trimqualities
    type:
      - 'null'
      - boolean
    doc: If set, trim bases at 5'/3' termini with quality scores <= to 
      --minquality value
    inputBinding:
      position: 101
      prefix: --trimqualities
  - id: trimwindows
    type:
      - 'null'
      - int
    doc: If set, quality trimming will be carried out using window based 
      approach.
    inputBinding:
      position: 101
      prefix: --trimwindows
outputs:
  - id: settings
    type:
      - 'null'
      - File
    doc: Output file containing information on the parameters used in the run as
      well as overall statistics.
    outputBinding:
      glob: $(inputs.settings)
  - id: output1
    type:
      - 'null'
      - File
    doc: Output file containing trimmed mate1 reads
    outputBinding:
      glob: $(inputs.output1)
  - id: output2
    type:
      - 'null'
      - File
    doc: Output file containing trimmed mate 2 reads
    outputBinding:
      glob: $(inputs.output2)
  - id: singleton
    type:
      - 'null'
      - File
    doc: Output file to which containing paired reads for which the mate has 
      been discarded
    outputBinding:
      glob: $(inputs.singleton)
  - id: outputcollapsed
    type:
      - 'null'
      - File
    doc: Contains overlapping mate-pairs which have been merged into a single 
      read (PE mode) or reads for which the adapter was identified by a minimum 
      overlap.
    outputBinding:
      glob: $(inputs.outputcollapsed)
  - id: outputcollapsedtruncated
    type:
      - 'null'
      - File
    doc: Collapsed reads which were trimmed due the presence of low-quality or 
      ambiguous nucleotides
    outputBinding:
      glob: $(inputs.outputcollapsedtruncated)
  - id: discarded
    type:
      - 'null'
      - File
    doc: Contains reads discarded due to the --minlength, --maxlength or --maxns
      options
    outputBinding:
      glob: $(inputs.discarded)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adapterremoval:2.3.4--pl5321haf24da9_2
