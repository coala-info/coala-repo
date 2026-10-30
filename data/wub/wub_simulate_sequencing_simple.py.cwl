cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulate_sequencing_simple.py
label: wub_simulate_sequencing_simple.py
doc: "Sample fragments from the input genome and simulate sequencing errors. Read lengths are drawn from the specified truncated gamma distribution. Chromosomes are sampled randomly for each read. The format of the read names is the following: r<unique_id>_<chromosome>_<frag_start>_<frag_end>_<strand>/q<realised_quality>/s<realised_substiutions>/d<realised_deletions>/i<realised_insertions>\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: nr_reads
    type:
      - 'null'
      - int
    doc: "Number of simulated reads (1)."
    inputBinding:
      position: 1
      prefix: -n
  - id: mean_length
    type:
      - 'null'
      - int
    doc: "Mean read length (5000)."
    inputBinding:
      position: 2
      prefix: -m
  - id: gamma_shape
    type:
      - 'null'
      - float
    doc: "Read length distribution: gamma shape parameter (1)."
    inputBinding:
      position: 3
      prefix: -a
  - id: low_trunc
    type:
      - 'null'
      - int
    doc: "Read length distribution: lower truncation point (100)."
    inputBinding:
      position: 4
      prefix: -l
  - id: high_trunc
    type:
      - 'null'
      - int
    doc: "Read length distribution: upper truncation point (None)."
    inputBinding:
      position: 5
      prefix: -u
  - id: error_rate
    type:
      - 'null'
      - float
    doc: "Total rate of substitutions insertions and deletions (0.1)."
    inputBinding:
      position: 6
      prefix: -e
  - id: error_weights
    type:
      - 'null'
      - string
    doc: "Relative frequency of substitutions,insertions,deletions (1,1,4)."
    inputBinding:
      position: 7
      prefix: -w
  - id: strand_bias
    type:
      - 'null'
      - float
    doc: "Strand bias: the ratio of forward and reverse reads (0.5)."
    inputBinding:
      position: 8
      prefix: -b
  - id: mock_quality
    type:
      - 'null'
      - int
    doc: "Mock base quality for fastq output (40)."
    inputBinding:
      position: 9
      prefix: -q
  - id: true_sam
    type:
      - 'null'
      - string
    doc: "Save true alignments in this SAM file (None)."
    inputBinding:
      position: 10
      prefix: -s
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Be quiet and do not print progress bar (False)."
    inputBinding:
      position: 11
      prefix: -Q
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed (None)."
    inputBinding:
      position: 12
      prefix: -z
  - id: input_fasta
    type: File
    doc: "Input genome in fasta format (default: stdin)."
    inputBinding:
      position: 100
  - id: output_fastq
    type:
      - 'null'
      - string
    default: "simulate_sequencing_simple.fastq"
    doc: "Output fastq (default: stdout)"
    inputBinding:
      position: 101
outputs:
  - id: reads_fastq
    type: File
    doc: "Simulated reads"
    outputBinding:
      glob: $(inputs.output_fastq)
  - id: true_alignments
    type:
      - 'null'
      - File
    doc: "True alignments of the simulated reads"
    outputBinding:
      glob: $(inputs.true_sam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
