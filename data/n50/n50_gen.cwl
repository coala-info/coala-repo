cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen
label: n50_gen
doc: "Generate random DNA sequences in FASTA or FASTQ files with varying lengths; file names contain N50, number of sequences and total length.\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: min_seqs
    type: int
    doc: "Minimum number of sequences per file"
    inputBinding:
      position: 1
  - id: max_seqs
    type: int
    doc: "Maximum number of sequences per file"
    inputBinding:
      position: 2
  - id: min_len
    type: int
    doc: "Minimum length of each sequence"
    inputBinding:
      position: 3
  - id: max_len
    type: int
    doc: "Maximum length of each sequence"
    inputBinding:
      position: 4
  - id: tot_files
    type: int
    doc: "Total number of files to generate"
    inputBinding:
      position: 5
  - id: format
    type: string
    doc: "Output format (fasta or fastq)"
    inputBinding:
      position: 6
  - id: outdir
    type: string
    doc: "Directory to store the output files (must exist, so it is created before the run)"
    inputBinding:
      position: 7
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the generated files (named N50_TOTSEQS_SUMLEN.fasta or .fastq)
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_gen.out
