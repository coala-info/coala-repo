cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBGraph2Pro
label: graph2pro-var_DBGraph2Pro
doc: "Graph2Pro: translate an assembly graph (SOAP edge files or FastG from MetaSPAdes
  or Megahit) into a peptide database for proteogenomic search.\n\nTool homepage:
  https://github.com/COL-IU/graph2pro-var"
inputs:
  - id: edge_file
    type:
      - 'null'
      - File
    doc: The input edge file name
    inputBinding:
      position: 101
      prefix: -e
  - id: edge_seq_file
    type: File
    doc: The input edge sequence (contig) file name; with -f or -S this is the assembly graph in FastG format
    inputBinding:
      position: 101
      prefix: -s
  - id: output_file
    type: string
    doc: Protein sequences file (base name only)
    inputBinding:
      position: 101
      prefix: -o
  - id: min_peptide_len
    type:
      - 'null'
      - int
    doc: minimum peptide length to be output (default 6)
    inputBinding:
      position: 101
      prefix: -p
  - id: max_peptide_len
    type:
      - 'null'
      - int
    doc: maximum peptide length to be output (default 50)
    inputBinding:
      position: 101
      prefix: -m
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: minimum contig length to be explored (longer contigs will be executed by FGS)
    inputBinding:
      position: 101
      prefix: -l
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: maximum sequence length (for memory allocation, default 3000)
    inputBinding:
      position: 101
      prefix: -L
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size (default 31)
    inputBinding:
      position: 101
      prefix: -k
  - id: mis_cleavage
    type:
      - 'null'
      - int
    doc: number of mis-cleavages (default 0)
    inputBinding:
      position: 101
      prefix: -c
  - id: max_depth
    type:
      - 'null'
      - int
    doc: maximum depth (default 10)
    inputBinding:
      position: 101
      prefix: -d
  - id: soap_mode
    type:
      - 'null'
      - boolean
    doc: SOAP when set (default off for SOAP2)
    inputBinding:
      position: 101
      prefix: -u
  - id: fastg_mode
    type:
      - 'null'
      - boolean
    doc: FastG when set (default off for SOAP2)
    inputBinding:
      position: 101
      prefix: -f
  - id: metaspades_fastg_output
    type:
      - 'null'
      - boolean
    doc: FastG output by MetaSPaDes when set (default off for SOAP2)
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: protein_file
    type: File
    doc: Peptide/protein sequences written to the base name given in output_file
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph2pro-var:1.0.0--0
stdout: graph2pro-var_DBGraph2Pro.out
