cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_missview
label: hicstuff_missview
doc: "Previews bins that will be missing in a Hi-C map with a given read length by
  finding repetitive regions in the genome.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: genome
    type: File
    doc: Genome file in fasta format.
    inputBinding:
      position: 1
  - id: aligner
    type:
      - 'null'
      - string
    doc: The read alignment software to use. Can be either bowtie2, minimap2 or 
      bwa. minimap2 should only be used for reads > 100 bp.
    inputBinding:
      position: 102
      prefix: --aligner
  - id: binning
    type:
      - 'null'
      - int
    doc: Resolution to use to preview the Hi-C map.
    inputBinding:
      position: 102
      prefix: --binning
  - id: force
    type:
      - 'null'
      - boolean
    doc: Write even if the output file already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: read_len
    type:
      - 'null'
      - int
    doc: Write even if the output file already exists.
    inputBinding:
      position: 102
      prefix: --read-len
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use in parallel.
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Directory where temporary files will be generated.
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output
    type: File
    doc: Path to the output image.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
