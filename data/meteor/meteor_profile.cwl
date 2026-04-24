cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Meteor
  - profile
label: meteor_profile
doc: "Generate species and functional abundance tables from raw gene counts.\n\nTool
  homepage: https://github.com/metagenopolis/meteor"
inputs:
  - id: completeness
    type:
      - 'null'
      - float
    doc: 'Cutoff above which a module is considered as present in a species. Value
      between 0.0 and 1.0 (default: 0.9).'
    inputBinding:
      position: 101
      prefix: --completeness
  - id: core_size
    type:
      - 'null'
      - int
    doc: 'Number of signature genes per species (MSP) used to estimate their respective
      abundance (default: 100).'
    inputBinding:
      position: 101
      prefix: --core_size
  - id: coverage_factor
    type:
      - 'null'
      - int
    doc: 'Multiplication factor for coverage normalization (default: 100).'
    inputBinding:
      position: 101
      prefix: -c
  - id: mapped_sample_dir
    type: Directory
    doc: Directory with raw gene counts of the sample to process. (contains a 
      metadata file ending with _census_stage_1.json)
    inputBinding:
      position: 101
      prefix: -i
  - id: msp_filter
    type:
      - 'null'
      - string
    doc: 'Minimal proportion of core genes detected in a sample to consider a species
      (MSP) as present (default: auto).'
    inputBinding:
      position: 101
      prefix: --msp_filter
  - id: normalization
    type:
      - 'null'
      - string
    doc: 'Normalization applied to raw gene counts (default: coverage). Options: coverage,
      fpkm, raw.'
    inputBinding:
      position: 101
      prefix: -n
  - id: rarefaction_level
    type:
      - 'null'
      - int
    doc: 'Rarefaction level. If <= 0, no rarefation is performed (default: 0).'
    inputBinding:
      position: 101
      prefix: -l
  - id: ref_dir
    type: Directory
    doc: Directory corresponding to the catalog used to generate raw gene 
      counts. (contains a file ending with *_reference.json)
    inputBinding:
      position: 101
      prefix: -r
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Seed of the random number generator used for rarefaction (default: 1234).'
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: profiled_sample_dir
    type: Directory
    doc: Directory where species and functional abundance tables of the sample 
      are saved.
    outputBinding:
      glob: $(inputs.profiled_sample_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
