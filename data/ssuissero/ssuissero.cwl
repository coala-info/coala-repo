cwlVersion: v1.2
class: CommandLineTool
baseCommand: SsuisSero.sh
label: ssuissero
doc: "Rapid serotyping of Streptococcus suis from assemblies (FASTA) or from nanopore
  reads (FASTQ).\n\nTool homepage: https://github.com/jimmyliu1326/SsuisSero"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: -i
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: -s
  - id: input_type
    type: string
    doc: "input type [fasta or fastq]"
    inputBinding:
      position: 101
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads [Default: 4]"
    inputBinding:
      position: 101
      prefix: --threads
  - id: outdir_path
    type: string
    doc: path to output directory
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: outdir
    type: Directory
    doc: Output directory with the serotyping result table
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssuissero:1.0.1--hdfd78af_1
stdout: ssuissero.out
