cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch
label: gsearch_add
doc: "Add new genome files to a pre-built HNSW graph database\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
arguments:
  - position: 10
    valueFrom: add
inputs:
  - id: hnsw_dir
    type: Directory
    doc: "set the name of directory containing already constructed hnsw data"
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: newdata_dir
    type: Directory
    doc: "set directory containing new data"
    inputBinding:
      position: 101
      prefix: --new
  - id: pio
    type:
      - 'null'
      - int
    doc: "Parallel IO processing"
    inputBinding:
      position: 1
      prefix: --pio
  - id: nbthreads
    type:
      - 'null'
      - int
    doc: "Number of threads for sketching"
    inputBinding:
      position: 2
      prefix: --nbthreads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages of the command
  - id: hnsw_dir_out
    type: Directory
    doc: The database directory with the new genomes added
    outputBinding:
      glob: $(inputs.hnsw_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hnsw_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_add.out
stderr: gsearch_add.log
