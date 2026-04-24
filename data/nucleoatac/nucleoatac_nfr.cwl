cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucleoatac
  - nfr
label: nucleoatac_nfr
doc: "NFR determination parameters\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: Tn5_PWM
    type:
      - 'null'
      - File
    doc: PWM descriptor file. Default is Human.PWM.txt included in package
    inputBinding:
      position: 101
      prefix: --pwm
  - id: bam_file
    type:
      - 'null'
      - File
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
  - id: genome_seq
    type:
      - 'null'
      - File
    doc: Indexed fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: ins_file
    type:
      - 'null'
      - File
    doc: bgzip compressed, tabix-indexed bedgraph file with insertion track. 
      will be generated if not included
    inputBinding:
      position: 101
      prefix: --ins_track
  - id: max_occ
    type:
      - 'null'
      - float
    doc: Maximum mean occupancy for NFR.
    inputBinding:
      position: 101
      prefix: --max_occ
  - id: max_occ_upper
    type:
      - 'null'
      - float
    doc: Maximum for minimum of upper bound occupancy in NFR.
    inputBinding:
      position: 101
      prefix: --max_occ_upper
  - id: nucpos_file
    type: File
    doc: bed file with nucleosome center calls
    inputBinding:
      position: 101
      prefix: --calls
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: occ_file
    type: File
    doc: bgzip compressed, tabix-indexed bedgraph file with occuppancy track.
    inputBinding:
      position: 101
      prefix: --occ_track
  - id: out_basename
    type:
      - 'null'
      - string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
stdout: nucleoatac_nfr.out
