cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grafimo
  - buildvg
label: grafimo_buildvg
doc: "Build a set of genome variation graphs (one VG/XG file for each chromosome, or
  for a chosen subset) from a reference genome FASTA file and a bgzipped VCF file.\n\nTool
  homepage: https://github.com/pinellolab/GRAFIMO"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_genome)
        writable: true
      - entry: $(inputs.vcf)
        writable: true
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
inputs:
  - id: reference_genome
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Path to reference genome FASTA file.
    inputBinding:
      position: 102
      prefix: --linear-genome
      valueFrom: $(self.basename)
  - id: vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: Path to VCF file. Note that the VCF should be compressed (e.g. myvcf.vcf.gz).
    inputBinding:
      position: 102
      prefix: --vcf
      valueFrom: $(self.basename)
  - id: chroms_build
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes for which construct the VG. By default GRAFIMO constructs the VG
      for all chromsomes.
    inputBinding:
      position: 102
      prefix: --chroms-build
  - id: chroms_prefix_build
    type:
      - 'null'
      - string
    doc: 'Prefix to append in front of chromosome numbers. To name chromosome VGs with
      only their number (e.g. 1.xg), use an empty string. Default: chr.'
    inputBinding:
      position: 102
      prefix: --chroms-prefix-build
  - id: chroms_namemap_build
    type:
      - 'null'
      - File
    doc: Space or tab-separated file, containing original chromosome names in the first
      columns and the names to use when storing corresponding VGs. By default the VGs
      are named after the encoded chromosome (e.g. chr1.xg).
    inputBinding:
      position: 102
      prefix: --chroms-namemap-build
  - id: reindex
    type:
      - 'null'
      - boolean
    doc: Reindex the VCF file with Tabix, even if a TBI index os already available.
    inputBinding:
      position: 102
      prefix: --reindex
  - id: outdir
    type: string
    default: grafimo_vg
    doc: Output directory (created before the run).
    inputBinding:
      position: 102
      prefix: --out
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. Use 0 to auto-detect. Default: 0. To search motifs
      in a whole genome variation graph the default is 1 (avoid memory issues).'
    inputBinding:
      position: 102
      prefix: --cores
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information about GRAFIMO run.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable error traceback.
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: outdir_dir
    type: Directory
    doc: Directory with the genome variation graphs (.xg and .gbwt files)
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
stdout: grafimo_buildvg.out
