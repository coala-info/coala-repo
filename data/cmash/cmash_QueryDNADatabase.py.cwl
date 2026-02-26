cwlVersion: v1.2
class: CommandLineTool
baseCommand: QueryDNADatabase.py
label: cmash_QueryDNADatabase.py
doc: "This script creates a CSV file of similarity indicies between the input file
  and each of the sketches in the training/reference file.\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs:
  - id: in_file
    type: File
    doc: 'Input file: FASTQ/A file (can be gzipped).'
    inputBinding:
      position: 1
  - id: training_data
    type: File
    doc: Training/reference data (HDF5 file created by MakeTrainingDatabase.py)
    inputBinding:
      position: 2
  - id: base_name
    type:
      - 'null'
      - boolean
    doc: Flag to indicate that only the base names (not the full path) should be
      saved in the output CSV file
    default: false
    inputBinding:
      position: 103
      prefix: --base_name
  - id: confidence
    type:
      - 'null'
      - float
    doc: Desired probability that all results were returned with containment 
      index above threshold [-ct]
    default: 0.95
    inputBinding:
      position: 103
      prefix: --confidence
  - id: containment_threshold
    type:
      - 'null'
      - float
    doc: Only return results with containment index above this value
    default: 0.02
    inputBinding:
      position: 103
      prefix: --containment_threshold
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force creation of new NodeGraph.
    default: false
    inputBinding:
      position: 103
      prefix: --force
  - id: fp_rate
    type:
      - 'null'
      - float
    doc: False positive rate.
    default: 0.0001
    inputBinding:
      position: 103
      prefix: --fp_rate
  - id: intersect_nodegraph
    type:
      - 'null'
      - boolean
    doc: Option to only insert query k-mers in bloom filter if they appear 
      anywhere in the training database.
    default: false
    inputBinding:
      position: 103
      prefix: --intersect_nodegraph
  - id: node_graph
    type:
      - 'null'
      - File
    doc: NodeGraph/bloom filter location. Used if it exists; if not, one will be
      created and put in the same directory as the specified output CSV file.
    inputBinding:
      position: 103
      prefix: --node_graph
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 20
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_csv
    type: File
    doc: Output CSV file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
