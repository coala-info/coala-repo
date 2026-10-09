cwlVersion: v1.2
class: CommandLineTool
baseCommand: generatemutationtrees
label: machina_generatemutationtrees
doc: "Generates all mutation trees given a frequency matrix.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: frequencies
    type: File
    doc: Frequencies
    inputBinding:
      position: 1
  - id: output_canonical_clone_trees
    type:
      - 'null'
      - boolean
    doc: Output canonical clone trees
    inputBinding:
      position: 101
      prefix: -C
  - id: max_mutation_trees
    type:
      - 'null'
      - int
    doc: 'Maximum number of mutation trees to enumerate (default: -1, unlimited)'
    inputBinding:
      position: 101
      prefix: -l
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory. Give the folder name with a trailing slash (for example
      trees/); the folder is created before the run and one .tree file is written
      per mutation tree.
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: -t
  - id: time_limit
    type:
      - 'null'
      - int
    doc: 'Time limit in seconds (default: -1, unlimited)'
    inputBinding:
      position: 101
      prefix: -tl
outputs:
  - id: stdout
    type: stdout
    doc: Mutation trees
  - id: output_dir_files
    type:
      type: array
      items: File
    doc: Files written into the output directory given in output_dir
    outputBinding:
      glob: $(inputs.output_dir)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: |
          ${
            if (inputs.output_dir && /\/$/.test(inputs.output_dir)) {
              return inputs.output_dir.replace(/\/+$/, "");
            }
            return ".unused_output_dir";
          }
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_generatemutationtrees.out
