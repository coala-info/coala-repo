cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp2cell score-snp
label: snp2cell_score-snp
doc: "Add fGWAS scores for network nodes based on GWAS summary statistics. Then propagate
  the scores across the network and calculate statistics based on random permutations.
  All calculated information will be saved in the s2c object.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: path to SNP2CELL object
    inputBinding:
      position: 1
  - id: fgwas_output_path
    type: File
    doc: path to tsv.gz file with SNP Bayes factors and weights per region 
      calculated by nf-fgwas
    inputBinding:
      position: 2
  - id: region_loc_path
    type: File
    doc: path to tsv file with genomic locations of regions (result from 
      `export_locations()`)
    inputBinding:
      position: 3
  - id: lexpand
    type:
      - 'null'
      - int
    doc: number of base pairs to expand the region to the left
    default: 250
    inputBinding:
      position: 104
      prefix: --lexpand
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: number of cpus to use
    inputBinding:
      position: 104
      prefix: --n-cpu
  - id: pos2gene
    type:
      - 'null'
      - File
    doc: csv file with no header and location (chrX:XXX-XXX) to gene symbol 
      mapping. If not provided, no mapping will be done. If a path is provided 
      the mapping will be read from the file. If a URL is provided, the mapping 
      will be queried from biomart.
    inputBinding:
      position: 104
      prefix: --pos2gene
  - id: rexpand
    type:
      - 'null'
      - int
    doc: number of base pairs to expand the region to the right
    default: 250
    inputBinding:
      position: 104
      prefix: --rexpand
  - id: save_key
    type:
      - 'null'
      - string
    doc: name for saving scores in object
    default: snp_score
    inputBinding:
      position: 104
      prefix: --save-key
outputs:
  - id: output_table
    type:
      - 'null'
      - File
    doc: path for saving the Regional Bayes Factors (RBF) as a table. If not 
      provided, the table will not be saved.
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
