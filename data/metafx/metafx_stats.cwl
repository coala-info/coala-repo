cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - stats
label: metafx_stats
doc: "supervised feature extraction using statistically significant k-mers\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads)
  - class: ShellCommandRequirement
arguments:
  - position: 102
    shellQuote: false
    valueFrom: "> metafx_stats.out && find $(inputs.work_dir) -type l -exec sh -c 't=`readlink -f \"$0\"`; rm \"$0\"; cp -r \"$t\" \"$0\"' {} \\;"
inputs:
  - id: k
    type: int
    doc: "k-mer size (in nucleotides, maximum value is 31)"
    inputBinding:
      position: 101
      prefix: --k
  - id: reads_file
    type: File
    doc: "tab-separated file with 2 values in each row: <path_to_file>\\t<category>. The paths must be the base names of the files given in reads."
    inputBinding:
      position: 101
      prefix: --reads-file
  - id: reads
    type: File[]
    doc: "Read files named in the reads file. They are staged in the working directory so that the names in the file resolve."
  - id: bad_frequency
    type: ['null', int]
    doc: "maximal frequency for a k-mer to be assumed erroneous"
    inputBinding:
      position: 101
      prefix: --bad-frequency
  - id: pchi2
    type: ['null', float]
    doc: "p-value for chi-squared test [default: 0.05]"
    inputBinding:
      position: 101
      prefix: --pchi2
  - id: pmw
    type: ['null', float]
    doc: "p-value for Mann-Whitney test [default: 0.05]"
    inputBinding:
      position: 101
      prefix: --pmw
  - id: depth
    type: ['null', int]
    doc: "Depth of de Bruijn graph traversal from pivot k-mers in number of branches"
    inputBinding:
      position: 101
      prefix: --depth
  - id: kmers_dir
    type: ['null', Directory]
    doc: "directory with pre-computed k-mers for samples in binary format"
    inputBinding:
      position: 101
      prefix: --kmers-dir
  - id: skip_graph
    type: ['null', boolean]
    doc: "if TRUE skip de Bruijn graph and fasta construction from components"
    inputBinding:
      position: 101
      prefix: --skip-graph
  - id: threads
    type: ['null', int]
    doc: "number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: memory
    type: ['null', string]
    doc: "memory to use (values with suffix: 1500M, 4G, etc.)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: work_dir
    type: string
    doc: "working directory (created by the tool, it must not exist before the run)"
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: results_dir
    type: Directory
    doc: "Working directory with the results"
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: File
    doc: Standard output
    outputBinding:
      glob: metafx_stats.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
