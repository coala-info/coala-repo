cwlVersion: v1.2
class: CommandLineTool
baseCommand: CopraRNA2.pl
label: coprarna_CopraRNA2.pl
doc: "CopraRNA is a tool for sRNA target prediction. It computes whole genome target
  predictions by combination of distinct whole genome IntaRNA predictions. As input
  CopraRNA requires at least 3 homologous sRNA sequences from 3 distinct organisms
  in FASTA format. Furthermore, each organisms' genome has to be part of the NCBI
  Reference Sequence (RefSeq) database (i.e. it should have exactly this NZ_* or this
  NC_XXXXXX format where * stands for any character and X stands for a digit between
  0 and 9). Depending on sequence length (target and sRNA), amount of input organisms
  and genome sizes, CopraRNA can take up to 24h or longer to compute. In most cases
  it is significantly faster. It is suggested to run CopraRNA on a machine with at
  least 8 GB of memory.\n\nCopraRNA produces a lot of file I/O. It is suggested to
  run CopraRNA in a dedicated empty directory to avoid unexpected behavior.\n\nThe
  central result table is CopraRNA_result.csv. Further explanations concerning the
  files in the run directory can be found in README.txt.\n\nTool homepage: https://github.com/PatrickRWright/CopraRNA"
inputs:
  - id: cons
    type:
      - 'null'
      - int
    doc: "controls consensus prediction\n                           '0' for off\n\
      \                           '1' for organism of interest based consensus\n \
      \                          '2' for overall consensus based prediction"
    inputBinding:
      position: 101
      prefix: --cons
  - id: cop1
    type:
      - 'null'
      - boolean
    doc: switch for CopraRNA1 prediction
    inputBinding:
      position: 101
      prefix: --cop1
  - id: cores
    type:
      - 'null'
      - int
    doc: amount of cores to use for parallel computation
    inputBinding:
      position: 101
      prefix: --cores
  - id: enrich
    type:
      - 'null'
      - int
    doc: if entered then DAVID-WS functional enrichment is calculated with given
      amount of top predictions
    inputBinding:
      position: 101
      prefix: --enrich
  - id: maxbpdist
    type:
      - 'null'
      - int
    doc: IntaRNA target (--tAccL) maximum base pair distance parameter
    inputBinding:
      position: 101
      prefix: --maxbpdist
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: switch to prevent removal of temporary files
    inputBinding:
      position: 101
      prefix: --noclean
  - id: nooi
    type:
      - 'null'
      - boolean
    doc: if set then the CopraRNA2 prediction mode is set not to focus on the 
      organism of interest
    inputBinding:
      position: 101
      prefix: --nooi
  - id: ntdown
    type:
      - 'null'
      - int
    doc: amount of nucleotides downstream of '--region' to parse for targeting
    inputBinding:
      position: 101
      prefix: --ntdown
  - id: ntup
    type:
      - 'null'
      - int
    doc: amount of nucleotides upstream of '--region' to parse for targeting
    inputBinding:
      position: 101
      prefix: --ntup
  - id: ooifilt
    type:
      - 'null'
      - int
    doc: post processing filter for organism of interest p-value 0=off
    inputBinding:
      position: 101
      prefix: --ooifilt
  - id: rcsize
    type:
      - 'null'
      - float
    doc: "minimum amount (%) of putative target homologs that need to be available\
      \ \n                           for a target cluster to be considered in the
      CopraRNA1 part (see --cop1) of the prediction"
    inputBinding:
      position: 101
      prefix: --rcsize
  - id: region
    type:
      - 'null'
      - string
    doc: "region to scan in whole genome target prediction\n                     \
      \      '5utr' for start codon\n                           '3utr' for stop codon\n\
      \                           'cds' for entire transcript"
    inputBinding:
      position: 101
      prefix: --region
  - id: root
    type:
      - 'null'
      - int
    doc: specifies root function to apply to the weights
    inputBinding:
      position: 101
      prefix: --root
  - id: srnaseq
    type:
      - 'null'
      - File
    doc: FASTA file with small RNA sequences
    inputBinding:
      position: 101
      prefix: --srnaseq
  - id: topcount
    type:
      - 'null'
      - int
    doc: specifies the amount of top predictions to return and use for the 
      extended regions plots
    inputBinding:
      position: 101
      prefix: --topcount
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: switch to print verbose output to terminal during computation
    inputBinding:
      position: 101
      prefix: --verbose
  - id: websrv
    type:
      - 'null'
      - boolean
    doc: switch to provide webserver output files
    inputBinding:
      position: 101
      prefix: --websrv
  - id: winsize
    type:
      - 'null'
      - int
    doc: IntaRNA target (--tAccW) window size parameter
    inputBinding:
      position: 101
      prefix: --winsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coprarna:2.1.4--hdfd78af_0
stdout: coprarna_CopraRNA2.pl.out
