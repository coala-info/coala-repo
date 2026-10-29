cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_helix_vote_classes
label: relion_relion_helix_vote_classes
doc: "Vote for helical segments' classes along filaments and group the filaments.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: The _data.star file with the classes to be analysed
    inputBinding:
      position: 101
      prefix: --i
  - id: nr_classes
    type: File
    doc: Number of classes in the input star file
    inputBinding:
      position: 101
      prefix: --nr_classes
  - id: coord_suffix
    type:
      - 'null'
      - string
    doc: The suffix for the coordinate files, e.g. "_picked.star" or ".box"
    inputBinding:
      position: 101
      prefix: --coord_suffix
  - id: pick
    type:
      - 'null'
      - File
    doc: 'Alternative to coord_suffix: a 2-column STAR file with micrographs and coordinate files'
    inputBinding:
      position: 101
      prefix: --pick
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output directory name (RELION default: HelixAnalyseClasses/)'
    inputBinding:
      position: 101
      prefix: --o
    default: HelixAnalyseClasses/
  - id: groups
    type:
      - 'null'
      - string
    doc: A string with grouping of comma-separated class numbers (with ':' for separation of groups, e.g.
      1,4,5:6,2)
    inputBinding:
      position: 101
      prefix: --groups
  - id: group_names
    type:
      - 'null'
      - string
    doc: A string with :-separated names for all groups (e.g. phf:sf)
    inputBinding:
      position: 101
      prefix: --group_names
  - id: voting_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum fraction to assign a helix to a group (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --voting_threshold
  - id: consistency_check
    type:
      - 'null'
      - float
    doc: 'Check this fraction of particles to be on line of start-end coordinates (RELION default: 0.05)'
    inputBinding:
      position: 101
      prefix: --consistency_check
  - id: min_nr_picks
    type:
      - 'null'
      - int
    doc: 'Select filaments that have at least this many picks for the group indicated below (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --min_nr_picks
  - id: min_picks_group
    type:
      - 'null'
      - int
    doc: 'Number of the group (first one is 1) to select based on minimum number of particles (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --min_picks_group
  - id: norm
    type:
      - 'null'
      - boolean
    doc: Perform normalisation before voting?
    inputBinding:
      position: 101
      prefix: --norm
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_helix_vote_classes.out
