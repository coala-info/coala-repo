cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth_extract
label: ccsmeth_extract
doc: "extract features from hifi reads.\n\nTool homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: if compressing the output using gzip
    inputBinding:
      position: 101
      prefix: --gzip
  - id: holeids_e
    type:
      - 'null'
      - File
    doc: "file contains holeids/hifiids to be extracted, default\nNone"
    inputBinding:
      position: 101
      prefix: --holeids_e
  - id: holeids_ne
    type:
      - 'null'
      - File
    doc: "file contains holeids/hifiids not to be extracted,\ndefault None"
    inputBinding:
      position: 101
      prefix: --holeids_ne
  - id: holes_batch
    type:
      - 'null'
      - int
    doc: "number of holes/hifi-reads in an batch to get/put in\nqueues, default 50"
    inputBinding:
      position: 101
      prefix: --holes_batch
  - id: identity
    type:
      - 'null'
      - float
    doc: identity cutoff for selecting alignment items, [0.0, 1.0], default 0.0
    inputBinding:
      position: 101
      prefix: --identity
  - id: input
    type: File
    doc: "input file in bam/sam format, can be unaligned\nhifi.bam/sam and aligned
      sorted hifi.bam/sam."
    inputBinding:
      position: 101
      prefix: --input
  - id: is_map
    type:
      - 'null'
      - string
    doc: if extracting mapping features, yes or no, default no. only works in 
      ALIGN-MODE
    inputBinding:
      position: 101
      prefix: --is_map
  - id: is_sn
    type:
      - 'null'
      - string
    doc: "if extracting signal-to-noise features, yes or no,\ndefault no"
    inputBinding:
      position: 101
      prefix: --is_sn
  - id: mapq
    type:
      - 'null'
      - int
    doc: MAPping Quality cutoff for selecting alignment items, default 1
    inputBinding:
      position: 101
      prefix: --mapq
  - id: methy_label
    type:
      - 'null'
      - string
    doc: "the label of the interested modified bases, this is\nfor training. 0 or
      1, default 1"
    inputBinding:
      position: 101
      prefix: --methy_label
  - id: mod_loc
    type:
      - 'null'
      - int
    doc: 0-based location of the targeted base in the motif, default 0
    inputBinding:
      position: 101
      prefix: --mod_loc
  - id: mode
    type:
      - 'null'
      - string
    doc: "denovo mode: extract features from unaligned/aligned\nhifi.bam without reference
      position info; align mode: extract features from aligned hifi.bam with reference\n\
      position info. default: denovo"
    inputBinding:
      position: 101
      prefix: --mode
  - id: motifs
    type:
      - 'null'
      - string
    doc: "motif seq to be extracted, default: CG. can be multi\nmotifs splited by
      comma (no space allowed in the input\nstr), or use IUPAC alphabet, the mod_loc
      of all motifs\nmust be the same"
    inputBinding:
      position: 101
      prefix: --motifs
  - id: no_decode
    type:
      - 'null'
      - boolean
    doc: not use CodecV1 to decode ipd/pw
    inputBinding:
      position: 101
      prefix: --no_decode
  - id: no_supplementary
    type:
      - 'null'
      - boolean
    doc: not use supplementary alignment
    inputBinding:
      position: 101
      prefix: --no_supplementary
  - id: norm
    type:
      - 'null'
      - string
    doc: "method for normalizing ipd/pw in subread level.\nzscore, min-mean, min-max,
      mad, or none. default\nzscore"
    inputBinding:
      position: 101
      prefix: --norm
  - id: ref
    type:
      - 'null'
      - File
    doc: path to genome reference to be aligned, in fasta/fa format.
    inputBinding:
      position: 101
      prefix: --ref
  - id: seq_len
    type:
      - 'null'
      - int
    doc: len of kmer. default 21
    inputBinding:
      position: 101
      prefix: --seq_len
  - id: skip_unmapped
    type:
      - 'null'
      - string
    doc: if skipping unmapped sites in reads, yes or no, default yes
    inputBinding:
      position: 101
      prefix: --skip_unmapped
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads, default 5
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "output file path to save the extracted features. If\nnot specified, use
      input_prefix.tsv as default."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
