cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsMap run_generate_ldscore
label: gsmap_run_generate_ldscore
doc: "Generate LD scores for a given sample, chromosome, and genotype data.\n\nTool
  homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: additional_baseline_annotation
    type:
      - 'null'
      - File
    doc: Path of additional baseline annotations
    inputBinding:
      position: 101
      prefix: --additional_baseline_annotation
  - id: bfile_root
    type: string
    doc: Root path for genotype plink bfiles (.bim, .bed, .fam).
    inputBinding:
      position: 101
      prefix: --bfile_root
  - id: chrom
    type: string
    doc: Chromosome id (1-22) or "all".
    inputBinding:
      position: 101
      prefix: --chrom
  - id: enhancer_annotation_file
    type:
      - 'null'
      - File
    doc: Path to enhancer annotation file (optional).
    inputBinding:
      position: 101
      prefix: --enhancer_annotation_file
  - id: gene_window_enhancer_priority
    type:
      - 'null'
      - string
    doc: Priority between gene window and enhancer annotations.
    inputBinding:
      position: 101
      prefix: --gene_window_enhancer_priority
  - id: gene_window_size
    type:
      - 'null'
      - int
    doc: Gene window size in base pairs.
    inputBinding:
      position: 101
      prefix: --gene_window_size
  - id: gtf_annotation_file
    type: File
    doc: Path to GTF annotation file.
    inputBinding:
      position: 101
      prefix: --gtf_annotation_file
  - id: keep_snp_root
    type:
      - 'null'
      - string
    doc: Root path for SNP files
    inputBinding:
      position: 101
      prefix: --keep_snp_root
  - id: ld_unit
    type:
      - 'null'
      - string
    doc: Unit for LD window.
    inputBinding:
      position: 101
      prefix: --ld_unit
  - id: ld_wind
    type:
      - 'null'
      - int
    doc: LD window size.
    inputBinding:
      position: 101
      prefix: --ld_wind
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: snp_multiple_enhancer_strategy
    type:
      - 'null'
      - string
    doc: Strategy for handling multiple enhancers per SNP.
    inputBinding:
      position: 101
      prefix: --snp_multiple_enhancer_strategy
  - id: spots_per_chunk
    type:
      - 'null'
      - int
    doc: Number of spots per chunk.
    inputBinding:
      position: 101
      prefix: --spots_per_chunk
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_run_generate_ldscore.out
