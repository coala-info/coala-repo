cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipyrad
label: ipyrad
doc: "ipyrad is a tool for assembling RAD-seq data.\n\nTool homepage: http://github.com/dereneaton/ipyrad"
inputs:
  - id: branch
    type:
      - 'null'
      - type: array
        items: string
    doc: create new branch of Assembly as params-{branch}.txt, and can be used 
      to drop samples from Assembly.
    inputBinding:
      position: 101
      prefix: -b
  - id: cores
    type:
      - 'null'
      - int
    doc: number of CPU cores to use (Default=0=All)
    default: 0
    inputBinding:
      position: 101
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print lots more info to ipyrad_log.txt.
    inputBinding:
      position: 101
      prefix: --debug
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: download fastq files by accession (e.g., SRP or SRR)
    inputBinding:
      position: 101
      prefix: --download
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite of existing data
    inputBinding:
      position: 101
      prefix: --force
  - id: ipcluster
    type:
      - 'null'
      - string
    doc: connect to running ipcluster, enter profile name or profile='default'
    inputBinding:
      position: 101
      prefix: --ipcluster
  - id: merge
    type:
      - 'null'
      - type: array
        items: string
    doc: merge multiple Assemblies into one joint Assembly, and can be used to 
      merge Samples into one Sample.
    inputBinding:
      position: 101
      prefix: -m
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: connect to parallel CPUs across multiple nodes
    inputBinding:
      position: 101
      prefix: --MPI
  - id: new
    type:
      - 'null'
      - string
    doc: create new file 'params-{new}.txt' in current directory
    inputBinding:
      position: 101
      prefix: -n
  - id: params
    type:
      - 'null'
      - File
    doc: 'path to params file for Assembly: params-{assembly_name}.txt'
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not print to stderror or stdout.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: results
    type:
      - 'null'
      - boolean
    doc: show results summary for Assembly in params.txt and exit
    inputBinding:
      position: 101
      prefix: --results
  - id: steps
    type:
      - 'null'
      - string
    doc: Set of assembly steps to run, e.g., -s 123
    inputBinding:
      position: 101
      prefix: -s
  - id: threading
    type:
      - 'null'
      - int
    doc: tune threading of multi-threaded binaries (Default=2)
    default: 2
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipyrad:0.9.108--pyhdfd78af_0
stdout: ipyrad.out
