cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-run-em
label: rsem_rsem-run-em
doc: "Run RSEM's expectation-maximization (EM) algorithm on the intermediate
  files made by rsem-parse-alignments and rsem-build-read-index. It writes
  isoform and gene level estimates, the fitted model, and optionally a
  transcript BAM file. The model parameters must be in imd_name.mparams.\n\nTool
  homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: Reference name (the prefix of the files made by rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: read_type
    type: int
    doc: '0 single read without quality score; 1 single read with quality score;
      2 paired-end read without quality score; 3 paired-end read with quality
      score.'
    inputBinding:
      position: 2
  - id: sample_name
    type: string
    doc: Sample name, including the path.
    inputBinding:
      position: 3
  - id: imd_name
    type: string
    doc: Prefix of the intermediate files (made by rsem-parse-alignments and
      rsem-build-read-index; imd_name.mparams must exist).
    inputBinding:
      position: 4
  - id: stat_name
    type: string
    doc: Prefix of the statistics files (made by rsem-parse-alignments).
    inputBinding:
      position: 5
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting 
      with the reference name). They are staged in the working directory.
  - id: imd_files
    type:
      type: array
      items: File
    doc: Intermediate files with the imd_name prefix (.dat, .omit, .mparams, 
      alignable read files and their .ridx indexes).
  - id: stat_files
    type:
      type: array
      items: File
    doc: Statistics files with the stat_name prefix (the .cnt file).
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. (default: 1)'
    inputBinding:
      position: 10
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set it quiet.
    inputBinding:
      position: 10
      prefix: -q
  - id: gibbs_out
    type:
      - 'null'
      - boolean
    doc: 'Generate output file used by Gibbs sampler. (default: off)'
    inputBinding:
      position: 10
      prefix: --gibbs-out
  - id: sampling
    type:
      - 'null'
      - boolean
    doc: 'Sample each read from its posterior distribution when BAM file is
      generated. (default: off)'
    inputBinding:
      position: 10
      prefix: --sampling
  - id: seed
    type:
      - 'null'
      - int
    doc: 'The seed (uint32) used for the BAM sampling. (default: off)'
    inputBinding:
      position: 10
      prefix: --seed
  - id: append_names
    type:
      - 'null'
      - boolean
    doc: 'Append transcript_name/gene_name when available. (default: off)'
    inputBinding:
      position: 10
      prefix: --append-names
  - id: bam_input
    type:
      - 'null'
      - File
    doc: 'The input alignment file (samInpF). When given, a BAM output file
      (sample_name.transcript.bam) is produced. (default: off)'
    inputBinding:
      position: 20
      prefix: -b
  - id: fai_file
    type:
      - 'null'
      - File
    doc: 'FASTA index file, for CRAM input to -b (has_fai is then 1, otherwise 0).'
    inputBinding:
      position: 22
outputs:
  - id: iso_res
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.imd_name).iso_res
    doc: Isoform level results.
  - id: gene_res
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.imd_name).gene_res
    doc: Gene level results.
  - id: stat_output_files
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - $(inputs.stat_name).model
        - $(inputs.stat_name).theta
    doc: Model and theta files.
  - id: transcript_bam
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.sample_name).transcript.bam
    doc: Transcript BAM file (only with bam_input).
  - id: gibbs_files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.imd_name).ofg
    doc: The .ofg file used by the Gibbs sampler (only with gibbs_out).
arguments:
  - position: 21
    valueFrom: '$(inputs.bam_input ? (inputs.fai_file ? "1" : "0") : [])'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_files)
      - entry: $(inputs.imd_files)
        writable: true
      - entry: $(inputs.stat_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
