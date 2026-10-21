cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sadie
  - make-all
label: sadie-antibody_sadie_make-all
doc: "Comprehensive database generation for SADIE AIRR analysis\n\nTool homepage: https://sadie.jordanrwillis.com"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: outpath
    type: string
    doc: Output path for all generated files
    inputBinding:
      position: 1
      prefix: --outpath
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference.yml file
    inputBinding:
      position: 1
      prefix: --reference
  - id: species
    type:
      - 'null'
      - string
    doc: Comma-separated list of species to build databases for (default all)
    inputBinding:
      position: 1
      prefix: --species
  - id: regenerate_catnap
    type:
      - 'null'
      - boolean
    doc: Regenerate CATNAP references from FASTA files
    inputBinding:
      position: 1
      prefix: --regenerate-catnap
  - id: regenerate_igl
    type:
      - 'null'
      - boolean
    doc: Regenerate IGL references from FASTA files
    inputBinding:
      position: 1
      prefix: --regenerate-igl
  - id: generate_reference
    type:
      - 'null'
      - boolean
    doc: Generate reference.yml file interactively or regenerate if missing
    inputBinding:
      position: 1
      prefix: --generate-reference
  - id: skip_blast
    type:
      - 'null'
      - boolean
    doc: Skip BLAST database generation
    inputBinding:
      position: 1
      prefix: --skip-blast
  - id: skip_aux
    type:
      - 'null'
      - boolean
    doc: Skip auxiliary file generation
    inputBinding:
      position: 1
      prefix: --skip-aux
  - id: skip_internal
    type:
      - 'null'
      - boolean
    doc: Skip internal annotation file generation
    inputBinding:
      position: 1
      prefix: --skip-internal
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Vebosity level, ex. -vvvvv for debug level logging
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Generated reference databases
    outputBinding:
      glob: $(inputs.outpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
stdout: sadie-antibody_sadie_make-all.out
