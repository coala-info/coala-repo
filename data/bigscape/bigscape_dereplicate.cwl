cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigscape_dereplicate
label: bigscape_dereplicate
doc: "Dereplicate mode - BiG-SCAPE performs a pairwise comparison of BGCs based on
  the protein sequence comparison tool sourmash, clusters them based on a similarity
  threshold, and selects a representative BGC per cluster.\n\nTool homepage: https://github.com/medema-group/BiG-SCAPE"
inputs:
  - id: config_file_path
    type:
      - 'null'
      - File
    doc: Path to BiG-SCAPE config.yml file, which stores values for a series of 
      advanced use parameters.
    inputBinding:
      position: 101
      prefix: --config-file-path
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Set the max number of cores available (default: use all available cores).'
    inputBinding:
      position: 101
      prefix: --cores
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Similarity threshold for sourmash distances. Only pairs with a 
      similarity equal or above this value will be considered for clustering. 
      [0.0<=x<=1.0]
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: exclude_gbk
    type:
      - 'null'
      - string
    doc: A comma separated list of strings. If any string in this list occurs in
      the .gbk filename, this file will not be used for the analysis
    inputBinding:
      position: 101
      prefix: --exclude-gbk
  - id: gbk_dir
    type: Directory
    doc: Input directory containing .gbk files to be used by BiG-SCAPE. 
      Duplicated filenames can be handled, but are not recommended. See the wiki
      for more details.
    inputBinding:
      position: 101
      prefix: --gbk-dir
  - id: include_gbk
    type:
      - 'null'
      - string
    doc: A comma separated list of strings. Only .gbk files that have the 
      string(s) in their filename will be used for the analysis. Use an asterisk
      to accept every file ('*' overrides '--exclude_gbk_str').
    inputBinding:
      position: 101
      prefix: --include-gbk
  - id: input_dir
    type: Directory
    doc: Input directory containing .gbk files to be used by BiG-SCAPE. 
      Duplicated filenames can be handled, but are not recommended. See the wiki
      for more details.
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: input_mode
    type:
      - 'null'
      - string
    doc: 'Tells BiG-SCAPE where to look for input GBK files. recursive: search for
      .gbk files recursively in input directory. Duplicated filenames are not recommended.
      flat: search for .gbk files in input directory only.'
    inputBinding:
      position: 101
      prefix: --input-mode
  - id: label
    type:
      - 'null'
      - string
    doc: A run label to be added to the output results folder name, as well as 
      dropdown menu in the visualization page. By default, BiG-SCAPE runs will 
      have a name such as [label]_YYYY-MM-DD_HH-MM-SS.
    inputBinding:
      position: 101
      prefix: --label
  - id: log_path
    type:
      - 'null'
      - File
    doc: Path to output log file.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: output_dir
    type: Directory
    doc: Output directory for all BiG-SCAPE results files.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print any log info to output, only write to logfile.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Prints more detailed information of each step in the analysis, output all
      kinds of logs, including debugging log info, and writes to logfile. Toggle to
      activate. Disclaimer: developed in linux, might not work as well in macOS.'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
stdout: bigscape_dereplicate.out
