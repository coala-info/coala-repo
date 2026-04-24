cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_emirge_makedb.py
label: emirge_emirge_makedb.py
doc: "emirge_makedb.py creates a reference database and the necessay indices for use
  by EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py
  will 1) download the most recent SILVA SSU database, 2) filter it by sequence length,
  3) cluster at 97% sequence identity, 4) replace ambiguous bases with random characters
  and 5) create a bowtie index.\n\nTool homepage: https://github.com/csmiller/EMIRGE"
inputs:
  - id: bowtie_build
    type:
      - 'null'
      - File
    doc: path to bowtie-build binary
    inputBinding:
      position: 101
      prefix: --bowtie-build
  - id: gene
    type:
      - 'null'
      - string
    doc: build database from this gene (SSU=Small Subunit rRNA; LSU=Large 
      Subunit rRNA)
    inputBinding:
      position: 101
      prefix: --gene
  - id: id
    type:
      - 'null'
      - float
    doc: Cluster at this fractional identity level
    inputBinding:
      position: 101
      prefix: --id
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep intermediary files
    inputBinding:
      position: 101
      prefix: --keep
  - id: max_len
    type:
      - 'null'
      - int
    doc: maximum reference sequence length
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum reference sequence length
    inputBinding:
      position: 101
      prefix: --min-len
  - id: release
    type:
      - 'null'
      - int
    doc: SILVA release number
    inputBinding:
      position: 101
      prefix: --release
  - id: silva_license_accepted
    type:
      - 'null'
      - boolean
    doc: I have read and accepted the SILVA license.
    inputBinding:
      position: 101
      prefix: --silva-license-accepted
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for vsearch clustering of database
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: working directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: vsearch
    type:
      - 'null'
      - File
    doc: path to vsearch binary
    inputBinding:
      position: 101
      prefix: --vsearch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_makedb.py.out
