cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - export-locations
label: snp2cell_export-locations
doc: "Save the genomic locations of network nodes in the s2c object to a tsv file.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: "path to SNP2CELL object"
    inputBinding:
      position: 2
  - id: output_path
    type:
      - 'null'
      - string
    doc: "output path for regions (default peak_locations.txt)"
    inputBinding:
      position: 1
      prefix: --output
  - id: pos2gene
    type:
      - 'null'
      - File
    doc: "csv file with no header and location (chrX:XXX-XXX) to gene symbol mapping. If not provided, no mapping will be done. If a path is provided the mapping will be read from the file. If a URL is provided, the mapping will be queried from biomart."
    inputBinding:
      position: 1
      prefix: --pos2gene
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: output
    type: File
    doc: Genomic locations of the network nodes
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path : 'peak_locations.txt')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_export-locations.out
stderr: snp2cell_export-locations.err
