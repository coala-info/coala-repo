cwlVersion: v1.2
class: CommandLineTool
baseCommand: rextract
label: recentrifuge_rextract
doc: "Selectively extract reads by Centrifuge output\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: any generated sequence file will be gzipped
    inputBinding:
      position: 101
      prefix: --compress
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: exclude_taxid
    type:
      - 'null'
      - type: array
        items: int
    doc: NCBI taxid code to exclude a taxon and all underneath (multiple -x is 
      available to exclude several taxid)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: treat all the input and output sequence files as FASTA instead of the 
      default FASTQ
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq_file
    type:
      - 'null'
      - File
    doc: single sequence file (no paired-ends), which may be gzipped
    inputBinding:
      position: 101
      prefix: --fastq
  - id: file
    type: File
    doc: Centrifuge output file
    inputBinding:
      position: 101
      prefix: --file
  - id: include_taxid
    type:
      - 'null'
      - type: array
        items: int
    doc: NCBI taxid code to include a taxon and all underneath (multiple -i is 
      available to include several taxid); by default all the taxa is considered
      for inclusion
    inputBinding:
      position: 101
      prefix: --include
  - id: limit
    type:
      - 'null'
      - int
    doc: limit of sequence reads to extract
    default: no limit
    inputBinding:
      position: 101
      prefix: --limit
  - id: mate1_file
    type:
      - 'null'
      - File
    doc: paired-ends sequence file (gzipped or not) for mate 1s (filename 
      usually includes _1)
    inputBinding:
      position: 101
      prefix: --mate1
  - id: mate2_file
    type:
      - 'null'
      - File
    doc: paired-ends sequence file (gzipped or not) for mate 2s (filename 
      usually includes _2)
    inputBinding:
      position: 101
      prefix: --mate2
  - id: maxreads
    type:
      - 'null'
      - int
    doc: maximum number of sequence reads to search for the taxa
    default: no maximum
    inputBinding:
      position: 101
      prefix: --maxreads
  - id: maxscore
    type:
      - 'null'
      - int
    doc: maximum score/confidence of the classification of a read to pass the 
      quality filter; all pass by default
    inputBinding:
      position: 101
      prefix: --maxscore
  - id: minscore
    type:
      - 'null'
      - int
    doc: minimum score/confidence of the classification of a read to pass the 
      quality filter; all pass by default
    inputBinding:
      position: 101
      prefix: --minscore
  - id: nodespath
    type:
      - 'null'
      - Directory
    doc: path for the nodes information files (nodes.dmp and names.dmp from 
      NCBI)
    inputBinding:
      position: 101
      prefix: --nodespath
  - id: unclassified
    type:
      - 'null'
      - boolean
    doc: Just extract unclassified reads (overrides other options)
    inputBinding:
      position: 101
      prefix: --unclassified
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_rextract.out
