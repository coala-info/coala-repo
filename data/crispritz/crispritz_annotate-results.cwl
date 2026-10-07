cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - annotate-results
label: crispritz_annotate-results
doc: "Add genomic information (annotations from a BED file) to targets results.\n  \nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: results_file
    type: File
    doc: Targets file containing all genomic targets for the guides set
    inputBinding:
      position: 1
  - id: annotations_file
    type: File
    doc: Text file containing the annotations in .bed format
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of output file
    inputBinding:
      position: 3
  - id: change_id
    type:
      - 'null'
      - File
    doc: Change the samples, population and superpopulation IDs. DEFAULT the 
      default IDs are taken from the 1000 genome project (used for Human Genome 
      hg19 and hg38)
    inputBinding:
      position: 4
      prefix: --change-ID
outputs:
  - id: annotation_targets
    type:
      - 'null'
      - File
    doc: Targets with their annotation
    outputBinding:
      glob: $(inputs.output_name).Annotation.targets.txt
  - id: annotation_summary
    type:
      - 'null'
      - File
    doc: Counts of targets per annotation and mismatch number
    outputBinding:
      glob: $(inputs.output_name).Annotation.summary.txt
  - id: result_files
    type:
      type: array
      items: File
    doc: All annotation output files
    outputBinding:
      glob: $(inputs.output_name)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
