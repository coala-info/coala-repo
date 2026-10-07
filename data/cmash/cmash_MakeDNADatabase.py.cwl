cwlVersion: v1.2
class: CommandLineTool
baseCommand: MakeDNADatabase.py
label: cmash_MakeDNADatabase.py
doc: "This script creates training/reference sketches for each FASTA/Q file listed
  in the input file.\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs:
  - id: in_file
    type: File
    doc: 'Input file: file containing (absolute) file names of training genomes.'
    inputBinding:
      position: 1
  - id: training_genomes
    type:
      type: array
      items: File
    doc: Training genome FASTA/Q files named in in_file; staged in the working 
      directory so that in_file can list them by file name.
  - id: out_file
    type: string
    doc: Output training database/reference file (in HDF5 format)
    inputBinding:
      position: 2
  - id: intersect_nodegraph
    type:
      - 'null'
      - boolean
    doc: Optional flag to export Nodegraph file (bloom filter) containing all 
      k-mers in the training database. Saved in same location as out_file. This 
      is to be used with QueryDNADatabase.py
    inputBinding:
      position: 102
      prefix: --intersect_nodegraph
  - id: k_size
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 102
      prefix: --k_size
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: Number of hashes to use.
    inputBinding:
      position: 102
      prefix: --num_hashes
  - id: prime
    type:
      - 'null'
      - int
    doc: Prime (for modding hashes)
    inputBinding:
      position: 102
      prefix: --prime
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_out_file
    type: File
    doc: Output training database/reference file (in HDF5 format)
    outputBinding:
      glob: '$(inputs.out_file)'
  - id: intersect_nodegraph_file
    type:
      - 'null'
      - File
    doc: Nodegraph file (bloom filter) of all training k-mers, written with 
      --intersect_nodegraph
    outputBinding:
      glob: $(inputs.out_file.replace(/\.[^.\/]*$/, '') + '.intersect.Nodegraph')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.training_genomes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
