cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat_preprocess
label: muat_preprocess
doc: "Preprocess VCF, SomAgg VCF, or TSV files with specified genome build and optional
  dictionaries.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: input_filepath
    type:
      type: array
      items: File
    doc: Input file paths.
    inputBinding:
      position: 1
  - id: ges_dictionary_filepath
    type:
      - 'null'
      - File
    doc: Path to the genic exonic strand dictionary (.tsv).
    inputBinding:
      position: 102
      prefix: --ges-dictionary-filepath
  - id: hg19
    type:
      - 'null'
      - File
    doc: Path to GRCh37/hg19 (.fa or .fa.gz)
    inputBinding:
      position: 102
      prefix: --hg19
  - id: hg38
    type:
      - 'null'
      - File
    doc: Path to GRCh38/hg38 (.fa or .fa.gz)
    inputBinding:
      position: 102
      prefix: --hg38
  - id: motif_dictionary_filepath
    type:
      - 'null'
      - File
    doc: Path to the motif dictionary (.tsv).
    inputBinding:
      position: 102
      prefix: --motif-dictionary-filepath
  - id: position_dictionary_filepath
    type:
      - 'null'
      - File
    doc: Path to the genomic position dictionary (.tsv).
    inputBinding:
      position: 102
      prefix: --position-dictionary-filepath
  - id: somagg
    type:
      - 'null'
      - boolean
    doc: Preprocess SomAgg VCF files.
    inputBinding:
      position: 102
      prefix: --somagg
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for storing preprocessed files.
    inputBinding:
      position: 102
      prefix: --tmp-dir
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Preprocess TSV files.
    inputBinding:
      position: 102
      prefix: --tsv
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: Preprocess VCF files.
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat_preprocess.out
