cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_metabinner.sh
label: metabinner_run_metabinner.sh
doc: "Run the MetaBinner ensemble binning pipeline on an assembly, coverage profile and k-mer profile.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.contig_file)
        writable: true
inputs:
  - id: contig_file
    type: File
    doc: "Metagenomic assembly file; staged writable in the working directory because FragGeneScan writes files beside it"
    inputBinding:
      position: 1
      prefix: -a
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: output_dir
    type: string
    doc: "Output directory (created by the script; must not exist); the script changes directory, so the path is passed as an absolute path in the working directory"
    inputBinding:
      position: 2
      prefix: -o
      valueFrom: $(runtime.outdir)/$(self)
  - id: coverage_profile
    type: File
    doc: "coverage_profile.tsv; table with one row per contig and one column per sample, tab separated"
    inputBinding:
      position: 3
      prefix: -d
  - id: kmer_profile
    type: File
    doc: "kmer_profile.csv; table with one row per contig and one column per k-mer, comma separated"
    inputBinding:
      position: 4
      prefix: -k
  - id: path_to_metabinner
    type: string
    doc: "Path to MetaBinner; in this image the scripts are in <path>/scripts, so use /usr/local/bin"
    default: /usr/local/bin
    inputBinding:
      position: 5
      prefix: -p
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Number of threads (default=1)"
    inputBinding:
      position: 6
      prefix: -t
  - id: dataset_scale
    type: 
      - 'null'
      - string
    doc: "Dataset scale; eg. small,large,huge (default=large)"
    inputBinding:
      position: 7
      prefix: -s
outputs:
  - id: output
    type: Directory
    doc: "Output directory with metabinner_res/metabinner_result.tsv"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: run_metabinner.out
stderr: run_metabinner.log
