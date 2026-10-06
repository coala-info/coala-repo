cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - replicate
label: amas_replicate
doc: "Create replicate datasets for phylogenetic jackknife\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: rep_aln
    type: int[]
    doc: 'Create replicate data sets for phylogenetic jackknife [replicates, no alignments for each replicate]'
    inputBinding:
      position: 1
      prefix: --rep-aln
  - id: out_format
    type: ['null', {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}]
    doc: 'File format for the output alignment. Default: fasta'
    inputBinding:
      position: 1
      prefix: --out-format
  - id: check_align
    type: ['null', boolean]
    doc: 'Check if input sequences are aligned. Default: no check'
    inputBinding:
      position: 1
      prefix: --check-align
  - id: cores
    type: ['null', int]
    doc: 'Number of cores used. Default: 1'
    inputBinding:
      position: 1
      prefix: --cores
  - id: in_files
    type: File[]
    doc: 'Alignment files to be taken as input'
    inputBinding:
      position: 1
      prefix: --in-files
  - id: in_format
    type: {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}
    doc: 'The format of input alignment'
    inputBinding:
      position: 1
      prefix: --in-format
  - id: data_type
    type: {type: enum, symbols: [aa, dna]}
    doc: 'Type of data'
    inputBinding:
      position: 1
      prefix: --data-type
outputs:
  - id: replicate_alignments
    type: File[]
    doc: 'Replicate concatenated alignments (replicate<N>_<loci>-loci-out.<ext>)'
    outputBinding:
      glob: 'replicate*-loci-out.*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
