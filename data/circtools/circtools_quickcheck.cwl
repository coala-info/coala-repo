cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - quickcheck
label: circtools_quickcheck
doc: "circular RNA sequencing library quality assessment\n\nTool homepage: https://github.com/dieterich-lab/circtools"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.output_directory) { l.push({"class": "Directory", "basename": inputs.output_directory.replace(/\/+$/, ""), "listing": [], "writable": true}); }
        return l;
      }
inputs:
  - id: detect_dir
    type: Directory
    doc: 'Path to the circtools detect data directory'
    inputBinding:
      position: 101
      prefix: -d
      valueFrom: '$(self.path)/'
  - id: star_dir
    type: Directory
    doc: 'Path to the base STAR data directory containing sub-folders with per-sample mappings'
    inputBinding:
      position: 101
      prefix: -s
      valueFrom: '$(self.path)/'
  - id: condition_list
    type: string
    doc: 'Comma-separated list of conditions which should be compared, e.g. "RNaseR +","RNaseR -"'
    inputBinding:
      position: 101
      prefix: -l
  - id: grouping
    type: string
    doc: 'Comma-separated list describing the relation of the columns to the sample names specified via -l'
    inputBinding:
      position: 101
      prefix: -g
  - id: output_directory
    type:
      - 'null'
      - string
    doc: 'The output directory for files created by circtools [Default: ./]'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_name
    type:
      - 'null'
      - string
    doc: 'The output name for files created by circtools [Default: quickcheck]'
    inputBinding:
      position: 101
      prefix: -n
  - id: colour
    type:
      - 'null'
      - string
    doc: 'Can be set to bw to create grayscale graphs for manuscripts (colour or bw)'
    inputBinding:
      position: 101
      prefix: -c
  - id: cleanup
    type:
      - 'null'
      - string
    doc: 'String to be removed from each sample name [Default: "_STARmapping.*Chimeric.out.junction"]'
    inputBinding:
      position: 101
      prefix: -C
  - id: starfolder
    type:
      - 'null'
      - string
    doc: 'Suffix string of the STAR folders [Default: ""]'
    inputBinding:
      position: 101
      prefix: -S
  - id: remove_last
    type:
      - 'null'
      - int
    doc: 'Remove last N characters from each column name of the circtools detect input data [Default: 0]'
    inputBinding:
      position: 101
      prefix: -L
  - id: remove_first
    type:
      - 'null'
      - int
    doc: 'Remove first N characters from each column name of the circtools detect input data [Default: 0]'
    inputBinding:
      position: 101
      prefix: -F
  - id: remove_columns
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of columns in the circtools detect data files to not include in the check'
    inputBinding:
      position: 101
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output name
    outputBinding:
      glob: $((inputs.output_directory || '.') + '/' + (inputs.output_name || 'quickcheck') + '*')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_quickcheck.out
