cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - index
label: bcftools_index
doc: Index VCF or BCF files for random access.
inputs:
  - id: input_file
    type: File
    doc: Input VCF or BCF file
    inputBinding:
      position: 1
  - id: csi
    type:
      - 'null'
      - boolean
    doc: Generate CSI format index (default)
    inputBinding:
      position: 102
      prefix: --csi
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite index if it already exists
    inputBinding:
      position: 102
      prefix: --force
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Set minimum interval size for CSI indices to 2^INT
    inputBinding:
      position: 102
      prefix: --min-shift
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: output_file
    type: string
    doc: Specify an output path for the index file
    inputBinding:
      position: 102
      prefix: --output
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Print per-contig stats
    inputBinding:
      position: 102
      prefix: --stats
  - id: tbi
    type:
      - 'null'
      - boolean
    doc: Generate TBI format index
    inputBinding:
      position: 102
      prefix: --tbi
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Specify an output path for the index file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
