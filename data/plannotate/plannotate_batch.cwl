cwlVersion: v1.2
class: CommandLineTool
baseCommand: plannotate batch
label: plannotate_batch
doc: "Annotates engineered DNA sequences, primarily plasmids. Accepts a FASTA or GenBank
  file and outputs a GenBank file with annotations, as well as an optional interactive
  plasmid map as an HTLM file.\n\nTool homepage: https://github.com/barricklab/pLannotate"
inputs:
  - id: csv_output
    type:
      - 'null'
      - boolean
    doc: creates a cvs file in specified path
    inputBinding:
      position: 101
      prefix: --csv
  - id: detailed_search
    type:
      - 'null'
      - boolean
    doc: uses modified algorithm for a more-detailed search with more false 
      positives
    inputBinding:
      position: 101
      prefix: --detailed
  - id: html_full_map
    type:
      - 'null'
      - boolean
    doc: creates an html plasmid map in specified path, with bokeh baked in
    inputBinding:
      position: 101
      prefix: --htmlfull
  - id: html_map
    type:
      - 'null'
      - boolean
    doc: creates an html plasmid map in specified path
    inputBinding:
      position: 101
      prefix: --html
  - id: input_file
    type: File
    doc: location of a FASTA or GBK file
    inputBinding:
      position: 101
      prefix: --input
  - id: linear
    type:
      - 'null'
      - boolean
    doc: enables linear DNA annotation
    inputBinding:
      position: 101
      prefix: --linear
  - id: no_gbk_output
    type:
      - 'null'
      - boolean
    doc: supresses GenBank output file
    inputBinding:
      position: 101
      prefix: --no_gbk
  - id: output_file_name
    type:
      - 'null'
      - string
    doc: name of output file (do not add extension).
    inputBinding:
      position: 101
      prefix: --file_name
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: location of output folder.
    inputBinding:
      position: 101
      prefix: --output
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: suffix appended to output files. Use '' for no suffix.
    inputBinding:
      position: 101
      prefix: --suffix
  - id: yaml_file
    type:
      - 'null'
      - File
    doc: path to YAML file for custom databases.
    inputBinding:
      position: 101
      prefix: --yaml_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
stdout: plannotate_batch.out
