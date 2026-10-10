cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - query
label: meta-sparse_sparse_query
doc: "Retrieve metadata for a set of references in a SPARSE database.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbname)
        writable: true
inputs:
  - id: dbname
    type: Directory
    doc: "SPARSE database folder (created by sparse init); staged writable in the working directory"
    inputBinding:
      position: 1
      prefix: --dbname
      valueFrom: $(self.basename)
  - id: seqlist
    type: 
      - 'null'
      - string
    doc: "File name for the output. Default: to screen (stdout)"
    inputBinding:
      position: 2
      prefix: --seqlist
  - id: default
    type: 
      - 'null'
      - string
    doc: "Default MapDB criteria for updates: representative, subpopulation, Virus, Eukaryota"
    inputBinding:
      position: 3
      prefix: --default
  - id: min
    type: 
      - 'null'
      - int
    doc: "Minimum size of genomes to show"
    inputBinding:
      position: 4
      prefix: --min
  - id: max
    type: 
      - 'null'
      - int
    doc: "Maximum size of genomes to show"
    inputBinding:
      position: 5
      prefix: --max
  - id: group
    type: 
      - 'null'
      - string
    doc: "Filter using the prefix of barcode addresses"
    inputBinding:
      position: 6
      prefix: --group
  - id: tag
    type: 
      - 'null'
      - string
    doc: "Filter by relationships between different level of barcodes, i.e. \"p!=r;p==a\""
    inputBinding:
      position: 7
      prefix: --tag
  - id: index
    type: 
      - 'null'
      - string
    doc: "Filter by index"
    inputBinding:
      position: 8
      prefix: --index
  - id: barcode
    type: 
      - 'null'
      - string
    doc: "Filter by barcode"
    inputBinding:
      position: 9
      prefix: --barcode
  - id: assembly_accession
    type: 
      - 'null'
      - string
    doc: "Filter by assembly_accession"
    inputBinding:
      position: 10
      prefix: --assembly_accession
  - id: refseq_category
    type: 
      - 'null'
      - string
    doc: "Filter by refseq_category"
    inputBinding:
      position: 11
      prefix: --refseq_category
  - id: assembly_level
    type: 
      - 'null'
      - string
    doc: "Filter by assembly_level"
    inputBinding:
      position: 12
      prefix: --assembly_level
  - id: taxid
    type: 
      - 'null'
      - string
    doc: "Filter by taxid"
    inputBinding:
      position: 13
      prefix: --taxid
  - id: organism_name
    type: 
      - 'null'
      - string
    doc: "Filter by organism_name"
    inputBinding:
      position: 14
      prefix: --organism_name
  - id: species
    type: 
      - 'null'
      - string
    doc: "Filter by species"
    inputBinding:
      position: 15
      prefix: --species
  - id: genus
    type: 
      - 'null'
      - string
    doc: "Filter by genus"
    inputBinding:
      position: 16
      prefix: --genus
  - id: family
    type: 
      - 'null'
      - string
    doc: "Filter by family"
    inputBinding:
      position: 17
      prefix: --family
  - id: order
    type: 
      - 'null'
      - string
    doc: "Filter by order"
    inputBinding:
      position: 18
      prefix: --order
  - id: class_name
    type: 
      - 'null'
      - string
    doc: "Filter by class"
    inputBinding:
      position: 19
      prefix: --class
  - id: phylum
    type: 
      - 'null'
      - string
    doc: "Filter by phylum"
    inputBinding:
      position: 20
      prefix: --phylum
  - id: kingdom
    type: 
      - 'null'
      - string
    doc: "Filter by kingdom"
    inputBinding:
      position: 21
      prefix: --kingdom
  - id: superkingdom
    type: 
      - 'null'
      - string
    doc: "Filter by superkingdom"
    inputBinding:
      position: 22
      prefix: --superkingdom
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: seqlist_out
    type: ['null', File]
    doc: "Metadata table written with --seqlist"
    outputBinding:
      glob: $(inputs.seqlist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_query.out
