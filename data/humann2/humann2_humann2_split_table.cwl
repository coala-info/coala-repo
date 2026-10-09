cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_split_table
label: humann2_humann2_split_table
doc: "Split gene table to input to HUMAnN\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "the gene table to read"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the directory for output files"
    inputBinding:
      position: 102
      prefix: "--output"
  - id: taxonomy_index
    type:
      - 'null'
      - int
    doc: "the index of the gene in the taxonomy data"
    inputBinding:
      position: 103
      prefix: "--taxonomy_index"
  - id: taxonomy_level
    type:
      - 'null'
      - string
    doc: "the level of taxonomy for the output (if input is from picrust metagenome_contributions.py): Kingdom, Phylum, Class, Order, Family, Genus or Species"
    inputBinding:
      position: 104
      prefix: "--taxonomy_level"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "additional output is printed"
    inputBinding:
      position: 105
      prefix: "--verbose"
outputs:
  - id: output
    type: Directory
    doc: "directory with one table per sample"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
