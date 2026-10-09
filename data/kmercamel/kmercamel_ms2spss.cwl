cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - ms2spss
label: kmercamel_ms2spss
doc: "Convert a masked superstring to a set of simplitigs (spectrum preserving string set)\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: kmer_size
    type: int
    doc: "k-mer size [required; up to 127]"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: output_file
    type: ['null', string]
    default: "ms2spss_out.fa"
    doc: "Output for the simplitigs; if not specified, printed to stdout"
    inputBinding:
      position: 1
      prefix: "-o"
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
stdout: kmercamel_ms2spss.out
