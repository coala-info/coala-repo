cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sketch
- protein
label: sourmash_sketch_protein
doc: 'Create protein sketches from protein sequences.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: filenames
  type:
  - 'null'
  - File[]
  doc: Sequence files (FASTA or FASTQ, optionally compressed).
  inputBinding:
    position: 100
- id: license
  type:
  - 'null'
  - string
  doc: signature license. Currently only CC0 is supported.
  inputBinding:
    position: 1
    prefix: --license
- id: param_string
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --param-string
  doc: signature parameters to use.
  inputBinding:
    position: 1
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of sequence files to load
  inputBinding:
    position: 1
    prefix: --from-file
- id: force
  type:
  - 'null'
  - boolean
  doc: recompute signatures even if the file exists
  inputBinding:
    position: 1
    prefix: --force
- id: output
  type:
  - 'null'
  - string
  doc: output computed signatures to this file
  inputBinding:
    position: 1
    prefix: --output
- id: set_name
  type:
  - 'null'
  - string
  doc: name the output sketch as specified; note, merges all input files while sketching
  inputBinding:
    position: 1
    prefix: --set-name
- id: output_dir
  type:
  - 'null'
  - string
  doc: output computed signatures to this directory
  inputBinding:
    position: 1
    prefix: --output-dir
- id: singleton
  type:
  - 'null'
  - boolean
  doc: compute a signature for each sequence record individually
  inputBinding:
    position: 1
    prefix: --singleton
- id: name_from_first
  type:
  - 'null'
  - boolean
  doc: name the signature generated from each file after the first record in the file
  inputBinding:
    position: 1
    prefix: --name-from-first
- id: randomize
  type:
  - 'null'
  - boolean
  doc: shuffle the list of input filenames randomly
  inputBinding:
    position: 1
    prefix: --randomize
- id: dayhoff
  type:
  - 'null'
  - boolean
  doc: compute sketches using the dayhoff alphabet instead
  inputBinding:
    position: 1
    prefix: --dayhoff
- id: hp
  type:
  - 'null'
  - boolean
  doc: compute sketches using the dayhoff alphabet instead
  inputBinding:
    position: 1
    prefix: --hp
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: output computed signatures to this file
  outputBinding:
    glob: $(inputs.output)
- id: output_dir_result
  type:
  - 'null'
  - Directory
  doc: output computed signatures to this directory
  outputBinding:
    glob: $(inputs.output_dir)
- id: sketches
  type:
    type: array
    items: File
  doc: Signature files written to the working directory or output directory.
  outputBinding:
    glob:
    - '*.sig'
    - $(inputs.output_dir)/*.sig
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
