cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - circtest
label: circtools_circtest
doc: "circular RNA statistical testing - Interface to https://github.com/dieterich-lab/CircTest\n\nTool homepage: https://github.com/dieterich-lab/circtools"
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
  - id: condition_list
    type: string
    doc: 'Comma-separated list of conditions which should be compared, e.g. "RNaseR +","RNaseR -"'
    inputBinding:
      position: 101
      prefix: -l
  - id: condition_columns
    type: string
    doc: 'Comma-separated list of 1-based column numbers in the circtools detect output which should be compared; e.g. 10,11,12,13,14,15'
    inputBinding:
      position: 101
      prefix: -c
  - id: grouping
    type: string
    doc: 'Comma-separated list describing the relation of the columns specified via -c to the sample names specified via -l'
    inputBinding:
      position: 101
      prefix: -g
  - id: replicates
    type:
      - 'null'
      - int
    doc: 'Number of replicates used for the circRNA experiment [Default: 3]'
    inputBinding:
      position: 101
      prefix: -r
  - id: max_fdr
    type:
      - 'null'
      - float
    doc: 'Cut-off value for the FDR [Default: 0.05]'
    inputBinding:
      position: 101
      prefix: -f
  - id: percentage
    type:
      - 'null'
      - float
    doc: 'The minimum percentage of circRNAs account for the total transcripts in at least one group. [Default: 0.01]'
    inputBinding:
      position: 101
      prefix: -p
  - id: filter_sample
    type:
      - 'null'
      - int
    doc: 'Number of samples that need to contain the amount of reads specified via -C [Default: 3]'
    inputBinding:
      position: 101
      prefix: -s
  - id: filter_count
    type:
      - 'null'
      - int
    doc: 'Number of CircRNA reads that each sample specified via -s has to contain [Default: 5]'
    inputBinding:
      position: 101
      prefix: -C
  - id: output_directory
    type:
      - 'null'
      - string
    doc: 'The output directory for files created by circtools [Default: .]'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_name
    type:
      - 'null'
      - string
    doc: 'The output name for files created by circtools [Default: circtest]'
    inputBinding:
      position: 101
      prefix: -n
  - id: max_plots
    type:
      - 'null'
      - int
    doc: 'How many of candidates should be plotted as bar chart? [Default: 50]'
    inputBinding:
      position: 101
      prefix: -m
  - id: label
    type:
      - 'null'
      - string
    doc: 'How should the samples be labeled? [Default: Sample]'
    inputBinding:
      position: 101
      prefix: -a
  - id: limit
    type:
      - 'null'
      - string
    doc: 'Range limit for the plots (-L)'
    inputBinding:
      position: 101
      prefix: -L
  - id: only_negative
    type:
      - 'null'
      - string
    doc: 'Only print entries with negative direction indicator [Default: False]'
    inputBinding:
      position: 101
      prefix: -O
  - id: add_header
    type:
      - 'null'
      - string
    doc: 'Add header to CSV output [Default: False]'
    inputBinding:
      position: 101
      prefix: -H
  - id: colour
    type:
      - 'null'
      - string
    doc: 'Can be set to bw to create grayscale graphs for manuscripts (colour or bw)'
    inputBinding:
      position: 101
      prefix: -M
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
      glob: $((inputs.output_directory || '.') + '/' + (inputs.output_name || 'circtest') + '*')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_circtest.out
