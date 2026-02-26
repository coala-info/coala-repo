cwlVersion: v1.2
class: CommandLineTool
baseCommand: gencore
label: gencore
doc: "Processes BAM/SAM files with reference and optional BED regions, generating
  consensus sequences and reports.\n\nTool homepage: https://github.com/OpenGene/gencore"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: bed file to specify the capturing region, none by default
    default: ''
    inputBinding:
      position: 101
      prefix: --bed
  - id: coverage_sampling
    type:
      - 'null'
      - int
    doc: the sampling rate for genome scale coverage statistics. Default 10000 
      means 1/10000.
    default: 10000
    inputBinding:
      position: 101
      prefix: --coverage_sampling
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output some debug information to STDERR.
    inputBinding:
      position: 101
      prefix: --debug
  - id: duplex_diff_threshold
    type:
      - 'null'
      - int
    doc: if the forward consensus and reverse consensus sequences have <= 
      <duplex_diff_threshold> mismatches, then they will be merged to generate a
      duplex consensus sequence, otherwise will be discarded. Default value is 
      2.
    default: 2
    inputBinding:
      position: 101
      prefix: --duplex_diff_threshold
  - id: duplex_only
    type:
      - 'null'
      - boolean
    doc: only output duplex consensus sequences, which means single stranded 
      consensus sequences will be discarded.
    inputBinding:
      position: 101
      prefix: --duplex_only
  - id: high_qual
    type:
      - 'null'
      - int
    doc: the threshold for a quality score to be considered as high quality. 
      Default 30 means Q30.
    default: 30
    inputBinding:
      position: 101
      prefix: --high_qual
  - id: input_file
    type:
      - 'null'
      - File
    doc: input sorted bam/sam file. STDIN will be read from if it's not 
      specified
    default: STDIN
    inputBinding:
      position: 101
      prefix: --in
  - id: json_report
    type:
      - 'null'
      - File
    doc: the json format report file name
    default: gencore.json
    inputBinding:
      position: 101
      prefix: --json
  - id: low_qual
    type:
      - 'null'
      - int
    doc: the threshold for a quality score to be considered as low quality. 
      Default 15 means Q15.
    default: 15
    inputBinding:
      position: 101
      prefix: --low_qual
  - id: moderate_qual
    type:
      - 'null'
      - int
    doc: the threshold for a quality score to be considered as moderate quality.
      Default 20 means Q20.
    default: 20
    inputBinding:
      position: 101
      prefix: --moderate_qual
  - id: no_duplex
    type:
      - 'null'
      - boolean
    doc: don't merge single stranded consensus sequences to duplex consensus 
      sequences.
    inputBinding:
      position: 101
      prefix: --no_duplex
  - id: output_file
    type:
      - 'null'
      - File
    doc: output bam/sam file. STDOUT will be written to if it's not specified
    default: STDOUT
    inputBinding:
      position: 101
      prefix: --out
  - id: quit_after_contig
    type:
      - 'null'
      - int
    doc: stop when <quit_after_contig> contigs are processed. Only used for fast
      debugging. Default 0 means no limitation.
    default: 0
    inputBinding:
      position: 101
      prefix: --quit_after_contig
  - id: ratio_threshold
    type:
      - 'null'
      - float
    doc: if the ratio of the major base in a cluster is less than 
      <ratio_threshold>, it will be further compared to the reference. The valud
      should be 0.5~1.0, and the default value is 0.8
    default: 0.8
    inputBinding:
      position: 101
      prefix: --ratio_threshold
  - id: ref
    type: File
    doc: reference fasta file name (should be an uncompressed .fa/.fasta file)
    inputBinding:
      position: 101
      prefix: --ref
  - id: score_threshold
    type:
      - 'null'
      - int
    doc: if the score of the major base in a cluster is less than 
      <score_threshold>, it will be further compared to the reference. The valud
      should be 1~20, and the default value is 6
    default: 6
    inputBinding:
      position: 101
      prefix: --score_threshold
  - id: supporting_reads
    type:
      - 'null'
      - int
    doc: only output consensus reads/pairs that merged by >= <supporting_reads> 
      reads/pairs. The valud should be 1~10, and the default value is 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --supporting_reads
  - id: umi_diff_threshold
    type:
      - 'null'
      - int
    doc: if two reads with identical mapping position have UMI difference <= 
      <umi_diff_threshold>, then they will be merged to generate a consensus 
      read. Default value is 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --umi_diff_threshold
  - id: umi_prefix
    type:
      - 'null'
      - string
    doc: the prefix for UMI, if it has. None by default. Check the README for 
      the defails of UMI formats.
    default: auto
    inputBinding:
      position: 101
      prefix: --umi_prefix
outputs:
  - id: html_report
    type:
      - 'null'
      - File
    doc: the html format report file name
    outputBinding:
      glob: $(inputs.html_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencore:0.17.2--he5ce664_4
