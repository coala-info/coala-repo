cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - spss2ms
label: kmercamel_spss2ms
doc: "Convert a set of simplitigs (spectrum preserving string set) to a masked superstring\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: kmer_size
    type: int
    doc: "k-mer size [required; up to 127]"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: output_file
    type: ['null', string]
    default: "spss2ms_out.fa"
    doc: "Output for the masked superstring; if not specified, printed to stdout"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: fasta
    type: File
    doc: "Input simplitigs (FASTA)"
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
stdout: kmercamel_spss2ms.out
