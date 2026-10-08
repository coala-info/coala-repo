cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/ClassifyContigNR.py
label: desman_ClassifyContigNR.py
doc: "Classify genes and contigs taxonomically from BLAST (outfmt 6) matches of
  their proteins against NCBI NR, using accession or GI to taxid mappings and a
  taxid lineage file; writes <stub>_genes.csv and <stub>_contigs.csv.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: blast_input_file
    type: File
    doc: blast 6 matches to taxaid database (*.b6 / *.m8)
    inputBinding:
      position: 10
  - id: query_length_file
    type: File
    doc: tab delimited file of query lengths
    inputBinding:
      position: 11
  - id: gid_taxaid_mapping_file
    type:
      - 'null'
      - File
    doc: mapping from gid to taxaid gzipped
    inputBinding:
      position: 1
      prefix: -g
  - id: acc_taxaid_mapping_file
    type:
      - 'null'
      - File
    doc: mapping from accession to taxaid gzipped
    inputBinding:
      position: 1
      prefix: -a
  - id: lineage_file
    type:
      - 'null'
      - File
    doc: text taxaid to lineage mapping
    inputBinding:
      position: 1
      prefix: -l
  - id: output_dir
    type: string
    doc: string specifying output directory and file stubs
    default: output
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: genes_classification
    type: File
    doc: Per-gene taxonomic assignment (<stub>_genes.csv)
    outputBinding:
      glob: $(inputs.output_dir)_genes.csv
  - id: contigs_classification
    type: File
    doc: Per-contig taxonomic assignment (<stub>_contigs.csv)
    outputBinding:
      glob: $(inputs.output_dir)_contigs.csv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
