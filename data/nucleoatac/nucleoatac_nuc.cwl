cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucleoatac
  - nuc
label: nucleoatac_nuc
doc: "Nucleosome calling\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: bam_file
    type: File
    doc: Accepts sorted BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: basename
    type: string
    doc: give output basename
    inputBinding:
      position: 101
      prefix: --out
  - id: bed_file
    type: File
    doc: Regions for which to do stuff.
    inputBinding:
      position: 101
      prefix: --bed
  - id: fragmentsizes_file
    type:
      - 'null'
      - File
    doc: "File with fragment size distribution. Use if don't\nwant calculation of
      fragment size"
    inputBinding:
      position: 101
      prefix: --sizes
  - id: genome_seq
    type:
      - 'null'
      - File
    doc: Indexed fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: min_lr
    type:
      - 'null'
      - float
    doc: Log likelihood ratio threshold for nucleosome calls. Default is 0
    inputBinding:
      position: 101
      prefix: --min_lr
  - id: min_z
    type:
      - 'null'
      - float
    doc: Z-score threshold for nucleosome calls. Default is 3
    inputBinding:
      position: 101
      prefix: --min_z
  - id: not_atac
    type:
      - 'null'
      - boolean
    doc: data is not atac-seq
    inputBinding:
      position: 101
      prefix: --not_atac
  - id: nuc_sep
    type:
      - 'null'
      - int
    doc: Minimum separation between non-redundant nucleosomes. Default is 120
    inputBinding:
      position: 101
      prefix: --nuc_sep
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: occ_file
    type:
      - 'null'
      - File
    doc: "bgzip compressed, tabix-indexed bedgraph file with\nocccupancy track. Otherwise
      occ not determined for nuc\npositions."
    inputBinding:
      position: 101
      prefix: --occ_track
  - id: redundant_sep
    type:
      - 'null'
      - int
    doc: "Minimum separation between redundant nucleosomes. Not\nrecommended to be
      below 15. Default is 25"
    inputBinding:
      position: 101
      prefix: --redundant_sep
  - id: sd
    type:
      - 'null'
      - int
    doc: "Standard deviation for smoothing. Affect the\nresolution at which nucleosomes
      can be positioned. Not\nrecommended to exceed 25 or to be smaller than 10.\n\
      Default is 10"
    inputBinding:
      position: 101
      prefix: --sd
  - id: tn5_pwm
    type:
      - 'null'
      - File
    doc: "PWM descriptor file. Default is Human.PWM.txt included\nin package"
    inputBinding:
      position: 101
      prefix: --pwm
  - id: vdensity_file
    type: File
    doc: VMat object
    inputBinding:
      position: 101
      prefix: --vmat
  - id: write_all
    type:
      - 'null'
      - boolean
    doc: write all tracks
    inputBinding:
      position: 101
      prefix: --write_all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
stdout: nucleoatac_nuc.out
