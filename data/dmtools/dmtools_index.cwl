cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - index
label: dmtools_index
doc: "Index a genome for dmtools.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_file)
        writable: true
inputs:
  - id: genome_file
    type: File
    doc: genome fasta file
    inputBinding:
      position: 101
      prefix: -g
      valueFrom: $(self.basename)
  - id: taps
    type:
      - 'null'
      - boolean
    doc: alignment TAPS reads with bwa mem
    inputBinding:
      position: 101
      prefix: --taps
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the genome (<genome>.batmeth2.fa and its bwa
      index, <genome>.bin, <genome>.len)
    outputBinding:
      glob: $(inputs.genome_file.basename).*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_index.out
