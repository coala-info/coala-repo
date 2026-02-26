cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaclassifier
label: metaclassifier
doc: "The metaclassifier.py uses DNA metabarcoding sequence reads and a database of
  marker sequences, including corresponding taxonomy classes to identify and quantify
  the floral composition of honey\n\nTool homepage: https://github.com/ewafula/MetaClassifier"
inputs:
  - id: sample_file
    type: File
    doc: "Input tab-delimited file specifying sample names, file names for forward
      paired-end reads, and file names for reverse paired-end (file path if not in
      working directory)\nThe second file not required for single-end frangments"
    inputBinding:
      position: 1
  - id: db_dir
    type: Directory
    doc: Input marker database directory with sequence fasta and corresponding 
      taxonomy lineage files for each marker
    inputBinding:
      position: 2
  - id: config_file
    type: File
    doc: Input tab-delimited file specifying marker name, and its corresponding 
      VSEARCH's usearch_global function minimum query coverage (i.e. 0.8 for 
      80%) and minimun sequence identity (i.e. 0.95 for 95%) for each search 
      marker (provide the file path if not in if the VSEARCH settings 
      configuration is not in working directory)
    inputBinding:
      position: 3
  - id: frag_type
    type:
      - 'null'
      - string
    doc: "Specify the sequence fragment type in the input sample file, available options
      are:\npaired: single-end read fragments (default)\nsingle: paired-end read fragments"
    default: paired
    inputBinding:
      position: 104
      prefix: --frag_type
  - id: max_markers
    type:
      - 'null'
      - int
    doc: Maximum missing markers allowed to retain a sample taxon (default = 0)
    default: 0
    inputBinding:
      position: 104
      prefix: --max_markers
  - id: merge
    type:
      - 'null'
      - boolean
    doc: 'Merge overlapping paired-end reads (default: False)'
    default: false
    inputBinding:
      position: 104
      prefix: --merge
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: "Minimum taxon read proportion allowed to retain a sample taxon, allowed
      proportion,\nranges from 0.00 to 0.01 (default = 0.00)"
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min_proportion
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Specify output directory name, otherwise it will automatically be 
      created using the input sample table file name
    inputBinding:
      position: 104
      prefix: --output_dir
  - id: pear_merger
    type:
      - 'null'
      - File
    doc: 'Path to PEAR, the paired-end read merger if not in environmental variables
      (ENV) (default: read from ENV)'
    default: read from ENV
    inputBinding:
      position: 104
      prefix: --pear_merger
  - id: seqtk_converter
    type:
      - 'null'
      - File
    doc: 'Path to seqtk, the sequence processing tool if not in environmental variables
      (ENV) (default: read from ENV)'
    default: read from ENV
    inputBinding:
      position: 104
      prefix: --seqtk_converter
  - id: tax_class
    type:
      - 'null'
      - string
    doc: 'Taxonomy class for quantify taxon level marker read abundance (default:
      genus)'
    default: genus
    inputBinding:
      position: 104
      prefix: --tax_class
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Specify the number of threads to use (default: 2)'
    default: 2
    inputBinding:
      position: 104
      prefix: --threads
  - id: vsearch_aligner
    type:
      - 'null'
      - File
    doc: 'Path to VSEARCH, the sequence analysis tool if not in environmental variables
      (ENV) (default: read from ENV)'
    default: read from ENV
    inputBinding:
      position: 104
      prefix: --vsearch_aligner
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaclassifier:v1.0.1--py_0
stdout: metaclassifier.out
