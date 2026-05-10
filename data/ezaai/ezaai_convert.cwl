cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ezaai
  - convert
label: ezaai_convert
doc: "Convert CDS FASTA file into protein DB\n\nTool homepage: http://leb.snu.ac.kr/ezaai"
inputs:
  - id: input_cds
    type: File
    doc: Input CDS file (FASTA format)
    inputBinding:
      position: 101
      prefix: -i
  - id: label
    type:
      - 'null'
      - string
    doc: Taxonomic label for phylogenetic tree
    inputBinding:
      position: 101
      prefix: -l
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Custom path to MMSeqs2 binary
    inputBinding:
      position: 101
      prefix: -mmseqs
  - id: sequence_type
    type: string
    doc: Sequence type of input file (nucl/prot)
    inputBinding:
      position: 101
      prefix: -s
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Custom temporary directory
    inputBinding:
      position: 101
      prefix: -tmp
  - id: output_db_path
    type: string
    doc: Output or path parameter `output_db_path`
    inputBinding:
      position: 102
      prefix: --output-db
outputs:
  - id: output_db
    type: File
    doc: Output protein DB
    outputBinding:
      glob: $(inputs.output_db_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
