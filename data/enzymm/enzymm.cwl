cwlVersion: v1.2
class: CommandLineTool
baseCommand: enzymm
label: enzymm
doc: "The Enzyme Motif Miner - Geometric matching of catalytic motifs in protein structures\n\
  \nTool homepage: https://pypi.org/project/enzymm/"
inputs:
  - id: conservation_cutoff
    type:
      - 'null'
      - float
    doc: Atoms with a value in the B-factor column below this cutoff will be 
      excluded form matching to the templates. Useful for predicted structures.
    default: 0
    inputBinding:
      position: 101
      prefix: --conservation-cutoff
  - id: include_query
    type:
      - 'null'
      - boolean
    doc: Include the query structure together with the hits in the pdb output
    default: false
    inputBinding:
      position: 101
      prefix: --include-query
  - id: include_template
    type:
      - 'null'
      - boolean
    doc: Include the template structure together with the hits in the pdb output
    default: false
    inputBinding:
      position: 101
      prefix: --include-template
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: File path to a PDB or mmCIF file to use as query
    default: []
    inputBinding:
      position: 101
      prefix: --input
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'The number of threads to spawn for jobs in parallel. Pass 0 to select all
      cores. Negative numbers: leave this many cores free.'
    default: 20
    inputBinding:
      position: 101
      prefix: --jobs
  - id: list
    type:
      - 'null'
      - File
    doc: File containing a list of PDB or mmCIF files to read
    default: None
    inputBinding:
      position: 101
      prefix: --list
  - id: match_small_templates
    type:
      - 'null'
      - boolean
    doc: If set, templates with less then 3 defined sidechain residues will 
      still be matched.
    default: false
    inputBinding:
      position: 101
      prefix: --match-small-templates
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Fixed Jess parameters for all templates. Jess space seperated 
      parameters rmsd, distance, max_dynamic_distance
    default: None
    inputBinding:
      position: 101
      prefix: --parameters
  - id: pdbs
    type:
      - 'null'
      - Directory
    doc: Output directory to which results should get written
    default: None
    inputBinding:
      position: 101
      prefix: --pdbs
  - id: skip_annotation
    type:
      - 'null'
      - boolean
    doc: If set, M-CSA derived templates will NOT be annotated with extra 
      information.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-annotation
  - id: skip_smaller_hits
    type:
      - 'null'
      - boolean
    doc: If set, will not search with smaller templates if larger templates have
      already found hits.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-smaller-hits
  - id: template_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing jess templates. This directory will be 
      recursively searched.
    default: None
    inputBinding:
      position: 101
      prefix: --template-dir
  - id: transform
    type:
      - 'null'
      - boolean
    doc: If set, one pdb file per matched template pdb with will be written in 
      the coordinate system of that template
    default: false
    inputBinding:
      position: 101
      prefix: --transform
  - id: unfiltered
    type:
      - 'null'
      - boolean
    doc: If set, matches which logistic regression predicts as false based on 
      RMSD and resdiue orientation will be retained. By default, matches 
      predicted as false are removed.
    default: false
    inputBinding:
      position: 101
      prefix: --unfiltered
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If process information and time progress should be printed to the 
      command line
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: warn
    type:
      - 'null'
      - boolean
    doc: If warings about bad template processing or suspicous and missing 
      annotations should be raised
    default: false
    inputBinding:
      position: 101
      prefix: --warn
outputs:
  - id: output
    type: File
    doc: Output tsv file to which results should get written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enzymm:0.3.1--pyhdfd78af_1
