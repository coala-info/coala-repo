cwlVersion: v1.2
class: CommandLineTool
baseCommand: hAMRoaster
label: hamroaster_hAMRoaster
doc: "hAMRoaster: A tool for harmonizing AMR gene annotations from multiple sources.\n\
  \nTool homepage: https://github.com/ewissel/hAMRoaster"
inputs:
  - id: abx_map
    type:
      - 'null'
      - File
    doc: full path to Abx:drug class mapping file, if included
    inputBinding:
      position: 101
      prefix: --abx_map
  - id: amr_key
    type: File
    doc: full path to key with known AMR phenotypes, REQUIRED
    inputBinding:
      position: 101
      prefix: --AMR_key
  - id: db_files
    type:
      - 'null'
      - Directory
    doc: Path to ontology index files, exclude "/" on end of path. Expecting 
      "/aro_categories_index.tsv" in the directory pointed to in this param.
    inputBinding:
      position: 101
      prefix: --db_files
  - id: fargene
    type:
      - 'null'
      - Directory
    doc: full path to the fARGene output directory (one subdirectory per model), if included
    inputBinding:
      position: 101
      prefix: --fargene
  - id: groupby_sample
    type:
      - 'null'
      - string
    doc: Should results from the mock community key be examined per sample 
      (True), or as one whole community (False)
    inputBinding:
      position: 101
      prefix: --groupby_sample
  - id: name
    type: string
    doc: an identifier for this analysis run, REQUIRED
    inputBinding:
      position: 101
      prefix: --name
  - id: shortbred
    type:
      - 'null'
      - Directory
    doc: full path to the shortBRED output directory (tsv files), if included
    inputBinding:
      position: 101
      prefix: --shortbred
  - id: shortbred_map
    type:
      - 'null'
      - File
    doc: full path to shortBRED mapping file, if included and not using default
    inputBinding:
      position: 101
      prefix: --shortbred_map
  - id: ham_out
    type: File
    doc: output file from hAMRonization (tsv), REQUIRED
    inputBinding:
      position: 101
      prefix: --ham_out
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory named after the --name argument, with the hAMRoaster
      result tables (thanksgiving_ham_<name>.csv, cooked_ham_w_true_pos_<name>.csv, ...)
    outputBinding:
      glob: $(inputs.name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamroaster:2.0--hdfd78af_0
