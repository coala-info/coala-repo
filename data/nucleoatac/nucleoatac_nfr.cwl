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
    secondaryFiles:
      - .bai
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
    type: File
    doc: Indexed fasta file. Needed for the bias calculation; nfr fails without it.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --fasta
  - id: ins_file
    type:
      - 'null'
      - File
    doc: bgzip compressed, tabix-indexed bedgraph file with insertion track. 
      will be generated if not included
    secondaryFiles:
      - .tbi
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
    secondaryFiles:
      - .tbi
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
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --occ_track
  - id: out_basename
    type:
      - 'null'
      - string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out
  - id: occ_bound_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Lower and upper bound occupancy tracks (NAME.occ.lower_bound.bedgraph.gz
      and NAME.occ.upper_bound.bedgraph.gz, with .tbi indexes) written by occ. The
      tool opens them by name beside the occ track, so they are staged together.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_basename_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in out_basename
    outputBinding:
      glob: $(inputs.out_basename)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ var l = []; if (inputs.occ_file) { l.push(inputs.occ_file); } (inputs.occ_bound_files || []).forEach(function(f){ l.push(f); }); return l; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
stdout: nucleoatac_nfr.out
