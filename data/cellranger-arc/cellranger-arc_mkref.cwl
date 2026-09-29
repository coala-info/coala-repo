cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - mkref
label: cellranger-arc_mkref
doc: Build a reference package from a user-supplied genome FASTA and gene GTF 
  file for 10x Genomics Cell Ranger Multiome ATAC + Gene Expression.
inputs:
  - id: config
    type: File
    doc: Path to configuration file containing additional information about the 
      reference.
    inputBinding:
      position: 101
      prefix: --config
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads used during STAR genome index generation. Defaults to
      1.
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: memgb
    type:
      - 'null'
      - int
    doc: Maximum memory (GB) used when aligning reads with STAR. Defaults to 16.
    inputBinding:
      position: 101
      prefix: --memgb
  - id: ref_version
    type:
      - 'null'
      - string
    doc: Optional reference version string to include with reference.
    inputBinding:
      position: 101
      prefix: --ref-version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
stdout: cellranger-arc_mkref.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
