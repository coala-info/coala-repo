cwlVersion: v1.2
class: CommandLineTool
baseCommand: AMBER
label: cami-amber_amber.py
doc: "AMBER: Assessment of Metagenome BinnERs\n\nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs:
  - id: bin_files
    type:
      type: array
      items: File
    doc: Binning files
    inputBinding:
      position: 1
  - id: colors
    type:
      - 'null'
      - string
    doc: Color indices
    inputBinding:
      position: 102
      prefix: --colors
  - id: desc
    type:
      - 'null'
      - string
    doc: Description for HTML page
    inputBinding:
      position: 102
      prefix: --desc
  - id: filter
    type:
      - 'null'
      - float
    doc: 'Filter out [FILTER]% smallest genome bins (default: 0)'
    default: 0
    inputBinding:
      position: 102
      prefix: --filter
  - id: genome_coverage
    type:
      - 'null'
      - string
    doc: genome coverages
    inputBinding:
      position: 102
      prefix: --genome_coverage
  - id: gold_standard_file
    type: File
    doc: Gold standard - ground truth - file
    inputBinding:
      position: 102
      prefix: --gold_standard_file
  - id: keyword
    type:
      - 'null'
      - string
    doc: Keyword in the second column of file with list of genomes to be removed
      (no keyword=remove all genomes in list)
    inputBinding:
      position: 102
      prefix: --keyword
  - id: labels
    type:
      - 'null'
      - string
    doc: Comma-separated binning names
    inputBinding:
      position: 102
      prefix: --labels
  - id: max_contamination
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of max. contamination thresholds (default %: 10,5)'
    default: 10,5
    inputBinding:
      position: 102
      prefix: --max_contamination
  - id: min_completeness
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of min. completeness thresholds (default %: 50,70,90)'
    default: 50,70,90
    inputBinding:
      position: 102
      prefix: --min_completeness
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequences
    inputBinding:
      position: 102
      prefix: --min_length
  - id: ncbi_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the NCBI taxonomy database dump files nodes.dmp, 
      merged.dmp, and names.dmp
    inputBinding:
      position: 102
      prefix: --ncbi_dir
  - id: remove_genomes
    type:
      - 'null'
      - File
    doc: File with list of genomes to be removed
    inputBinding:
      position: 102
      prefix: --remove_genomes
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silent mode
    inputBinding:
      position: 102
      prefix: --silent
  - id: skip_gs
    type:
      - 'null'
      - boolean
    doc: Skip gold standard evaluation vs itself
    inputBinding:
      position: 102
      prefix: --skip_gs
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Print summary to stdout
    inputBinding:
      position: 102
      prefix: --stdout
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write the results to
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
