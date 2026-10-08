cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metamaps
  - mapAgainstIndex
label: metamaps_mapagainstindex
doc: "Map long reads against an index built with metamaps index.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
inputs:
  - id: index_files
    type: File[]
    doc: All files written by metamaps index (<prefix>.index, <prefix>.arguments, <prefix>.1, ...)
  - id: index_prefix
    type: string
    doc: index prefix (the value given to metamaps index --index)
    inputBinding:
      position: 1
      prefix: --index
  - id: query
    type: File
    doc: an input query file (fasta/fastq)[.gz]
    inputBinding:
      position: 2
      prefix: --query
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 3
      prefix: --output
  - id: threads
    type: ['null', int]
    doc: 'count of threads for parallel execution [default : 1]'
    inputBinding:
      position: 4
      prefix: --threads
  - id: all
    type: ['null', boolean]
    doc: report all the mapping locations for a read, default is to consider few best ones
    inputBinding:
      position: 5
      prefix: --all
outputs:
  - id: mapping_files
    type: File[]
    doc: Mapping files written with the output name as prefix
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
