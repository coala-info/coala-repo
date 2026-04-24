cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirmite legacy
label: tirmite_legacy
doc: "Map HMM models of transposon termini to genomic sequences\n\nTool homepage:
  https://github.com/Adamtaranto/TIRmite"
inputs:
  - id: aln_dir
    type:
      - 'null'
      - Directory
    doc: "Path to directory containing only TIR alignments in\nFASTA format to be
      converted to HMM."
    inputBinding:
      position: 101
      prefix: --alnDir
  - id: aln_file
    type:
      - 'null'
      - File
    doc: "Provide a single TIR alignment in FASTA format to be\nconverted to HMM.
      Incompatible with \"--alnDir\"."
    inputBinding:
      position: 101
      prefix: --alnFile
  - id: genome
    type: File
    doc: Path to target genome that will be queried with HMMs.
    inputBinding:
      position: 101
      prefix: --genome
  - id: gff_out
    type:
      - 'null'
      - boolean
    doc: "If set report features as prefix.gff3. File saved to\noutdir. Default: False"
    inputBinding:
      position: 101
      prefix: --gffOut
  - id: hmm_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing pre-prepared TIR-pHMMs.
    inputBinding:
      position: 101
      prefix: --hmmDir
  - id: hmm_file
    type:
      - 'null'
      - File
    doc: Path to single HMM file. Incompatible with "--hmmDir".
    inputBinding:
      position: 101
      prefix: --hmmFile
  - id: hmmbuild
    type:
      - 'null'
      - File
    doc: Set location of hmmbuild if not in PATH.
    inputBinding:
      position: 101
      prefix: --hmmbuild
  - id: hmmpress
    type:
      - 'null'
      - File
    doc: Set location of hmmpress if not in PATH.
    inputBinding:
      position: 101
      prefix: --hmmpress
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: If set do not delete temp file directory.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: left_model
    type:
      - 'null'
      - File
    doc: "HMM model for left terminus. Use with --rightModel for\nasymmetric elements."
    inputBinding:
      position: 101
      prefix: --leftModel
  - id: left_nhmmer
    type:
      - 'null'
      - File
    doc: "Path to precomputed nhmmer output for left model. Use\nwith --rightNhmmer
      and --leftModel/--rightModel for\nasymmetric elements."
    inputBinding:
      position: 101
      prefix: --leftNhmmer
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: matrix
    type:
      - 'null'
      - string
    doc: Use custom DNA substitution matrix with nhmmer.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: maxdist
    type:
      - 'null'
      - int
    doc: "Maximum distance allowed between termini candidates to\nconsider valid pairing."
    inputBinding:
      position: 101
      prefix: --maxdist
  - id: maxeval
    type:
      - 'null'
      - float
    doc: Maximum e-value allowed for valid hit.
    inputBinding:
      position: 101
      prefix: --maxeval
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum valid hit length as prop of model length.
    inputBinding:
      position: 101
      prefix: --mincov
  - id: nhmmer
    type:
      - 'null'
      - File
    doc: Set location of nhmmer if not in PATH.
    inputBinding:
      position: 101
      prefix: --nhmmer
  - id: nhmmer_file
    type:
      - 'null'
      - File
    doc: "Path to precomputed nhmmer output file. Requires\n--hmmFile for model length
      calculation."
    inputBinding:
      position: 101
      prefix: --nhmmerFile
  - id: nobias
    type:
      - 'null'
      - boolean
    doc: Turn OFF bias correction of scores in nhmmer.
    inputBinding:
      position: 101
      prefix: --nobias
  - id: nopairing
    type:
      - 'null'
      - boolean
    doc: If set, only report HMM hits. Do not attempt pairing.
    inputBinding:
      position: 101
      prefix: --nopairing
  - id: orientation
    type:
      - 'null'
      - string
    doc: "Orientation pattern for pairing hits. F=Forward,\nR=Reverse. Options: F,R
      (TIR), F,F (LTR), R,R, R,F"
    inputBinding:
      position: 101
      prefix: --orientation
  - id: padlen
    type:
      - 'null'
      - int
    doc: "Extract x bases either side of model hit when writing\nhits to fasta."
    inputBinding:
      position: 101
      prefix: --padlen
  - id: pair_bed
    type:
      - 'null'
      - File
    doc: "If set TIRmite will preform pairing on TIRs from\ncustom bedfile only."
    inputBinding:
      position: 101
      prefix: --pairbed
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Add prefix to all hits and paired elements detected in\nthis run."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: report
    type:
      - 'null'
      - string
    doc: "Options for reporting model hits in GFF annotation\nfile."
    inputBinding:
      position: 101
      prefix: --report
  - id: right_model
    type:
      - 'null'
      - File
    doc: "HMM model for right terminus. Use with --leftModel for\nasymmetric elements."
    inputBinding:
      position: 101
      prefix: --rightModel
  - id: right_nhmmer
    type:
      - 'null'
      - File
    doc: "Path to precomputed nhmmer output for right model. Use\nwith --leftNhmmer
      and --leftModel/--rightModel for\nasymmetric elements."
    inputBinding:
      position: 101
      prefix: --rightNhmmer
  - id: stable_reps
    type:
      - 'null'
      - int
    doc: "Number of times to iterate pairing procedure when no\nadditional pairs are
      found AND remaining unpaired hits\n> 0."
    inputBinding:
      position: 101
      prefix: --stableReps
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: "Base directory for temporary files. Uses system temp\nif not specified."
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads available to hmmer software.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: All output files will be written to this directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
