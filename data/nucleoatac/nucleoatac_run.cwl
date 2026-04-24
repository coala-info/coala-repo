cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleoatac run
label: nucleoatac_run
doc: "Run the nucleoatac pipeline\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: bam_file
    type: File
    doc: Accepts sorted BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed_file
    type: File
    doc: Regions for which to do stuff.
    inputBinding:
      position: 101
      prefix: --bed
  - id: genome_seq
    type: File
    doc: Indexed fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: output_basename
    type: string
    doc: give output basename
    inputBinding:
      position: 101
      prefix: --out
  - id: tn5_pwm
    type:
      - 'null'
      - File
    doc: PWM descriptor file. Default is Human.PWM.txt included in package
    inputBinding:
      position: 101
      prefix: --pwm
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
stdout: nucleoatac_run.out
