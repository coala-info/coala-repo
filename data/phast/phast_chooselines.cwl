cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_chooselines
label: phast_chooselines
doc: "Choose lines from a MAF file based on a phylogenetic tree and conservation scores.\n\
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: tree_file
    type: File
    doc: Phylogenetic tree file (e.g., Newick format)
    inputBinding:
      position: 2
  - id: conservation_file
    type: File
    doc: Conservation scores file (e.g., from phastCons)
    inputBinding:
      position: 3
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of a conserved region to be chosen
    inputBinding:
      position: 104
      prefix: --min-length
  - id: threshold
    type:
      - 'null'
      - float
    doc: Conservation score threshold for choosing lines
    inputBinding:
      position: 104
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for chosen lines
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
