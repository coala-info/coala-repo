cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirmite_pair
label: tirmite_pair
doc: "Pair precomputed nhmmer hits for transposon detection\n\nTool homepage: https://github.com/Adamtaranto/TIRmite"
inputs:
  - id: genome
    type: File
    doc: Path to target genome FASTA file.
    inputBinding:
      position: 101
      prefix: --genome
  - id: gff_out
    type:
      - 'null'
      - boolean
    doc: Generate GFF3 output file.
    inputBinding:
      position: 101
      prefix: --gffOut
  - id: hmm_file
    type:
      - 'null'
      - File
    doc: Path to HMM file for extracting model lengths (for single model 
      pairing).
    inputBinding:
      position: 101
      prefix: --hmmFile
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Preserve temporary directory.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: left_model
    type:
      - 'null'
      - File
    doc: Path to left HMM model file (for asymmetric pairing).
    inputBinding:
      position: 101
      prefix: --leftModel
  - id: left_nhmmer
    type:
      - 'null'
      - File
    doc: Path to nhmmer output for left model (use with --rightNhmmer).
    inputBinding:
      position: 101
      prefix: --leftNhmmer
  - id: lengths_file
    type:
      - 'null'
      - File
    doc: Path to tab-delimited file with model_name and model_length columns.
    inputBinding:
      position: 101
      prefix: --lengthsFile
  - id: logfile
    type:
      - 'null'
      - boolean
    doc: Write log messages to file in output directory.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance allowed between termini for pairing.
    inputBinding:
      position: 101
      prefix: --maxdist
  - id: max_eval
    type:
      - 'null'
      - float
    doc: Maximum e-value allowed for valid hit.
    inputBinding:
      position: 101
      prefix: --maxeval
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum hit coverage as proportion of model length.
    inputBinding:
      position: 101
      prefix: --mincov
  - id: nhmmer_file
    type:
      - 'null'
      - File
    doc: Path to single nhmmer output file (requires --hmmFile or 
      --lengthsFile).
    inputBinding:
      position: 101
      prefix: --nhmmerFile
  - id: nopairing
    type:
      - 'null'
      - boolean
    doc: Only report individual hits, skip pairing.
    inputBinding:
      position: 101
      prefix: --nopairing
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'Orientation pattern for pairing. F=Forward(+), R=Reverse(-). Options: F,R
      (TIR), F,F (LTR), R,R, R,F.'
    inputBinding:
      position: 101
      prefix: --orientation
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: padlen
    type:
      - 'null'
      - int
    doc: Extract N bases flanking each hit in FASTA output.
    inputBinding:
      position: 101
      prefix: --padlen
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: report
    type:
      - 'null'
      - string
    doc: Types of hits to include in GFF output.
    inputBinding:
      position: 101
      prefix: --report
  - id: right_model
    type:
      - 'null'
      - File
    doc: Path to right HMM model file (for asymmetric pairing).
    inputBinding:
      position: 101
      prefix: --rightModel
  - id: right_nhmmer
    type:
      - 'null'
      - File
    doc: Path to nhmmer output for right model (use with --leftNhmmer).
    inputBinding:
      position: 101
      prefix: --rightNhmmer
  - id: stable_reps
    type:
      - 'null'
      - int
    doc: Number of iterations when no new pairs found.
    inputBinding:
      position: 101
      prefix: --stableReps
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Base directory for temporary files.
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
stdout: tirmite_pair.out
