cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh_sankoff
label: machina_pmh_sankoff
doc: "Performs the Sankoff algorithm on a phylogenetic tree with leaf labelings.\n\
  \nTool homepage: https://github.com/raphael-group/machina"
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
  - id: color_map_file
    type:
      - 'null'
      - File
    doc: Color map file
    inputBinding:
      position: 103
      prefix: -c
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix. To write into a folder, give the folder name with a trailing
      slash (for example out/); the folder is created before the run.
    inputBinding:
      position: 103
      prefix: -o
  - id: primary_sites
    type:
      - 'null'
      - string
    doc: Primary anatomical sites separated by commas (if omitted, every 
      anatomical site will be considered iteratively as the primary)
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Summary of the enumerated labelings (the tool prints it to standard error)
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
stdout: machina_pmh_sankoff.out
stderr: machina_pmh_sankoff.err
