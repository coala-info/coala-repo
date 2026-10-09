cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - maskopt
label: kmercamel_maskopt
doc: "Optimize the mask of a masked superstring\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: kmer_size
    type: int
    doc: "k-mer size [required; up to 127]"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: target
    type: ['null', string]
    doc: "The target mask type to be run [maxone (default), minone, minrun, approxminrun]"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: output_file
    type: ['null', string]
    default: "maskopt_out.fa"
    doc: "Output for the masked superstring; if not specified, printed to stdout"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: distinct_reverse_complement
    type: ['null', boolean]
    doc: "Treat k-mer and its reverse complement as distinct"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: ms
    type: File
    doc: "Input masked superstring (FASTA)"
    inputBinding:
      position: 10
outputs:
  - id: output_file_out
    type: ['null', File]
    doc: "Output file written with -o"
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_maskopt.out
