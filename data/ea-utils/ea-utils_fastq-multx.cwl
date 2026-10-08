cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-multx
label: ea-utils_fastq-multx
doc: "Output files must contain a '%' sign which is replaced with the barcode id in
  the barcodes file.\nOutput file can be n/a to discard the corresponding data (use
  this for the barcode read)\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs:
  - id: barcodes_file
    type: File
    doc: Barcodes file (or the indexed read file with -g); given after -g, -l, 
      -L or -B
    inputBinding:
      position: 1
  - id: read1_fq
    type: File
    doc: Read 1 FASTQ file
    inputBinding:
      position: 2
  - id: mate_fq
    type:
      - 'null'
      - type: array
        items: File
    doc: Mate FASTQ files (kept in sync with read 1)
    inputBinding:
      position: 3
  - id: determine_barcodes_from_any_read
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from any read, using BCFIL as a master list
    inputBinding:
      position: 0
      prefix: -l
  - id: determine_barcodes_from_indexed_read
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from the indexed read
    inputBinding:
      position: 0
      prefix: -g
  - id: determine_barcodes_from_read1
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from <read1.fq>, using BCFIL as a master list
    inputBinding:
      position: 0
      prefix: -L
  - id: divide_threshold_factor
    type:
      - 'null'
      - float
    doc: Divide threshold for auto-determine by factor NUM (1), > 1 = more 
      sensitive
    inputBinding:
      position: 104
      prefix: -t
  - id: dont_trim_barcodes
    type:
      - 'null'
      - boolean
    doc: Don't trim barcodes off before writing out destination
    inputBinding:
      position: 104
      prefix: -x
  - id: dry_run_print_list
    type:
      - 'null'
      - boolean
    doc: Don't execute, just print likely barcode list
    inputBinding:
      position: 104
      prefix: -n
  - id: force_beginning_of_line
    type:
      - 'null'
      - boolean
    doc: Force beginning of line (5') for barcode matching
    inputBinding:
      position: 104
      prefix: -b
  - id: force_end_of_line
    type:
      - 'null'
      - boolean
    doc: Force end of line (3') for batcode matching
    inputBinding:
      position: 104
      prefix: -e
  - id: max_mismatches_unique
    type:
      - 'null'
      - int
    doc: Allow up to N mismatches, as long as they are unique
    inputBinding:
      position: 104
      prefix: -m
  - id: min_distance_best_next_best
    type:
      - 'null'
      - int
    doc: Require a minimum distance of N between the best and next best
    inputBinding:
      position: 104
      prefix: -d
  - id: min_phred_quality
    type:
      - 'null'
      - int
    doc: Require a minimum phred quality of N to accept a barcode base
    inputBinding:
      position: 104
      prefix: -q
  - id: use_barcodes_from_file
    type:
      - 'null'
      - boolean
    doc: Use barcodes from BCFIL, no determination step, codes in <read1.fq>
    inputBinding:
      position: 0
      prefix: -B
  - id: use_group_name
    type:
      - 'null'
      - string
    doc: Use group(s) matching NAME only
    inputBinding:
      position: 104
      prefix: -G
  - id: use_illumina_header
    type:
      - 'null'
      - boolean
    doc: Use barcodes from illumina's header, instead of a read
    inputBinding:
      position: 104
      prefix: -H
  - id: verify_mated_id_match_char
    type:
      - 'null'
      - string
    doc: Verify that mated id's match up to character C (Use ' ' for illumina)
    inputBinding:
      position: 104
      prefix: -v
  - id: output_paths
    type:
      type: array
      items: string
      inputBinding:
        prefix: -o
    doc: Output files (one per input, required); each must contain a '%' sign 
      which is replaced with the barcode id, or be n/a to discard that input
    inputBinding:
      position: 105
outputs:
  - id: demultiplexed
    type:
      type: array
      items: File
    doc: Demultiplexed FASTQ files, one per barcode id and input
    outputBinding:
      glob: |-
        ${ return inputs.output_paths.filter(function(p){ return p != 'n/a'; }).map(function(p){ return p.replace('%', '*'); }); }
  - id: stats
    type: stdout
    doc: Barcode counts per output file
stdout: fastq-multx.stats.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
