cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm2
  - testrun
label: checkm2_testrun
doc: "Runs Checkm2 on internal test genomes to ensure it runs without errors.\n\n\
  Tool homepage: https://github.com/chklovski/CheckM2"
inputs:
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Provide a location for the CheckM2 database for a given predict run
    inputBinding:
      position: 101
      prefix: --database_path
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: lowmem
    type:
      - 'null'
      - boolean
    doc: Low memory mode. Reduces DIAMOND blocksize to significantly reduce RAM 
      usage at the expense of longer runtime
    inputBinding:
      position: 101
      prefix: --lowmem
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUS to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
stdout: checkm2_testrun.out
