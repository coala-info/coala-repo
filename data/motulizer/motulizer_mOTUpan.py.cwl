cwlVersion: v1.2
class: CommandLineTool
baseCommand: mOTUpan.py
label: motulizer_mOTUpan.py
doc: "From a buch of amino-acid sequences or COG-sets, computes concensus AA/COG sets.
  Returns all to stdout by default.\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs:
  - id: boots
    type:
      - 'null'
      - int
    doc: number of bootstraps for fpr and recall estimate (default 0), careful, 
      slows down program linearly
    inputBinding:
      position: 101
      prefix: --boots
  - id: checkm
    type:
      - 'null'
      - File
    doc: checkm file if you want to seed completnesses with it, accepts 
      concatenations of multiple checkm-files, check manual for more formating 
      options
    inputBinding:
      position: 101
      prefix: --checkm
  - id: faas
    type:
      - 'null'
      - type: array
        items: File
    doc: list of amino-acids faas of MAGs or whatnot, or a text file with paths 
      to the faas (with the --txt switch)
    inputBinding:
      position: 101
      prefix: --faas
  - id: force
    type:
      - 'null'
      - boolean
    doc: force execution answering default answers
    inputBinding:
      position: 101
      prefix: --force
  - id: gene_clusters_file
    type:
      - 'null'
      - File
    doc: file with COG-sets (see doc)
    inputBinding:
      position: 101
      prefix: --gene_clusters_file
  - id: genome2gene_clusters_only
    type:
      - 'null'
      - boolean
    doc: returns genome2gene_clusters only
    inputBinding:
      position: 101
      prefix: --genome2gene_clusters_only
  - id: length_seed
    type:
      - 'null'
      - boolean
    doc: seed completeness by length fraction [0-100]
    inputBinding:
      position: 101
      prefix: --length_seed
  - id: long
    type:
      - 'null'
      - boolean
    doc: longform output, a JSON-file with a lot more information (might be 
      cryptic...)
    inputBinding:
      position: 101
      prefix: --long
  - id: max_iter
    type:
      - 'null'
      - int
    doc: max number of iterations (set to one if you have only few traits, e.g. 
      re-estimation of completeness is nonsensical)
    inputBinding:
      position: 101
      prefix: --max_iter
  - id: name
    type:
      - 'null'
      - string
    doc: if you want to name this bag of bins
    inputBinding:
      position: 101
      prefix: --name
  - id: precluster
    type:
      - 'null'
      - boolean
    doc: precluster proteomes with cd-hit, mainly for legacy reasons, mmseqs2 is
      faaaaaast
    inputBinding:
      position: 101
      prefix: --precluster
  - id: random_seed
    type:
      - 'null'
      - boolean
    doc: random seed completeness between 5 and 95 percent
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: seed
    type:
      - 'null'
      - int
    doc: seed completeness, advice a number around 90 (95 default), this is the 
      default completeness prior
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (default all, e.g. 20), only gene clustering is 
      multithreaded right now, the rest is to come
    inputBinding:
      position: 101
      prefix: --threads
  - id: txt
    type:
      - 'null'
      - boolean
    doc: the '--faas' switch indicates a file with paths
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
