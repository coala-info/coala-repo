cwlVersion: v1.2
class: CommandLineTool
baseCommand: targqc
label: targqc
doc: "TargQC, target coverage evaluation tool.\n\nTool homepage: https://github.com/vladsaveliev/TargQC"
inputs:
  - id: input_bam
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: amplicons_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: BED file with regions to analyse. If not specified, CDS across full 
      genome will be analysed
    inputBinding:
      position: 102
      prefix: --amplicons
  - id: bed_file
    type:
      - 'null'
      - type: array
        items: File
    doc: BED file with regions to analyse. If not specified, CDS across full 
      genome will be analysed
    inputBinding:
      position: 102
      prefix: --bed
  - id: bwa_bwa_prefix
    type:
      - 'null'
      - string
    doc: Path to BWA index prefix to align if input is FastQ
    inputBinding:
      position: 102
      prefix: --bwa--bwa-prefix
  - id: capture_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: BED file with regions to analyse. If not specified, CDS across full 
      genome will be analysed
    inputBinding:
      position: 102
      prefix: --capture
  - id: depth_thresholds
    type:
      - 'null'
      - string
    doc: Depth thresholds
    inputBinding:
      position: 102
      prefix: --depth-threshold
  - id: downsample
    type:
      - 'null'
      - float
    doc: If input is FastQ, select K% random read pairs from each input set. 
      Default is 0.05%. To turn off (align all reads), set --downsample 1
    default: 0.05
    inputBinding:
      position: 102
      prefix: --downsample
  - id: downsample_fraction
    type:
      - 'null'
      - float
    doc: If input is FastQ, select K% random read pairs from each input set. 
      Default is 0.05%. To turn off (align all reads), set --downsample 1
    default: 0.05
    inputBinding:
      position: 102
      prefix: --downsample-fraction
  - id: downsample_pairs_num
    type:
      - 'null'
      - int
    doc: If input is FastQ, select N random read pairs from each input set 
      (instead of default fraction 0.05).
    inputBinding:
      position: 102
      prefix: --downsample-pairs-num
  - id: downsample_to
    type:
      - 'null'
      - int
    doc: If input is FastQ, select N random read pairs from each input set 
      (instead of default fraction 0.05).
    inputBinding:
      position: 102
      prefix: --downsample-to
  - id: fai
    type:
      - 'null'
      - File
    doc: Path to fai fasta index - sort BAM and BED files, and to get chromosome
      lengths for proper padding BED files; optional
    inputBinding:
      position: 102
      prefix: --fai
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome build (hg19 or hg38), used to pick genome annotation BED file if
      not specified, or path to .fa bwa prefix
    inputBinding:
      position: 102
      prefix: --genome
  - id: padding
    type:
      - 'null'
      - int
    doc: integer indicating the number of bases to extend each target region up 
      and down-stream. Default is 200
    default: 200
    inputBinding:
      position: 102
      prefix: --padding
  - id: queue
    type:
      - 'null'
      - string
    doc: Scheduler queue to run jobs on, for ipython parallel
    inputBinding:
      position: 102
      prefix: --queue
  - id: reannotate
    type:
      - 'null'
      - boolean
    doc: Re-annotate BED file with gene names, even if it's 4 columns or more
    inputBinding:
      position: 102
      prefix: --reannotate
  - id: resources
    type:
      - 'null'
      - type: array
        items: string
    doc: Cluster specific resources specifications. Can be specified multiple 
      times. Supports SGE, Torque, LSF and SLURM parameters.
    inputBinding:
      position: 102
      prefix: --resources
  - id: reuse
    type:
      - 'null'
      - boolean
    doc: reuse intermediate non-empty files in the work dir from previous run
    inputBinding:
      position: 102
      prefix: --reuse
  - id: scheduler
    type:
      - 'null'
      - string
    doc: Scheduler to use for ipython parallel
    inputBinding:
      position: 102
      prefix: --scheduler
  - id: test
    type:
      - 'null'
      - string
    doc: Quick test of correct installation.
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --nt
  - id: threads_alias
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (or directory name in case of bcbio final dir)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targqc:1.8.1--py37hb3f55d8_0
