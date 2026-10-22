cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smalt
  - index
label: smalt_index
doc: "Index a reference genome for SMALT alignment.\n\nTool homepage: https://www.sanger.ac.uk/tool/smalt-0/"
inputs:
  - id: index_name
    type: string
    doc: Name for the index
    inputBinding:
      position: 102
  - id: reference_file
    type: File
    doc: Reference genome file (e.g., FASTA format)
    inputBinding:
      position: 103
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Length of the k-mer words indexed.
    inputBinding:
      position: 101
      prefix: -k
  - id: stride
    type:
      - 'null'
      - int
    doc: Sample every <stepsiz>-th k-mer word (stride).
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written by smalt (<index_name>.sma and <index_name>.smi)
    outputBinding:
      glob: $(inputs.index_name).*
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
stdout: smalt_index.out
