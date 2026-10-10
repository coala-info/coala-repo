cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - unique
label: metafx_unique
doc: "supervised feature extraction using group-specific k-mers\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads)
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
  - id: min_samples
    type: ['null', int]
    doc: "k-mer is considered group-specific if present in at least G samples of that group. G iterates in range [--min-samples; --max-samples] [default: 2]"
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: max_samples
    type: ['null', int]
    doc: "k-mer is considered group-specific if present in at least G samples of that group. G iterates in range [--min-samples; --max-samples] [default: #{samples in category}/2 + 1]"
    inputBinding:
      position: 101
      prefix: --max-samples
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
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_unique.out
