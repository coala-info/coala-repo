cwlVersion: v1.2
class: CommandLineTool
baseCommand: PIRATE
label: pirate_PIRATE
doc: "PIRATE input/output:\n\nTool homepage: https://github.com/SionBayliss/PIRATE"
inputs:
  - id: align
    type:
      - 'null'
      - boolean
    doc: align all genes and produce core/pangenome alignments
    inputBinding:
      position: 101
      prefix: --align
  - id: check
    type:
      - 'null'
      - boolean
    doc: check installation and run on example files
    inputBinding:
      position: 101
      prefix: --check
  - id: check_nucl
    type:
      - 'null'
      - boolean
    doc: check installation and run on example files using --nucl
    inputBinding:
      position: 101
      prefix: --check-n
  - id: classify_off
    type:
      - 'null'
      - boolean
    doc: do not classify paralogs, assumes this has been run previously
    inputBinding:
      position: 101
      prefix: --classify-off
  - id: features
    type:
      - 'null'
      - type: array
        items: string
    doc: choose features to use for pangenome construction. Multiple may be 
      entered, seperated by a comma
    inputBinding:
      position: 101
      prefix: --features
  - id: identity_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: '% identity thresholds to use for pangenome construction'
    inputBinding:
      position: 101
      prefix: --steps
  - id: input_dir
    type: Directory
    doc: input directory containing gffs
    inputBinding:
      position: 101
      prefix: --input
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length for feature extraction
    inputBinding:
      position: 101
      prefix: --min-len
  - id: nucl
    type:
      - 'null'
      - boolean
    doc: CDS are not translated to AA sequence
    inputBinding:
      position: 101
      prefix: --nucl
  - id: pan_off
    type:
      - 'null'
      - boolean
    doc: don't run pangenome tool [assumes PIRATE has been previously run and 
      resulting files are present in output folder]
    inputBinding:
      position: 101
      prefix: --pan-off
  - id: pan_opt
    type:
      - 'null'
      - string
    doc: additional arguments to pass to pangenome_contruction
    inputBinding:
      position: 101
      prefix: --pan-opt
  - id: para_args
    type:
      - 'null'
      - string
    doc: options to pass to paralog splitting algorithm
    inputBinding:
      position: 101
      prefix: --para-args
  - id: para_off
    type:
      - 'null'
      - boolean
    doc: switch off paralog identification
    inputBinding:
      position: 101
      prefix: --para-off
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: switch off verbose
    inputBinding:
      position: 101
      prefix: --quiet
  - id: retain_intermediate_files
    type:
      - 'null'
      - int
    doc: retain intermediate files
      --pan-off), 2 = all
    inputBinding:
      position: 101
      prefix: -z
  - id: rplots
    type:
      - 'null'
      - boolean
    doc: plot summaries using R [requires dependencies]
    inputBinding:
      position: 101
      prefix: --rplots
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads/cores used by PIRATE
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory in which to create PIRATE folder
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirate:1.0.5--hdfd78af_3
