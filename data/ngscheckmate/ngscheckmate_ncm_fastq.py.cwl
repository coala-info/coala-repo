cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncm_fastq.py
label: ngscheckmate_ncm_fastq.py
doc: "NGSCheckMate v1.0\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: desired_depth
    type:
      - 'null'
      - int
    doc: The target depth for read subsampling. NGSCheckMate calculates a 
      subsampling rate based on this target depth.
    inputBinding:
      position: 101
      prefix: --depth
  - id: feature_pattern_file
    type: File
    doc: A binary pattern file (.pt) that lists flanking sequences of selected 
      SNPs (included in the package; SNP/SNP.pt)
    inputBinding:
      position: 101
      prefix: --pt
  - id: input_file_list
    type: File
    doc: A text file that lists input fastq (or fastq.gz) files and sample names
      (one per line; see Input file format)
    inputBinding:
      position: 101
      prefix: --list
  - id: maxthread
    type:
      - 'null'
      - int
    doc: 'The number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --maxthread
  - id: nodeptherror
    type:
      - 'null'
      - boolean
    doc: in case estimated subsampling rate is larger than 1, do not stop but 
      reset it to 1 and continue
    inputBinding:
      position: 101
      prefix: --nodeptherror
  - id: output_dir
    type: Directory
    doc: An output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_filename
    type:
      - 'null'
      - string
    doc: A prefix for output files
    inputBinding:
      position: 101
      prefix: --outfilename
  - id: pattern_length
    type:
      - 'null'
      - int
    doc: 'The length of the flanking sequences of the SNPs (default: 21bp). It is
      not recommended that you change this value unless you create your own pattern
      file (.pt) with a different length. See Supporting Scripts for how to generate
      your own pattern file.'
    inputBinding:
      position: 101
      prefix: --pattern_length
  - id: reference_length
    type:
      - 'null'
      - int
    doc: 'The length of the genomic region with read mapping (default: 3E9) used to
      compute subsampling rate. If your data is NOT human WGS and you use the -d option,
      it is highly recommended that you specify this value.'
    inputBinding:
      position: 101
      prefix: --reference_length
  - id: strict_vaf_correlation
    type:
      - 'null'
      - boolean
    doc: Use strict VAF correlation cutoffs. Recommended when your data may 
      include related individuals (parents-child, siblings)
    inputBinding:
      position: 101
      prefix: --family_cutoff
  - id: subsampling_rate
    type:
      - 'null'
      - float
    doc: The read subsampling rate
    inputBinding:
      position: 101
      prefix: --ss
  - id: test_samplename
    type:
      - 'null'
      - string
    doc: 'file including test sample namses with ":" delimiter (default : all combinations
      of samples), -t filename. -t option is for the previous NGSCheckMate version.
      No longer used.'
    inputBinding:
      position: 101
      prefix: --testsamplename
  - id: use_nonzero_mean_depth
    type:
      - 'null'
      - boolean
    doc: 'Use the mean of non-zero depths across the SNPs as a reference depth (default:
      Use the mean depth across all the SNPs)'
    inputBinding:
      position: 101
      prefix: --nonzero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
stdout: ngscheckmate_ncm_fastq.py.out
