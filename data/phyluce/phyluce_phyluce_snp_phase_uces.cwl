cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_phase_uces
label: phyluce_phyluce_snp_phase_uces
doc: "Phase reads in a BAM file into two separate alleles. Then produce a consensus sequence for each allele.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
arguments:
  - position: 100
    shellQuote: false
    valueFrom: '&& for f in $(inputs.output)/fastas/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm -f "$f"; cp "$t" "$f"; fi; done'
inputs:
  - id: config
    type: File
    doc: "A configuration file containing the reference-to-read sample mapping and some metadata"
    inputBinding:
      position: 1
      prefix: --config
  - id: staged_files
    type:
      - type: array
        items: File
    doc: "Reference FASTA files named in the [references] section of the configuration file. They are copied into the working directory under their own names, so write them in the configuration file as plain file names."
  - id: bams
    type: Directory
    doc: "The directory containing sample-specific BAM files"
    inputBinding:
      position: 2
      prefix: --bams
  - id: output
    type: string
    doc: "The directory in which to store the SNPs files"
    inputBinding:
      position: 3
      prefix: --output
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: "Use this flag if you want to discard all base calls with limited certainty (covered by <3 reads). This will produce the ambiguity character \"N\" instead of that potential base call in the final sequence."
    inputBinding:
      position: 4
      prefix: --conservative
  - id: cores
    type:
      - 'null'
      - int
    doc: "For parallel processing you can choose the number of cores you want CLC to run on."
    inputBinding:
      position: 5
      prefix: --cores
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 6
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 7
      prefix: --log-path
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: output_dir
    type: Directory
    doc: "The output directory with one folder per sample and the fastas folder of cleaned, balanced allele FASTA files (including joined_allele_sequences_all_samples.fasta)."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
      - '$(inputs.staged_files.map(function(f) { return {"entry": f, "entryname": f.basename, "writable": true}; }))'
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
