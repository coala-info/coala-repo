cwlVersion: v1.2
class: CommandLineTool
baseCommand: gothresher_prep
label: gothresher_prep
doc: "Generate the ontology graph and ancestor mapping files (onto directory) that
  GOThresher needs, from a Gene Ontology OBO file. Run once per ontology version. The
  files are written to the directory named by onto_dir in the config file (default
  onto).\n\nTool homepage: https://github.com/FriedbergLab/GOThresher"
inputs:
  - id: input
    type: File
    doc: Path of GO file (OBO format) to be processed
    inputBinding:
      position: 1
      prefix: --input
  - id: config
    type:
      - 'null'
      - File
    doc: INI file, for example gothresher.ini (default gothresher.ini in the working
      directory)
    inputBinding:
      position: 1
      prefix: --config
outputs:
  - id: onto_dir
    type: Directory
    doc: Directory with alt_to_id.graph, bp/cc/mf.graph and bp/cc/mf_ancestors.map
    outputBinding:
      glob: onto
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0
