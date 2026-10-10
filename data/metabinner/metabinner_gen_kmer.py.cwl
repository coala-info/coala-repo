cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen_kmer.py
label: metabinner_gen_kmer.py
doc: "Generates the k-mer composition profile of contigs for MetaBinner.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
inputs:
  - id: fasta_file
    type: File
    doc: "Contigs in FASTA format; staged writable because the output is written beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: length_threshold
    type: int
    doc: "Minimum contig length: contigs of this length or shorter are skipped"
    inputBinding:
      position: 2
  - id: kmer_len
    type: int
    doc: "k-mer length (e.g. 4)"
    inputBinding:
      position: 3
outputs:
  - id: kmer_profile
    type: File
    doc: "k-mer composition profile (CSV), <name>_kmer_<k>_f<length>.csv"
    outputBinding:
      glob: $(inputs.fasta_file.nameroot)_kmer_$(inputs.kmer_len)_f$(inputs.length_threshold).csv
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: gen_kmer.out
