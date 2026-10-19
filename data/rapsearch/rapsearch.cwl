cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapsearch
label: rapsearch
doc: 'RAPSearch2: fast protein similarity search tool for short reads. The database
  is made with prerapsearch.


  Tool homepage: https://omics.informatics.indiana.edu/mg/RAPSearch2/'
inputs:
  - id: query_file
    type: File
    doc: query file or stdin (FASTA or FASTQ format)
    inputBinding:
      position: 101
      prefix: -q
  - id: database
    type: string
    doc: database file (base name only, with full path)
    inputBinding:
      position: 101
      prefix: -d
  - id: database_files
    type:
      type: array
      items: File
    doc: Database files made by prerapsearch (the hash file and the .info file), staged
      in the working directory so that the base name resolves
  - id: output_file
    type: string
    doc: output file name (the tool writes <name>.m8 and <name>.aln)
    inputBinding:
      position: 101
      prefix: -o
  - id: stream_output
    type:
      - 'null'
      - int
    doc: 'stream one result through stdout [1: m8 result, 2: aln result, default:
      don''t stream any result through stdout]'
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads [default: 1]'
    inputBinding:
      position: 101
      prefix: -z
  - id: report_evalue_format
    type:
      - 'null'
      - string
    doc: 'report log10(E-value) or E-value for each hit [t/T: log10(E-value), the
      default; f/F: E-value]'
    inputBinding:
      position: 101
      prefix: -s
  - id: evalue_threshold
    type:
      - 'null'
      - double
    doc: 'E-value threshold, given in the format of log10(E-value), or E-value (when
      -s is set to f) [default: 1.0/10.0].'
    inputBinding:
      position: 101
      prefix: -e
  - id: bit_score_threshold
    type:
      - 'null'
      - double
    doc: 'threshold of bit score [default: 0.0]. It is the alternative option to limit
      the hits to report.'
    inputBinding:
      position: 101
      prefix: -i
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: 'threshold of minimal alignment length [default: 0]'
    inputBinding:
      position: 101
      prefix: -l
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: 'number of database sequences to show one-line descriptions [default: 500].
      If it''s -1, all results will be shown.'
    inputBinding:
      position: 101
      prefix: -v
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: 'number of database sequence to show alignments [default: 100]. If it''s
      -1, all results will be shown.'
    inputBinding:
      position: 101
      prefix: -b
  - id: query_sequence_type
    type:
      - 'null'
      - string
    doc: 'type of query sequences [u/U:unknown, n/N:nucleotide, a/A:amino acid, q/Q:fastq,
      default: u]'
    inputBinding:
      position: 101
      prefix: -t
  - id: output_matched_reads
    type:
      - 'null'
      - string
    doc: 'output ALL/MATCHED query reads into the alignment file [t/T: output all
      query reads, f/F: output matched reads, default: f]'
    inputBinding:
      position: 101
      prefix: -p
  - id: apply_gap_extension
    type:
      - 'null'
      - string
    doc: 'apply gap extension [t/T: yes, f/F: no, default: t]'
    inputBinding:
      position: 101
      prefix: -g
  - id: fast_mode
    type:
      - 'null'
      - string
    doc: 'use fast mode (10~30 fold) [t/T: yes, f/F: no, default: f]'
    inputBinding:
      position: 101
      prefix: -a
  - id: use_hssp_criterion
    type:
      - 'null'
      - string
    doc: 'apply HSSP criterion instead of E-value criterion [t/T: HSSP, f/F: E-value
      criteria, default: f]'
    inputBinding:
      position: 101
      prefix: -w
  - id: output_xml
    type:
      - 'null'
      - string
    doc: 'print hits in xml format [t/T: yes, f/F: no, default: f]'
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Streamed result (empty unless -u is used)
  - id: hits_files
    type:
      type: array
      items: File
    doc: Alignment and m8 hit files written with the output name
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.database_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapsearch:2.24--1
stdout: rapsearch.out
