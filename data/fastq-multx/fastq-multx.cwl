cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-multx
label: fastq-multx
doc: "Demultiplexes FASTQ files based on barcodes. It can determine barcodes from
  indexed reads, a master list, or use provided barcodes directly. It handles paired-end
  reads and offers various options for matching and output control.\n\nTool homepage:
  https://github.com/brwnj/fastq-multx"
inputs:
  - id: barcodes_file
    type: File
    doc: Barcodes file. The format depends on the mode (-g, -l, -L, -B).
    inputBinding:
      position: 1
  - id: read1_file
    type: File
    doc: First FASTQ read file.
    inputBinding:
      position: 2
  - id: mate_read_file
    type:
      - 'null'
      - File
    doc: Optional mate FASTQ read file for paired-end reads.
    inputBinding:
      position: 3
  - id: auto_determine_threshold_factor
    type:
      - 'null'
      - int
    doc: Divide threshold for auto-determine by factor NUM. > 1 = more 
      sensitive.
    default: 1
    inputBinding:
      position: 104
      prefix: -t
  - id: determine_barcodes_from_indexed_read
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from the indexed read SEQFIL. The parameter is an 
      index lane, and frequently occurring sequences are used.
    inputBinding:
      position: 104
      prefix: -g
  - id: determine_barcodes_from_master_list
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from any read, using BCFIL as a master list. All 
      barcodes in the file are tried, and the group with the most matches is 
      chosen.
    inputBinding:
      position: 104
      prefix: -l
  - id: determine_barcodes_from_read1_master_list
    type:
      - 'null'
      - boolean
    doc: Determine barcodes from <read1.fq>, using BCFIL as a master list.
    inputBinding:
      position: 104
      prefix: -L
  - id: dont_trim_barcodes
    type:
      - 'null'
      - boolean
    doc: Don't trim barcodes off before writing out destination.
    inputBinding:
      position: 104
      prefix: -x
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't execute, just print likely barcode list.
    inputBinding:
      position: 104
      prefix: -n
  - id: force_beginning_of_line
    type:
      - 'null'
      - boolean
    doc: Force beginning of line (5') for barcode matching.
    inputBinding:
      position: 104
      prefix: -b
  - id: force_end_of_line
    type:
      - 'null'
      - boolean
    doc: Force end of line (3') for barcode matching.
    inputBinding:
      position: 104
      prefix: -e
  - id: group_name
    type:
      - 'null'
      - string
    doc: Use group(s) matching NAME only.
    inputBinding:
      position: 104
      prefix: -G
  - id: max_mismatches_pair
    type:
      - 'null'
      - string
    doc: Allow N,M mismatches in indexes 1,2 respectively (see -m N).
    inputBinding:
      position: 104
      prefix: -M
  - id: max_mismatches_union
    type:
      - 'null'
      - int
    doc: Allow N mismatches in union of all indexes, unless -M is supplied.
    default: 1
    inputBinding:
      position: 104
      prefix: -m
  - id: min_distance_best_vs_next_best
    type:
      - 'null'
      - int
    doc: Require a minimum distance of N between the best and next best.
    default: 2
    inputBinding:
      position: 104
      prefix: -d
  - id: min_phred_quality
    type:
      - 'null'
      - int
    doc: Require a minimum phred quality of N to accept a barcode base.
    default: 0
    inputBinding:
      position: 104
      prefix: -q
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files. Must contain a '%' sign which is replaced with the 
      barcode id. Can be 'n/a' to discard.
    inputBinding:
      position: 104
      prefix: -o
  - id: use_illumina_header
    type:
      - 'null'
      - boolean
    doc: Use barcodes from illumina's header, instead of a read.
    inputBinding:
      position: 104
      prefix: -H
  - id: use_provided_barcodes
    type:
      - 'null'
      - boolean
    doc: Use barcodes from BCFIL, no determination step, codes in <read1.fq>.
    inputBinding:
      position: 104
      prefix: -B
  - id: verify_mated_ids_up_to_char
    type:
      - 'null'
      - string
    doc: Verify that mated id's match up to character C (Use ' ' for illumina).
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-multx:1.4.2--h9948957_5
stdout: fastq-multx.out
