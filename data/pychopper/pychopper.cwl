cwlVersion: v1.2
class: CommandLineTool
baseCommand: pychopper
label: pychopper
doc: "Tool to identify, orient and rescue full-length cDNA reads.\n\nTool homepage:
  https://github.com/epi2me-labs/pychopper"
inputs:
  - id: input_fastx
    type: File
    doc: Input file.
    inputBinding:
      position: 101
  - id: output_fastx
    type: string
    doc: Output file.
    inputBinding:
      position: 102
  - id: primers
    type:
      - 'null'
      - File
    doc: Primers fasta.
    inputBinding:
      position: 1
      prefix: -b
  - id: phmm_file
    type:
      - 'null'
      - File
    doc: File with custom profile HMMs (None).
    inputBinding:
      position: 1
      prefix: -g
  - id: config_file
    type:
      - 'null'
      - File
    doc: File to specify primer configurations for each direction (None).
    inputBinding:
      position: 1
      prefix: -c
  - id: kit
    type:
      - 'null'
      - string
    doc: 'Use primer sequences from this kit (PCS109). One of PCS109, PCS110, PCS111,
      PCS114, LSK114, PCB111, PCB114.'
    inputBinding:
      position: 1
      prefix: -k
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff parameter (autotuned).
    inputBinding:
      position: 1
      prefix: -q
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum mean base quality (7.0).
    inputBinding:
      position: 1
      prefix: -Q
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum segment length (50).
    inputBinding:
      position: 1
      prefix: -z
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (pychopper.pdf).
    inputBinding:
      position: 1
      prefix: -r
  - id: unclass_output
    type:
      - 'null'
      - string
    doc: Write unclassified reads to this file.
    inputBinding:
      position: 1
      prefix: -u
  - id: len_fail_output
    type:
      - 'null'
      - string
    doc: Write fragments failing the length filter in this file.
    inputBinding:
      position: 1
      prefix: -l
  - id: rescue_output
    type:
      - 'null'
      - string
    doc: Write rescued reads to this file.
    inputBinding:
      position: 1
      prefix: -w
  - id: stats_output
    type:
      - 'null'
      - string
    doc: Write statistics to this file.
    inputBinding:
      position: 1
      prefix: -S
  - id: qc_fail_output
    type:
      - 'null'
      - string
    doc: Write reads failing mean quality filter to this file.
    inputBinding:
      position: 1
      prefix: -K
  - id: autotune_nr
    type:
      - 'null'
      - int
    doc: Approximate number of reads used for tuning the cutoff parameter (10000).
    inputBinding:
      position: 1
      prefix: -Y
  - id: autotune_samples
    type:
      - 'null'
      - int
    doc: Number of samples taken when tuning cutoff parameter (30).
    inputBinding:
      position: 1
      prefix: -L
  - id: scores_output
    type:
      - 'null'
      - string
    doc: Write alignment scores to this BED file.
    inputBinding:
      position: 1
      prefix: -A
  - id: method
    type:
      - 'null'
      - string
    doc: 'Detection method: phmm or edlib (phmm).'
    inputBinding:
      position: 1
      prefix: -m
  - id: rescue
    type:
      - 'null'
      - string
    doc: 'Protocol-specific read rescue: DCS109 (None).'
    inputBinding:
      position: 1
      prefix: -x
  - id: keep_primers
    type:
      - 'null'
      - boolean
    doc: Keep primers, but trim the rest.
    inputBinding:
      position: 1
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (8).
    inputBinding:
      position: 1
      prefix: -t
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Maximum number of reads processed in each batch (10000).
    inputBinding:
      position: 1
      prefix: -B
  - id: read_stats
    type:
      - 'null'
      - string
    doc: Tab separated file with per-read stats (None).
    inputBinding:
      position: 1
      prefix: -D
  - id: comment_as_bam_tags
    type:
      - 'null'
      - boolean
    doc: Output FASTQ comment as BAM tags. Use with minimap2 -y to pass UMI and additional
      info into BAM file.
    inputBinding:
      position: 1
      prefix: -y
  - id: detect_umis
    type:
      - 'null'
      - boolean
    doc: Detect UMIs
    inputBinding:
      position: 1
      prefix: -U
outputs:
  - id: output_fastx_out
    type: File
    doc: Output file with the oriented, trimmed full-length reads.
    outputBinding:
      glob: $(inputs.output_fastx)
  - id: unclassified
    type:
      - 'null'
      - File
    doc: Unclassified reads
    outputBinding:
      glob: $(inputs.unclass_output)
  - id: length_failed
    type:
      - 'null'
      - File
    doc: Fragments failing the length filter
    outputBinding:
      glob: $(inputs.len_fail_output)
  - id: rescued
    type:
      - 'null'
      - File
    doc: Rescued reads
    outputBinding:
      glob: $(inputs.rescue_output)
  - id: stats
    type:
      - 'null'
      - File
    doc: Statistics file
    outputBinding:
      glob: $(inputs.stats_output)
  - id: qc_failed
    type:
      - 'null'
      - File
    doc: Reads failing the mean quality filter
    outputBinding:
      glob: $(inputs.qc_fail_output)
  - id: scores
    type:
      - 'null'
      - File
    doc: Alignment scores BED file
    outputBinding:
      glob: $(inputs.scores_output)
  - id: read_stats_out
    type:
      - 'null'
      - File
    doc: Per-read stats file
    outputBinding:
      glob: $(inputs.read_stats)
  - id: report
    type:
      - 'null'
      - File
    doc: PDF report file
    outputBinding:
      glob: $(inputs.report_pdf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pychopper:2.7.10--pyhdfd78af_0
