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
    type:
      - 'null'
      - File
    doc: Use barcodes from BCFIL, no determination step, codes in <read1.fq>.
    inputBinding:
      position: 1
      prefix: -B
  - id: master_list_any_read
    type:
      - 'null'
      - File
    doc: Determine barcodes from any read, using BCFIL as a master list. All 
      barcodes in the file are tried, and the group with the most matches is 
      chosen.
    inputBinding:
      position: 1
      prefix: -l
  - id: master_list_read1
    type:
      - 'null'
      - File
    doc: Determine barcodes from <read1.fq>, using BCFIL as a master list.
    inputBinding:
      position: 1
      prefix: -L
  - id: index_read_file
    type:
      - 'null'
      - File
    doc: Determine barcodes from the indexed read SEQFIL. The parameter is an 
      index lane, and frequently occurring sequences are used. The same file 
      must also be the first of the input reads.
    inputBinding:
      position: 1
      prefix: -g
  - id: use_illumina_header
    type:
      - 'null'
      - boolean
    doc: Use barcodes from illumina's header, instead of a read.
    inputBinding:
      position: 1
      prefix: -H
  - id: force_beginning_of_line
    type:
      - 'null'
      - boolean
    doc: Force beginning of line (5') for barcode matching.
    inputBinding:
      position: 1
      prefix: -b
  - id: force_end_of_line
    type:
      - 'null'
      - boolean
    doc: Force end of line (3') for barcode matching.
    inputBinding:
      position: 1
      prefix: -e
  - id: auto_determine_threshold_factor
    type:
      - 'null'
      - int
    doc: Divide threshold for auto-determine by factor NUM. > 1 = more 
      sensitive.
    inputBinding:
      position: 1
      prefix: -t
  - id: group_name
    type:
      - 'null'
      - string
    doc: Use group(s) matching NAME only.
    inputBinding:
      position: 1
      prefix: -G
  - id: dont_trim_barcodes
    type:
      - 'null'
      - boolean
    doc: Don't trim barcodes off before writing out destination.
    inputBinding:
      position: 1
      prefix: -x
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't execute, just print likely barcode list.
    inputBinding:
      position: 1
      prefix: -n
  - id: verify_mated_ids_up_to_char
    type:
      - 'null'
      - string
    doc: Verify that mated id's match up to character C (Use ' ' for illumina).
    inputBinding:
      position: 1
      prefix: -v
  - id: max_mismatches_union
    type:
      - 'null'
      - int
    doc: Allow N mismatches in union of all indexes, unless -M is supplied.
    inputBinding:
      position: 1
      prefix: -m
  - id: max_mismatches_pair
    type:
      - 'null'
      - string
    doc: Allow N,M mismatches in indexes 1,2 respectively (see -m N).
    inputBinding:
      position: 1
      prefix: -M
  - id: min_distance_best_vs_next_best
    type:
      - 'null'
      - int
    doc: Require a minimum distance of N between the best and next best.
    inputBinding:
      position: 1
      prefix: -d
  - id: min_phred_quality
    type:
      - 'null'
      - int
    doc: Require a minimum phred quality of N to accept a barcode base.
    inputBinding:
      position: 1
      prefix: -q
  - id: reads
    type:
      type: array
      items: File
    doc: Input FASTQ files in order (the index read first when barcodes come 
      from an index read, then read1 and the mate reads).
    inputBinding:
      position: 2
  - id: output_files
    type:
      type: array
      items: string
      inputBinding:
        prefix: -o
    doc: Output file names, one per input read. Each must contain a '%' sign 
      which is replaced with the barcode id. Use 'n/a' to discard an input 
      (for example the barcode read).
    inputBinding:
      position: 3
outputs:
  - id: demultiplexed
    type:
      type: array
      items: File
    doc: Demultiplexed FASTQ files, one per barcode and output template
      (including the unmatched reads)
    outputBinding:
      glob: |
        ${
          var pats = [];
          for (var i = 0; i < inputs.output_files.length; i++) {
            var o = inputs.output_files[i];
            if (o !== 'n/a') { pats.push(o.replace('%', '*')); }
          }
          return pats;
        }
  - id: stdout
    type: stdout
    doc: Barcode statistics written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-multx:1.4.2--h9948957_5
stdout: fastq-multx.out
