cwlVersion: v1.2
class: CommandLineTool
baseCommand: Filter_tooshort.py
label: metabinner_Filter_tooshort.py
doc: "Filters out contigs shorter than a given length from a FASTA file.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
inputs:
  - id: input_file
    type: File
    doc: "Input FASTA file; staged writable because the outputs are written beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: k
    type: int
    doc: "Minimum contig length: only contigs longer than K are kept"
    inputBinding:
      position: 2
outputs:
  - id: filtered_fasta
    type: File
    doc: "Contigs longer than K, written as <input name>_<K>.fa"
    outputBinding:
      glob: $(inputs.input_file.nameroot)_$(inputs.k).fa
  - id: contig_lengths
    type: File
    doc: "Contig names and lengths of the kept contigs"
    outputBinding:
      glob: contig_length_filter$(inputs.k).txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: Filter_tooshort.out
