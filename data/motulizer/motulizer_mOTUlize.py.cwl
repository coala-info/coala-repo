cwlVersion: v1.2
class: CommandLineTool
baseCommand: mOTUlize
label: motulizer_mOTUlize.py
doc: "From a set of genomes, makes metagenomic Operational Taxonomic Units (mOTUs).
  By default it makes a graph of 95% (reciprocal) ANI (with fastANI) connected MAGs
  (with completeness > 40%, contamination < 5%). The mOTUs will be the connected components
  of this graph, to which smaller \"SUBs\" with ANI > 95% are recruited. If similarities
  provided, it should be a TAB-separated file with columns as query, subject and similarity
  (in percent, e.g. [0-100]) if you also provide fasta-files (for stats purpouses)
  query and names should correspond to the fasta-files you provide. If the columns
  are file names, the folders are removed (mainly so it can read fastANI output directly).\n\
  \nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs:
  - id: checkm
    type:
      - 'null'
      - File
    doc: checkm file (or whatever you want to use as completness), if not 
      provided, all genomes are assumed to be seed MAG (e.g complete enough)
    inputBinding:
      position: 101
      prefix: --checkm
  - id: fnas
    type:
      - 'null'
      - type: array
        items: File
    doc: list of nucleotide fasta-files of MAGs or whatnot
    inputBinding:
      position: 101
      prefix: --fnas
  - id: force
    type:
      - 'null'
      - boolean
    doc: force execution (overwritting existing files)
    inputBinding:
      position: 101
      prefix: --force
  - id: keep_simi_file
    type:
      - 'null'
      - boolean
    doc: keep generated similarity file if '--similarities' is not provided, 
      does nothing if '--similarity' is provided
    inputBinding:
      position: 101
      prefix: --keep-simi-file
  - id: long
    type:
      - 'null'
      - boolean
    doc: longform output, a JSON-file with a lot more information (might be 
      cryptic...)
    inputBinding:
      position: 101
      prefix: --long
  - id: mag_completeness
    type:
      - 'null'
      - float
    doc: 'completeness cutoff for seed MAGs, default : 40'
    inputBinding:
      position: 101
      prefix: --MAG-completeness
  - id: mag_contamination
    type:
      - 'null'
      - float
    doc: 'contamination cutoff for seed MAGs, default : 5'
    inputBinding:
      position: 101
      prefix: --MAG-contamination
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'prefix for the mOTU names, default : mOTU_'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: similarities
    type:
      - 'null'
      - File
    doc: file containing similarities between MAGs, if not provided, will use 
      fastANI to compute one
    inputBinding:
      position: 101
      prefix: --similarities
  - id: similarity_cutoff
    type:
      - 'null'
      - float
    doc: 'distance cutoff for making the graph, default : 95'
    inputBinding:
      position: 101
      prefix: --similarity-cutoff
  - id: sub_completeness
    type:
      - 'null'
      - float
    doc: 'completeness cutoff for recruited SUBs, default : 0'
    inputBinding:
      position: 101
      prefix: --SUB-completeness
  - id: sub_contamination
    type:
      - 'null'
      - float
    doc: 'contamination cutoff for recruited SUBs, default : 100'
    inputBinding:
      position: 101
      prefix: --SUB-contamination
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (default all, e.g. 20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: txt
    type:
      - 'null'
      - boolean
    doc: the '--fnas' switch indicates a file with paths
    inputBinding:
      position: 101
      prefix: --txt
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: send output to this file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
