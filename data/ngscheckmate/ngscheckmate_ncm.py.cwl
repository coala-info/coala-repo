cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncm.py
label: ngscheckmate_ncm.py
doc: "Ensuring Sample Identity v1.0.1. Input = the absolute path list of vcf files
  (samtools mpileup and bcftools). Output = Matched samples List\n\nTool homepage:
  https://github.com/parklab/NGSCheckMate"
inputs:
  - id: bam_files
    type:
      - 'null'
      - boolean
    doc: BAM files to do NGS Checkmate
    inputBinding:
      position: 101
      prefix: --BAM
  - id: bed_file
    type: File
    doc: A bed file containing SNP polymorphisms
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: data_dir
    type: Directory
    doc: data directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: data_list
    type: File
    doc: data list
    inputBinding:
      position: 101
      prefix: --list
  - id: family_cutoff
    type:
      - 'null'
      - boolean
    doc: apply strict correlation threshold to remove family cases
    inputBinding:
      position: 101
      prefix: --family_cutoff
  - id: nonzero
    type:
      - 'null'
      - boolean
    doc: 'Use non-zero mean depth of target loci as reference correlation. (default:
      Use mean depth of all target loci)'
    inputBinding:
      position: 101
      prefix: --nonzero
  - id: output_filename
    type:
      - 'null'
      - string
    doc: 'OutputFileName ( default : output ), -N filename'
    inputBinding:
      position: 101
      prefix: --outfilename
  - id: test_samplename
    type:
      - 'null'
      - string
    doc: 'file including test sample namses  with ":" delimeter (default : all combinations
      of samples), -t filename'
    inputBinding:
      position: 101
      prefix: --testsamplename
  - id: vcf_files
    type:
      - 'null'
      - boolean
    doc: VCF files to do NGS Checkmate
    inputBinding:
      position: 101
      prefix: --VCF
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: directory name for temp and output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
