cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miRge-build
label: mirge-build
doc: "miRge-build builds small-RNA libraries for an organism of choice, to use in the miRge3.0 pipeline\n\nTool homepage: https://github.com/mhalushka/miRge3_build"
inputs:
  - id: genome
    type: File
    doc: Genome file in fasta format (.fna, .fasta or .fa)
    inputBinding:
      position: 101
      prefix: --genome
  - id: mature_mir
    type: File
    doc: Mature miRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --mature-mir
  - id: hpin_mir
    type: File
    doc: Hairpin miRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --hpin-mir
  - id: mature_trna
    type: File
    doc: Mature tRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --mature-trna
  - id: pre_trna
    type: File
    doc: Precursor tRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --pre-trna
  - id: snorna
    type: File
    doc: snoRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --snorna
  - id: rrna
    type: File
    doc: rRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --rrna
  - id: ncrna_other
    type: File
    doc: All other non-coding RNA in fasta format
    inputBinding:
      position: 101
      prefix: --ncrna-other
  - id: mrna
    type: File
    doc: mRNA file in fasta format
    inputBinding:
      position: 101
      prefix: --mrna
  - id: spike_in
    type:
      - 'null'
      - File
    doc: User defined custom spike-in file in fasta format
    inputBinding:
      position: 101
      prefix: --spike-in
  - id: ann_gff
    type: File
    doc: miRNA annotation gff file
    inputBinding:
      position: 101
      prefix: --ann-gff
  - id: gen_repeats
    type:
      - 'null'
      - File
    doc: Genome repeats file with .gtf extension (optional; enables novel miRNA prediction in miRge3.0)
    inputBinding:
      position: 101
      prefix: --gen-repeats
  - id: mir_db
    type: string
    doc: Name of the database to be used (miRBase or miRGeneDB)
    inputBinding:
      position: 101
      prefix: --mir-DB
  - id: organism_name
    type: string
    doc: Name of the organism, one word, use _ as separator if necessary
    inputBinding:
      position: 101
      prefix: --organism-name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processors to use for trimming, qc, and alignment (default 1)
    inputBinding:
      position: 101
      prefix: --threads
  - id: bowtie_path
    type:
      - 'null'
      - string
    doc: Path to the directory containing the bowtie binary (required if bowtie is not in the path)
    inputBinding:
      position: 101
      prefix: --bowtie-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: library_directory
    type: Directory
    doc: Library folder named after the organism, with annotation.Libs, fasta.Libs and index.Libs
    outputBinding:
      glob: $(inputs.organism_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge-build:0.0.1--pyh3252c3a_0
stdout: mirge-build.out
