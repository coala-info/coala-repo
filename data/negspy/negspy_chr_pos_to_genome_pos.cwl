cwlVersion: v1.2
class: CommandLineTool
baseCommand: [chr_pos_to_genome_pos.py]
label: negspy_chr_pos_to_genome_pos
doc: "Convert chromosome,position pairs read from standard input (whitespace-separated
  columns) to genome positions. Assumes hg19 unless another assembly or a chromsizes
  file is given.\n\nTool homepage: https://github.com/pkerpedjiev/negspy"
inputs:
  - id: input_table
    type: File
    doc: Table whose columns hold chromosome names and positions (read on standard input).
  - id: assembly
    type:
      - 'null'
      - string
    doc: Genome assembly (default hg19).
    inputBinding:
      position: 1
      prefix: --assembly
  - id: chromsizes_file
    type:
      - 'null'
      - File
    doc: Chromosome sizes file to use instead of a built-in assembly.
    inputBinding:
      position: 2
      prefix: --chromsizes-file
  - id: new_chrom
    type:
      - 'null'
      - string
    doc: Name that replaces the translated chromosome column (default genome(chrom)).
    inputBinding:
      position: 3
      prefix: --new-chrom
  - id: columns
    type:
      - 'null'
      - string
    doc: "Column pairs to translate, 1-based, pairs separated by colons and several
      pairs by commas (e.g. 3:5,3:6). Default 1,2."
    inputBinding:
      position: 4
      prefix: --columns
outputs:
  - id: stdout
    type: stdout
    doc: Table with translated genome positions.
stdin: $(inputs.input_table.path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
stdout: negspy_chr_pos_to_genome_pos.out
