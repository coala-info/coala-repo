cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_annotated_regions_from_gb.py
label: getorganelle_get_annotated_regions_from_gb.py
doc: "Extract the annotated regions (CDS, tRNA, rRNA and intergenic regions) of GenBank files into fasta files per gene, with a statistics table.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: gb_files
    type:
      - type: array
        items: File
    doc: "GenBank files."
    inputBinding:
      position: 1
  - id: output_dir
    type:
      - string
    doc: "Output folder."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: gene_types
    type:
      - 'null'
      - string
    doc: "Annotation type taken as gene. Default: CDS,tRNA,rRNA"
    inputBinding:
      position: 101
      prefix: "-t"
  - id: separate_copy
    type:
      - 'null'
      - boolean
    doc: "By default, only keep one copy (see '--copy-mode') if there are several regions with the same name. Choose this to keep all copies."
    inputBinding:
      position: 101
      prefix: "--separate-copy"
  - id: copy_mode
    type:
      - 'null'
      - string
    doc: "first|longest|leastN|leastN_longest (default)."
    inputBinding:
      position: 101
      prefix: "--copy-mode"
  - id: separate_exon
    type:
      - 'null'
      - boolean
    doc: "By default, combining exons. Choose this to separate exons."
    inputBinding:
      position: 101
      prefix: "--separate-exon"
  - id: keys
    type:
      - 'null'
      - string
    doc: "The key to the gene name: gene, label, product or other keys in the qualifiers region. Default: gene,label,product,note"
    inputBinding:
      position: 101
      prefix: "--keys"
  - id: mix
    type:
      - 'null'
      - boolean
    doc: "Mix different genes into a single fasta file. In this mode, the sequence header will be >gene_name - gb_info"
    inputBinding:
      position: 101
      prefix: "--mix"
  - id: case_mode
    type:
      - 'null'
      - string
    doc: "first: gene name case-non-sensitive, consistent to the first appearance; lower; upper; raw: gene name case-sensitive. Default: first"
    inputBinding:
      position: 101
      prefix: "--case-mode"
  - id: ignore_format_error
    type:
      - 'null'
      - boolean
    doc: "Skip the Error: key \"*\" not found in annotation. Not suggested."
    inputBinding:
      position: 101
      prefix: "--ignore-format-error"
  - id: translate_to_product
    type:
      - 'null'
      - boolean
    doc: "Translate the tRNA gene name to the form of their product. Default: False"
    inputBinding:
      position: 101
      prefix: "--translate-to-product"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Choose to overwrite previous result."
    inputBinding:
      position: 101
      prefix: "--overwrite"
outputs:
  - id: output_directory
    type:
      - Directory
    doc: "Output folder with gene and intergene fasta files and statistics.txt."
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_get_annotated_regions_from_gb.py.out
