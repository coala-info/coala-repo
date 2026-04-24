cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysamstats
label: pysamstats
doc: "Calculate statistics against genome positions based on sequence alignments from
  a SAM or BAM file and print them to stdout.\n\nTool homepage: https://github.com/alimanfoo/pysamstats"
inputs:
  - id: input_file
    type: File
    doc: SAM or BAM file
    inputBinding:
      position: 1
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Chromosome name.
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: end
    type:
      - 'null'
      - int
    doc: End position (1-based).
    inputBinding:
      position: 102
      prefix: --end
  - id: fasta
    type:
      - 'null'
      - File
    doc: Reference sequence file, only required for some statistics.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fields
    type:
      - 'null'
      - string
    doc: Comma-separated list of fields to output (defaults to all fields).
    inputBinding:
      position: 102
      prefix: --fields
  - id: format
    type:
      - 'null'
      - string
    doc: Output format, one of {tsv, csv, hdf5} (defaults to tsv). N.B., hdf5 
      requires PyTables to be installed.
    inputBinding:
      position: 102
      prefix: --format
  - id: hdf5_chunksize
    type:
      - 'null'
      - int
    doc: Size of chunks in number of bytes (defaults to 2**20).
    inputBinding:
      position: 102
      prefix: --hdf5-chunksize
  - id: hdf5_complevel
    type:
      - 'null'
      - int
    doc: HDF5 compression level (defaults to 5).
    inputBinding:
      position: 102
      prefix: --hdf5-complevel
  - id: hdf5_complib
    type:
      - 'null'
      - string
    doc: HDF5 compression library (defaults to zlib).
    inputBinding:
      position: 102
      prefix: --hdf5-complib
  - id: hdf5_dataset
    type:
      - 'null'
      - string
    doc: Name of HDF5 dataset to create (defaults to "data").
    inputBinding:
      position: 102
      prefix: --hdf5-dataset
  - id: hdf5_group
    type:
      - 'null'
      - string
    doc: Name of HDF5 group to write to (defaults to the root group).
    inputBinding:
      position: 102
      prefix: --hdf5-group
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum read depth permitted in pileup-based statistics. The default 
      limit is 8000.
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Only reads with base quality equal to or greater than this value will 
      be counted (0 by default). Only applies to pileup-based statistics.
    inputBinding:
      position: 102
      prefix: --min-baseq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Only reads with mapping quality equal to or greater than this value 
      will be counted (0 by default).
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_del
    type:
      - 'null'
      - boolean
    doc: Don't count reads aligned with a deletion at the given position. Only 
      applies to pileup-based statistics.
    inputBinding:
      position: 102
      prefix: --no-del
  - id: no_dup
    type:
      - 'null'
      - boolean
    doc: Don't count reads flagged as duplicate.
    inputBinding:
      position: 102
      prefix: --no-dup
  - id: omit_header
    type:
      - 'null'
      - boolean
    doc: Omit header row from output.
    inputBinding:
      position: 102
      prefix: --omit-header
  - id: pad
    type:
      - 'null'
      - boolean
    doc: Pad pileup-based stats so a record is emitted for every position 
      (default is only covered positions).
    inputBinding:
      position: 102
      prefix: --pad
  - id: progress
    type:
      - 'null'
      - int
    doc: Report progress every N rows.
    inputBinding:
      position: 102
      prefix: --progress
  - id: start
    type:
      - 'null'
      - int
    doc: Start position (1-based).
    inputBinding:
      position: 102
      prefix: --start
  - id: stepper
    type:
      - 'null'
      - string
    doc: 'Stepper to provide to underlying pysam call. Options are:"all" (default):
      all reads are returned, except where flags BAM_FUNMAP, BAM_FSECONDARY, BAM_FQCFAIL,
      BAM_FDUP set; "nofilter" applies no filter to returned reads; "samtools": filter
      & read processing as in _csamtools_ pileup. This requires a fasta file. For
      complete details see the pysam documentation.'
    inputBinding:
      position: 102
      prefix: --stepper
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Truncate pileup-based stats so no records are emitted outside the 
      specified range.
    inputBinding:
      position: 102
      prefix: --truncate
  - id: type
    type:
      - 'null'
      - string
    doc: 'Type of statistics to print, one of: alignment_binned, baseq, baseq_ext,
      baseq_ext_strand, baseq_strand, coverage, coverage_binned, coverage_ext, coverage_ext_binned,
      coverage_ext_strand, coverage_gc, coverage_strand, mapq, mapq_binned, mapq_strand,
      tlen, tlen_binned, tlen_strand, variation, variation_strand.'
    inputBinding:
      position: 102
      prefix: --type
  - id: window_offset
    type:
      - 'null'
      - int
    doc: Window offset to use for deciding which genome position to report 
      binned statistics against. The default is 150, i.e., the middle of 300bp 
      window.
    inputBinding:
      position: 102
      prefix: --window-offset
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of window for binned statistics (default is 300).
    inputBinding:
      position: 102
      prefix: --window-size
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Use zero-based coordinates (default is false, i.e., use one-based 
      coords).
    inputBinding:
      position: 102
      prefix: --zero-based
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file. If not provided, write to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysamstats:1.1.2--py311h384fd50_15
