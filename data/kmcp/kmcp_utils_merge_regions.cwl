cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - merge-regions
label: kmcp_utils_merge_regions
doc: "Merge species/assembly-specific regions\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: ignore_type
    type: ['null', boolean]
    doc: "Merge species and assembly-specific regions"
    inputBinding:
      position: 1
      prefix: "--ignore-type"
  - id: line_chunk_size
    type: ['null', int]
    doc: "Number of lines to process for each thread (default 5000)"
    inputBinding:
      position: 1
      prefix: "--line-chunk-size"
  - id: max_fpr
    type: ['null', float]
    doc: "Maximum false positive rate of a read in search result (default 0.05)"
    inputBinding:
      position: 1
      prefix: "--max-fpr"
  - id: max_gap
    type: ['null', int]
    doc: "Maximum distance of starting positions of two adjacent regions, 0 for no limitation, 1 for no merging"
    inputBinding:
      position: 1
      prefix: "--max-gap"
  - id: min_overlap
    type: ['null', int]
    doc: "Minimum overlap of two adjacent regions, recommend K-1 (default 1)"
    inputBinding:
      position: 1
      prefix: "--min-overlap"
  - id: min_query_cov
    type: ['null', float]
    doc: "Minimum query coverage of a read in search result (default 0.55)"
    inputBinding:
      position: 1
      prefix: "--min-query-cov"
  - id: name_assembly
    type: ['null', string]
    doc: "Name of assembly-specific regions (default \"assembly-specific\")"
    inputBinding:
      position: 1
      prefix: "--name-assembly"
  - id: name_species
    type: ['null', string]
    doc: "Name of species-specific regions (default \"species-specific\")"
    inputBinding:
      position: 1
      prefix: "--name-species"
  - id: out_file
    type: ['null', string]
    default: "merged_regions.bed"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: regexp
    type: ['null', string]
    doc: "Regular expression for extract reference name and query locations (default \"^(.+)_sliding:(\\\\d+)\\\\-(\\\\d+)$\")"
    inputBinding:
      position: 1
      prefix: "--regexp"
  - id: search_results
    type:
      type: array
      items: File
    doc: "Filtered search result files (from kmcp utils filter)"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_file_out
    type: ['null', File]
    doc: "Output file written with --out-file"
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type: ['null', File]
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_utils_merge_regions.out
