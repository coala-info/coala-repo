cwlVersion: v1.2
class: CommandLineTool
baseCommand: imsindel
label: imsindel
doc: "imsindel\n\nTool homepage: https://github.com/NCGG-MGC/IMSindel"
inputs:
  - id: alt_read_depth
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --alt-read-depth
  - id: bam
    type: File
    doc: /path/to/foo.bam
    inputBinding:
      position: 101
      prefix: --bam
  - id: baseq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --baseq
  - id: chr
    type:
      - 'null'
      - string
    doc: chromosome
    inputBinding:
      position: 101
      prefix: --chr
  - id: clip_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --clip-length
  - id: exclude_region
    type:
      - 'null'
      - File
    doc: /path/to/exclude-list
    inputBinding:
      position: 101
      prefix: --exclude-region
  - id: glsearch
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --glsearch
  - id: glsearch_mat
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --glsearch-mat
  - id: indelsize
    type:
      - 'null'
      - int
    doc: maximal indel-size
    inputBinding:
      position: 101
      prefix: --indelsize
  - id: mafft
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --mafft
  - id: mapq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --mapq
  - id: pair_within
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --pair-within
  - id: reffa
    type:
      - 'null'
      - File
    doc: /path/to/ref.fa
    inputBinding:
      position: 101
      prefix: --reffa
  - id: samtools
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --samtools
  - id: support_clip_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --support-clip-length
  - id: support_reads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --support-reads
  - id: temp
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 101
      prefix: --temp
  - id: thread
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --thread
  - id: within
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --within
  - id: outd_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outd_path`
    inputBinding:
      position: 102
      prefix: --outd
  - id: output_consensus_seq_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_consensus_seq_path`
    inputBinding:
      position: 103
      prefix: --output-consensus-seq
outputs:
  - id: outd
    type:
      - 'null'
      - Directory
    doc: /path/to/outoput-dir
    outputBinding:
      glob: $(inputs.outd_path)
  - id: output_consensus_seq
    type:
      - 'null'
      - Directory
    doc: /path/to/output-dir
    outputBinding:
      glob: $(inputs.output_consensus_seq_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imsindel:1.0.2--hdfd78af_1
