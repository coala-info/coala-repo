cwlVersion: v1.2
class: CommandLineTool
baseCommand: vaf_ncm.py
label: ngscheckmate_vaf_ncm.py
doc: "NGSCheckMate v1.0. Computes sample matches from the VAF files written by
  ngscheckmate_fastq or ncm_fastq.py.\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: input_dir_name
    type: Directory
    doc: Input directory that contains the output VAF files of 
      ngscheckmate_fastq or ncm_fastq.py.
    inputBinding:
      position: 1
      prefix: --inputDir
  - id: output_dir_path
    type: string
    doc: Output directory
    inputBinding:
      position: 1
      prefix: --outdir
  - id: output_filename
    type:
      - 'null'
      - string
    doc: 'Output file prefix (default : "output")'
    inputBinding:
      position: 2
      prefix: --outfilename
  - id: family_cutoff
    type:
      - 'null'
      - boolean
    doc: Use strict VAF correlation cutoffs. Recommended when your data may 
      include related individuals (parents-child, siblings)
    inputBinding:
      position: 2
      prefix: --family_cutoff
  - id: nonzero
    type:
      - 'null'
      - boolean
    doc: 'Use the mean of non-zero depths across the SNPs as a reference depth (default:
      Use the mean depth across all the SNPs)'
    inputBinding:
      position: 2
      prefix: --nonzero
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the correlation tables, matched list and plot
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
