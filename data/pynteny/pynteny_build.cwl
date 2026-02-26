cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pynteny
  - build
label: pynteny_build
doc: "Translate nucleotide assembly file and assign contig and gene location info
  to each identified ORF (using prodigal). Label predicted ORFs according to positional
  info and export a fasta file containing predicted and translated ORFs. Alternatively,
  extract peptide sequences from GenBank file containing ORF annotations and write
  labelled peptide sequences to a fasta file.\n\nTool homepage: http://github.com/robaina/Pynteny"
inputs:
  - id: data
    type: File
    doc: path to assembly input nucleotide data or annotated GenBank file. It 
      can be a single file or a directory of files (either of FASTA or GeneBank 
      format). If a directory, file name can be prepended to the label of each 
      translated peptide originally coming from that file by default (i.e., to 
      track the genome of origin) with the flag '--prepend-filename.'
    inputBinding:
      position: 101
      prefix: --data
  - id: log
    type:
      - 'null'
      - File
    doc: path to log file. Log not written by default.
    inputBinding:
      position: 101
      prefix: --log
  - id: prepend_filename
    type:
      - 'null'
      - boolean
    doc: whether to prepend file name to peptide sequences when a directory with
      multiple fasta or genbank files is used as input.
    inputBinding:
      position: 101
      prefix: --prepend-filename
  - id: processes
    type:
      - 'null'
      - int
    doc: set maximum number of processes. Defaults to all but one.
    inputBinding:
      position: 101
      prefix: --processes
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: path to output (labelled peptide database) file. Defaults to file in 
      directory of input data.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
