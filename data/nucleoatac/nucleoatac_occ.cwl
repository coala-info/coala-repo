cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucleoatac
  - occ
label: nucleoatac_occ
doc: "Calculate nucleosome occupancy\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: bam_file
    type: File
    doc: Sorted (and indexed) BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed_file
    type: File
    doc: Peaks in bed format
    inputBinding:
      position: 101
      prefix: --bed
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: confidence interval level for lower and upper bounds. default is 0.9, 
      should be between 0 and 1
    default: 0.9
    inputBinding:
      position: 101
      prefix: --confidence_interval
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: fasta_genome_seq
    type:
      - 'null'
      - File
    doc: Indexed fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: flank
    type:
      - 'null'
      - int
    doc: Distance on each side of dyad to include for local occ calculation. 
      Default is 60.
    default: 60
    inputBinding:
      position: 101
      prefix: --flank
  - id: fragmentsizes_file
    type:
      - 'null'
      - File
    doc: File with fragment size distribution. Use if don't want calculation of 
      fragment size
    inputBinding:
      position: 101
      prefix: --sizes
  - id: min_occ
    type:
      - 'null'
      - float
    doc: Occupancy cutoff for determining nucleosome distribution. Default is 
      0.1
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_occ
  - id: nuc_sep
    type:
      - 'null'
      - int
    doc: minimum separation between occupany peaks. Default is 120.
    default: 120
    inputBinding:
      position: 101
      prefix: --nuc_sep
  - id: out_basename
    type: string
    doc: give output basename
    inputBinding:
      position: 101
      prefix: --out
  - id: pwm_tn5_pwm
    type:
      - 'null'
      - File
    doc: PWM descriptor file. Default is Human.PWM.txt included in package
    default: Human.PWM.txt
    inputBinding:
      position: 101
      prefix: --pwm
  - id: step
    type:
      - 'null'
      - int
    doc: step size along genome for comuting occ. Default is 5. Should be odd, 
      or will be subtracted by 1
    default: 5
    inputBinding:
      position: 101
      prefix: --step
  - id: upper
    type:
      - 'null'
      - int
    doc: upper limit in insert size. default is 251
    default: 251
    inputBinding:
      position: 101
      prefix: --upper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
stdout: nucleoatac_occ.out
