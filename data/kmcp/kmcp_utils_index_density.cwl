cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - index-density
label: kmcp_utils_index_density
doc: "Plot the element density of bloom filters for an index file\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: bin_size
    type: ['null', int]
    doc: "Bin size/width"
    inputBinding:
      position: 1
      prefix: "--bin-size"
  - id: bins
    type: ['null', int]
    doc: "Number of bins for counting the number of 1s (default 1024)"
    inputBinding:
      position: 1
      prefix: "--bins"
  - id: out_file
    type: ['null', string]
    default: "index_density.tsv"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: out_img
    type: ['null', string]
    doc: "Out density image, in format of jpeg"
    inputBinding:
      position: 1
      prefix: "--out-img"
  - id: index_file
    type: File
    doc: "Index file (.uniki) of a kmcp database"
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
  - id: image
    type: ['null', File]
    doc: "Density image"
    outputBinding:
      glob: $(inputs.out_img)
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
stdout: kmcp_utils_index_density.out
