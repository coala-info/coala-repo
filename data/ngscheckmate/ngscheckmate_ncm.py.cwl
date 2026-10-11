cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncm.py
label: ngscheckmate_ncm.py
doc: "Ensuring Sample Identity v1.0.1. Input = a directory or a list of VCF files
  (samtools mpileup and bcftools) or BAM files. Output = Matched samples list\n\nSet
  the NCM_REF environment variable to the reference FASTA when running with BAM files
  (ncm_ref input).\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: bam_files
    type:
      - 'null'
      - boolean
    doc: BAM files to do NGS Checkmate
    inputBinding:
      position: 1
      prefix: --BAM
  - id: vcf_files
    type:
      - 'null'
      - boolean
    doc: VCF files to do NGS Checkmate
    inputBinding:
      position: 1
      prefix: --VCF
  - id: bed_file
    type: File
    doc: A bed file containing SNP polymorphisms
    inputBinding:
      position: 2
      prefix: --bedfile
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: data directory (use this or data_list)
    inputBinding:
      position: 2
      prefix: --dir
  - id: data_list
    type:
      - 'null'
      - File
    doc: data list (use this or data_dir). The files named in the list must be
      given in list_files.
    inputBinding:
      position: 2
      prefix: --list
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in data_list (staged so that the names in the list resolve)
  - id: family_cutoff
    type:
      - 'null'
      - boolean
    doc: apply strict correlation threshold to remove family cases
    inputBinding:
      position: 3
      prefix: --family_cutoff
  - id: nonzero
    type:
      - 'null'
      - boolean
    doc: 'Use non-zero mean depth of target loci as reference correlation. (default:
      Use mean depth of all target loci)'
    inputBinding:
      position: 3
      prefix: --nonzero
  - id: output_filename
    type:
      - 'null'
      - string
    doc: 'OutputFileName ( default : output ), -N filename'
    inputBinding:
      position: 3
      prefix: --outfilename
  - id: test_samplename
    type:
      - 'null'
      - File
    doc: 'file including test sample namses  with ":" delimeter (default : all combinations
      of samples), -t filename'
    inputBinding:
      position: 3
      prefix: --testsamplename
  - id: output_dir_path
    type: string
    doc: directory name for temp and output files
    inputBinding:
      position: 3
      prefix: --outdir
  - id: ncm_ref
    type:
      - 'null'
      - File
    doc: Reference FASTA (NCM_REF environment variable), needed with BAM files
outputs:
  - id: output_dir
    type: Directory
    doc: directory with the output tables, the plot and the R script
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: NCM_REF
        envValue: '$(inputs.ncm_ref ? inputs.ncm_ref.path : "")'
  - class: InitialWorkDirRequirement
    listing: '$(inputs.list_files ? inputs.list_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
