cwlVersion: v1.2
class: CommandLineTool
baseCommand: svpg_call
label: svpg_call
doc: "Call structural variants using SVPG\n\nTool homepage: https://github.com/coopsor/SVPG"
inputs:
  - id: alt_consensus
    type:
      - 'null'
      - boolean
    doc: Generate alternative allele consensus sequences for insertion using 
      pyabpoa.
    inputBinding:
      position: 101
      prefix: --alt_consensus
  - id: bam
    type:
      - 'null'
      - File
    doc: Coordinate-sorted and indexed BAM file with aligned long reads.
    inputBinding:
      position: 101
      prefix: --bam
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the chromosomes list to call SVs (e.g., --contigs chr1 chr2 
      chrX)
    inputBinding:
      position: 101
      prefix: --contigs
  - id: gfa
    type:
      - 'null'
      - File
    doc: Pangenome reference file that the long reads were aligned to (.gfa)
    inputBinding:
      position: 101
      prefix: --gfa
  - id: max_merge_threshold
    type:
      - 'null'
      - int
    doc: Maximum distance of SV signals to be merged.
    inputBinding:
      position: 101
      prefix: --max_merge_threshold
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: Maximum SV size to detect include sequence information. Set to -1 for 
      unlimited size.
    inputBinding:
      position: 101
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for reads to be considered in SV detection.
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum read support threshold for SV calling. Adjust based on 
      sequencing depth.
    inputBinding:
      position: 101
      prefix: --min_support
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: Minimum size of SVs to be detected.
    inputBinding:
      position: 101
      prefix: --min_sv_size
  - id: noseq
    type:
      - 'null'
      - boolean
    doc: Disable sequence extraction for SVs. Useful for ultra-large SVs to save
      time and disk space.
    inputBinding:
      position: 101
      prefix: --noseq
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: read
    type:
      - 'null'
      - string
    doc: 'Type of sequencing reads: `ont` for Oxford Nanopore, `hifi` for PacBio HiFi.'
    inputBinding:
      position: 101
      prefix: --read
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Realign the noise reads to the reference for more accurate SV sequence 
      inference
    inputBinding:
      position: 101
      prefix: --realign
  - id: ref
    type:
      - 'null'
      - File
    doc: The reference genome used for pangenome construction (.fa), is also 
      serves as the coordinate system for SVPG’s SV call output.
    inputBinding:
      position: 101
      prefix: --ref
  - id: skip_genotype
    type:
      - 'null'
      - boolean
    doc: Skip genotyping step to speed up the processing.
    inputBinding:
      position: 101
      prefix: --skip_genotype
  - id: types
    type:
      - 'null'
      - string
    doc: 'SV types to include in output VCF (default: DEL,INS,DUP,INV,BND). Give a
      comma-separated list of SV types, like "DEL,INS"'
    inputBinding:
      position: 101
      prefix: --types
  - id: ultra_split_size
    type:
      - 'null'
      - int
    doc: Ignore extremely large BNDs from split alignments unless supported by 
      high enough reads, which may be regarded as false-negative 
      intra-chromosomal translocation
    inputBinding:
      position: 101
      prefix: --ultra_split_size
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify the working directory to store output files.
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: VCF output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
