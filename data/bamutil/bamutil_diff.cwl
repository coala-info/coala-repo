cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - diff
label: bamutil_diff
doc: "Diff 2 coordinate sorted SAM/BAM files.\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in1
    type: File
    doc: first coordinate sorted SAM/BAM file to be diffed
    inputBinding:
      position: 1
      prefix: --in1
  - id: in2
    type: File
    doc: second coordinate sorted SAM/BAM file to be diffed
    inputBinding:
      position: 1
      prefix: --in2
  - id: out
    type:
      - 'null'
      - string
    doc: 'output filename, use .bam extension to output in SAM/BAM format instead
      of diff format (default: stdout)'
    inputBinding:
      position: 1
      prefix: --out
  - id: all
    type:
      - 'null'
      - boolean
    doc: diff all the SAM/BAM fields.
    inputBinding:
      position: 1
      prefix: --all
  - id: flag
    type:
      - 'null'
      - boolean
    doc: diff the flags.
    inputBinding:
      position: 1
      prefix: --flag
  - id: map_qual
    type:
      - 'null'
      - boolean
    doc: diff the mapping qualities.
    inputBinding:
      position: 1
      prefix: --mapQual
  - id: mate
    type:
      - 'null'
      - boolean
    doc: diff the mate chrom/pos.
    inputBinding:
      position: 1
      prefix: --mate
  - id: isize
    type:
      - 'null'
      - boolean
    doc: diff the insert sizes.
    inputBinding:
      position: 1
      prefix: --isize
  - id: seq
    type:
      - 'null'
      - boolean
    doc: diff the sequence bases.
    inputBinding:
      position: 1
      prefix: --seq
  - id: base_qual
    type:
      - 'null'
      - boolean
    doc: diff the base qualities.
    inputBinding:
      position: 1
      prefix: --baseQual
  - id: tags
    type:
      - 'null'
      - string
    doc: diff the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
    inputBinding:
      position: 1
      prefix: --tags
  - id: every_tag
    type:
      - 'null'
      - boolean
    doc: diff all the Tags
    inputBinding:
      position: 1
      prefix: --everyTag
  - id: no_cigar
    type:
      - 'null'
      - boolean
    doc: do not diff the the cigars.
    inputBinding:
      position: 1
      prefix: --noCigar
  - id: no_pos
    type:
      - 'null'
      - boolean
    doc: do not diff the positions.
    inputBinding:
      position: 1
      prefix: --noPos
  - id: only_diffs
    type:
      - 'null'
      - boolean
    doc: only print the fields that are different
    inputBinding:
      position: 1
      prefix: --onlyDiffs
  - id: rec_pool_size
    type:
      - 'null'
      - int
    doc: 'number of records to allow to be stored at a time, default value: 1000000
      (-1 unlimited)'
    inputBinding:
      position: 1
      prefix: --recPoolSize
  - id: pos_diff
    type:
      - 'null'
      - int
    doc: 'max base pair difference between possibly matching records, default value:
      100000'
    inputBinding:
      position: 1
      prefix: --posDiff
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not expect an EOF block on a bam file.
    inputBinding:
      position: 1
      prefix: --noeof
  - id: params
    type:
      - 'null'
      - boolean
    doc: Print the parameter settings
    inputBinding:
      position: 1
      prefix: --params
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not send usage information (phone home)
    inputBinding:
      position: 1
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning percentage [50]
    inputBinding:
      position: 1
      prefix: --phoneHomeThinning
outputs:
  - id: diff_stdout
    type: stdout
    doc: Differences in diff format (when --out is not given)
  - id: diff_files
    type: File[]
    doc: Output file(s) written with --out (record diffs, and only_<in1>/only_<in2>
      files for SAM/BAM output)
    outputBinding:
      glob: '$(inputs.out ? inputs.out.split(''.'')[0] + ''*'' : ''_none_'')'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_diff.txt
