cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - viewpoint-coordinates
label: capcruncher_utilities_viewpoint-coordinates
doc: "Align viewpoint (capture oligo) sequences to the genome and report the restriction fragments they fall in.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: viewpoints
    type: File
    doc: "Path to viewpoints"
    inputBinding:
      position: 2
      prefix: -v
  - id: genome
    type: File
    doc: "Path to genome fasta file"
    inputBinding:
      position: 2
      prefix: -g
  - id: genome_indicies
    type: Directory
    doc: "Directory holding the genome bowtie2 indices; the path passed to -i is this directory plus index_basename"
    inputBinding:
      position: 2
      prefix: -i
      valueFrom: $(self.path + '/' + inputs.index_basename)
  - id: index_basename
    type: string
    doc: "Basename (prefix) of the bowtie2 index files inside genome_indicies, e.g. bt2 for bt2.1.bt2"
  - id: recognition_site
    type:
      - 'null'
      - string
    doc: "Restriction site used"
    inputBinding:
      position: 2
      prefix: -r
  - id: output
    type: string
    default: viewpoint_coordinates.bed
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: coordinates
    type: File
    doc: "Viewpoint coordinates (bed)"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
