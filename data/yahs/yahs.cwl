cwlVersion: v1.2
class: CommandLineTool
baseCommand: yahs
label: yahs
doc: "Scaffold contigs using Hi-C data\n\nTool homepage: https://github.com/c-zhou/yahs"
inputs:
  - id: contigs_fa
    type: File
    doc: Input FASTA file of contigs
    inputBinding:
      position: 1
  - id: hic_data
    type: File
    doc: Input Hi-C data file (BED, BAM, PA5, or BIN)
    inputBinding:
      position: 2
  - id: agp_file
    type:
      - 'null'
      - File
    doc: AGP file (for rescaffolding)
    inputBinding:
      position: 103
      prefix: -a
  - id: input_file_type
    type:
      - 'null'
      - string
    doc: input file type BED|BAM|PA5|BIN, file name extension is ignored if set
    inputBinding:
      position: 103
      prefix: --file-type
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum length of a contig to scaffold
    inputBinding:
      position: 103
      prefix: -l
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 103
      prefix: -q
  - id: no_contig_error_correction
    type:
      - 'null'
      - boolean
    doc: do not do contig error correction
    inputBinding:
      position: 103
      prefix: --no-contig-ec
  - id: no_memory_check
    type:
      - 'null'
      - boolean
    doc: do not do memory check at runtime
    inputBinding:
      position: 103
      prefix: --no-mem-check
  - id: no_scaffold_error_correction
    type:
      - 'null'
      - boolean
    doc: do not do scaffold error correction
    inputBinding:
      position: 103
      prefix: --no-scaffold-ec
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files
    inputBinding:
      position: 103
      prefix: -o
  - id: read_length
    type:
      - 'null'
      - int
    doc: read length (required for PA5 format input)
    inputBinding:
      position: 103
      prefix: --read-length
  - id: resolutions
    type:
      - 'null'
      - type: array
        items: int
    doc: list of resolutions in ascending order
    inputBinding:
      position: 103
      prefix: -r
  - id: restriction_enzyme
    type:
      - 'null'
      - string
    doc: restriction enzyme cutting sites
    inputBinding:
      position: 103
      prefix: -e
  - id: rounds_per_resolution
    type:
      - 'null'
      - int
    doc: rounds to run at each resoultion level
    inputBinding:
      position: 103
      prefix: -R
  - id: telomeric_motif
    type:
      - 'null'
      - string
    doc: telomeric sequence motif
    inputBinding:
      position: 103
      prefix: --telo-motif
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
stdout: yahs.out
