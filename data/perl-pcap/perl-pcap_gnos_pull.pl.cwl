cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnos_pull.pl
label: perl-pcap_gnos_pull.pl
doc: "Pull alignments or calls from GNOS repositories into a local mirror\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: analysis
    type: string
    doc: "ALIGNMENTS or CALLS"
    inputBinding:
      position: 101
      prefix: --analysis
  - id: outdir
    type: string
    doc: "Where to save jsonl and resulting GNOS downloads"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: config
    type: File
    doc: "Mapping of GNOS repos to permissions keys"
    inputBinding:
      position: 101
      prefix: --config
  - id: symlinks
    type:
      - 'null'
      - boolean
    doc: "Rebuild symlinks only"
    inputBinding:
      position: 101
      prefix: --symlinks
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel GNOS retrievals"
    inputBinding:
      position: 101
      prefix: --threads
  - id: url
    type:
      - 'null'
      - string
    doc: "The base URL to retrieve jsonl file from [http://pancancer.info/gnos_metadata/latest/]"
    inputBinding:
      position: 101
      prefix: --url
  - id: info
    type:
      - 'null'
      - boolean
    doc: "Just print how many donors will be included in the pull and some stats"
    inputBinding:
      position: 101
      prefix: --info
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print extra debug information"
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_out
    type:
      - 'null'
      - Directory
    doc: "Output folder with the jsonl file and GNOS downloads"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_gnos_pull.pl.out
