cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools_all
doc: "Run the clusters, variants and synteny comparisons.\n\nTool homepage: https://github.com/agshumate/LiftoffTools"
inputs:
  - id: reference_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: 'reference fasta'
    inputBinding:
      position: 1
      prefix: -r
  - id: target_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: 'target fasta'
    inputBinding:
      position: 2
      prefix: -t
  - id: reference_annotation
    type: File
    doc: 'reference annotation file in GFF or GTF format, or gffutils database created in a previous liftoff or liftofftools run'
    inputBinding:
      position: 3
      prefix: -rg
  - id: target_annotation
    type: File
    doc: 'target annotation file in GFF or GTF format, or gffutils database created in a previous liftoff or liftofftools run'
    inputBinding:
      position: 4
      prefix: -tg
  - id: protein_coding_only
    type:
      - 'null'
      - boolean
    doc: 'analyze protein coding gene clusters only'
    inputBinding:
      position: 5
      prefix: -c
  - id: feature_types
    type:
      - 'null'
      - File
    doc: 'text file with additional feature types besides genes to analyze'
    inputBinding:
      position: 6
      prefix: -f
  - id: infer_genes
    type:
      - 'null'
      - boolean
    doc: 'infer genes from the annotation'
    inputBinding:
      position: 7
      prefix: -infer-genes
  - id: output_dir
    type: string
    doc: 'output directory'
    inputBinding:
      position: 8
      prefix: -dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force overwrite of output/intermediate files in -dir'
    inputBinding:
      position: 9
      prefix: -force
  - id: mmseqs_path
    type:
      - 'null'
      - string
    doc: 'mmseqs path if not in working directory or PATH'
    inputBinding:
      position: 10
      prefix: -mmseqs_path
  - id: mmseqs_params
    type:
      - 'null'
      - string
    doc: 'space delimited list of additional mmseqs parameters. Default="--min-seq-id 0.9 -c 0.9"'
    inputBinding:
      position: 11
      prefix: -mmseqs_params
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: 'calculate edit distance between reference gene order and target gene order'
    inputBinding:
      position: 12
      prefix: -edit-distance
  - id: reference_sort
    type:
      - 'null'
      - File
    doc: 'txt file with the order of the reference chromosomes to be plotted on the x-axis'
    inputBinding:
      position: 13
      prefix: -r-sort
  - id: target_sort
    type:
      - 'null'
      - File
    doc: 'txt file with the order of the target chromosomes to be plotted on the y-axis'
    inputBinding:
      position: 14
      prefix: -t-sort
outputs:
  - id: output_directory
    type: Directory
    doc: 'Directory with the comparison results'
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_fasta)
        writable: true
      - entry: $(inputs.target_fasta)
        writable: true
      - entry: $(inputs.reference_annotation)
        writable: true
      - entry: $(inputs.target_annotation)
        writable: true
arguments:
  - position: 200
    valueFrom: all
  - position: 201
    shellQuote: false
    valueFrom: "&& find $(inputs.output_dir) -type l -delete"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
