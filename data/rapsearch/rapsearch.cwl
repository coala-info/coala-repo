cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapsearch
label: rapsearch
doc: "Fast protein similarity search tool for short reads\n\nTool homepage: https://github.com/zhaoyanswill/RAPSearch2"
inputs:
  - id: apply_gap_extension
    type:
      - 'null'
      - string
    doc: 'apply gap extension [t/T: yes, f/F: no, default: t]'
    inputBinding:
      position: 101
      prefix: -g
  - id: bit_score_threshold
    type:
      - 'null'
      - double
    doc: 'threshold of bit score [default: 0.0]. It is the alternative option to limit
      the hits to report.'
    inputBinding:
      position: 101
      prefix: -i
  - id: database
    type: string
    doc: database file (**base name only**, with full path)
    inputBinding:
      position: 101
      prefix: -d
  - id: evalue_threshold
    type:
      - 'null'
      - double
    doc: E-value threshold, given in the format of log10(E-value), or E-value 
      (when -s is set to f)
    inputBinding:
      position: 101
      prefix: -e
  - id: fast_mode
    type:
      - 'null'
      - string
    doc: 'use fast mode (10~30 fold) [t/T: yes, f/F: no, default: f]'
    inputBinding:
      position: 101
      prefix: -a
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: threshold of minimal alignment length
    inputBinding:
      position: 101
      prefix: -l
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: "number of database sequence to show alignments [default: 100]. If it's -1,
      all results will be shown."
    inputBinding:
      position: 101
      prefix: -b
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: "number of database sequences to show one-line descriptions [default: 500].
      If it's -1, all results will be shown."
    inputBinding:
      position: 101
      prefix: -v
  - id: output_matched_reads
    type:
      - 'null'
      - string
    doc: 'output ALL/MATCHED query reads into the alignment file [t/T: output all
      query reads, f/F: output matched reads, default: f]'
    inputBinding:
      position: 101
      prefix: -p
  - id: output_xml
    type:
      - 'null'
      - string
    doc: 'print hits in xml format [t/T: yes, f/F: no, default: f]'
    inputBinding:
      position: 101
      prefix: -x
  - id: query_file
    type: File
    doc: query file or stdin (FASTA or FASTQ format)
    inputBinding:
      position: 101
      prefix: -q
  - id: query_sequence_type
    type:
      - 'null'
      - string
    doc: 'type of query sequences [u/U:unknown, n/N:nucleotide, a/A:amino acid, q/Q:fastq,
    inputBinding:
      position: 101
      prefix: -t
  - id: report_evalue_format
    type:
      - 'null'
      - string
    doc: 'report log10(E-value) or E-value for each hit [t/T: log10(E-value), the
      default; f/F: E-value]'
    inputBinding:
      position: 101
      prefix: -s
  - id: stream_output
    type:
      - 'null'
      - int
    doc: "stream one result through stdout [1: m8 result, 2: aln result, default:
      don't stream any result through stdout]"
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -z
  - id: use_hssp_criterion
    type:
      - 'null'
      - string
    doc: 'apply HSSP criterion instead of E-value criterion [t/T: HSSP, f/F: E-value
      criteria, default: f]'
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapsearch:2.24--1
