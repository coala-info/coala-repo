cwlVersion: v1.2
class: CommandLineTool
baseCommand: StreamingQueryDNADatabase.py
label: cmash_StreamingQueryDNADatabase.py
doc: "This script calculates containment indicies for each of the training/reference
  sketches by streaming through the query file.\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs:
  - id: in_file
    type: File
    doc: 'Input file: FASTA/Q file to be processes'
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Training database/reference file (in HDF5 format). Created with 
      MakeStreamingDNADatabase.py
    inputBinding:
      position: 2
  - id: range
    type: string
    doc: Range of k-mer sizes in the formate <start>-<end>-<increment>. So 
      5-10-2 means [5, 7, 9]. If <end> is larger than the k-mer sizeof the 
      training data, this will automatically be reduced.
    inputBinding:
      position: 3
  - id: containment_threshold
    type:
      - 'null'
      - float
    doc: Only return results with containment index above this threshold at the 
      maximum k-mer size.
    inputBinding:
      position: 104
      prefix: --containment_threshold
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Location of pre-filter bloom filter. Use only if you absolutely know 
      what you're doing (hard to error check bloom filters).
    inputBinding:
      position: 104
      prefix: --filter_file
  - id: location_of_thresh
    type:
      - 'null'
      - int
    doc: Location in range to apply the threshold passed by the -c flag. -l 2 -c
      5-50-10 means the threshold will be applied at k-size 25. Default is 
      largest size.
    inputBinding:
      position: 104
      prefix: --location_of_thresh
  - id: plot_file
    type:
      - 'null'
      - boolean
    doc: Optional flag to specify that a plot of the k-mer curves should also be
      saved (same basenameas the out_file).
    inputBinding:
      position: 104
      prefix: --plot_file
  - id: reads_per_core
    type:
      - 'null'
      - int
    doc: Number of reads per core in each chunk of parallelization. Set as high 
      as memory will allow (eg. 1M on 256GB, 48 core machine)
    inputBinding:
      position: 104
      prefix: --reads_per_core
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Operate in sensitive mode. Marginally more true positives with 
      significantly more false positives. Use with caution.
    inputBinding:
      position: 104
      prefix: --sensitive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out progress report/timing information
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: out_file
    type: File
    doc: Output csv file with the containment indices.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
