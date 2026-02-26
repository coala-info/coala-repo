cwlVersion: v1.2
class: CommandLineTool
baseCommand: condiga
label: condiga
doc: "ConDiGA: Contigs directed gene annotation for accurate protein sequence database
  construction in metaproteomics.\n\nTool homepage: https://github.com/metagentools/ConDiGA"
inputs:
  - id: assembly_summary
    type: File
    doc: path to the assembly_summary.txt file
    inputBinding:
      position: 101
      prefix: --assembly-summary
  - id: contigs
    type: File
    doc: path to the contigs file
    inputBinding:
      position: 101
      prefix: --contigs
  - id: coverages
    type: File
    doc: path to the contig coverages file
    inputBinding:
      position: 101
      prefix: --coverages
  - id: genes
    type: File
    doc: path to the genes file
    inputBinding:
      position: 101
      prefix: --genes
  - id: genome_coverage
    type:
      - 'null'
      - float
    doc: minimum genome coverage cut-off
    default: 0.001
    inputBinding:
      position: 101
      prefix: --genome-coverage
  - id: map_threshold
    type:
      - 'null'
      - float
    doc: minimum mapping length threshold cut-off
    default: 0.5
    inputBinding:
      position: 101
      prefix: --map-threshold
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 8
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: rel_abundance
    type:
      - 'null'
      - float
    doc: minimum relative abundance cut-off
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --rel-abundance
  - id: taxa
    type: File
    doc: path to the taxanomic classification results file
    inputBinding:
      position: 101
      prefix: --taxa
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/condiga:0.2.2--pyhdfd78af_0
