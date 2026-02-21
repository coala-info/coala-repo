cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - sort
label: bcftools_sort
doc: "Sort VCF/BCF file.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: max_mem
    type:
      - 'null'
      - string
    doc: Maximum memory to use
    default: 768M
    inputBinding:
      position: 102
      prefix: --max-mem
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary files
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
