cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_blast_atlas_all_vs_all
label: cct_build_blast_atlas_all_vs_all
doc: "This script generates several CCT projects automatically, and then it combines
  the results into a single montage map. The montage consists of a separate map for
  each sequence of interest. This command is used to first create a blast atlas all
  vs all project directory and then again to generate the montage. After the project
  has been created, place the genomes to compare in the comparison_genomes directory.\n  \nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: project
    type:
      - 'null'
      - Directory
    doc: Existing all vs all project directory; maps and the montage are created 
      in it
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)
  - id: project_name
    type:
      - 'null'
      - string
    doc: Name of a new project directory to create (used when no existing 
      project is given)
    inputBinding:
      position: 1
      prefix: -p
  - id: memory
    type:
      - 'null'
      - string
    doc: "Memory value for Java's -Xmx option (Default: 1500m)."
    inputBinding:
      position: 2
      prefix: -m
  - id: custom
    type:
      - 'null'
      - string
    doc: Custom settings for map creation.
    inputBinding:
      position: 2
      prefix: -c
  - id: max_blast_comparisons
    type:
      - 'null'
      - int
    doc: "Maximum number of comparison genomes to display (Default: 100)."
    inputBinding:
      position: 2
      prefix: -b
  - id: map_size
    type:
      - 'null'
      - string
    doc: Size of custom maps to create (small/medium/large/x-large or a 
      combination separated by commas).
    inputBinding:
      position: 2
      prefix: -z
  - id: start_at_xml
    type:
      - 'null'
      - boolean
    doc: Jump to XML generation. Skips performing blast.
    inputBinding:
      position: 2
      prefix: -x
  - id: start_at_map
    type:
      - 'null'
      - boolean
    doc: Start at map generation. Skips performing blast and generating XML.
    inputBinding:
      position: 2
      prefix: -r
  - id: start_at_montage
    type:
      - 'null'
      - boolean
    doc: Start at montage generation. Skips creating the individual maps.
    inputBinding:
      position: 2
      prefix: -g
  - id: columns
    type:
      - 'null'
      - int
    doc: "The number of columns to use in the montage image (Default: 4)."
    inputBinding:
      position: 2
      prefix: -y
outputs:
  - id: project_dir
    type: Directory
    doc: All vs all project directory with maps and montage
    outputBinding:
      glob: "$(inputs.project ? inputs.project.basename : inputs.project_name)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
