cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakmeopen
label: krakmeopen
doc: "A Kraken2 downstream analysis toolkit. More specifically, calculate a series\n\
  of quality metrics for Kraken2 classifications.\n\nTool homepage: https://github.com/danisven/KrakMeOpen"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Kraken2 read-by-read classifications file.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_file_list
    type:
      - 'null'
      - File
    doc: "A file containing file paths to multiple pickles, one\nper line. Will calculate
      metrics on the sum of kmer\ncounts from all pickles."
    inputBinding:
      position: 101
      prefix: --input_file_list
  - id: input_pickle
    type:
      - 'null'
      - File
    doc: "A pickle file containing kmer tallies, produced with\n--output_pickle"
    inputBinding:
      position: 101
      prefix: --input_pickle
  - id: names
    type: File
    doc: "NCBI style taxonomy names dump file (names.dmp).\nRequired."
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes
    type: File
    doc: "NCBI style taxonomy nodes dump file (nodes.dmp).\nRequired."
    inputBinding:
      position: 101
      prefix: --nodes
  - id: tax_id
    type:
      - 'null'
      - int
    doc: "A taxonomic ID for a clade that you wish to calculate\nquality metrics for."
    inputBinding:
      position: 101
      prefix: --tax_id
  - id: tax_id_file
    type:
      - 'null'
      - File
    doc: "Supply multiple taxonomic IDs at once. A textfile with\none taxonomic ID
      per line. Calculate quality metrics\nfor the clades rooted at the taxonomic
      IDs in the\nfile."
    inputBinding:
      position: 101
      prefix: --tax_id_file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The file to write the quality metrics output to.
    outputBinding:
      glob: $(inputs.output)
  - id: output_pickle
    type:
      - 'null'
      - File
    doc: "The pickle file to write kmer tallies to. Use this\nargument to supress
      calculation of quality metrics and\nonly output kmer counts to a pickled file.
      Input the\npickled file using --input_pickle."
    outputBinding:
      glob: $(inputs.output_pickle)
  - id: kmer_tally_table
    type:
      - 'null'
      - File
    doc: "File to output the complete kmer tally table for each\ntax ID to. Optional."
    outputBinding:
      glob: $(inputs.kmer_tally_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakmeopen:0.1.5--pyh3252c3a_0
