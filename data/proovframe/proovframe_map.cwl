cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proovframe
  - map
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
    doc: Extra parameters for diamond (passed after `--`)
    inputBinding:
      position: 200
      prefix: --
  - id: database
    type:
      - 'null'
      - string
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
  - id: out_path
    type: string
    doc: write alignments to this file [basename(seqs).o6]
    inputBinding:
      position: 105
      prefix: --out
outputs:
  - id: out
    type: File
    doc: write alignments to this file [basename(seqs).o6]
    outputBinding:
      glob: $(inputs.out_path)
  - id: database_out
    type:
      - 'null'
      - File
    doc: diamond database created when --aa is given and the database did not exist
    outputBinding:
      glob: $(inputs.database)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
