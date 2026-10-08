cwlVersion: v1.2
class: CommandLineTool
baseCommand: fseq
label: fseq
doc: "F-Seq Version 1.84\n\nTool homepage: http://fureylab.web.unc.edu/software/fseq/"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input read files in BED format (one file per chromosome, named after the
      chromosome, e.g. chr22.bed)
    inputBinding:
      position: 200
  - id: background_dir
    type:
      - 'null'
      - Directory
    doc: background directory
    inputBinding:
      position: 102
      prefix: -b
  - id: feature_length
    type:
      - 'null'
      - int
    doc: feature length
    inputBinding:
      position: 102
      prefix: -l
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: fragment size
    inputBinding:
      position: 102
      prefix: -f
  - id: genomic_count
    type:
      - 'null'
      - int
    doc: genomic count of sequence reads
    inputBinding:
      position: 102
      prefix: -c
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: input directory
    inputBinding:
      position: 102
      prefix: -d
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory (default=current directory); it is created before the run
    inputBinding:
      position: 102
      prefix: -o
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output format: wig, bed or npf (default wig)'
    inputBinding:
      position: 102
      prefix: -of
  - id: ploidy_dir
    type:
      - 'null'
      - Directory
    doc: ploidy/input directory
    inputBinding:
      position: 102
      prefix: -p
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold (standard deviations)
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: wg_threshold_set
    type:
      - 'null'
      - float
    doc: wg threshold set
    inputBinding:
      position: 102
      prefix: -wg
  - id: wiggle_step
    type:
      - 'null'
      - int
    doc: wiggle track step
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fseq:1.84--py35pl5.22.0_0
stdout: fseq.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ if (inputs.output_dir) { return [{"entryname": inputs.output_dir,
      "entry": {"class": "Directory", "listing": []}, "writable": true}]; } return
      []; }'
