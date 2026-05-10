cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hulk
  - smash
label: hulk_smash
doc: "Smash a bunch of sketches and return a distance matrix. This subcommand performs
  pairwise comparisons of sketches and then writes a distance matrix.\n\nTool homepage:
  https://github.com/will-rowe/hulk"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: tells HULK which sketching algorithm to use [histosketch kmv khf]
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: banner_matrix
    type:
      - 'null'
      - boolean
    doc: write a matrix file for banner
    inputBinding:
      position: 101
      prefix: --bannerMatrix
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: minimizer k-mer length
    inputBinding:
      position: 101
      prefix: --kmerSize
  - id: metric
    type:
      - 'null'
      - string
    doc: tells HULK which distance metric to use [jaccard weightedjaccard]
    inputBinding:
      position: 101
      prefix: --metric
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processors to use
    inputBinding:
      position: 101
      prefix: --processors
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: create the files needed to profile HULK using the go tool pprof
    inputBinding:
      position: 101
      prefix: --profiling
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursively search the supplied sketch directory (-d)
    inputBinding:
      position: 101
      prefix: --recursive
  - id: sketch_dir
    type:
      - 'null'
      - Directory
    doc: the directory containing the sketches to smash (compare)...
    inputBinding:
      position: 101
      prefix: --sketchDir
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 102
      prefix: --log
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 103
      prefix: --out-file
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: filename for log file, if omitted then STDOUT used by default
    outputBinding:
      glob: $(inputs.log_path)
  - id: out_file
    type:
      - 'null'
      - File
    doc: directory and basename for saving the outfile(s)
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hulk:1.0.0--h375a9b1_0
