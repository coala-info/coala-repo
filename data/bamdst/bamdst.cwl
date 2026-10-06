cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdst
label: bamdst
doc: "A lightweight tool to calculate depth and coverage statistics for target regions
  in BAM files.\n\nTool homepage: https://github.com/shiquan/bamdst"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Probe or target regions file; regions are merged before depths are calculated
    inputBinding:
      position: 102
      prefix: --bed
  - id: flank
    type:
      - 'null'
      - int
    doc: Flank n bp of each region (default 200)
    inputBinding:
      position: 102
      prefix: -f
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Map quality cutoff value; reads with a value greater or equal are counted
      (default 20)
    inputBinding:
      position: 102
      prefix: -q
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: Set the max depth to stat the cumulative distribution (default 0)
    inputBinding:
      position: 102
      prefix: --maxdepth
  - id: cutoffdepth
    type:
      - 'null'
      - int
    doc: List the coverage of above depths (default 0)
    inputBinding:
      position: 102
      prefix: --cutoffdepth
  - id: isize
    type:
      - 'null'
      - int
    doc: Stat the inferred insert size under this value (default 2000)
    inputBinding:
      position: 102
      prefix: --isize
  - id: uncover_cutoff
    type:
      - 'null'
      - int
    doc: Region will be included in the uncover file if below it (default 5)
    inputBinding:
      position: 102
      prefix: --uncover
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: Begin position of the bed file is 1-based
    inputBinding:
      position: 102
      prefix: '-1'
  - id: bamout_path
    type:
      - 'null'
      - string
    doc: Target reads will be exported to this BAM file
    inputBinding:
      position: 102
      prefix: --bamout
  - id: output_dir_path
    type: string
    doc: Output directory (created before the run)
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with coverage.report, cumu.plot, insert.plot, chromosome.report,
      region.tsv.gz, depth.tsv.gz and uncover.bed
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: bamout
    type:
      - 'null'
      - File
    doc: BAM file with the target reads
    outputBinding:
      glob: $(inputs.bamout_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |
        ${ return {"class": "Directory", "basename": inputs.output_dir_path, "listing": [], "writable": true}; }
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bamdst:1.0.9_cv1
