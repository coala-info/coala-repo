cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinkit_blast
label: metabinkit_metabinkit_blast
doc: "BLAST a fasta file against a reference database and add taxonomy information to the result table.\n\nTool homepage: https://github.com/envmetagen/metabinkit"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.db_files || []).forEach(function (f) { l.push({entryname: f.basename, entry: f}); });
        return l;
      }
inputs:
  - id: fasta_file
    type: File
    doc: "Query fasta file"
    inputBinding:
      position: 100
      prefix: -f
  - id: reference_db
    type: string
    doc: "Reference BLAST indexed database name (prefix of the database files staged with db_files)"
    inputBinding:
      position: 100
      prefix: -D
  - id: db_files
    type:
      type: array
      items: File
    doc: "BLAST database files of the reference database (.ndb, .nhr, .nin, .not, .nsq, .ntf, .nto, .njs, .nog, ...), staged in the working directory"
  - id: outfile
    type: string
    doc: "Output file name"
    inputBinding:
      position: 100
      prefix: -o
  - id: outformat
    type: 
      - 'null'
      - string
    doc: "output format (default: 6 qseqid evalue pident qcovs saccver staxid ssciname sseqid)"
    inputBinding:
      position: 100
      prefix: -O
  - id: taxdir
    type: 
      - 'null'
      - Directory
    doc: "folder with NCBI's taxonomy database (default: db folder of the image)"
    inputBinding:
      position: 100
      prefix: -T
  - id: threads
    type: 
      - 'null'
      - int
    doc: "maximum number of threads (default: 2)"
    inputBinding:
      position: 100
      prefix: -t
  - id: max_hsps
    type: 
      - 'null'
      - int
    doc: "BLAST's max_hsps parameter (default: 1)"
    inputBinding:
      position: 100
      prefix: -m
  - id: word_size
    type: 
      - 'null'
      - int
    doc: "BLAST's word_size parameter (default: 6)"
    inputBinding:
      position: 100
      prefix: -w
  - id: evalue
    type: 
      - 'null'
      - float
    doc: "BLAST's evalue parameter (default: 1)"
    inputBinding:
      position: 100
      prefix: -e
  - id: perc_identity
    type: 
      - 'null'
      - float
    doc: "BLAST's perc_identity parameter (default: 50)"
    inputBinding:
      position: 100
      prefix: -I
  - id: qcov_hsp_perc
    type: 
      - 'null'
      - float
    doc: "BLAST's qcov_hsp_perc parameter (default: 98)"
    inputBinding:
      position: 100
      prefix: -q
  - id: gapopen
    type: 
      - 'null'
      - int
    doc: "BLAST's gapopen parameter (default: 0)"
    inputBinding:
      position: 100
      prefix: -G
  - id: gapextend
    type: 
      - 'null'
      - int
    doc: "BLAST's gapextend parameter (default: 2)"
    inputBinding:
      position: 100
      prefix: -E
  - id: task
    type: 
      - 'null'
      - string
    doc: "BLAST's task parameter (default: blastn)"
    inputBinding:
      position: 100
      prefix: -X
  - id: reward
    type: 
      - 'null'
      - int
    doc: "BLAST's reward parameter (default: 1)"
    inputBinding:
      position: 100
      prefix: -r
  - id: penalty
    type: 
      - 'null'
      - int
    doc: "BLAST's penalty parameter (default: -1)"
    inputBinding:
      position: 100
      prefix: -p
  - id: max_target_seqs
    type: 
      - 'null'
      - int
    doc: "BLAST's max_target_seqs parameter (default: 100)"
    inputBinding:
      position: 100
      prefix: -M
  - id: taxids_blacklist_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "restrict search to taxids not present in the files provided (comma separated on the command line); incompatible with taxids_positive_files"
    inputBinding:
      position: 100
      prefix: -N
      itemSeparator: ','
  - id: taxids_positive_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "restrict search to taxids present in the files provided (comma separated on the command line); incompatible with taxids_blacklist_files"
    inputBinding:
      position: 100
      prefix: -P
      itemSeparator: ','
outputs:
  - id: blast_table
    type: File
    doc: "BLAST result table"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
stdout: metabinkit_blast.out
stderr: metabinkit_blast.log
