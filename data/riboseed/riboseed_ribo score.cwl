cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribo score
label: riboseed_ribo score
doc: "This does some simple blasting to detect correctness of riboSeed results\n\n\
  Tool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: indir
    type: Directory
    doc: dir containing a genbank file, assembly filesas fastas. Usually the 
      'mauve' dir in the riboSeed results
    inputBinding:
      position: 1
  - id: assembly_ext
    type:
      - 'null'
      - string
    doc: extenssion of reference, usually fasta
    inputBinding:
      position: 102
      prefix: --assembly_ext
  - id: blast_full
    type:
      - 'null'
      - boolean
    doc: if true, blast full sequences along with just the flanking. 
      Interpretation is not implemented currently as false positives cant be 
      detected this way
    inputBinding:
      position: 102
      prefix: --blast_Full
  - id: flanking_length
    type:
      - 'null'
      - int
    doc: 'length of flanking regions, in bp; default: 1000'
    inputBinding:
      position: 102
      prefix: --flanking_length
  - id: min_percent
    type:
      - 'null'
      - float
    doc: minimum percent identity
    inputBinding:
      position: 102
      prefix: --min_percent
  - id: ref_ext
    type:
      - 'null'
      - string
    doc: extension of reference, usually .gb
    inputBinding:
      position: 102
      prefix: --ref_ext
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Logger writes debug to file in output dir; this sets verbosity level sent
      to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical();
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: directory in which to place the output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
