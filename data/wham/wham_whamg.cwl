cwlVersion: v1.2
class: CommandLineTool
baseCommand: whamg
label: wham_whamg
doc: "WHAM-GRAPHENING: structural variant caller. Reads one or more BAM files and
  writes SV calls in VCF to standard output (run statistics go to standard error).\n\nTool
  homepage: https://github.com/zeeev/wham"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Comma separated list of bam files
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 1
      prefix: -f
      itemSeparator: ','
  - id: reference
    type: File
    doc: The reference genome (indexed fasta)
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 1
      prefix: -a
  - id: stats_only
    type:
      - 'null'
      - boolean
    doc: Exits the program after the stats are gathered
    inputBinding:
      position: 1
      prefix: -s
  - id: graph_file
    type:
      - 'null'
      - string
    doc: File to write graph to (very large output)
    inputBinding:
      position: 1
      prefix: -g
  - id: exclude_seqids
    type:
      - 'null'
      - string
    doc: Comma sep. list of seqids to skip (use -e or -c, not both)
    inputBinding:
      position: 1
      prefix: -e
  - id: keep_seqids
    type:
      - 'null'
      - string
    doc: Comma sep. list of seqids to keep
    inputBinding:
      position: 1
      prefix: -c
  - id: region
    type:
      - 'null'
      - string
    doc: Region in format seqid:start-end [whole genome]
    inputBinding:
      position: 1
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use [1 CPU]
    inputBinding:
      position: 1
      prefix: -x
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: Mapping quality filter [20]
    inputBinding:
      position: 1
      prefix: -m
  - id: split_read_tag
    type:
      - 'null'
      - string
    doc: non standard split read tag [SA]
    inputBinding:
      position: 1
      prefix: -i
  - id: sample_until_success
    type:
      - 'null'
      - boolean
    doc: Sample reads until success
    inputBinding:
      position: 1
      prefix: -z
  - id: min_matching_bases
    type:
      - 'null'
      - int
    doc: Minimum number of matching bases (both reads) [100]
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: vcf
    type: stdout
    doc: SV calls in VCF format
  - id: graph_out
    type:
      - 'null'
      - File
    doc: Graph file
    outputBinding:
      glob: $(inputs.graph_file)
  - id: stderr_log
    type: stderr
    doc: Run statistics and bam stats
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
stdout: whamg.vcf
stderr: whamg.log
