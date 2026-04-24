cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./NGmerge
label: ngmerge_NGmerge
doc: "Merges paired-end reads from FASTQ files.\n\nTool homepage: https://github.com/harvardinformatics/NGmerge"
inputs:
  - id: adapter_removal_mode
    type:
      - 'null'
      - boolean
    doc: Use 'adapter-removal' mode (also sets -d option)
    inputBinding:
      position: 101
      prefix: -a
  - id: check_dovetailing
    type:
      - 'null'
      - boolean
    doc: Option to check for dovetailing (with 3' overhangs)
    inputBinding:
      position: 101
      prefix: -d
  - id: dovetailed_reads_log
    type:
      - 'null'
      - File
    doc: Log file for dovetailed reads (adapter sequences)
    inputBinding:
      position: 101
      prefix: -c
  - id: error_profile_file
    type:
      - 'null'
      - File
    doc: Use given error profile for merged qual scores
    inputBinding:
      position: 101
      prefix: -w
  - id: fastq_quality_offset
    type:
      - 'null'
      - int
    doc: FASTQ quality offset
    inputBinding:
      position: 101
      prefix: -q
  - id: formatted_alignments_log
    type:
      - 'null'
      - File
    doc: Log file for formatted alignments of merged reads
    inputBinding:
      position: 101
      prefix: -j
  - id: forward_reads
    type: File
    doc: Input FASTQ file with reads from forward direction
    inputBinding:
      position: 101
      prefix: '-1'
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Option to gzip FASTQ output(s)
    inputBinding:
      position: 101
      prefix: -z
  - id: header_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter for headers of paired reads
    inputBinding:
      position: 101
      prefix: -t
  - id: interleaved_fastq
    type:
      - 'null'
      - boolean
    doc: Option to produce interleaved FASTQ output(s)
    inputBinding:
      position: 101
      prefix: -i
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file for stitching results of each read pair
    inputBinding:
      position: 101
      prefix: -l
  - id: max_input_quality_score
    type:
      - 'null'
      - int
    doc: Maximum input quality score (0-based)
    inputBinding:
      position: 101
      prefix: -u
  - id: min_dovetail_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap of dovetailed alignments
    inputBinding:
      position: 101
      prefix: -e
  - id: min_output_length
    type:
      - 'null'
      - int
    doc: Minimum length of output reads
    inputBinding:
      position: 101
      prefix: -x
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap of the paired-end reads
    inputBinding:
      position: 101
      prefix: -m
  - id: mismatches_fraction
    type:
      - 'null'
      - float
    doc: Mismatches to allow in the overlapped region (a fraction of the overlap
      length)
    inputBinding:
      position: 101
      prefix: -p
  - id: no_gzip_output
    type:
      - 'null'
      - boolean
    doc: Option to not gzip FASTQ output(s)
    inputBinding:
      position: 101
      prefix: -y
  - id: reverse_reads
    type: File
    doc: Input FASTQ file with reads from reverse direction
    inputBinding:
      position: 101
      prefix: '-2'
  - id: shortest_stitched_read
    type:
      - 'null'
      - boolean
    doc: Option to produce shortest stitched read
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -n
  - id: use_fastq_join_method
    type:
      - 'null'
      - boolean
    doc: Use 'fastq-join' method for merged qual scores
    inputBinding:
      position: 101
      prefix: -g
  - id: validate_mode
    type:
      - 'null'
      - boolean
    doc: Use 'validate' mode (skip alignment)
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Option to print status updates/counts to stderr
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: "Output FASTQ file(s): - in 'stitch' mode (def.), the file of merged reads
      - in 'adapter-removal' mode (-a) or 'validate' mode (-r), the output files will
      be <file>_1.fastq and <file>_2.fastq"
    outputBinding:
      glob: $(inputs.output_file)
  - id: failed_stitching_file
    type:
      - 'null'
      - File
    doc: FASTQ files for reads that failed stitching (output as <file>_1.fastq 
      and <file>_2.fastq)
    outputBinding:
      glob: $(inputs.failed_stitching_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmerge:0.5--h89d970f_0
