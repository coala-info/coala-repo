cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - args_oap
  - stage_two
label: args_oap_stage_two
doc: "Stage two of the ARGs-OAP pipeline for antibiotic resistance gene analysis,
  performing sequence alignment and classification.\n\nTool homepage: https://github.com/xinehc/args_oap"
inputs:
  - id: blastout
    type:
      - 'null'
      - File
    doc: BLAST output (-outfmt "6 qseqid sseqid pident length qlen slen evalue bitscore"),
      if given then skip BLAST.
    inputBinding:
      position: 101
      prefix: --blastout
  - id: database
    type:
      - 'null'
      - File
    doc: Customized database (indexed) other than SARG.
    inputBinding:
      position: 101
      prefix: --database
  - id: e_value
    type:
      - 'null'
      - float
    doc: E-value cutoff for target sequences.
    inputBinding:
      position: 101
      prefix: --e
  - id: identity
    type:
      - 'null'
      - float
    doc: Identity cutoff (in percentage) for target sequences.
    inputBinding:
      position: 101
      prefix: --id
  - id: indir
    type: Directory
    doc: Input folder. Should be the output folder of stage_one (containing <metadata.txt>
      and <extracted.fa>).
    inputBinding:
      position: 101
      prefix: --indir
  - id: length
    type:
      - 'null'
      - int
    doc: Aligned length cutoff (in amino acid) for target sequences.
    inputBinding:
      position: 101
      prefix: --length
  - id: query_cover
    type:
      - 'null'
      - float
    doc: Query cover cutoff (in percentage) for target sequences.
    inputBinding:
      position: 101
      prefix: --qcov
  - id: structure1
    type:
      - 'null'
      - File
    doc: Customized structure file (weight 1, single-component).
    inputBinding:
      position: 101
      prefix: --structure1
  - id: structure2
    type:
      - 'null'
      - File
    doc: Customized structure file (weight 1/2, two-component).
    inputBinding:
      position: 101
      prefix: --structure2
  - id: structure3
    type:
      - 'null'
      - File
    doc: Customized structure file (weight 1/3, multi-component).
    inputBinding:
      position: 101
      prefix: --structure3
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder, if not given then same as input folder (--indir).
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
