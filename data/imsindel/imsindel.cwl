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
    secondaryFiles:
      - .bai
    doc: /path/to/foo.bam (coordinate sorted, with .bai index)
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
    type: string
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
    type: int
    doc: maximal indel-size (the reference window around a candidate is this
      long, so it must be larger than the read length)
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
    type: File
    secondaryFiles:
      - .fai
    doc: /path/to/ref.fa (with .fai index)
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
      - string
    default: /tmp
    doc: Temporary directory (must exist)
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
    type: string
    doc: /path/to/outoput-dir
    inputBinding:
      position: 102
      prefix: --outd
  - id: output_consensus_seq_path
    type:
      - 'null'
      - string
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
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outd_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
      - entryname: '$(inputs.output_consensus_seq_path ? inputs.output_consensus_seq_path : "unused_consensus_dir")'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imsindel:1.0.2--hdfd78af_1
