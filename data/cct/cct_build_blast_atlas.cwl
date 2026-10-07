cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_blast_atlas
label: cct_build_blast_atlas
doc: "This command is used to first create a blast atlas project directory and then
  again to generate maps. Run this command with the '-i' option and a GenBank file
  to create a new project using the GenBank file as the reference genome. After the
  project has been created, place the genomes to compare with the reference in the
  comparison_genomes directory. Draw maps by running this command again with the
  '-p' option pointing to the project directory.\n\nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Sequence file in GenBank format, with a .gbk extension. Only required 
      when first creating a blast atlas project.
    inputBinding:
      position: 1
      prefix: -i
  - id: project
    type:
      - 'null'
      - Directory
    doc: Existing blast atlas project directory; maps are created in it
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)
  - id: project_name
    type:
      - 'null'
      - string
    doc: Name of a new project directory to create (with '-i'). The project is 
      named after the GenBank file when not given.
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
outputs:
  - id: project_dir
    type: Directory
    doc: Blast atlas project directory
    outputBinding:
      glob: "$(inputs.project ? inputs.project.basename : (inputs.project_name ? 
        inputs.project_name : inputs.input.nameroot))"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
