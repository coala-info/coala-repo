cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - awk_gtf
label: mikado_util_awk_gtf
doc: "Retrieve specific feature slices from a GTF file.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: region
    type:
      - 'null'
      - string
    doc: Region defined as a string like <chrom>:<start>..<end>.
    inputBinding:
      position: 101
      prefix: -r
  - id: chrom
    type:
      - 'null'
      - string
    doc: Chromosome.
    inputBinding:
      position: 101
      prefix: --chrom
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: Assume the input is sorted.
    inputBinding:
      position: 101
      prefix: -as
  - id: start
    type:
      - 'null'
      - int
    doc: Start of the region.
    inputBinding:
      position: 101
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: End of the region.
    inputBinding:
      position: 101
      prefix: --end
  - id: gtf
    type: File
    doc: Input GTF file.
    inputBinding:
      position: 201
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name; printed to standard output if omitted.
    inputBinding:
      position: 202
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_text
    type: stdout
    doc: Output printed to standard output when no output file is given.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util_awk_gtf.out
