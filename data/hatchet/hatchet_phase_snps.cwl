cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - phase-snps
label: hatchet_phase_snps
doc: "Phase germline SNPs using a reference panel (requires shapeit, picard and a reference panel).

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: refpaneldir
    type:
      - 'null'
      - Directory
    doc: Path to Reference Panel
    inputBinding:
      position: 10
      prefix: -D
  - id: refgenome
    type: File
    secondaryFiles:
      - '.fai'
      - '^.dict'
    doc: Path to Reference genome used in BAM files
    inputBinding:
      position: 10
      prefix: -g
  - id: refversion
    type: string
    doc: Version of reference genome used in BAM files
    inputBinding:
      position: 10
      prefix: -V
  - id: chrnotation
    type:
      - 'null'
      - boolean
    doc: "Use this flag to indicate that chromosomes are named with \"chr\" (default: no \"chr\")"
    inputBinding:
      position: 10
      prefix: -N
  - id: outdir
    type: string
    doc: Output folder for phased VCFs (created in the working directory)
    inputBinding:
      position: 10
      prefix: -o
  - id: snps
    type:
      type: array
      items: File
    doc: List of SNPs in the normal sample to phase
    inputBinding:
      position: 10
      prefix: -L
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of available parallel processes (default: 2)"
    inputBinding:
      position: 10
      prefix: -j
  - id: shapeit
    type:
      - 'null'
      - string
    doc: "Path to shapeit executable (default: look in $PATH)"
    inputBinding:
      position: 10
      prefix: -si
  - id: picard
    type:
      - 'null'
      - string
    doc: "Path to picard executable or jar (default: look in $PATH)"
    inputBinding:
      position: 10
      prefix: -pc
  - id: bcftools
    type:
      - 'null'
      - string
    doc: "Path to the directory of \"bcftools\" executable (default: look in $PATH)"
    inputBinding:
      position: 10
      prefix: -bt
  - id: bgzip
    type:
      - 'null'
      - string
    doc: "Path to the directory of \"bgzip\" executable (default: look in $PATH)"
    inputBinding:
      position: 10
      prefix: -bg
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: phased_dir
    type: Directory
    doc: Folder with phased VCFs
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "basename": inputs.outdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_phase_snps.out
