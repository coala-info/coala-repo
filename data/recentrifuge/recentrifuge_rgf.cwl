cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgf
label: recentrifuge_rgf
doc: "Robust comparative analysis and contamination removal for functional metagenomics\n\
  \nTool homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: avoid_cross
    type:
      - 'null'
      - boolean
    doc: avoid cross analysis
    inputBinding:
      position: 101
      prefix: --avoidcross
  - id: controls_number
    type:
      - 'null'
      - int
    doc: this number of first samples will be treated as negative controls; 
      default is no controls. CAUTION! Regentrifuge direct support of control 
      samples is experimental.
    inputBinding:
      position: 101
      prefix: --controls
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: exclude_taxid
    type:
      - 'null'
      - type: array
        items: string
    doc: GO code to exclude a GO node and all underneath (multiple -x is 
      available to exclude several GOs)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: file
    type:
      type: array
      items: File
    doc: GO output files in tab separated columns with the format:taxid, gi, go,
      score and evalue. Currently, the data for the analysis is retrieved from 
      the last 3 columns. Multiple -f is available to include several samples.
    inputBinding:
      position: 101
      prefix: --file
  - id: include_taxid
    type:
      - 'null'
      - type: array
        items: string
    doc: GO code to include a GO node and all underneath (multiple -i is 
      available to include several GOs); by default all the GOs are considered 
      for inclusion
    inputBinding:
      position: 101
      prefix: --include
  - id: mingene
    type:
      - 'null'
      - int
    doc: minimum genes to avoid collapsing GO genes hierarchy levels
    inputBinding:
      position: 101
      prefix: --mingene
  - id: minscore
    type:
      - 'null'
      - int
    doc: minimum score/confidence of the annotation of a scaffold to pass the 
      quality filter; all pass by default
    inputBinding:
      position: 101
      prefix: --minscore
  - id: nodes_path
    type:
      - 'null'
      - File
    doc: path for the nodes information files (nodes.dmp and names.dmp adapted 
      from GO)
    inputBinding:
      position: 101
      prefix: --nodespath
  - id: output_type
    type:
      - 'null'
      - string
    doc: type of scoring to be applied, and can be one of ['FULL', 'CSV', 
      'MULTICSV', 'TSV', 'DYNOMICS']
    inputBinding:
      position: 101
      prefix: --extra
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: pickle (serialize) statistics and data results in pandas DataFrames 
      (format affected by selection of --extra); one additional flag and the 
      input samples will be serialized as a dict of sample names and TaxTree 
      objects
    inputBinding:
      position: 101
      prefix: --pickle
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: deactivate parallel processing
    inputBinding:
      position: 101
      prefix: --sequential
  - id: summary_option
    type:
      - 'null'
      - string
    doc: select to "add" summary samples to other samples, or to "only" show 
      summary samples or to "avoid" summaries at all
    inputBinding:
      position: 101
      prefix: --summary
  - id: takeoutroot
    type:
      - 'null'
      - boolean
    doc: remove counts directly assigned to the "root" level
    inputBinding:
      position: 101
      prefix: --takeoutroot
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for parallel processing; 0 (default) means 
      legacy mode using min(cpu_count, samples)
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outhtml
    type:
      - 'null'
      - File
    doc: HTML output file (if not given the filename will be inferred from input
      files)
    outputBinding:
      glob: $(inputs.outhtml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
