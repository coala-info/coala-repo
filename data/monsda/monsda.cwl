cwlVersion: v1.2
class: CommandLineTool
baseCommand: monsda
label: monsda
doc: "Modular Organizer of Nextflow and Snakemake driven hts Data Analysis\n\nTool
  homepage: https://github.com/jfallmann/MONSDA"
inputs:
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Cleanup workdir (Nextflow), append -n to see list of files to clean or 
      -f to actually remove those files
    inputBinding:
      position: 101
      prefix: --clean
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: Configuration json to read and optional config for nextflow
    inputBinding:
      position: 101
      prefix: --config
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Working Directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set log level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: nextflow
    type:
      - 'null'
      - boolean
    doc: Wrap around Nextflow
    inputBinding:
      position: 101
      prefix: --nextflow
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of parallel processes to start MONSDA with, capped by MAXTHREADS
      in config!
    inputBinding:
      position: 101
      prefix: --procs
  - id: save
    type:
      - 'null'
      - boolean
    doc: Do not actually run jobs, create corresponding text file containing 
      CLI-calls and arguments for manual running instead
    inputBinding:
      position: 101
      prefix: --save
  - id: skeleton
    type:
      - 'null'
      - boolean
    doc: Just create the minimal directory hierarchy as needed
    inputBinding:
      position: 101
      prefix: --skeleton
  - id: snakemake
    type:
      - 'null'
      - boolean
    doc: Wrap around Snakemake, default
    default: true
    inputBinding:
      position: 101
      prefix: --snakemake
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: If Snakemake directory is locked you can unlock before processing
    inputBinding:
      position: 101
      prefix: --unlock
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Should conda be used, default True
    default: true
    inputBinding:
      position: 101
      prefix: --use-conda
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monsda:1.2.8--pyhdfd78af_0
stdout: monsda.out
