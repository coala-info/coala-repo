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
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (genome FASTA, gene GTF, motifs file). 
      They are staged in the working directory, so the config file can name 
      them by base name.
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
  - id: reference_dir
    type:
      type: array
      items: Directory
    doc: Reference package folder named after the genome in the config file
    outputBinding:
      glob: '*'
      outputEval: '$(self.filter(function(f) { return f.class == "Directory"; 
        }))'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.reference_files ? inputs.reference_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
stdout: cellranger-arc_mkref.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
