cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign_prepare_reference
doc: "Limit XYalign to only preparing reference fastas for individuals with and without\
  \ Y chromosomes. These fastas can then be passed with each sample to save subsequent\
  \ processing time.\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs:
  - id: bwa_index
    type:
      - 'null'
      - string
    doc: If True, index with BWA during PREPARE_REFERENCE. The program reads any non-empty
      value as True (even 'False'), so leave it unset to skip indexing. Only relevant
      when running the PREPARE_REFERENCE module by itself.
    inputBinding:
      position: 101
      prefix: --bwa_index
  - id: bwa_path
    type:
      - 'null'
      - string
    doc: Path to bwa. Default is 'bwa'
    inputBinding:
      position: 101
      prefix: --bwa_path
  - id: logfile
    type:
      - 'null'
      - string
    doc: Name of logfile. Will overwrite if exists. Default is sample_xyalign.log
    inputBinding:
      position: 101
      prefix: --logfile
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Include flag to preserve temporary files.
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: ref
    type: File
    doc: Path to reference sequence (including file name). Must have a .fai index
      beside it.
    inputBinding:
      position: 101
      prefix: --ref
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: reference_mask
    type:
      - 'null'
      - type: array
        items: File
    doc: Bed file containing regions to replace with Ns in the sex chromosome reference.
      Examples might include the pseudoautosomal regions on the Y to force all mapping/calling
      on those regions of the X chromosome. Default is None.
    inputBinding:
      position: 101
      prefix: --reference_mask
  - id: reporting_level
    type:
      - 'null'
      - string
    doc: Set level of messages printed to console. Default is 'INFO'. Choose from
      (in decreasing amount of reporting) DEBUG, INFO, ERROR or CRITICAL
    inputBinding:
      position: 101
      prefix: --reporting_level
  - id: sambamba_path
    type:
      - 'null'
      - string
    doc: Path to sambamba. Default is 'sambamba'
    inputBinding:
      position: 101
      prefix: --sambamba_path
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Name/ID of sample - for use in plot titles and file naming. Default is sample
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools. Default is 'samtools'
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: xx_ref_out
    type:
      - 'null'
      - string
    doc: Desired path to and name of masked output fasta for samples WITHOUT a Y chromosome
      (e.g., XX, XXX, XO, etc.). Overwrites if exists. Use if you would like output
      somewhere other than XYalign reference directory. Otherwise, use --xx_ref_name.
    inputBinding:
      position: 101
      prefix: --xx_ref_out
  - id: xx_ref_out_name
    type:
      - 'null'
      - string
    doc: Desired name for masked output fasta for samples WITHOUT a Y chromosome (e.g.,
      XX, XXX, XO, etc.). Defaults to 'xyalign_noY.masked.fa'. Will be output in the
      XYalign reference directory.
    inputBinding:
      position: 101
      prefix: --xx_ref_out_name
  - id: xy_ref_out
    type:
      - 'null'
      - string
    doc: Desired path to and name of masked output fasta for samples WITH a Y chromosome
      (e.g., XY, XXY, etc.). Overwrites if exists. Use if you would like output somewhere
      other than XYalign reference directory. Otherwise, use --xy_ref_name.
    inputBinding:
      position: 101
      prefix: --xy_ref_out
  - id: xy_ref_out_name
    type:
      - 'null'
      - string
    doc: Desired name for masked output fasta for samples WITH a Y chromosome (e.g.,
      XY, XXY, etc.). Defaults to 'xyalign_withY.masked.fa'. Will be output in the
      XYalign reference directory.
    inputBinding:
      position: 101
      prefix: --xy_ref_out_name
  - id: y_chromosome
    type:
      type: array
      items: string
    doc: Names of y-linked scaffolds in reference fasta (must match reference exactly).
      Defaults to chrY. Give None if using an assembly without a Y chromosome
    inputBinding:
      position: 101
      prefix: --y_chromosome
  - id: output_dir
    type: string
    default: xyalign_output
    doc: Output directory. XYalign will create a directory structure within this directory
    inputBinding:
      position: 101
      prefix: --output_dir
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: xx_ref_out_file
    type:
      - 'null'
      - File
    doc: Masked output fasta for samples WITHOUT a Y chromosome, written to the path
      given in xx_ref_out
    outputBinding:
      glob: $(inputs.xx_ref_out)
  - id: xy_ref_out_file
    type:
      - 'null'
      - File
    doc: Masked output fasta for samples WITH a Y chromosome, written to the path
      given in xy_ref_out
    outputBinding:
      glob: $(inputs.xy_ref_out)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --PREPARE_REFERENCE
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_1
stdout: xyalign_prepare_reference.out
