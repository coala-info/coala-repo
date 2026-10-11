cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncm_fastq.py
label: ngscheckmate_ncm_fastq.py
doc: "NGSCheckMate v1.0. Checks sample identity from FASTQ files: counts reads
  matching the SNP flanking patterns and correlates the allele fractions between
  samples.\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: input_file_list
    type: File
    doc: A text file that lists input fastq (or fastq.gz) files and sample names
      (one per line, tab separated; a paired-end sample lists both files).
    inputBinding:
      position: 1
      prefix: --list
  - id: fastq_files
    type:
      type: array
      items: File
    doc: The FASTQ files named in the input file list (staged so that the names
      resolve)
  - id: feature_pattern_file
    type: File
    doc: A binary pattern file (.pt) that lists flanking sequences of selected 
      SNPs (included in the package; SNP/SNP.pt)
    inputBinding:
      position: 1
      prefix: --pt
  - id: output_dir_path
    type: string
    doc: An output directory
    inputBinding:
      position: 1
      prefix: --outdir
  - id: output_filename
    type:
      - 'null'
      - string
    doc: A prefix for output files
    inputBinding:
      position: 2
      prefix: --outfilename
  - id: strict_vaf_correlation
    type:
      - 'null'
      - boolean
    doc: Use strict VAF correlation cutoffs. Recommended when your data may 
      include related individuals (parents-child, siblings)
    inputBinding:
      position: 2
      prefix: --family_cutoff
  - id: use_nonzero_mean_depth
    type:
      - 'null'
      - boolean
    doc: 'Use the mean of non-zero depths across the SNPs as a reference depth (default:
      Use the mean depth across all the SNPs)'
    inputBinding:
      position: 2
      prefix: --nonzero
  - id: subsampling_rate
    type:
      - 'null'
      - float
    doc: The read subsampling rate
    inputBinding:
      position: 2
      prefix: --ss
  - id: desired_depth
    type:
      - 'null'
      - int
    doc: The target depth for read subsampling. NGSCheckMate calculates a 
      subsampling rate based on this target depth.
    inputBinding:
      position: 2
      prefix: --depth
  - id: reference_length
    type:
      - 'null'
      - float
    doc: 'The length of the genomic region with read mapping (default: 3E9) used to
      compute subsampling rate. If your data is NOT human WGS and you use the -d option,
      it is highly recommended that you specify this value.'
    inputBinding:
      position: 2
      prefix: --reference_length
  - id: pattern_length
    type:
      - 'null'
      - int
    doc: 'The length of the flanking sequences of the SNPs (default: 21bp). It is
      not recommended that you change this value unless you create your own pattern
      file (.pt) with a different length.'
    inputBinding:
      position: 2
      prefix: --pattern_length
  - id: maxthread
    type:
      - 'null'
      - int
    doc: 'The number of threads (default: 1)'
    inputBinding:
      position: 2
      prefix: --maxthread
  - id: nodeptherror
    type:
      - 'null'
      - string
    doc: in case estimated subsampling rate is larger than 1, do not stop but 
      reset it to 1 and continue
    inputBinding:
      position: 2
      prefix: --nodeptherror
  - id: test_samplename
    type:
      - 'null'
      - File
    doc: 'file including test sample names with ":" delimiter (default : all combinations
      of samples). The -t option is for the previous NGSCheckMate version and is
      no longer used.'
    inputBinding:
      position: 2
      prefix: --testsamplename
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the VAF files, the correlation tables and the 
      plot
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.fastq_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
