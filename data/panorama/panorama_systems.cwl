cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama systems
label: panorama_systems
doc: "PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE
  LICENSE AGREEMENT\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: annotation_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the annotation sources to load if different from the system 
      source. Can specify more than one, separated by space.
    inputBinding:
      position: 101
      prefix: --annotation_sources
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: jaccard
    type:
      - 'null'
      - float
    doc: Minimum Jaccard similarity used to filter edges between gene families. 
      Increasing this value improves precision but significantly lowers 
      sensitivity.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: models
    type: File
    doc: "Path to model list file. Note: Use 'panorama utils --models' to create the
      models list file."
    inputBinding:
      position: 101
      prefix: --models
  - id: pangenomes
    type: File
    doc: A list of pangenome .h5 files in a .tsv file.
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: source
    type: string
    doc: Name of the annotation source to select in pangenomes.
    inputBinding:
      position: 101
      prefix: --source
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
stdout: panorama_systems.out
