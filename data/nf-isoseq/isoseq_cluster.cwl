cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, cluster]
label: isoseq_cluster
doc: "Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS)

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: flnc_bam
    type: File
    doc: "Input flnc BAM or ConsensusReadSet XML"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: transcripts_output
    type: string
    doc: "Output transcripts BAM or TranscriptSet XML"
    inputBinding:
      position: 2
  - id: poa_cov
    type: ['null', int]
    doc: "Maximum number of CCS reads used for POA consensus. [100]"
    inputBinding:
      position: 100
      prefix: --poa-cov
  - id: min_subreads_split
    type: ['null', int]
    doc: "Subread threshold for HQ/LQ split. [7]"
    inputBinding:
      position: 100
      prefix: --min-subreads-split
  - id: split_bam
    type: ['null', int]
    doc: "Split BAM output files into at maximum N files; 0 means no splitting [0]"
    inputBinding:
      position: 100
      prefix: --split-bam
  - id: singletons
    type: ['null', boolean]
    doc: "Output FLNCs that could not be clustered."
    inputBinding:
      position: 100
      prefix: --singletons
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]"
    inputBinding:
      position: 100
      prefix: --log-level
  - id: log_file
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 100
      prefix: --log-file
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection. [0]"
    inputBinding:
      position: 100
      prefix: --num-threads
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: transcripts_bam
    type: File
    doc: "Transcripts BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.transcripts_output)
  - id: hq_bam
    type: ['null', File]
    doc: "High-quality transcripts BAM"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).hq.bam
  - id: lq_bam
    type: ['null', File]
    doc: "Low-quality transcripts BAM"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).lq.bam
  - id: hq_fasta
    type: ['null', File]
    doc: "High-quality transcripts FASTA"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).hq.fasta.gz
  - id: lq_fasta
    type: ['null', File]
    doc: "Low-quality transcripts FASTA"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).lq.fasta.gz
  - id: cluster_report
    type: ['null', File]
    doc: "Cluster report CSV"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).cluster_report.csv
  - id: cluster_membership
    type: ['null', File]
    doc: "Cluster membership"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).cluster
  - id: singletons_bam
    type: ['null', File]
    doc: "Singletons BAM (with singletons)"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).singletons.bam
  - id: transcriptset_xml
    type: ['null', File]
    doc: "TranscriptSet XML"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).transcriptset.xml
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
