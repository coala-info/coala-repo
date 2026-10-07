cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - exon
label: circtools_exon
doc: "circular RNA exon usage analysis\n\nTool homepage: https://github.com/dieterich-lab/circtools"
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
    doc: 'Comma-separated list of 1-based column numbers in the circtools detect output which should be compared'
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
    type: string
    doc: 'Comma-separated list describing the relation of the samples specified via -g to the sample names specified via -l'
    inputBinding:
      position: 101
      prefix: -r
  - id: ballgown_data
    type: Directory
    doc: 'Path to the ballgown data directory'
    inputBinding:
      position: 101
      prefix: -b
      valueFrom: '$(self.path)/'
  - id: gtf_file
    type: File
    doc: 'Path to the GTF file containing the employed genome annotation'
    inputBinding:
      position: 101
      prefix: -G
  - id: circtest_file
    type: File
    doc: 'Path to the CircTest CSV file containing the CircTest results'
    inputBinding:
      position: 101
      prefix: -C
  - id: has_header
    type:
      - 'null'
      - string
    doc: 'Do the CircTest result files have a header? [Default: No]'
    inputBinding:
      position: 101
      prefix: -H
  - id: output_directory
    type:
      - 'null'
      - string
    doc: 'The output directory for files created by circtools [Default: .]'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'The output name (prefix) for files created by circtools [Default: exon_analysis]'
    inputBinding:
      position: 101
      prefix: -n
  - id: species
    type: string
    doc: 'Species code: hs, mm, rn or ss'
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix
    outputBinding:
      glob: $((inputs.output_directory || '.') + '/' + (inputs.output_prefix || 'exon_analysis') + '*')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_exon.out
