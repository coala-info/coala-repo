cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segway
  - annotate
label: segway_annotate
doc: "Annotates genomic data using a trained model.\n\nTool homepage: http://segway.hoffmanlab.org/"
inputs:
  - id: genomedata
    type: string
    doc: Genomic data to annotate
    inputBinding:
      position: 1
  - id: traindir
    type: Directory
    doc: Directory containing the trained model
    inputBinding:
      position: 2
  - id: annotatedir
    type: Directory
    doc: Directory to store annotations
    inputBinding:
      position: 3
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: delete any preexisting files and assumes any model filesspecified in 
      options as output to be overwritten
    inputBinding:
      position: 104
      prefix: --clobber
  - id: exclude_coords
    type:
      - 'null'
      - File
    doc: filter out genomic coordinates in FILE (default none)
    inputBinding:
      position: 104
      prefix: --exclude-coords
  - id: include_coords
    type:
      - 'null'
      - File
    doc: 'limit to genomic coordinates in FILE (default all) (Note: does not apply
      to --validation-coords)'
    inputBinding:
      position: 104
      prefix: --include-coords
  - id: output_label
    type:
      - 'null'
      - string
    doc: in the segmentation file, for each coordinate print only its superlabel
      ("seg"), only its sublabel ("subseg"), or both ("full") (default seg)
    inputBinding:
      position: 104
      prefix: --output-label
  - id: recover
    type:
      - 'null'
      - Directory
    doc: continue from interrupted run in DIR
    inputBinding:
      position: 104
      prefix: --recover
  - id: seg_table
    type:
      - 'null'
      - File
    doc: load segment hyperparameters from FILE (default none)
    inputBinding:
      position: 104
      prefix: --seg-table
  - id: virtual_evidence
    type:
      - 'null'
      - File
    doc: virtual evidence with priors for labels at each position in FILE 
      (default none)
    inputBinding:
      position: 104
      prefix: --virtual-evidence
outputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: create identification BED track in FILE (default WORKDIR/segway.bed.gz)
    outputBinding:
      glob: $(inputs.bed_file)
  - id: big_bed_file
    type:
      - 'null'
      - File
    doc: specify layered bigBed filename
    outputBinding:
      glob: $(inputs.big_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
