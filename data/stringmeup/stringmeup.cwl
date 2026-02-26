cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringmeup
label: stringmeup
doc: "A post-processing tool to reclassify Kraken 2 output based on the confidence
  score and/or minimum minimizer hit groups.\n\nTool homepage: https://github.com/danisven/StringMeUp"
inputs:
  - id: confidence
    type: float
    doc: The confidence score threshold to be used in reclassification [0-1].
    inputBinding:
      position: 1
  - id: classifications
    type: File
    doc: Path to the Kraken 2 output file containing the individual read 
      classifications.
    inputBinding:
      position: 2
  - id: gz_output
    type:
      - 'null'
      - boolean
    doc: Set this flag to output <output_classifications> and <output_verbose> 
      in gzipped format (will add .gz extension to the filenames).
    inputBinding:
      position: 103
      prefix: --gz_output
  - id: keep_unclassified
    type:
      - 'null'
      - boolean
    doc: 'Specify if you want to output unclassified reads in addition to classified
      reads. NOTE(!): This script will always discard reads that are unclassified
      in the classifications input file, this flag will just make sure to keep previously
      classified reads even if they are reclassified as unclassified by this script.
      TIP(!): Always run Kraken2 with no confidence cutoff.'
    inputBinding:
      position: 103
      prefix: --keep_unclassified
  - id: minimum_hit_groups
    type:
      - 'null'
      - int
    doc: 'The minimum number of hit groups a read needs to be classified. NOTE: You
      need to supply a classifications file (kraken2 output) that contain the "minimizer_hit_groups"
      column.'
    inputBinding:
      position: 103
      prefix: --minimum_hit_groups
  - id: names
    type: File
    doc: Taxonomy names dump file (names.dmp)
    inputBinding:
      position: 103
      prefix: --names
  - id: nodes
    type: File
    doc: Taxonomy nodes dump file (nodes.dmp)
    inputBinding:
      position: 103
      prefix: --nodes
outputs:
  - id: output_report
    type:
      - 'null'
      - File
    doc: File to save the Kraken 2 report in.
    outputBinding:
      glob: $(inputs.output_report)
  - id: output_classifications
    type:
      - 'null'
      - File
    doc: File to save the Kraken 2 read classifications in.
    outputBinding:
      glob: $(inputs.output_classifications)
  - id: output_verbose
    type:
      - 'null'
      - File
    doc: File to send verbose output to. This file will contain, for each read, 
      (1) original classification, (2) new classification, (3) original 
      confidence, (4), new confidence (5), original taxa name (6), new taxa 
      name, (7) original rank, (8) new rank, (9) distance travelled (how many 
      nodes was it lifted upwards in the taxonomy).
    outputBinding:
      glob: $(inputs.output_verbose)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmeup:0.1.5--pyhdfd78af_0
