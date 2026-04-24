cwlVersion: v1.2
class: CommandLineTool
baseCommand: myloasm
label: myloasm
doc: "high-resolution metagenomic assembly with noisy long reads. See online documentation
  for full options.\n\nTool homepage: https://github.com/bluenote-1577/myloasm"
inputs:
  - id: input_reads
    type:
      type: array
      items: File
    doc: Input read file(s) -- multiple files are concatenated
    inputBinding:
      position: 1
  - id: absolute_coverage_threshold
    type:
      - 'null'
      - int
    doc: Remove all contigs with <= this estimated coverage depth (DP1 coverage;
      99% identity coverage)
    inputBinding:
      position: 102
      prefix: --absolute-coverage-threshold
  - id: aggressive_bloom
    type:
      - 'null'
      - boolean
    doc: More aggressive filtering of low-abundance k-mers. May be 
      non-deterministic
    inputBinding:
      position: 102
      prefix: --aggressive-bloom
  - id: bloom_filter_size
    type:
      - 'null'
      - string
    doc: 'Bloom filter size in GB. Increase for massive datasets if initial k-mer
      counting is a bottleneck (default: automatic estimation)'
    inputBinding:
      position: 102
      prefix: --bloom-filter-size
  - id: clean_dir
    type:
      - 'null'
      - boolean
    doc: Do not dump large intermediate data to disk (intermediate data is 
      useful for rerunning)
    inputBinding:
      position: 102
      prefix: --clean-dir
  - id: compression_ratio
    type:
      - 'null'
      - int
    doc: Compression ratio (1/c k-mers selected). Must be <= 15
    inputBinding:
      position: 102
      prefix: --c
  - id: dereplication_ani
    type:
      - 'null'
      - int
    doc: Mark contigs with >= this average nucleotide identity (ANI) to a larger
      contig as alternate
    inputBinding:
      position: 102
      prefix: --dereplication-ani
  - id: dereplication_length
    type:
      - 'null'
      - int
    doc: Mark contigs with > 90% aligned, < this length, and >= 
      --dereplication-ani as alternate
    inputBinding:
      position: 102
      prefix: --dereplication-length
  - id: hifi
    type:
      - 'null'
      - boolean
    doc: PacBio HiFi mode -- assumes less chimericism and higher accuracy
    inputBinding:
      position: 102
      prefix: --hifi
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Verbosity level. Warning: trace is very verbose'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: Minimum overlap length for graph construction
    inputBinding:
      position: 102
      prefix: --min-ol
  - id: min_reads_contig
    type:
      - 'null'
      - int
    doc: Output contigs with >= this number of reads
    inputBinding:
      position: 102
      prefix: --min-reads-contig
  - id: nano_r10
    type:
      - 'null'
      - boolean
    doc: R10 nanopore mode for sup/hac data (> ~97% median accuracy). Specifying
      this flag does not do anything for now
    inputBinding:
      position: 102
      prefix: --nano-r10
  - id: new_polish_trimming
    type:
      - 'null'
      - boolean
    doc: 'New mode: trim windows during polishing. Takes slightly longer, may incrementally
      improve polishing for some datasets'
    inputBinding:
      position: 102
      prefix: --new-polish-trimming
  - id: quality_value_cutoff
    type:
      - 'null'
      - int
    doc: Disallow reads with < % identity for graph building (estimated from 
      base qualities)
    inputBinding:
      position: 102
      prefix: --quality-value-cutoff
  - id: secondary_coverage_threshold
    type:
      - 'null'
      - int
    doc: Remove contigs with <= this estimated coverage depth and <= 2 reads 
      (DP1 coverage; 99% identity coverage)
    inputBinding:
      position: 102
      prefix: --secondary-coverage-threshold
  - id: singleton_coverage_threshold
    type:
      - 'null'
      - int
    doc: Remove singleton contigs with <= this estimated coverage depth (DP1 
      coverage; 99% identity coverage)
    inputBinding:
      position: 102
      prefix: --singleton-coverage-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for results; created if it does not exist
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/myloasm:0.4.0--ha6fb395_0
