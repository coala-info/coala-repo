cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cirtap
  - best
label: cirtap_best
doc: "Select best genomes based on stats retrieved from genome_summary\n\nTool homepage:
  https://github.com/MGXlab/cirtap/"
inputs:
  - id: output_path
    type: Directory
    doc: Path to write results
    inputBinding:
      position: 1
  - id: db_dir
    type: Directory
    doc: Path to the local mirror. Must contain a `RELEASE_NOTES` directory and 
      a `genomes` directory
    inputBinding:
      position: 102
      prefix: --db-dir
  - id: index_path
    type: Directory
    doc: Path to the index file
    inputBinding:
      position: 102
      prefix: --index-path
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write logging information in this file
    inputBinding:
      position: 102
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Define loglevel
    inputBinding:
      position: 102
  - id: ncbi_db
    type:
      - 'null'
      - File
    doc: Path to the taxa.sqlite created by ete3
    inputBinding:
      position: 102
  - id: thresh
    type:
      - 'null'
      - int
    doc: Integer threshold for including a genome based on completeness and 
      contamination stats. This is useed as completeness - 5*contamination > 
      thresh
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
stdout: cirtap_best.out
