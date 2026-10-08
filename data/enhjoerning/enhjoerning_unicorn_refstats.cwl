cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - refstats
label: enhjoerning_unicorn_refstats
doc: "Compute per reference statistics.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: bam
    type: File
    doc: "Input BAM or SAM file"
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads [4]"
    inputBinding:
      position: 101
      prefix: -t
  - id: outbam
    type:
      - 'null'
      - string
    doc: "Output BAM file with filtered alignments."
    inputBinding:
      position: 101
      prefix: -o
  - id: outstat
    type:
      - 'null'
      - string
    doc: "Output statistics file"
    inputBinding:
      position: 101
      prefix: --outstat
  - id: minrefl
    type:
      - 'null'
      - int
    doc: "Minimum reference length to consider [0]"
    inputBinding:
      position: 101
      prefix: --minrefl
  - id: minreads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads to consider [1]"
    inputBinding:
      position: 101
      prefix: --minreads
  - id: minalnas
    type:
      - 'null'
      - int
    doc: "Minimum alignment score [-Inf]"
    inputBinding:
      position: 101
      prefix: --minalnas
  - id: maxdust
    type:
      - 'null'
      - int
    doc: "Maximum alignment dust score [100]"
    inputBinding:
      position: 101
      prefix: --maxdust
  - id: withtid
    type:
      - 'null'
      - boolean
    doc: "Report taxid of reference sequence. Requires --acc2tax, --names and --nodes options."
    inputBinding:
      position: 101
      prefix: --withtid
  - id: names
    type:
      - 'null'
      - File
    doc: "Taxonomy nodeid to name mapping file."
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes
    type:
      - 'null'
      - File
    doc: "Taxonomy nodeid to parent nodeid mapping file."
    inputBinding:
      position: 101
      prefix: --nodes
  - id: acc2tax
    type:
      - 'null'
      - File
    doc: "Accession to taxid mapping file or .khash file."
    inputBinding:
      position: 101
      prefix: --acc2tax
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print libunicorn's messages."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: "Per reference statistics (when --outstat is not given)"
  - id: out_bam
    type:
      - 'null'
      - File
    doc: "Output BAM file with filtered alignments"
    outputBinding:
      glob: $(inputs.outbam)
  - id: out_stat
    type:
      - 'null'
      - File
    doc: Output statistics file
    outputBinding:
      glob: $(inputs.outstat)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn_refstats.out
