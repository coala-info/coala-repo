cwlVersion: v1.2
class: CommandLineTool
baseCommand: pispino_seqprep
label: pispino_pispino_seqprep
doc: "reindex, join, quality filter, convert and merge!\n\nTool homepage: https://github.com/hsgweon/pispino"
inputs:
  - id: base_phred_quality
    type:
      - 'null'
      - int
    doc: Base PHRED quality score
    default: 33
    inputBinding:
      position: 101
      prefix: -b
  - id: fastx_min_percent_bases
    type:
      - 'null'
      - int
    doc: FASTX FASTQ_QUALITY_FILTER - Minimum percent of bases that must have q 
      quality
    default: 80
    inputBinding:
      position: 101
      prefix: --FASTX-p
  - id: fastx_min_quality
    type:
      - 'null'
      - int
    doc: FASTX FASTQ_QUALITY_FILTER - Minimum quality score to keep
    default: 30
    inputBinding:
      position: 101
      prefix: --FASTX-q
  - id: fastx_remove_n
    type:
      - 'null'
      - boolean
    doc: FASTX FASTQ_TO_FASTA - remove sequences with unknown (N) nucleotides
    default: false
    inputBinding:
      position: 101
      prefix: --FASTX-n
  - id: forward_reads_only
    type:
      - 'null'
      - boolean
    doc: Do NOT join paired-end sequences, but just use the forward reads.
    inputBinding:
      position: 101
      prefix: --forwardreadsonly
  - id: input_dir
    type: Directory
    doc: Directory with raw sequences in gzipped FASTQ
    inputBinding:
      position: 101
      prefix: -i
  - id: joiner_method
    type:
      - 'null'
      - string
    doc: 'Joiner method: "PEAR" and "FASTQJOIN"'
    default: VSEARCH
    inputBinding:
      position: 101
      prefix: --joiner_method
  - id: pear_options
    type:
      - 'null'
      - string
    doc: 'User customisable parameter: You can add/change PEAR parameters. Please
      use "--PEAR_options=" followed by custom parameters wrapped around them. E.g.
      --PEAR_options="-v 8 -t 2". Note that if you put two same parameters such as
      "-v 8 -v 15", PEAR will use the later.'
    inputBinding:
      position: 101
      prefix: --PEAR_options
  - id: retain_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Retain intermediate files (Beware intermediate files use excessive disk
      space!)
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: Tap separated file with three columns for sample ids, forward-read 
      filename and reverse-read filename. Only the files listed in this file 
      will be processed.
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to output results
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pispino:1.1--py35_0
