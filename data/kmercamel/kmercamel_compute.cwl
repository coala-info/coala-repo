cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - compute
label: kmercamel_compute
doc: "Compute a masked superstring (and optionally the maximum-ones mask) of the k-mers of a FASTA file\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: kmer_size
    type: int
    doc: "k-mer size [required; up to 127]"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: algorithm
    type: ['null', string]
    doc: "The algorithm to be run [global (default), streaming, local, globalAC (experimental), localAC (experimental)]"
    inputBinding:
      position: 1
      prefix: "-a"
  - id: output_file
    type: ['null', string]
    default: "compute_out.fa"
    doc: "Output for the (minone) masked superstring; if not specified, printed to stdout"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: mask_maxone_file
    type: ['null', string]
    doc: "If given, print also the masked superstring with mask maximizing ones to this file (only with global)"
    inputBinding:
      position: 1
      prefix: "-M"
  - id: optimize_simplitigs
    type: ['null', boolean]
    doc: "Optimize for the input being correctly computed simplitigs (only with global)"
    inputBinding:
      position: 1
      prefix: "-S"
  - id: d_max
    type: ['null', int]
    doc: "d_max for local algorithm; default 5"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: distinct_reverse_complement
    type: ['null', boolean]
    doc: "Treat k-mer and its reverse complement as distinct"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: min_frequency
    type: ['null', int]
    doc: "Minimum frequency to represent a k-mer; default 1"
    inputBinding:
      position: 1
      prefix: "-z"
  - id: fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 10
outputs:
  - id: output_file_out
    type: ['null', File]
    doc: "Output file written with -o"
    outputBinding:
      glob: $(inputs.output_file)
  - id: mask_maxone_out
    type: ['null', File]
    doc: "Masked superstring with mask maximizing ones (-M)"
    outputBinding:
      glob: $(inputs.mask_maxone_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_compute.out
