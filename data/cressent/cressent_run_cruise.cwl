cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - run_cruise
label: cressent_run_cruise
doc: "Search for iterons around CRESS stem-loops in GFF files.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: input_fasta
    type: File
    doc: "Path to input FASTA file with all sequences"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: input_gff
    type: File
    doc: "Path to associated input GFF file"
    inputBinding:
      position: 101
      prefix: --inputGFF
  - id: output_gff
    type: string
    doc: "Path for output GFF file (default: finaloutput.gff)"
    inputBinding:
      position: 101
      prefix: --outputGFF
  - id: output_annotations
    type:
      - 'null'
      - string
    doc: "Identifiers to selectively preserve annotations (default: 2 CRUISE)"
    inputBinding:
      position: 101
      prefix: --outputAnnotations
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum iteron length (default = 5)"
    inputBinding:
      position: 101
      prefix: --minLength
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum iteron length (default = 12)"
    inputBinding:
      position: 101
      prefix: --maxLength
  - id: search_range
    type:
      - 'null'
      - int
    doc: "Number of base pairs around nona to search (default = 65)"
    inputBinding:
      position: 101
      prefix: --range
  - id: rank
    type:
      - 'null'
      - string
    doc: "Use ranking system, True or False (default = True)"
    inputBinding:
      position: 101
      prefix: --rank
  - id: number_top_iterons
    type:
      - 'null'
      - int
    doc: "The number of iterons returned in rank order (default = 5)"
    inputBinding:
      position: 101
      prefix: --numberTopIterons
  - id: max_score
    type:
      - 'null'
      - int
    doc: "Maximum score allowed for iterons if rank = False (default = 40)"
    inputBinding:
      position: 101
      prefix: --maxScore
  - id: wiggle
    type:
      - 'null'
      - int
    doc: "Max difference between iteron length and distance (default = 5)"
    inputBinding:
      position: 101
      prefix: --wiggle
  - id: good_length
    type:
      - 'null'
      - int
    doc: "The highest favorable iteron length (default = 11)"
    inputBinding:
      position: 101
      prefix: --goodLength
  - id: do_stem_loop
    type:
      - 'null'
      - string
    doc: "Whether to annotate stem-loop repeats, True or False (default = True)"
    inputBinding:
      position: 101
      prefix: --doStemLoop
  - id: do_known_iterons
    type:
      - 'null'
      - string
    doc: "Whether to annotate known iterons, True or False (default = True)"
    inputBinding:
      position: 101
      prefix: --doKnownIterons
  - id: max_dist
    type:
      - 'null'
      - int
    doc: "Maximum allowed distance between iterons (default = 20)"
    inputBinding:
      position: 101
      prefix: --maxDist
  - id: best_dist
    type:
      - 'null'
      - int
    doc: "Optimal maximum distance between iterons (default = 10)"
    inputBinding:
      position: 101
      prefix: --bestDist
  - id: score_range
    type:
      - 'null'
      - int
    doc: "Score range between outputted candidates (default = 50)"
    inputBinding:
      position: 101
      prefix: --scoreRange
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
