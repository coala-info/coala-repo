cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Meteor
  - merge
label: meteor_merge
doc: "Merge abundance tables from multiple samples into a single directory.\n\nTool
  homepage: https://github.com/metagenopolis/meteor"
inputs:
  - id: merge_gene_abundance
    type:
      - 'null'
      - boolean
    doc: Merge gene abundance tables.
    inputBinding:
      position: 101
      prefix: -g
  - id: min_msp_abundance
    type:
      - 'null'
      - float
    doc: Minimum msp abundance
    default: 0.0
    inputBinding:
      position: 101
      prefix: -a
  - id: min_msp_occurrence
    type:
      - 'null'
      - int
    doc: Report only species (MSPs) occuring in at least n samples
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix added to output filenames
    default: output
    inputBinding:
      position: 101
      prefix: -p
  - id: profile_dir
    type: Directory
    doc: Directory containing subdirectories (one per sample) with abundance 
      tables to be merged. (each subdirectory contains a metadata file ending 
      with _census_stage_2.json)
    inputBinding:
      position: 101
      prefix: -i
  - id: ref_dir
    type: Directory
    doc: Directory corresponding to the gene catalog used to generate the 
      abundance tables. (contains a file ending with *_reference.json)
    inputBinding:
      position: 101
      prefix: -r
  - id: remove_empty_samples
    type:
      - 'null'
      - boolean
    doc: Remove samples with no detected species (MSPs)
    default: false
    inputBinding:
      position: 101
      prefix: -s
  - id: save_biom
    type:
      - 'null'
      - boolean
    doc: Save the merged species abundance table in biom format
    default: false
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: merging_dir
    type: Directory
    doc: Directory where the merged abundance tables are saved.
    outputBinding:
      glob: $(inputs.merging_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
