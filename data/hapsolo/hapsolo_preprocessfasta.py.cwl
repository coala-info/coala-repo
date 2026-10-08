cwlVersion: v1.2
class: CommandLineTool
baseCommand: preprocessfasta.py
label: hapsolo_preprocessfasta.py
doc: "Preprocess FASTA file and outputs a clean FASTA and seperates contigs based
  on unique headers. Removes special chars\n\nTool homepage: https://github.com/esolares/HapSolo"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file (staged in the working directory; the tool writes <name>_new.fasta and a contigs folder next to its input path)
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
  - id: max_contig_size
    type:
      - 'null'
      - float
    doc: Max size of contig in Mb to output in contigs folder.
    inputBinding:
      position: 101
      prefix: --maxcontig
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: clean_fasta
    type:
      - 'null'
      - File
    doc: Cleaned FASTA file (<input name>_new.fasta)
    outputBinding:
      glob: '*_new.fasta'
  - id: contigs
    type:
      - 'null'
      - Directory
    doc: Folder with one FASTA file per contig
    outputBinding:
      glob: contigs
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
stdout: hapsolo_preprocessfasta.py.out
