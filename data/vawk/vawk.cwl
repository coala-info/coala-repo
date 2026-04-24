cwlVersion: v1.2
class: CommandLineTool
baseCommand: vawk
label: vawk
doc: "An awk-like VCF parser\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs:
  - id: cmd
    type: string
    doc: "vawk command syntax is exactly the same as awk syntax with\na few additional
      features. The INFO field can be split using\nthe I$ prefix and the SAMPLE field
      can be split using\nthe S$ prefix. For example, I$AF prints the allele frequency
      of\neach variant and S$NA12878 prints the entire SAMPLE field for the\nNA12878
      individual for each variant. S$* returns all samples.\n\nThe SAMPLE field can
      be further split based on the keys in the\nFORMAT field of the VCF (column 9).
      For example, S$NA12877$GT\nreturns the genotype of the NA12878 individual.\n\
      \nex: '{ if (I$AF>0.5) print $1,$2,$3,I$AN,S$NA12878,S$NA12877$GT }'"
    inputBinding:
      position: 1
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'VCF file (default: stdin)'
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging level verbosity
    inputBinding:
      position: 103
      prefix: --debug
  - id: declare_variable
    type:
      - 'null'
      - type: array
        items: string
    doc: 'declare an external variable (e.g.: SIZE=10000)'
    inputBinding:
      position: 103
      prefix: --var
  - id: info_column
    type:
      - 'null'
      - int
    doc: column of the INFO field
    inputBinding:
      position: 103
      prefix: --col
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: print VCF header
    inputBinding:
      position: 103
      prefix: --header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vawk:0.0.2--py27_0
stdout: vawk.out
