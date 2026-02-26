cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngmaster
label: ngmaster
doc: "In silico multi-antigen sequence typing for Neisseria gonorrhoeae (NG-MAST)
  and Neisseria gonorrhoeae Sequence Typing for Antimicrobial Resistance (NG-STAR)\n\
  \nTool homepage: https://github.com/MDU-PHL/ngmaster"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: input FASTA files eg. fasta1, fasta2, fasta3 ... fastaN
    inputBinding:
      position: 1
  - id: assumeyes
    type:
      - 'null'
      - boolean
    doc: assume you are certain you wish to update db
    inputBinding:
      position: 102
      prefix: --assumeyes
  - id: comments
    type:
      - 'null'
      - boolean
    doc: Include NG-STAR comments for each allele in output
    inputBinding:
      position: 102
      prefix: --comments
  - id: csv
    type:
      - 'null'
      - boolean
    doc: output comma-separated format (CSV) rather than tab-separated
    inputBinding:
      position: 102
      prefix: --csv
  - id: db
    type:
      - 'null'
      - Directory
    doc: "specify custom directory containing allele databases\ndirectory must contain
      database sequence files (.tfa) and allele profile files (ngmast.txt / ngstar.txt)\n\
      in mlst format (see <https://github.com/tseemann/mlst#adding-a-new-scheme>)"
    inputBinding:
      position: 102
      prefix: --db
  - id: mincov
    type:
      - 'null'
      - float
    doc: DNA percent coverage to report partial allele at [?]
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minid
    type:
      - 'null'
      - float
    doc: DNA percent identity of full allele to consider 'similar' [~]
    inputBinding:
      position: 102
      prefix: --minid
  - id: test
    type:
      - 'null'
      - boolean
    doc: run test example
    inputBinding:
      position: 102
      prefix: --test
  - id: updatedb
    type:
      - 'null'
      - boolean
    doc: update NG-MAST and NG-STAR allele databases from 
      <https://rest.pubmlst.org/db/pubmlst_neisseria_seqdef>
    inputBinding:
      position: 102
      prefix: --updatedb
outputs:
  - id: printseq
    type:
      - 'null'
      - File
    doc: specify filename to save allele sequences to
    outputBinding:
      glob: $(inputs.printseq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmaster:1.1.1--pyhdfd78af_1
