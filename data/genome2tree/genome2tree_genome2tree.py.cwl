cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome2tree.py
label: genome2tree_genome2tree.py
doc: "Pipeline to create a supermatrix from FASTA files\n\nTool homepage: https://github.com/RicoLeiser/Genome2Tree"
inputs:
  - id: dna_input
    type:
      - 'null'
      - boolean
    doc: Input files are DNA (.fna); will be translated with Prodigal
    default: false
    inputBinding:
      position: 101
      prefix: --dna
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: Force rerun of OrthoFinder even if results exist
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: input_dir
    type: Directory
    doc: Directory containing input FASTA files (.faa or .fna)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_dir
    type: Directory
    doc: Output directory for all results
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output supermatrix files
    default: supermatrix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genome2tree:1.1.0--pyhdfd78af_0
stdout: genome2tree_genome2tree.py.out
