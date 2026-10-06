cwlVersion: v1.2
class: CommandLineTool
baseCommand: AssemblyStatistics
label: assemblyutility_AssemblyStatistics
doc: "Calculate assembly statistics (total length, longest contig, N10-N100) for a FASTA/FASTQ
  file or a list of contig lengths. Writes <input>Stats.txt and <input>Stats_10k_5k_1k.txt
  beside the input.\n\nTool homepage: https://github.com/yechengxi/AssemblyUtility"
inputs:
  - id: contigs_filename
    type: File
    doc: The input contigs file (FASTA or FASTQ), or a text file with one contig length per line.
    inputBinding:
      position: 1
      prefix: contigs
      valueFrom: $(self.basename)
  - id: cut_off_length
    type:
      - 'null'
      - int
    doc: Only contigs longer than this length are counted (default 100).
    inputBinding:
      position: 2
      prefix: LenTh
  - id: genome_size
    type:
      - 'null'
      - long
    doc: Estimated genome size, used to report NG statistics.
    inputBinding:
      position: 3
      prefix: GS
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stats
    type: File
    doc: Statistics report (total length, longest contig, N10-N100)
    outputBinding:
      glob: $(inputs.contigs_filename.basename)Stats.txt
  - id: stats_bins
    type: File
    doc: Counts and lengths of contigs above 10k, 5k and 1k
    outputBinding:
      glob: $(inputs.contigs_filename.basename)Stats_10k_5k_1k.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.contigs_filename)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
stdout: assemblyutility_AssemblyStatistics.out
