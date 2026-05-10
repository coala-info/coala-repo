cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp2cell export-locations
label: snp2cell_export-locations
doc: "Save the genomic locations of network nodes in the s2c object to a tsv file.\n\
  \nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: path to SNP2CELL object
    inputBinding:
      position: 1
  - id: pos2gene
    type:
      - 'null'
      - File
    doc: csv file with no header and location (chrX:XXX-XXX) to gene symbol 
      mapping. If not provided, no mapping will be done. If a path is provided 
      the mapping will be read from the file. If a URL is provided, the mapping 
      will be queried from biomart.
    inputBinding:
      position: 102
      prefix: --pos2gene
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output path for regions
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
