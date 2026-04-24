cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem call_genes
label: refinem_call_genes
doc: "Identify genes within genomes.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: genome_nt_dir
    type: Directory
    doc: directory containing nucleotide scaffolds for each genome
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 2
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 103
      prefix: --cpus
  - id: genome_ext
    type:
      - 'null'
      - string
    doc: extension of genomes (other files in directory are ignored)
    inputBinding:
      position: 103
      prefix: --genome_ext
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
  - id: unbinned_file
    type:
      - 'null'
      - File
    doc: call genes on unbinned scaffolds
    inputBinding:
      position: 103
      prefix: --unbinned_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem_call_genes.out
