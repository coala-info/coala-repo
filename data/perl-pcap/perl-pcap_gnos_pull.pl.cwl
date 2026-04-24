cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./gnos_pull.pl
label: perl-pcap_gnos_pull.pl
doc: "PCAP GNOS pull tool for retrieving ALIGNMENTS or CALLS metadata and data from
  GNOS repositories.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: analysis
    type: string
    doc: ALIGNMENTS or CALLS
    inputBinding:
      position: 101
      prefix: --analysis
  - id: config
    type: File
    doc: Mapping of GNOS repos to permissions keys
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: prints extra debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: info
    type:
      - 'null'
      - boolean
    doc: Just prints how many donor's will be included in pull and some stats.
    inputBinding:
      position: 101
      prefix: --info
  - id: man
    type:
      - 'null'
      - boolean
    doc: More verbose usage info
    inputBinding:
      position: 101
      prefix: --man
  - id: symlinks
    type:
      - 'null'
      - boolean
    doc: Rebuild symlinks only.
    inputBinding:
      position: 101
      prefix: --symlinks
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel GNOS retrievals.
    inputBinding:
      position: 101
      prefix: --threads
  - id: url
    type:
      - 'null'
      - string
    doc: The base URL to retrieve jsonl file from
    inputBinding:
      position: 101
      prefix: --url
outputs:
  - id: outdir
    type: Directory
    doc: Where to save jsonl and resulting GNOS downloads
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
