cwlVersion: v1.2
class: CommandLineTool
baseCommand: padloc
label: padloc
doc: "Locate antiviral defence systems in prokaryotic genomes\n\nTool homepage: https://github.com/padlocbio/padloc"
inputs:
  - id: check_deps
    type:
      - 'null'
      - boolean
    doc: Check that dependencies are installed
    inputBinding:
      position: 101
      prefix: --check-deps
  - id: cpu
    type:
      - 'null'
      - int
    doc: Use [n] CPUs
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: crispr
    type:
      - 'null'
      - File
    doc: CRISPRDetect output file containing array data
    inputBinding:
      position: 101
      prefix: --crispr
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Data directory
    default: /usr/local/data
    inputBinding:
      position: 101
      prefix: --data
  - id: db_install
    type:
      - 'null'
      - string
    doc: Install specific PADLOC-DB release [n]
    inputBinding:
      position: 101
      prefix: --db-install
  - id: db_list
    type:
      - 'null'
      - boolean
    doc: List all PADLOC-DB releases
    inputBinding:
      position: 101
      prefix: --db-list
  - id: db_update
    type:
      - 'null'
      - boolean
    doc: Install latest PADLOC-DB release
    inputBinding:
      position: 101
      prefix: --db-update
  - id: db_version
    type:
      - 'null'
      - boolean
    doc: Print database version information
    inputBinding:
      position: 101
      prefix: --db-version
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run with debug messages
    inputBinding:
      position: 101
      prefix: --debug
  - id: faa
    type:
      - 'null'
      - File
    doc: Amino acid FASTA file (only valid with [--gff])
    inputBinding:
      position: 101
      prefix: --faa
  - id: fix_prodigal
    type:
      - 'null'
      - boolean
    doc: Set this flag when providing an FAA and GFF file generated with 
      prodigal to force fixing of sequence IDs
    inputBinding:
      position: 101
      prefix: --fix-prodigal
  - id: fna
    type:
      - 'null'
      - File
    doc: Nucleic acid FASTA file
    inputBinding:
      position: 101
      prefix: --fna
  - id: gff
    type:
      - 'null'
      - File
    doc: GFF file (only valid with [--faa])
    inputBinding:
      position: 101
      prefix: --gff
  - id: ncrna
    type:
      - 'null'
      - File
    doc: Infernal output file containing ncRNA data
    inputBinding:
      position: 101
      prefix: --ncrna
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/padloc:2.0.0--hdfd78af_0
stdout: padloc.out
