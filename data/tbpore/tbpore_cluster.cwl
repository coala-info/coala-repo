cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbpore
  - cluster
label: tbpore_cluster
doc: "Cluster consensus sequences\n\nTool homepage: https://github.com/mbhall88/tbpore/"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Two or more consensus fasta sequences. Use glob patterns to input 
      several easily (e.g. output/sample_*/*.consensus.fa).
    inputBinding:
      position: 1
  - id: cache
    type:
      - 'null'
      - Directory
    doc: Path to use for the cache
    default: /root/.cache
    inputBinding:
      position: 102
      prefix: --cache
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove all temporary files on *successful* completion
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Remove all temporary files on *successful* completion
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to place output files
    default: .
    inputBinding:
      position: 102
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in multithreaded tools
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Clustering threshold
    default: 6
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Specify where to write all (tbpore) temporary files.
    default: <outdir>/.tbpore
    inputBinding:
      position: 102
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
stdout: tbpore_cluster.out
