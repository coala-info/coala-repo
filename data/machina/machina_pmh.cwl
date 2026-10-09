cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh
label: machina_pmh
doc: "Machina PMH tool for phylogenetic analysis.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: clone_tree
    type: File
    doc: Clone tree
    inputBinding:
      position: 1
  - id: leaf_labeling
    type: File
    doc: Leaf labeling
    inputBinding:
      position: 2
  - id: allowed_migration_patterns
    type:
      - 'null'
      - string
    doc: 'Allowed migration patterns: 0 : PS, 1 : PS, S, 2 : PS, S, M, 3 : PS, S,
      M, R. If no pattern is specified, all allowed patterns will be enumerated.'
    inputBinding:
      position: 103
      prefix: -m
  - id: color_map_file
    type: File
    doc: Color map file
    inputBinding:
      position: 103
      prefix: -c
  - id: export_ilp
    type:
      - 'null'
      - boolean
    doc: Export ILP
    inputBinding:
      position: 103
      prefix: -e
  - id: gurobi_logging
    type:
      - 'null'
      - boolean
    doc: Gurobi logging
    inputBinding:
      position: 103
      prefix: -log
  - id: migration_graphs_file
    type:
      - 'null'
      - File
    doc: Optional file with migration graphs
    inputBinding:
      position: 103
      prefix: -G
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix. To write into a folder, give the folder name with a trailing
      slash (for example out/); the folder is created before the run.
    inputBinding:
      position: 103
      prefix: -o
  - id: output_search_graph
    type:
      - 'null'
      - boolean
    doc: Output search graph
    inputBinding:
      position: 103
      prefix: -g
  - id: primary_anatomical_site
    type: string
    doc: Primary anatomical site
    inputBinding:
      position: 103
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: time_limit
    type:
      - 'null'
      - int
    doc: Time limit in seconds
    inputBinding:
      position: 103
      prefix: -l
  - id: ub_gamma
    type:
      - 'null'
      - int
    doc: Upper bound on the comigration number
    inputBinding:
      position: 103
      prefix: -UB_gamma
  - id: ub_mu
    type:
      - 'null'
      - int
    doc: Upper bound on the migration number
    inputBinding:
      position: 103
      prefix: -UB_mu
  - id: ub_sigma
    type:
      - 'null'
      - int
    doc: Upper bound on the seeding site number
    inputBinding:
      position: 103
      prefix: -UB_sigma
  - id: use_old_ilp
    type:
      - 'null'
      - boolean
    doc: Use old ILP (typically much slower)
    inputBinding:
      position: 103
      prefix: -OLD
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: |
          ${
            if (inputs.output_prefix && /\/$/.test(inputs.output_prefix)) {
              return inputs.output_prefix.replace(/\/+$/, "");
            }
            return ".unused_output_dir";
          }
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh.out
