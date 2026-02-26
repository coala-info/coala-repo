cwlVersion: v1.2
class: CommandLineTool
baseCommand: proovframe_map
label: proovframe_map
doc: "For consensus sequences with rather low expected error rates\nand if your reference
  database has a good represention of similar\nsequences, you might want to switch
  to '-m fast' or '-m sensitive'\nto speed things up.\nAlso note, I've experienced
  inefficient parallelization if\ncorrecting a small number of Mb sized genomes (as
  opposed to thousands\nof long-reads) - presumably because diamond threads on a per-sequence\n\
  basis\n\nTool homepage: https://github.com/thackl/proovframe"
inputs:
  - id: seqs_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: extra_diamond_params
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra parameters for diamond
    inputBinding:
      position: 2
  - id: aa
    type:
      - 'null'
      - boolean
    doc: protein file, not required if db provided.
    inputBinding:
      position: 103
      prefix: --aa
  - id: database
    type:
      - 'null'
      - string
    doc: created if not existing and --aa given
    default: '[basename(aa).dmnd]'
    inputBinding:
      position: 103
      prefix: --db
  - id: db
    type:
      - 'null'
      - boolean
    doc: created if not existing and --aa given [basename(aa).dmnd]
    inputBinding:
      position: 103
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show debug messages
    inputBinding:
      position: 103
      prefix: --debug
  - id: diamond_mode
    type:
      - 'null'
      - string
    doc: one of fast,sensitive,{mid,more,very,ultra}-sensitive
    default: more-sensitive
    inputBinding:
      position: 103
      prefix: --diamond-mode
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: print the diamond command, but don't run it
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: protein_file
    type:
      - 'null'
      - File
    doc: protein file, not required if db provided.
    inputBinding:
      position: 103
      prefix: --aa
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write alignments to this file [basename(seqs).o6]
    outputBinding:
      glob: $(inputs.out)
  - id: alignments_file
    type:
      - 'null'
      - File
    doc: write alignments to this file
    outputBinding:
      glob: $(inputs.alignments_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
