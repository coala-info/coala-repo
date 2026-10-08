cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_cluster.py
label: freddie_freddie_cluster.py
doc: "Cluster segmented reads into isoforms with an integer linear program (needs
  the Gurobi solver).\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs:
  - id: segment_dir
    type: Directory
    doc: Path to Freddie segment directory of the reads
    inputBinding:
      position: 101
      prefix: --segment-dir
  - id: recycle_model
    type:
      - 'null'
      - string
    doc: 'Model type: constant, exons, introns, relative. Default: constant'
    inputBinding:
      position: 101
      prefix: --recycle-model
  - id: gap_offset
    type:
      - 'null'
      - int
    doc: 'Slack +- value for exons and the unaligned gaps. Default: 20'
    inputBinding:
      position: 101
      prefix: --gap-offset
  - id: epsilon
    type:
      - 'null'
      - float
    doc: 'Epsilon percent value for how much can unaligned gaps can cover. Default:
      0.2'
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: max_rounds
    type:
      - 'null'
      - int
    doc: 'Maximum number of ILP rounds. Default 30'
    inputBinding:
      position: 101
      prefix: --max-rounds
  - id: min_isoform_size
    type:
      - 'null'
      - int
    doc: 'Minimum isoform size in terms of number supporting reads. Default 3'
    inputBinding:
      position: 101
      prefix: --min-isoform-size
  - id: max_ilp
    type:
      - 'null'
      - int
    doc: 'Maximum number of unique reads allowed for an ILP instance. ILP instances
      with more reads will have their input broken into evenly sized problems, each
      with less than the max. Default 1000'
    inputBinding:
      position: 101
      prefix: --max-ilp
  - id: timeout
    type:
      - 'null'
      - int
    doc: 'Gurobi time-out in minutes. Default: 1'
    inputBinding:
      position: 101
      prefix: --timeout
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: logs_dir
    type:
      - 'null'
      - string
    doc: 'Directory path where logs will be outputted. Default: No log'
    inputBinding:
      position: 101
      prefix: --logs-dir
  - id: outdir
    type:
      - 'null'
      - string
    doc: 'Path to output directory. Default: freddie_cluster/'
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: 'Path to output directory. Default: freddie_cluster/'
    outputBinding:
      glob: "${ return inputs.outdir ? inputs.outdir : 'freddie_cluster'; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_cluster.py.out
