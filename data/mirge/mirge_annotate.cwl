cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miRge2.0
  - annotate
label: mirge_annotate
doc: "Annotate the reads from miRNA sequencing data\n\nTool homepage: https://github.com/mhalushka/miRge"
inputs:
  - id: samples
    type:
      type: array
      items: File
    doc: Sample files (*.fastq or *.fastq.gz). A single file where each row is one sample name is also accepted.
    inputBinding:
      position: 101
      prefix: -s
  - id: outdir_path
    type:
      - 'null'
      - string
    default: miRge_output
    doc: "Directory of the outputs"
    inputBinding:
      position: 101
      prefix: -o
  - id: mirna_database
    type:
      - 'null'
      - string
    default: miRBase
    doc: "The miRNA database (miRBase, or miRGeneDB)"
    inputBinding:
      position: 101
      prefix: -d
  - id: bowtie_path
    type:
      - 'null'
      - string
    default: /usr/local/bin
    doc: "Path to the system's bowtie binary directory"
    inputBinding:
      position: 101
      prefix: -pb
  - id: library_dir
    type: Directory
    doc: "Path to the miRge libraries (the folder that holds the species folder with index.Libs, fasta.Libs and annotation.Libs)"
    inputBinding:
      position: 101
      prefix: -lib
  - id: species
    type: string
    doc: "The species: human, mouse, fruitfly, nematode, rat or zebrafish (novel miRNA detection is confined to human and mouse)"
    inputBinding:
      position: 101
      prefix: -sp
  - id: canonical_proportion
    type:
      - 'null'
      - float
    doc: "Threshold of the proportion of canonical reads for the miRNAs to be kept when counting, between 0 and 0.5 (default 0.1)"
    inputBinding:
      position: 101
      prefix: -ex
  - id: adapter
    type:
      - 'null'
      - string
    doc: "The adapter to remove: illumina, ion or a defined sequence (default none)"
    inputBinding:
      position: 101
      prefix: -ad
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: "Phred64 format"
    inputBinding:
      position: 101
      prefix: -phred64
  - id: spike_in
    type:
      - 'null'
      - boolean
    doc: "Annotate spike-ins if the bowtie index files are located at the path of bowtie index files"
    inputBinding:
      position: 101
      prefix: -spikeIn
  - id: write_trimmed_collapsed_fasta
    type:
      - 'null'
      - boolean
    doc: "Write trimmed and collapsed fasta file"
    inputBinding:
      position: 101
      prefix: -tcf
  - id: isomir_entropy
    type:
      - 'null'
      - boolean
    doc: "Calculate isomir entropy"
    inputBinding:
      position: 101
      prefix: -di
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of processors to use for trimming, qc and alignment (default 1)"
    inputBinding:
      position: 101
      prefix: -cpu
  - id: a_to_i_editing
    type:
      - 'null'
      - boolean
    doc: "Calculate A to I editing"
    inputBinding:
      position: 101
      prefix: -ai
  - id: gff_output
    type:
      - 'null'
      - boolean
    doc: "Output results in gff format"
    inputBinding:
      position: 101
      prefix: -gff
  - id: trna_fragments
    type:
      - 'null'
      - boolean
    doc: "Analyze tRNA fragments"
    inputBinding:
      position: 101
      prefix: -trf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the results
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge:2.0.6--py27_4
stdout: mirge_annotate.out
