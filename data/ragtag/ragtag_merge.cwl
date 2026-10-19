cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - merge
label: ragtag_merge
doc: "Scaffold merging: derive a consensus scaffolding solution by reconciling distinct\
  \ scaffoldings of 'asm.fa'.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: assembly
    type: File
    doc: assembly fasta file (uncompressed or bgzipped) (staged writable because the
      tool writes a .fai index beside it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: scaffolding_agps
    type:
      type: array
      items: File
    doc: scaffolding AGP files
    inputBinding:
      position: 2
  - id: agp_weights
    type:
      - 'null'
      - File
    doc: CSV list of (AGP file,weight) [null]
    inputBinding:
      position: 101
      prefix: -f
  - id: skip
    type:
      - 'null'
      - File
    doc: list of query headers to leave unplaced [null]
    inputBinding:
      position: 101
      prefix: -j
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: minimum assembly sequence length [100000]
    inputBinding:
      position: 101
      prefix: -l
  - id: min_edge_weight
    type:
      - 'null'
      - float
    doc: minimum edge weight. NA if using Hi-C [0.0]
    inputBinding:
      position: 101
      prefix: -e
  - id: gap_func
    type:
      - 'null'
      - string
    doc: function for merging gap lengths {'min', 'max', or 'mean'} [min]
    inputBinding:
      position: 101
      prefix: --gap-func
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory (default ragtag_output)
    default: ragtag_output
    inputBinding:
      position: 101
      prefix: -o
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite intermediate files
    inputBinding:
      position: 101
      prefix: -w
  - id: add_suffix
    type:
      - 'null'
      - boolean
    doc: add suffix to unplaced sequence headers
    inputBinding:
      position: 101
      prefix: -u
  - id: hic_bam
    type:
      - 'null'
      - File
    doc: Hi-C alignments in BAM format, sorted by read name [null]
    inputBinding:
      position: 101
      prefix: -b
  - id: restriction_enzymes
    type:
      - 'null'
      - string
    doc: CSV list of restriction enzymes/sites or 'DNase' [GATC]
    inputBinding:
      position: 101
      prefix: -r
  - id: terminus_portion
    type:
      - 'null'
      - float
    doc: portion of the sequence termini to consider for links [1.0]
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Output directory with the result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.assembly)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_merge.out
