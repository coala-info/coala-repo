cwlVersion: v1.2
class: CommandLineTool
baseCommand: sativa.py
label: sativa_sativa.py
doc: "SATIVA v0.9.1, released on 2023-08-16. Last version: https://github.com/amkozlov/sativa\
  \ \nBy A.Kozlov and J.Zhang, the Exelixis Lab. Based on RAxML 8.2.3 by A.Stamatakis.\n\
  \nTool homepage: https://github.com/amkozlov/sativa"
inputs:
  - id: alignment
    type: File
    doc: "Reference alignment file (PHYLIP or FASTA). Sequences\nmust be aligned,
      their IDs must correspond to those in\ntaxonomy file."
    inputBinding:
      position: 101
      prefix: --alignment
  - id: brlen_pv
    type:
      - 'null'
      - float
    doc: 'P-value for branch length Erlang test. Default: 0=off'
    inputBinding:
      position: 101
      prefix: --brlen_pv
  - id: conf_cutoff
    type:
      - 'null'
      - float
    doc: 'Confidence cut-off between 0 and 1. Default: 0'
    inputBinding:
      position: 101
      prefix: --conf_cutoff
  - id: config_fname
    type:
      - 'null'
      - File
    doc: Config file name.
    inputBinding:
      position: 101
      prefix: --config_fname
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Debug mode, intermediate files will not be cleaned up.
    inputBinding:
      position: 101
      prefix: --debug
  - id: enable_memory_saving
    type:
      - 'null'
      - boolean
    doc: "Enable RAxML memory saving (useful for large and gappy\nalignments)."
    inputBinding:
      position: 101
      prefix: --enable_memory_saving
  - id: final_jplace_fname
    type:
      - 'null'
      - type: array
        items: File
    doc: "Do not call RAxML to perform final EPA classification,\nuse existing .jplace
      file as input instead. This could\nbe also a directory with *.jplace files."
    inputBinding:
      position: 101
      prefix: --final_jplace_fname
  - id: jplace_fname
    type:
      - 'null'
      - type: array
        items: File
    doc: "Do not call RAxML to perform EPA leave-one-out test,\nuse existing .jplace
      file as input instead. This could\nbe also a directory with *.jplace files."
    inputBinding:
      position: 101
      prefix: --jplace_fname
  - id: method
    type:
      - 'null'
      - string
    doc: "Method of multifurcation resolution: thorough use\nstardard constrainted
      RAxML tree search (default) fast\nuse RF distance as search convergence criterion
      (RAxML\n-D option) ultrafast optimize model+branch lengths\nonly (RAxML -f e
      option)"
    inputBinding:
      position: 101
      prefix: --method
  - id: min_lhw
    type:
      - 'null'
      - float
    doc: "A value between 0 and 1, the minimal sum of likelihood\nweight of an assignment
      to a specific rank. This value\nrepresents a confidence measure of the assignment,\n\
      assignments below this value will be discarded.\nDefault: 0 to output all possbile
      assignments."
    inputBinding:
      position: 101
      prefix: --min_lhw
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Specify the number of CPUs (default: 20)'
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: current).'
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Job name, will be used as a prefix for output file\nnames (default: taxonomy
      file name without extension)"
    inputBinding:
      position: 101
      prefix: --output_name
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: 'Random seed to be used with RAxML. Default: 12345'
    inputBinding:
      position: 101
      prefix: --rand_seed
  - id: rank_test
    type:
      - 'null'
      - boolean
    doc: Test for misplaced higher ranks.
    inputBinding:
      position: 101
      prefix: --ranktest
  - id: ref_fname
    type:
      - 'null'
      - File
    doc: "Specify the reference alignment and taxonomy in\nrefjson format."
    inputBinding:
      position: 101
      prefix: --ref_fname
  - id: rep_num
    type:
      - 'null'
      - int
    doc: "Number of RAxML tree searches (with distinct random\nseeds) to resolve multifurcation.
      Default: 1"
    inputBinding:
      position: 101
      prefix: --rep_num
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "Resume execution after a premature termination (e.g.,\ndue to expired job
      time limit). Run name of the\nprevious (terminated) job must be specified via
      -n\noption."
    inputBinding:
      position: 101
      prefix: --resume
  - id: synonym_fname
    type:
      - 'null'
      - File
    doc: "File listing synonymous rank names, which will be\nconsidered equivalent.
      Please enter one name per line;\nseparate groups with an empty line."
    inputBinding:
      position: 101
      prefix: --synonym_fname
  - id: taxonomic_code
    type: string
    doc: "Taxonomic code: BAC(teriological), BOT(anical),\nZOO(logical), VIR(ological)"
    inputBinding:
      position: 101
      prefix: --taxonomic_code
  - id: taxonomy
    type: File
    doc: Reference taxonomy file.
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files.
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional info messages to the console.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sativa:0.9.3--py312h031d066_0
stdout: sativa_sativa.py.out
