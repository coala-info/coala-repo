cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygcap
label: pygcap
doc: "Find Gene Cluster\n\nTool homepage: https://github.com/jrim42/pyGCAP"
inputs:
  - id: taxon
    type: string
    doc: Taxon identifier
    inputBinding:
      position: 1
  - id: probe_path
    type: File
    doc: Probe file path
    inputBinding:
      position: 2
  - id: identity
    type:
      - 'null'
      - float
    inputBinding:
      position: 103
      prefix: --identity
  - id: max_target_seqs
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --max_target_seqs
  - id: skip
    type:
      - 'null'
      - string
    doc: Options to skip steps, e.g., ncbi, mmseqs2, parsing, uniprot, blastdb 
      or all
    inputBinding:
      position: 103
      prefix: --skip
  - id: thread
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --thread
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Working directory path
    inputBinding:
      position: 103
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygcap:1.2.6--pyhdfd78af_0
stdout: pygcap.out
