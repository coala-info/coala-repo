cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - autoindex
label: vg_autoindex
doc: "Build indexes for vg\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: gbz
    type:
      - 'null'
      - File
    doc: GBZ file to make indexes from
    inputBinding:
      position: 101
      prefix: --gbz
  - id: gfa
    type:
      - 'null'
      - File
    doc: GFA file to make a graph from
    inputBinding:
      position: 101
      prefix: --gfa
  - id: gff_feature
    type:
      - 'null'
      - string
    doc: GTF/GFF feature type (col. 3) to add to graph
    inputBinding:
      position: 101
      prefix: --gff-feature
  - id: gff_tx_tag
    type:
      - 'null'
      - string
    doc: GTF/GFF tag (in col. 9) for ID
    inputBinding:
      position: 101
      prefix: --gff-tx-tag
  - id: hap_tx_gff
    type:
      - 'null'
      - type: array
        items: File
    doc: GTF/GFF file with transcript annotations of a named haplotype (may 
      repeat)
    inputBinding:
      position: 101
      prefix: --hap-tx-gff
  - id: ins_fasta
    type:
      - 'null'
      - File
    doc: FASTA file with sequences of INS variants from -v
    inputBinding:
      position: 101
      prefix: --ins-fasta
  - id: no_guessing
    type:
      - 'null'
      - boolean
    doc: do not guess that pre-existing files are indexes i.e. force-regenerate 
      any index not explicitly provided
    inputBinding:
      position: 101
      prefix: --no-guessing
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to use for all output
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file with the reference sequence (may repeat)
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: target_mem
    type:
      - 'null'
      - string
    doc: target max memory usage (not exact, formatted INT[kMG])
    inputBinding:
      position: 101
      prefix: --target-mem
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory to use for intermediate files
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: tx_gff
    type:
      - 'null'
      - type: array
        items: File
    doc: GTF/GFF file with transcript annotations (may repeat)
    inputBinding:
      position: 101
      prefix: --tx-gff
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF file with sequence names matching -r (may repeat)
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbosity
    type:
      - 'null'
      - int
    doc: log to stderr {0 = none, 1 = basic, 2 = debug}
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: workflow to produce indexes for (may repeat)
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
stdout: vg_autoindex.out
