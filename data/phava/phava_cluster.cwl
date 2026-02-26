cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava cluster
label: phava_cluster
doc: "Cluster PhaVa database\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: dir
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL PHAVA OPERATIONS ***
    inputBinding:
      position: 101
      prefix: --dir
  - id: flanksize
    type:
      - 'null'
      - int
    doc: Size flanking size to include on either side of invertable regions (in 
      bps)
    default: 1000
    inputBinding:
      position: 101
      prefix: --flankSize
  - id: log
    type:
      - 'null'
      - boolean
    doc: Should the logging info be output to stdout? Otherwise, it will be 
      written to 'PhaVa.log'
    default: false
    inputBinding:
      position: 101
      prefix: --log
  - id: new_dir
    type:
      - 'null'
      - Directory
    doc: New PhaVa directory for the clustered database (defaults to '-d' if not
      supplied or './phava_out' for multiple genomes). To cluster the invertons 
      from multiple genomes, supply a comma-separated list of PhaVa directories 
      to the '-d' parameter
    inputBinding:
      position: 101
      prefix: --new_dir
  - id: pident
    type:
      - 'null'
      - float
    doc: Percent identity for the clustering
    default: 0.95
    inputBinding:
      position: 101
      prefix: --pident
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_cluster.out
