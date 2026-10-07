cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuteSV_ONLINE
label: cutesv-ol_cuteSV_ONLINE
doc: "cuteSV-OL is a real-time SV detection tool based on cuteSV.\n\nTool homepage:
  https://github.com/120L022331/cuteSV-OL"
inputs:
  - id: fastq_dir
    type: Directory
    doc: The fastq folder monitored by cuteSV-OL.
    inputBinding:
      position: 1
      valueFrom: $(self.path + '/')
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: The reference genome in fasta format.
    inputBinding:
      position: 2
  - id: work_dir
    type: string
    doc: Work diretory for cuteSV-OL (created empty in the working directory).
    default: cutesv_ol_work
    inputBinding:
      position: 3
  - id: output_vcf
    type: string
    doc: The vcf folder where cuteSV-OL outputs real-time test results to. 
      The tool creates it; it must not exist yet.
    default: cutesv_ol_vcf
    inputBinding:
      position: 4
      valueFrom: $(self + '/')
  - id: batch_interval
    type:
      - 'null'
      - int
    doc: Real-time results are generated every batch_interval batches
    inputBinding:
      position: 105
      prefix: --batch_interval
  - id: high_freq_file
    type:
      - 'null'
      - File
    doc: high frequence SV file or user-defined recall set[vcf]
    inputBinding:
      position: 105
      prefix: --high_freq_file
  - id: mmi_path
    type:
      - 'null'
      - File
    doc: Minimizer index for the reference in minimap2.
    inputBinding:
      position: 105
      prefix: --mmi_path
  - id: monitor_fade
    type:
      - 'null'
      - int
    doc: Monitor will close if no new files are detected after monitor_fade 
      second.
    inputBinding:
      position: 105
      prefix: --monitor_fade
  - id: pctsize
    type:
      - 'null'
      - float
    doc: Min pct allele size similarity
    inputBinding:
      position: 105
      prefix: --pctsize
  - id: recall_file
    type:
      - 'null'
      - File
    doc: candidate SV mapping to the high frequence SV
    inputBinding:
      position: 105
      prefix: --recall_file
  - id: ref_dist
    type:
      - 'null'
      - int
    doc: Max reference location distance
    inputBinding:
      position: 105
      prefix: --ref_dist
  - id: sv_freq
    type:
      - 'null'
      - float
    doc: Target SV frequence for detection
    inputBinding:
      position: 105
      prefix: --sv_freq
  - id: target_rate
    type:
      - 'null'
      - float
    doc: stop sequency if the detected rate is higher than target_rate
    inputBinding:
      position: 105
      prefix: --target_rate
  - id: target_set
    type:
      - 'null'
      - File
    doc: high frequence SV file or user-defined recall set[vcf]
    inputBinding:
      position: 105
      prefix: --target_set
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 105
      prefix: --threads
  - id: user_defined
    type:
      - 'null'
      - boolean
    doc: The recall set[vcf] is user-defined
    inputBinding:
      position: 105
      prefix: --user_defined
outputs:
  - id: vcf_dir
    type: Directory
    doc: Folder with the real-time VCF results (<depth>_output.vcf)
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: work_dir_out
    type: Directory
    doc: cuteSV-OL work directory (BAM files, signatures, depth logs)
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.work_dir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
stdout: cutesv-ol_cuteSV_ONLINE.out
