cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigscape
  - benchmark
label: bigscape_benchmark
doc: "Benchmarking mode - Compare a BiG-SCAPE or BiG-SLICE BGC clustering against
  a known/expected set of BGC <-> GCF assignments. For a more comprehensive help menu
  and tutorials see GitHub Wiki.\n\nTool homepage: https://github.com/medema-group/BiG-SCAPE"
inputs:
  - id: big_dir
    type: Directory
    doc: Path to BiG-SCAPE (v1 or v2) or BiG-SLICE output directory.
    inputBinding:
      position: 101
      prefix: --BiG-dir
  - id: gcf_assignment_file
    type: File
    doc: Path to GCF assignments file. BiG-SCAPE will compare a run output to 
      these assignments.
    inputBinding:
      position: 101
      prefix: --GCF-assignment-file
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
stdout: bigscape_benchmark.out
