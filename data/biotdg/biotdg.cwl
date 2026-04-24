cwlVersion: v1.2
class: CommandLineTool
baseCommand: biotdg
label: biotdg
doc: "Bioinformatics Test Data Generator\n\nTool homepage: https://github.com/biowdl/biotdg"
inputs:
  - id: coverage
    type:
      - 'null'
      - float
    doc: 'Average coverage for the generated reads. NOTE: This is multiplied by the
      ploidy of the chromosome.'
    inputBinding:
      position: 101
      prefix: --coverage
  - id: maximum_n_number
    type:
      - 'null'
      - int
    doc: Maximum number of Ns allowed in a given read.
    inputBinding:
      position: 101
      prefix: --maximum-n-number
  - id: ploidy_table
    type: File
    doc: Tab-delimited file with two columns specifying the chromosome name and its
      ploidy. By default all chromosomes have a ploidy of 2.
    inputBinding:
      position: 101
      prefix: --ploidy-table
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed for dwgsim (default: 1).'
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: read1_error_rate
    type:
      - 'null'
      - float
    doc: Same as -e flag in dwgsim. per base/color/flow error rate of the first read.
    inputBinding:
      position: 101
      prefix: --read1-error-rate
  - id: read2_error_rate
    type:
      - 'null'
      - float
    doc: Same as -E flag in dwgsim. per base/color/flow error rate of the second read.
    inputBinding:
      position: 101
      prefix: --read2-error-rate
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length to be used by dwgsim.
    inputBinding:
      position: 101
      prefix: --read-length
  - id: reference
    type: File
    doc: Reference genome for the sample.
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_name
    type: string
    doc: Name of the sample to generate. The sample must be in the VCF file.
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: vcf
    type: File
    doc: VCF file with mutations.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotdg:0.1.0--py_0
