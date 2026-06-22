cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - occupancy_filter
label: phykit_occupancy_filter
doc: Filter alignments and/or trees by cross-file taxon occupancy. Counts how 
  many files each taxon appears in and retains only taxa meeting a minimum 
  threshold. Outputs filtered copies of each input file.
inputs:
  - id: file_list
    type: File
    doc: file listing paths to alignment or tree files, one per line
    inputBinding:
      position: 101
      prefix: --list
  - id: format
    type:
      - 'null'
      - string
    doc: 'input file format: fasta or trees'
    inputBinding:
      position: 101
      prefix: --format
  - id: threshold
    type:
      - 'null'
      - float
    doc: minimum occupancy to retain a taxon. Values between 0 and 1 are treated
      as a fraction (e.g., 0.5 = 50% of files). Values >= 1 are treated as an 
      absolute count.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: output_dir
    type: string
    doc: directory for filtered output files
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix added to output filenames before the extension
    inputBinding:
      position: 101
      prefix: --suffix
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: directory for filtered output files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
