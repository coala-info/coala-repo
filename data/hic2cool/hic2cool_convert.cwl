cwlVersion: v1.2
class: CommandLineTool
baseCommand: hic2cool convert
label: hic2cool_convert
doc: "convert a hic file to a cooler file\n\nTool homepage: https://github.com/4dn-dcic/hic2cool"
inputs:
  - id: infile
    type: File
    doc: hic input file path
    inputBinding:
      position: 1
  - id: nproc
    type:
      - 'null'
      - int
    doc: number of processes to use to parse hic file. default set to 1
    default: 1
    inputBinding:
      position: 102
      prefix: --nproc
  - id: resolution
    type:
      - 'null'
      - int
    doc: integer bp resolution desired in cooler file. Setting to 0 (default) 
      will use all resolutions. If all resolutions are used, a multi-res .cool 
      file will be created, which has a different hdf5 structure. See the README
      for more info
    default: 0
    inputBinding:
      position: 102
      prefix: --resolution
  - id: silent
    type:
      - 'null'
      - boolean
    doc: if used, silence standard program output
    inputBinding:
      position: 102
      prefix: --silent
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: if used, print out non-critical WARNING messages, which are hidden by 
      default. Silent mode takes precedence over this
    inputBinding:
      position: 102
      prefix: --warnings
outputs:
  - id: outfile
    type: File
    doc: cooler output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
