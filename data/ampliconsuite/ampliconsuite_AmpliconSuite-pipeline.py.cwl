cwlVersion: v1.2
class: CommandLineTool
baseCommand: AmpliconSuite-pipeline.py
label: ampliconsuite_AmpliconSuite-pipeline.py
doc: "A pipeline wrapper for AmpliconArchitect, invoking alignment CNV calling and
  CNV filtering prior. Can launch AA, as well as downstream amplicon classification.\n\
  \nTool homepage: https://github.com/AmpliconSuite"
inputs:
  - id: aa_extendmode
    type:
      - 'null'
      - string
    doc: If --run_AA selected, set the --extendmode argument to AA. Default mode
      is 'EXPLORE'
    inputBinding:
      position: 101
      prefix: --AA_extendmode
  - id: aa_insert_sdevs
    type:
      - 'null'
      - float
    doc: Number of standard deviations around the insert size. May need to 
      increase for sequencing runs with high variance after insert size 
      selection step.
    inputBinding:
      position: 101
      prefix: --AA_insert_sdevs
  - id: aa_python_interpreter
    type:
      - 'null'
      - string
    doc: By default AmpliconSuite-pipeline will use the system's default python 
      path. If you would like to use a different python version with AA, set 
      this to either the path to the interpreter or 'python', 'python3', 
      'python2'
    inputBinding:
      position: 101
      prefix: --aa_python_interpreter
  - id: aa_runmode
    type:
      - 'null'
      - string
    doc: If --run_AA selected, set the --runmode argument to AA. Default mode is
      'FULL'
    inputBinding:
      position: 101
      prefix: --AA_runmode
  - id: aa_src
    type:
      - 'null'
      - Directory
    doc: Specify a custom $AA_SRC path. Overrides the bash variable
    inputBinding:
      position: 101
      prefix: --AA_src
  - id: align_only
    type:
      - 'null'
      - boolean
    doc: Only perform the alignment stage (do not run CNV calling and seeding
    inputBinding:
      position: 101
      prefix: --align_only
  - id: bam
    type:
      - 'null'
      - File
    doc: Coordinate sorted BAM file (aligned to an AA-supported reference.)
    inputBinding:
      position: 101
      prefix: --bam
  - id: cngain
    type:
      - 'null'
      - float
    doc: CN gain threshold to consider for AA seeding
    inputBinding:
      position: 101
      prefix: --cngain
  - id: cnsize_min
    type:
      - 'null'
      - int
    doc: CN interval size (in bp) to consider for AA seeding
    inputBinding:
      position: 101
      prefix: --cnsize_min
  - id: cnv_bed
    type:
      - 'null'
      - File
    doc: 'BED file (or CNVKit .cns file) of CNV changes. Fields in the bed file should
      be: chr start end name cngain'
    inputBinding:
      position: 101
      prefix: --cnv_bed
  - id: cnvkit_dir
    type:
      - 'null'
      - Directory
    doc: Optional path to cnvkit.py. Assumes CNVKit is on the system path if not
      set and no --cnv_bed given
    inputBinding:
      position: 101
      prefix: --cnvkit_dir
  - id: cnvkit_segmentation
    type:
      - 'null'
      - string
    doc: Segmentation method for CNVKit (if used), defaults to CNVKit default 
      segmentation method (cbs).
    inputBinding:
      position: 101
      prefix: --cnvkit_segmentation
  - id: completed_aa_runs
    type:
      - 'null'
      - Directory
    doc: Path to a directory containing one or more completed AA runs which 
      utilized the same reference genome.
    inputBinding:
      position: 101
      prefix: --completed_AA_runs
  - id: completed_run_metadata
    type:
      - 'null'
      - File
    doc: Run metadata JSON to retroactively assign to collection of samples
    inputBinding:
      position: 101
      prefix: --completed_run_metadata
  - id: download_repo
    type:
      - 'null'
      - type: array
        items: string
    doc: Download the selected data repo to the $AA_DATA_REPO directory and 
      exit.
    inputBinding:
      position: 101
      prefix: --download_repo
  - id: downsample
    type:
      - 'null'
      - float
    doc: AA downsample argument (see AA documentation)
    inputBinding:
      position: 101
      prefix: --downsample
  - id: fastqs
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq files (r1.fq r2.fq)
    inputBinding:
      position: 101
      prefix: --fastqs
  - id: foldback_pair_support_min
    type:
      - 'null'
      - int
    doc: Number of read pairs for minimum foldback SV support. Used value will 
      be the maximum of pair_support and this argument.
    inputBinding:
      position: 101
      prefix: --foldback_pair_support_min
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Do not run amplified_intervals.py to remove low confidence candidate 
      seed regions overlapping repetitive parts of the genome
    inputBinding:
      position: 101
      prefix: --no_filter
  - id: no_qc
    type:
      - 'null'
      - boolean
    doc: Skip QC on the BAM file. Do not adjust AA insert_sdevs for poor-quality
      insert size distribution
    inputBinding:
      position: 101
      prefix: --no_QC
  - id: normal_bam
    type:
      - 'null'
      - File
    doc: Path to matched normal bam for CNVKit (optional)
    inputBinding:
      position: 101
      prefix: --normal_bam
  - id: nthreads
    type: int
    doc: Number of threads to use in BWA and CNV calling
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: pair_support_min
    type:
      - 'null'
      - int
    doc: Number of read pairs for minimum breakpoint support
    inputBinding:
      position: 101
      prefix: --pair_support_min
  - id: ploidy
    type:
      - 'null'
      - float
    doc: Ploidy estimate for CNVKit (optional). This is not used outside of 
      CNVKit.
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: project_key
    type:
      - 'null'
      - string
    doc: Project key for upload (required if --upload is set)
    inputBinding:
      position: 101
      prefix: --project_key
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: Project UUID for upload (required if --upload is set)
    inputBinding:
      position: 101
      prefix: --project_uuid
  - id: purity
    type:
      - 'null'
      - float
    doc: Tumor purity estimate for CNVKit (optional). This is not used outside 
      of CNVKit.
    inputBinding:
      position: 101
      prefix: --purity
  - id: python3_path
    type:
      - 'null'
      - File
    doc: If needed, specify a custom path to python3.
    inputBinding:
      position: 101
      prefix: --python3_path
  - id: ref
    type:
      - 'null'
      - string
    doc: Reference genome version. Autodetected unless fastqs given as input.
    inputBinding:
      position: 101
      prefix: --ref
  - id: rscript_path
    type:
      - 'null'
      - File
    doc: Specify custom path to Rscript for CNVKit, which requires R version 
      >=3.5
    inputBinding:
      position: 101
      prefix: --rscript_path
  - id: run_aa
    type:
      - 'null'
      - boolean
    doc: Run AA after all files prepared. Default off.
    inputBinding:
      position: 101
      prefix: --run_AA
  - id: run_ac
    type:
      - 'null'
      - boolean
    doc: Run AmpliconClassifier after all files prepared. Default off.
    inputBinding:
      position: 101
      prefix: --run_AC
  - id: sample_metadata
    type:
      - 'null'
      - File
    doc: JSON file of sample metadata to build on
    inputBinding:
      position: 101
      prefix: --sample_metadata
  - id: sample_name
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: samtools_path
    type:
      - 'null'
      - File
    doc: Path to samtools binary (e.g., /path/to/my/samtools). If unset, will 
      use samtools on system path.
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: sv_vcf
    type:
      - 'null'
      - File
    doc: Provide a VCF file of externally-called SVs to augment SVs identified 
      by AA internally.
    inputBinding:
      position: 101
      prefix: --sv_vcf
  - id: sv_vcf_no_filter
    type:
      - 'null'
      - boolean
    doc: Use all external SV calls from the --sv_vcf arg, even those without 
      'PASS' in the FILTER column.
    inputBinding:
      position: 101
      prefix: --sv_vcf_no_filter
  - id: upload
    type:
      - 'null'
      - boolean
    doc: (Optional) Upload results to specified project on AmpliconRepository
    inputBinding:
      position: 101
      prefix: --upload
  - id: upload_server
    type:
      - 'null'
      - string
    doc: "Upload server: 'local', 'dev', 'prod' (prod is default)"
    inputBinding:
      position: 101
      prefix: --upload_server
  - id: username
    type:
      - 'null'
      - string
    doc: Username for upload (required if --upload is set)
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory name. Will create directory if needed.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampliconsuite:1.5.0--pyhdfd78af_0
