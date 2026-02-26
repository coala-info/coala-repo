cwlVersion: v1.2
class: CommandLineTool
baseCommand: LABRATsc.py
label: labrat_LABRATsc.py
doc: "How to perform tests? Either compare psi values of individual cells or subsample
  cells from clusters.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs:
  - id: alevindir
    type:
      - 'null'
      - Directory
    doc: Directory containing subdirectories of alevin output.
    inputBinding:
      position: 101
      prefix: --alevindir
  - id: conditiona
    type:
      - 'null'
      - string
    doc: Must be found in the second column of the conditions file. Delta psi is
      calculated as conditionB - conditionA.
    inputBinding:
      position: 101
      prefix: --conditionA
  - id: conditionb
    type:
      - 'null'
      - string
    doc: Must be found in the second column of the conditions file. Delta psi is
      calculated as conditionB - conditionA.
    inputBinding:
      position: 101
      prefix: --conditionB
  - id: conditions
    type:
      - 'null'
      - File
    doc: Two column, tab-delimited file with column names 'sample' and 
      'condition'. First column contains cell ids and second column contains 
      cell condition or cluster.
    inputBinding:
      position: 101
      prefix: --conditions
  - id: gff
    type:
      - 'null'
      - File
    doc: GFF of transcript annotation.
    inputBinding:
      position: 101
      prefix: --gff
  - id: mode
    type:
      - 'null'
      - string
    doc: How to perform tests? Either compare psi values of individual cells or 
      subsample cells from clusters.
    inputBinding:
      position: 101
      prefix: --mode
  - id: readcountfilter
    type:
      - 'null'
      - int
    doc: Minimum read count necessary for calculation of psi values. Genes that 
      do not pass this filter will have reported psi values of NA. If mode == 
      'cellbycell', then this is the number of reads mapping to a gene in that 
      single cell. If mode == 'subsampleClusters' then this is the summed number
      of reads across all cells in a predefined cluster.
    inputBinding:
      position: 101
      prefix: --readcountfilter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRATsc.py.out
