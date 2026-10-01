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
      prefix: -s
  - id: brlen_pv
    type:
      - 'null'
      - float
    doc: 'P-value for branch length Erlang test. Default: 0=off'
    inputBinding:
      position: 101
      prefix: -P
  - id: conf_cutoff
    type:
      - 'null'
      - float
    doc: 'Confidence cut-off between 0 and 1. Default: 0'
    inputBinding:
      position: 101
      prefix: -C
  - id: config_fname
    type:
      - 'null'
      - File
    doc: Config file name.
    inputBinding:
      position: 101
      prefix: -c
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Debug mode, intermediate files will not be cleaned up.
    inputBinding:
      position: 101
      prefix: -debug
  - id: enable_memory_saving
    type:
      - 'null'
      - boolean
    doc: "Enable RAxML memory saving (useful for large and gappy\nalignments)."
    inputBinding:
      position: 101
      prefix: -S
  - id: final_jplace_fname
    type:
      - 'null'
      - type: array
        items: File
    doc: "Do not call RAxML to perform final EPA classification,\nuse existing .jplace
      file as input instead. This could\nbe also a directory with *.jplace files."
    inputBinding:
      position: 101
      prefix: -J
  - id: jplace_fname
    type:
      - 'null'
      - type: array
        items: File
    doc: "Do not call RAxML to perform EPA leave-one-out test,\nuse existing .jplace
      file as input instead. This could\nbe also a directory with *.jplace files."
    inputBinding:
      position: 101
      prefix: -j
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
      prefix: -m
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
      prefix: -l
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Specify the number of CPUs (default: 20)'
    inputBinding:
      position: 101
      prefix: -T
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory (default: current).'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Job name, will be used as a prefix for output file\nnames (default: taxonomy
      file name without extension)"
    inputBinding:
      position: 101
      prefix: -n
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: 'Random seed to be used with RAxML. Default: 12345'
    inputBinding:
      position: 101
      prefix: -p
  - id: rank_test
    type:
      - 'null'
      - boolean
    doc: Test for misplaced higher ranks.
    inputBinding:
      position: 101
      prefix: -ranktest
  - id: ref_fname
    type:
      - 'null'
      - File
    doc: "Specify the reference alignment and taxonomy in\nrefjson format."
    inputBinding:
      position: 101
      prefix: -r
  - id: rep_num
    type:
      - 'null'
      - int
    doc: "Number of RAxML tree searches (with distinct random\nseeds) to resolve multifurcation.
      Default: 1"
    inputBinding:
      position: 101
      prefix: -N
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "Resume execution after a premature termination (e.g.,\ndue to expired job
      time limit). Run name of the\nprevious (terminated) job must be specified via
      -n\noption."
    inputBinding:
      position: 101
      prefix: -R
  - id: synonym_fname
    type:
      - 'null'
      - File
    doc: "File listing synonymous rank names, which will be\nconsidered equivalent.
      Please enter one name per line;\nseparate groups with an empty line."
    inputBinding:
      position: 101
      prefix: -Y
  - id: taxonomic_code
    type: string
    doc: "Taxonomic code: BAC(teriological), BOT(anical),\nZOO(logical), VIR(ological)"
    inputBinding:
      position: 101
      prefix: -x
  - id: taxonomy
    type: File
    doc: Reference taxonomy file.
    inputBinding:
      position: 101
      prefix: -t
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Directory for temporary files.
    inputBinding:
      position: 101
      prefix: -tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional info messages to the console.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: current).'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sativa:0.9.3--py312h031d066_0
stdout: sativa_sativa.py.out
