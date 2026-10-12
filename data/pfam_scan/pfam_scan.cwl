cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfam_scan.pl
label: pfam_scan
doc: "Search a FASTA file against a library of Pfam HMMs.\n\nTool homepage: http://ftp.ebi.ac.uk/pub/databases/Pfam/Tools/"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file to scan
    inputBinding:
      position: 101
      prefix: -fasta
  - id: database_dir
    type: Directory
    doc: Directory location of the Pfam files (Pfam-A.hmm pressed with hmmpress,
      Pfam-A.hmm.dat, optionally active_site.dat)
    inputBinding:
      position: 101
      prefix: -dir
  - id: outfile
    type:
      - 'null'
      - string
    doc: Output file name, otherwise the result goes to standard output
    inputBinding:
      position: 101
      prefix: -outfile
  - id: clan_overlap
    type:
      - 'null'
      - boolean
    doc: Show overlapping hits within clan member families (applies to Pfam-A
      families only)
    inputBinding:
      position: 101
      prefix: -clan_overlap
  - id: align
    type:
      - 'null'
      - boolean
    doc: Show the HMM-sequence alignment for each match
    inputBinding:
      position: 101
      prefix: -align
  - id: e_seq
    type:
      - 'null'
      - float
    doc: Hmmscan E-value sequence cutoff for Pfam-A searches (default Pfam defined)
    inputBinding:
      position: 101
      prefix: -e_seq
  - id: e_dom
    type:
      - 'null'
      - float
    doc: Hmmscan E-value domain cutoff for Pfam-A searches (default Pfam defined)
    inputBinding:
      position: 101
      prefix: -e_dom
  - id: b_seq
    type:
      - 'null'
      - float
    doc: Hmmscan bit score sequence cutoff for Pfam-A searches (default Pfam defined)
    inputBinding:
      position: 101
      prefix: -b_seq
  - id: b_dom
    type:
      - 'null'
      - float
    doc: Hmmscan bit score domain cutoff for Pfam-A searches (default Pfam defined)
    inputBinding:
      position: 101
      prefix: -b_dom
  - id: predict_active_sites
    type:
      - 'null'
      - boolean
    doc: Predict active site residues for Pfam-A matches
    inputBinding:
      position: 101
      prefix: -as
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write results in JSON format
    inputBinding:
      position: 101
      prefix: -json
  - id: json_pretty
    type:
      - 'null'
      - boolean
    doc: Write results in JSON format, formatted with the "pretty" option of the
      JSON module (-json pretty)
    inputBinding:
      position: 101
      prefix: -json
      valueFrom: "$(self ? 'pretty' : null)"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel CPU workers to use for multithreads (default all)
    inputBinding:
      position: 101
      prefix: -cpu
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Treat sequence as DNA and perform six-frame translation before searching;
      reports ORFs longer than 20 residues
    inputBinding:
      position: 101
      prefix: -translate
  - id: translate_mode
    type:
      - 'null'
      - string
    doc: Six-frame translation mode, either "all" (translate everything, no
      individual ORFs) or "orf" (report only ORFs longer than 20 residues)
    inputBinding:
      position: 101
      prefix: -translate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the result when -outfile is not used
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result file written with -outfile
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pfam_scan:1.6--hdfd78af_5
stdout: pfam_scan.out
