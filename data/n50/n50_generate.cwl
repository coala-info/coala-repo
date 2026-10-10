cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50_generate
label: n50_generate
doc: "Generate reads with n50_simreads from a read length distribution (CSV with a length,count header, as made by n50_binner).\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: input_file
    type: File
    doc: "Input file path (CSV with the columns length,count)"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: outdir
    type: string
    doc: "Output directory (must exist, so it is created before the run)"
    inputBinding:
      position: 2
      prefix: "-o"
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format (FASTQ by default, FASTA also supported)"
    inputBinding:
      position: 3
      prefix: "-f"
  - id: simreads_path
    type:
      - 'null'
      - string
    doc: "Path to the n50_simreads executable (the default ./n50_simreads is not on the path in the container, so n50_simreads is used)"
    default: n50_simreads
    inputBinding:
      position: 4
      prefix: "-s"
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the simulated reads
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
stdout: n50_generate.out
