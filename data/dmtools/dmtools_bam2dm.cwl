cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - bam2dm
label: dmtools_bam2dm
doc: "Convert BAM files to DM format for methylation ratio and chromatin accessibility
  analysis.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: binput
    type: File
    doc: Bam format file, sorted by chrom.
    inputBinding:
      position: 101
      prefix: --binput
  - id: context_filter
    type:
      - 'null'
      - string
    doc: 'context filter for print results, C, CG, CHG, CHH, default: C'
    inputBinding:
      position: 101
      prefix: --cf
  - id: coverage
    type:
      - 'null'
      - int
    doc: '>= <INT> coverage. default:4'
    inputBinding:
      position: 101
      prefix: --coverage
  - id: genome
    type: File
    doc: genome fasta file
    inputBinding:
      position: 101
      prefix: --genome
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: <= <INT> coverage. default:500
    inputBinding:
      position: 101
      prefix: --maxcoverage
  - id: max_zoom_levels
    type:
      - 'null'
      - int
    doc: 'The maximum number of zoom levels. [0-10], default: 2'
    inputBinding:
      position: 101
      prefix: --zl
  - id: min_quality_score
    type:
      - 'null'
      - int
    doc: calculate the methratio while read QulityScore >= Q. default:20
    inputBinding:
      position: 101
      prefix: -Q
  - id: n_cs_per_region
    type:
      - 'null'
      - int
    doc: '>= <INT> nCs per region. default:1'
    inputBinding:
      position: 101
      prefix: -nC
  - id: n_mismatch
    type:
      - 'null'
      - float
    doc: Number of mismatches, default 0.06 percentage of read length. [0-1]
    inputBinding:
      position: 101
      prefix: --Nmismatch
  - id: nome_seq
    type:
      - 'null'
      - boolean
    doc: data type for NoMe-seq
    inputBinding:
      position: 101
      prefix: --NoMe
  - id: out
    type: string
    doc: Prefix of methratio.dm output file
    inputBinding:
      position: 101
      prefix: --out
  - id: print_context
    type:
      - 'null'
      - boolean
    doc: print context in DM file
    inputBinding:
      position: 101
      prefix: --Cx
  - id: print_coverage
    type:
      - 'null'
      - boolean
    doc: print coverage in DM file
    inputBinding:
      position: 101
      prefix: -C
  - id: print_end
    type:
      - 'null'
      - boolean
    doc: print end in DM file
    inputBinding:
      position: 101
      prefix: -E
  - id: print_id
    type:
      - 'null'
      - boolean
    doc: print ID in DM file
    inputBinding:
      position: 101
      prefix: --Id
  - id: print_methratio_txt
    type:
      - 'null'
      - boolean
    doc: print prefix.methratio.txt file
    inputBinding:
      position: 101
      prefix: --mrtxt
  - id: print_strand
    type:
      - 'null'
      - boolean
    doc: print strand in DM file
    inputBinding:
      position: 101
      prefix: -S
  - id: remove_dup
    type:
      - 'null'
      - boolean
    doc: REMOVE_DUP, default:false
    inputBinding:
      position: 101
      prefix: --remove_dup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_bam2dm.out
