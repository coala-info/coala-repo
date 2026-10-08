cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - process_atac
label: dastk_process_atac
doc: "This script analyzes ATAC-Seq and GRO-Seq data and produces various plots for
  further data analysis.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: atac_peaks
    type: File
    doc: Full path to the ATAC-Seq broadPeak file.
    inputBinding:
      position: 101
      prefix: --atac-peaks
  - id: motif_path
    type: Directory
    doc: Folder with the motif sites (.bed, .BedGraph or .txt files) for the
      desired reference genome.
    inputBinding:
      position: 101
      prefix: --motif-path
  - id: radius
    type:
      - 'null'
      - int
    doc: Radius around BED regions for which to scan for motifs. Default = 1500
    inputBinding:
      position: 101
      prefix: --radius
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome to which the organism is mapped (e.g. hg38, mm10). Mutually
      exclusive with --chromosomes.
    inputBinding:
      position: 101
      prefix: --genome
  - id: chromosomes
    type:
      - 'null'
      - File
    doc: Chromosome size file. See README for details in generating this file.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use for multiprocessing of MD-score calculations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_dir
    type: string
    doc: Folder where the scores file will be saved (created by the wrapper).
      The file is named <peak file rootname>_md_scores.txt.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: md_scores
    type: File
    doc: MD scores of each motif file (<peak file rootname>_md_scores.txt)
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.atac_peaks.nameroot)_md_scores.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_process_atac.out
