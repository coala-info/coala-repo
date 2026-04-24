cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - goa
label: rbpbench_goa
doc: "GO enrichment analysis (GOA)\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: goa_bg_gene_list
    type:
      - 'null'
      - File
    doc: Supply file with gene IDs (one ID per row) to use as background gene 
      list for GOA. NOTE that gene IDs need to be compatible with --gtf
    inputBinding:
      position: 101
      prefix: --goa-bg-gene-list
  - id: goa_filter_purified
    type:
      - 'null'
      - boolean
    doc: Filter out GOA results labeled as purified (i.e., GO terms with 
      significantly lower concentration) in HTML table
    inputBinding:
      position: 101
      prefix: --goa-filter-purified
  - id: goa_gene2go_file
    type:
      - 'null'
      - File
    doc: 'Provide gene ID to GO IDs mapping table (row format: gene_id<tab>go_id1,go_id2).
      By default, a local file with ENSEMBL gene IDs is used. NOTE that gene IDs need
      to be compatible with --gtf'
    inputBinding:
      position: 101
      prefix: --goa-gene2go-file
  - id: goa_max_child
    type:
      - 'null'
      - int
    doc: Specify maximum number of children for a significant GO term to be 
      reported in HTML table, e.g. --goa-max- child 100. This allows filtering 
      out very broad terms
    inputBinding:
      position: 101
      prefix: --goa-max-child
  - id: goa_min_depth
    type:
      - 'null'
      - int
    doc: Specify minimum depth number for a significant GO term to be reported 
      in HTML table, e.g. --goa-min-depth 5
    inputBinding:
      position: 101
      prefix: --goa-min-depth
  - id: goa_obo_file
    type:
      - 'null'
      - File
    doc: Provide GO DAG obo file
    inputBinding:
      position: 101
      prefix: --goa-obo-file
  - id: goa_obo_mode
    type:
      - 'null'
      - int
    doc: 'Define how to obtain GO DAG (directed acyclic graph) obo file. 1: download
      most recent file from internet, 2: use local file, 3: provide file via --goa-obo-file'
    inputBinding:
      position: 101
      prefix: --goa-obo-mode
  - id: goa_pval
    type:
      - 'null'
      - float
    doc: GO enrichment analysis p-value threshold (applied on corrected p-value)
    inputBinding:
      position: 101
      prefix: --goa-pval
  - id: gtf_file
    type: File
    doc: Input GTF file with genomic annotations to extract background genes 
      used for GOA. Note that eventually only genes are used which are present 
      in internal Ensembl gene ID -> GO ID(s) mapping or in provided mapping via
      --goa-gene2go-file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_genes_file
    type: File
    doc: Supply file with gene IDs (one ID per row) to define which genes to use
      as target genes in GO enrichment analysis (GOA)
    inputBinding:
      position: 101
      prefix: --in
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: Store plot files with absolute paths in HTML files. Default is relative
      paths
    inputBinding:
      position: 101
      prefix: --plot-abs-paths
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML'
    inputBinding:
      position: 101
      prefix: --sort-js-mode
outputs:
  - id: output_folder
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
