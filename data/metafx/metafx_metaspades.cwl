cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - metaspades
label: metafx_metaspades
doc: "unsupervised feature extraction and distance estimation via metaSpades\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads)
  - class: ShellCommandRequirement
arguments:
  - position: 102
    shellQuote: false
    valueFrom: "> metafx_metaspades.out && find $(inputs.work_dir) -type l -exec sh -c 't=`readlink -f \"$0\"`; rm \"$0\"; cp -r \"$t\" \"$0\"' {} \\;"
inputs:
  - id: k
    type: int
    doc: "k-mer size (in nucleotides, maximum value is 31)"
    inputBinding:
      position: 101
      prefix: --k
  - id: reads
    type: File[]
    doc: "list of PAIRED-END reads files from single environment. FASTQ, FASTA, gzip-compressed. The files are staged together in the working directory (mates of a pair must sit in one folder to be detected)."
    inputBinding:
      position: 101
      prefix: --reads
      valueFrom: |-
        ${ return self.map(function(f){ return f.basename; }); }
  - id: separate
    type: ['null', boolean]
    doc: "if TRUE use every spades contig as a separate feature (do not combine them in components; -l, -b1, -b2 ignored)"
    inputBinding:
      position: 101
      prefix: --separate
  - id: min_seq_len
    type: ['null', int]
    doc: "minimal sequence length to be added to a component (in nucleotides) [default: 100]"
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: min_comp_size
    type: ['null', int]
    doc: "minimum size of extracted components (features) in k-mers [default: 1000]"
    inputBinding:
      position: 101
      prefix: --min-comp-size
  - id: max_comp_size
    type: ['null', int]
    doc: "maximum size of extracted components (features) in k-mers [default: 10000]"
    inputBinding:
      position: 101
      prefix: --max-comp-size
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
      glob: metafx_metaspades.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
