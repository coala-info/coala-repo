cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MapCaller
  - index
label: mapcaller_index
doc: 'Index a reference genome (FASTA); writes the index files that start with the
  given index prefix.


  Tool homepage: https://github.com/hsinnan75/MapCaller'
inputs:
  - id: ref_file
    type: File
    doc: Reference genome file in FASTA format
    inputBinding:
      position: 1
  - id: index_prefix
    type: string
    doc: Prefix of the index files to be written
    inputBinding:
      position: 2
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files
    outputBinding:
      glob: $(inputs.index_prefix)*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapcaller:0.9.9.41--h13024bc_6
stdout: mapcaller_index.out
