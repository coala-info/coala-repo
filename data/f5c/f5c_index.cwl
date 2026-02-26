cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - index
label: f5c_index
doc: "Build an index for accessing the base sequence (fastq/fasta) and raw signal
  (fast5/slow5) for a given read ID. f5c index is an extended and optimised version
  of nanopolish index by Jared Simpson\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs:
  - id: reads_fastq
    type: File
    doc: Base sequence file (fastq/fasta)
    inputBinding:
      position: 1
  - id: fast5_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: path to the directory containing fast5 files. This option can be given 
      multiple times.
    inputBinding:
      position: 102
      prefix: -d
  - id: iop
    type:
      - 'null'
      - int
    doc: number of I/O processes to read fast5 files (makes fast5 indexing 
      faster)
    inputBinding:
      position: 102
      prefix: --iop
  - id: sequencing_summary
    type:
      - 'null'
      - File
    doc: the sequencing summary file
    inputBinding:
      position: 102
      prefix: -s
  - id: skip_slow5_idx
    type:
      - 'null'
      - boolean
    doc: do not build the .idx for the slow5 file (useful when a slow5 index is 
      already available)
    inputBinding:
      position: 102
      prefix: --skip-slow5-idx
  - id: slow5
    type:
      - 'null'
      - File
    doc: slow5 file containing raw signals
    inputBinding:
      position: 102
      prefix: --slow5
  - id: summary_file_list
    type:
      - 'null'
      - File
    doc: file containing the paths to the sequencing summary files (one per 
      line)
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used for bgzf compression (makes indexing faster)
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
stdout: f5c_index.out
