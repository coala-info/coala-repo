cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - seed-pos
label: lexicmap_utils_seed_pos
doc: "Extract and plot the distance and positions of seeds (k-mers) in the index.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: index
    type: Directory
    doc: 'Index directory created by "lexicmap index".'
    inputBinding:
      position: 1
      prefix: -d
  - id: all_refs
    type:
      - 'null'
      - boolean
    doc: 'Output for all reference genomes. This would take a long time for an index with a lot of genomes.'
    inputBinding:
      position: 2
      prefix: -a
  - id: bins
    type:
      - 'null'
      - int
    doc: 'Number of bins in histograms. [100]'
    inputBinding:
      position: 3
      prefix: -b
  - id: color_index
    type:
      - 'null'
      - int
    doc: 'Color index (1-7). [1]'
    inputBinding:
      position: 4
      prefix: --color-index
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Overwrite existing output directory.'
    inputBinding:
      position: 5
      prefix: --force
  - id: height
    type:
      - 'null'
      - float
    doc: 'Histogram height (unit: inch). [4]'
    inputBinding:
      position: 6
      prefix: --height
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: 'Maximum opened files, used for extracting sequences. [512]'
    inputBinding:
      position: 7
      prefix: --max-open-files
  - id: min_dist
    type:
      - 'null'
      - int
    doc: 'Only output records with seed distance >= this value.'
    inputBinding:
      position: 8
      prefix: -D
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports and recommends a ".gz" suffix'
    inputBinding:
      position: 9
      prefix: -o
  - id: plot_dir
    type:
      - 'null'
      - string
    doc: 'Output directory for histograms of seed distances and numbers of seeds in sliding windows.'
    inputBinding:
      position: 10
      prefix: -O
  - id: plot_ext
    type:
      - 'null'
      - string
    doc: 'Histogram plot file extension. [.png]'
    inputBinding:
      position: 11
      prefix: --plot-ext
  - id: ref_name
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Reference name(s).'
    inputBinding:
      position: 12
      prefix: -n
      itemSeparator: ','
  - id: slid_step
    type:
      - 'null'
      - int
    doc: 'The step size of sliding windows for counting the number of seeds [100]'
    inputBinding:
      position: 13
      prefix: -s
  - id: slid_window
    type:
      - 'null'
      - int
    doc: 'The window size of sliding windows for counting the number of seeds [250]'
    inputBinding:
      position: 14
      prefix: -w
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show more columns including position of the previous seed and sequence between the two seeds. Slow: set min_dist to 1000 or higher.'
    inputBinding:
      position: 15
      prefix: -v
  - id: width
    type:
      - 'null'
      - float
    doc: 'Histogram width (unit: inch). [6]'
    inputBinding:
      position: 16
      prefix: --width
  - id: infile_list
    type:
      - 'null'
      - File
    doc: 'File of input file list (one file per line). If given, they are appended to files from CLI arguments.'
    inputBinding:
      position: 90
      prefix: -X
  - id: log
    type:
      - 'null'
      - string
    doc: 'Log file.'
    inputBinding:
      position: 91
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not print any verbose information. But you can write them to a file with --log.'
    inputBinding:
      position: 92
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. By default, it uses all available cores.'
    inputBinding:
      position: 93
      prefix: -j
outputs:
  - id: output
    type: File?
    doc: 'The seed distance table'
    outputBinding:
      glob: $(inputs.out_file)
  - id: plots
    type: Directory?
    doc: 'Directory with the histograms, written when plot_dir is set'
    outputBinding:
      glob: $(inputs.plot_dir)
  - id: log_out
    type: File?
    doc: 'Log file, written when log is set'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
