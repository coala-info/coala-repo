cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms
label: machina_ms
doc: "Enumerates the mutation trees of a frequency matrix and checks which migration
  patterns can generate it.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: frequencies
    type: File
    doc: Frequencies
    inputBinding:
      position: 1
  - id: primary_tumor
    type: string
    doc: Primary tumor
    inputBinding:
      position: 101
      prefix: -p
  - id: color_map_file
    type:
      - 'null'
      - File
    doc: Color map file
    inputBinding:
      position: 101
      prefix: -c
  - id: output_search_graph
    type:
      - 'null'
      - boolean
    doc: Output search graph
    inputBinding:
      position: 101
      prefix: -g
  - id: max_mutation_trees
    type:
      - 'null'
      - int
    doc: 'Maximum number of mutation trees to enumerate (default: -1, unlimited)'
    inputBinding:
      position: 101
      prefix: -l
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix. Give a folder name with a trailing slash (for example out/);
      the folder is created before the run.
    inputBinding:
      position: 101
      prefix: -o
  - id: migration_tree_file
    type:
      - 'null'
      - File
    doc: Migration tree file
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (the verdict on the frequency matrix)
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
stdout: machina_ms.out
stderr: machina_ms.err
