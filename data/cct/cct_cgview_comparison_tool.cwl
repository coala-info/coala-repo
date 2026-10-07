cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgview_comparison_tool
label: cct_cgview_comparison_tool
doc: "Run this command once to generate a project directory. After the project is
  created place a reference genome in the reference_genome directory and any genomes
  to compare with the reference in the comparison_genomes directory. Draw maps by
  running this command again with the '-p' option pointing to the project directory.\n  \nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: project
    type:
      - 'null'
      - Directory
    doc: Existing project directory (with reference_genome and comparison_genomes 
      filled in); maps are drawn into it
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)
  - id: project_name
    type:
      - 'null'
      - string
    doc: Name of a new blank project directory to create (used when no existing 
      project is given)
    inputBinding:
      position: 1
      prefix: -p
  - id: settings
    type:
      - 'null'
      - File
    doc: The settings file. If none is provided, the default settings file is 
      copied from $CCT_HOME/conf/project_settings.conf to the project directory.
    inputBinding:
      position: 2
      prefix: -s
  - id: config
    type:
      - 'null'
      - File
    doc: The configuration file. The default is to use the 
      $CCT_HOME/conf/global_settings.conf file.
    inputBinding:
      position: 2
      prefix: -g
  - id: map_size
    type:
      - 'null'
      - string
    doc: Size of custom maps to create (small/medium/large/x-large or a 
      combination separated by commas, e.g. small,large)
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
  - id: map_prefix
    type:
      - 'null'
      - string
    doc: Prefix to be appended to map names (Default is to add no additional 
      prefix).
    inputBinding:
      position: 2
      prefix: -f
  - id: max_blast_comparisons
    type:
      - 'null'
      - int
    doc: The maximum number of BLAST results sets to be passed to the XML 
      creation phase (Default is 100).
    inputBinding:
      position: 2
      prefix: -b
  - id: sort_blast_tracks
    type:
      - 'null'
      - boolean
    doc: Sort BLAST results such that genomes with highest similarity are 
      plotted first.
    inputBinding:
      position: 2
      prefix: -t
  - id: cct
    type:
      - 'null'
      - boolean
    doc: Colour BLAST results based on percent identity of hit instead of by 
      source genome, and ignore 'use_opacity' setting in configuration file.
    inputBinding:
      position: 2
      prefix: --cct
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory string to pass to Java's '-Xmx' option (Default is 1500m).
    inputBinding:
      position: 2
      prefix: -m
  - id: custom
    type:
      - 'null'
      - type: array
        items: string
    doc: Settings used to customize the appearance of the map (e.g. 
      tickLength=20 labelFontSize=15).
    inputBinding:
      position: 3
      prefix: -c
outputs:
  - id: project_dir
    type: Directory
    doc: Project directory with BLAST results and maps
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
