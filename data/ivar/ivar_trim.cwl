cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar trim
label: ivar_trim
doc: "Trim primers and quality from aligned reads in a BAM file.\n\nTool homepage:
  https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: include_no_primers
    type:
      - 'null'
      - boolean
    doc: Include reads with no primers. By default, reads with no primers are 
      excluded
    inputBinding:
      position: 101
      prefix: -e
  - id: input_bam
    type:
      - 'null'
      - File
    doc: BAM file, with aligned reads, to trim primers and quality. If not 
      specified will use standard in
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_reads
    type:
      - 'null'
      - boolean
    doc: 'Keep reads to allow for reanalysis: keep reads which would be dropped by
      alignment length filter or primer requirements, but mark them QCFAIL'
    inputBinding:
      position: 101
      prefix: -k
  - id: min_length
    type:
      - 'null'
      - string
    doc: 'Minimum length of read to retain after trimming (Default: 50% average length
      of the first 1000 reads)'
    inputBinding:
      position: 101
      prefix: -m
  - id: min_quality
    type:
      - 'null'
      - int
    doc: 'Minimum quality threshold for sliding window to pass (Default: 20)'
    default: 20
    inputBinding:
      position: 101
      prefix: -q
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output BAM file. If none is specified output will go to 
      std out
    inputBinding:
      position: 101
      prefix: -p
  - id: primer_info_file
    type:
      - 'null'
      - File
    doc: '[EXPERIMENTAL] Primer pair information file containing left and right primer
      names for the same amplicon separated by a tab. If provided, reads that do not
      fall within atleat one amplicon will be ignored prior to primer trimming.'
    inputBinding:
      position: 101
      prefix: -f
  - id: primer_offset
    type:
      - 'null'
      - int
    doc: 'Primer position offset (Default: 0). Reads that occur at the specified offset
      positions relative to primer positions will also be trimmed.'
    default: 0
    inputBinding:
      position: 101
      prefix: -x
  - id: primers_bed
    type: File
    doc: BED file with primer sequences and positions. If no BED file is 
      specified, only quality trimming will be done.
    inputBinding:
      position: 101
      prefix: -b
  - id: sliding_window_width
    type:
      - 'null'
      - int
    doc: 'Width of sliding window (Default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_trim.out
