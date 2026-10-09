cwlVersion: v1.2
class: CommandLineTool
baseCommand: hichipper
label: hichipper_call
doc: 'a preprocessing and QC pipeline for HiChIP data.


  Tool homepage: https://github.com/aryeelab/hichipper'
inputs:
  - id: mode
    type: string
    doc: 'hichipper mode: [call, *.yaml] ^ either specify the word `call` and feed

      in a valid interactions file OR specify the .yaml format for options to be

      parsed from a manifest file (see documentation)'
    inputBinding:
      position: 1
    default: call
  - id: basic_qc
    type:
      - 'null'
      - boolean
    doc: Create a simple QC report without Pandoc
    inputBinding:
      position: 102
      prefix: --basic-qc
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: 'Path to bedtools; by default, assumes that

      bedtools is in PATH'
    inputBinding:
      position: 102
      prefix: --bedtools-path
  - id: bgzip_path
    type:
      - 'null'
      - string
    doc: 'Path to macs2; by default, assumes that bgzip

      is in PATH'
    inputBinding:
      position: 102
      prefix: --bgzip-path
  - id: ignore_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Comma separated list of sample names to

      ignore; NONE (special string) by default'
    inputBinding:
      position: 102
      prefix: --ignore-samples
      itemSeparator: ','
  - id: input_vi
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Comma-separted list of interactions files for

      loop calling; option valid only in `call`

      mode'
    inputBinding:
      position: 102
      prefix: --input-vi
      itemSeparator: ','
  - id: keep_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of sample names to keep; ALL (special string) by default
    inputBinding:
      position: 102
      prefix: --keep-samples
      itemSeparator: ','
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary files?
    inputBinding:
      position: 102
      prefix: --keep-temp-files
  - id: macs2_genome
    type:
      - 'null'
      - string
    doc: 'Argument to pass to the -g variable in MACS2

      (mm for mouse genome; hs for human genome);

      default = "hs"'
    inputBinding:
      position: 102
      prefix: --macs2-genome
  - id: macs2_path
    type:
      - 'null'
      - string
    doc: 'Path to macs2; by default, assumes that macs2

      is in PATH'
    inputBinding:
      position: 102
      prefix: --macs2-path
  - id: macs2_string
    type:
      - 'null'
      - string
    doc: 'String of arguments to pass to MACS2; only is

      called when peaks are set to be called;

      default = "-q 0.01 --extsize 147 --nomodel"'
    inputBinding:
      position: 102
      prefix: --macs2-string
  - id: make_ucsc
    type:
      - 'null'
      - boolean
    doc: 'Make additional output files that can support

      viewing in UCSC genome browser; requires

      tabix and bgzip; does the same thing as

      --make-washu.'
    inputBinding:
      position: 102
      prefix: --make-ucsc
  - id: make_washu
    type:
      - 'null'
      - boolean
    doc: 'Make additional output files that can support

      viewing in WashU genome browser; requires

      tabix and bgzip; does the same thing as

      --make-ucsc.'
    inputBinding:
      position: 102
      prefix: --make-washu
  - id: max_dist
    type:
      - 'null'
      - string
    doc: 'Maximum distance for loop calls; default =

      2000000'
    inputBinding:
      position: 102
      prefix: --max-dist
  - id: merge_gap
    type:
      - 'null'
      - string
    doc: 'Merge nearby peaks (after all padding is

      complete; default = 500'
    inputBinding:
      position: 102
      prefix: --merge-gap
  - id: min_dist
    type:
      - 'null'
      - string
    doc: 'Minimum distance for loop calls; default =

      5000'
    inputBinding:
      position: 102
      prefix: --min-dist
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: 'Completely skip anchor merging; will affect

      summary statistics. Not recommended unless

      understood what is happening.'
    inputBinding:
      position: 102
      prefix: --no-merge
  - id: out
    type: string
    doc: 'Output directory name; must not be already

      existing'
    inputBinding:
      position: 102
      prefix: --out
  - id: peak_pad
    type:
      - 'null'
      - string
    doc: 'Peak padding width (applied on both left and

      right); default = 500'
    inputBinding:
      position: 102
      prefix: --peak-pad
  - id: peaks
    type:
      - 'null'
      - string
    doc: 'Either 1 of 4 peak logic strings or a valid

      filepath to a .bed (or similary formatted)

      file; defers to what is in the .yaml'
    inputBinding:
      position: 102
      prefix: --peaks
  - id: r_path
    type:
      - 'null'
      - string
    doc: 'Path to R; by default, assumes that R is in

      PATH'
    inputBinding:
      position: 102
      prefix: --r-path
  - id: read_length
    type:
      - 'null'
      - string
    doc: 'Length of reads from sequencing runs; default

      = 75'
    inputBinding:
      position: 102
      prefix: --read-length
  - id: restriction_frags
    type:
      - 'null'
      - File
    doc: 'Filepath to restriction fragment files; will

      overwrite specification of this file when a

      .yaml is supplied for mode'
    inputBinding:
      position: 102
      prefix: --restriction-frags
  - id: skip_background_correction
    type:
      - 'null'
      - boolean
    doc: 'Skip restriction fragment aware background

      correction?'
    inputBinding:
      position: 102
      prefix: --skip-background-correction
  - id: skip_diffloop
    type:
      - 'null'
      - boolean
    doc: 'Skip analyses in diffloop (e.g. Mango loop

      calling; .rds generation)'
    inputBinding:
      position: 102
      prefix: --skip-diffloop
  - id: skip_resfrag_pad
    type:
      - 'null'
      - boolean
    doc: Skip restriction fragment aware padding
    inputBinding:
      position: 102
      prefix: --skip-resfrag-pad
  - id: tabix_path
    type:
      - 'null'
      - string
    doc: 'Path to samtools; by default, assumes that

      tabix is in PATH'
    inputBinding:
      position: 102
      prefix: --tabix-path
  - id: peaks_file
    type:
      - 'null'
      - File
    doc: Peaks as a valid .bed (or similarly formatted) file, such as a narrowPeak
      file. Use peaks for the 4 peak logic strings.
    inputBinding:
      position: 102
      prefix: --peaks
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name; must not be already existing
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hichipper:0.7.7--py_0
stdout: hichipper_call.out
