cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi mp
label: tsumugi_mp
doc: "Filter gene pairs based on Mammalian Phenotype ontology terms and annotations.\n\
  \nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: exclude_mp_id
    type:
      - 'null'
      - string
    doc: Exclude gene pairs that (when measured) lack the specified MP term 
      (descendants included).
    inputBinding:
      position: 101
      prefix: --exclude
  - id: genewise
    type:
      - 'null'
      - boolean
    doc: Filter by number of phenotypes per KO mouse
    inputBinding:
      position: 101
      prefix: --genewise
  - id: genewise_annotations
    type:
      - 'null'
      - File
    doc: Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz). 
      Required when using '-e/--exclude' to determine genes that were measured 
      and showed no phenotype for the target MP term.
    inputBinding:
      position: 101
      prefix: --genewise_annotations
  - id: include_mp_id
    type:
      - 'null'
      - string
    doc: Include gene pairs that share the specified MP term (descendants 
      included).
    inputBinding:
      position: 101
      prefix: --include
  - id: life_stage
    type:
      - 'null'
      - string
    doc: Filter by life stage. 'Embryo', 'Early', 'Interval', and 'Late'.
    inputBinding:
      position: 101
      prefix: --life_stage
  - id: mp_obo
    type:
      - 'null'
      - File
    doc: Path to Mammalian Phenotype ontology file (mp.obo). Used to map and 
      infer hierarchical relationships among MP terms.
    inputBinding:
      position: 101
      prefix: --mp_obo
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: Filter by number of shared phenotypes between KO pairs
    inputBinding:
      position: 101
      prefix: --pairwise
  - id: pairwise_similarity_annotations
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
  - id: sex
    type:
      - 'null'
      - string
    doc: Filter by sexual dimorphism. 'Male' or 'Female'.
    inputBinding:
      position: 101
      prefix: --sex
  - id: zygosity
    type:
      - 'null'
      - string
    doc: Filter by zygosity.  'Homo', 'Hetero' or 'Hemi'.
    inputBinding:
      position: 101
      prefix: --zygosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_mp.out
