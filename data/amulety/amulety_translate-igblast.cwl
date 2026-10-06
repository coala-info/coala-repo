cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amulety
  - translate-igblast
label: amulety_translate-igblast
doc: "Translates nucleotide sequences to amino acid sequences using IgBlast. It reads an AIRR rearrangement TSV file, runs IgBlast on the nucleotide sequences and saves the translated data into a new TSV file in the output directory.\n\nTool homepage: https://github.com/immcantation/amulety"
inputs:
  - id: input_file
    type: File
    doc: The path to the input data file. The data file should be in TSV format following the AIRR specifications.
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_dir
    type: string
    doc: The directory where the translated AIRR file will be saved.
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: reference_dir
    type: Directory
    doc: The directory to the igblast references.
    inputBinding:
      position: 1
      prefix: --reference-dir
  - id: keep_regions
    type: ['null', boolean]
    doc: If True, keeps the region translations in the output airr file. If False, it removes them.
    inputBinding:
      position: 1
      prefix: --keep-regions
  - id: sequence_col
    type: ['null', string]
    doc: 'The name of the column containing the nucleotide sequences to translate. [default: sequence]'
    inputBinding:
      position: 1
      prefix: --sequence-col
  - id: nproc
    type: ['null', int]
    doc: 'Number of processors to use for IgBlast. [default: 1]'
    inputBinding:
      position: 1
      prefix: --nproc
  - id: log_file
    type: ['null', string]
    doc: Path to log file. If not provided, logs will be printed to stdout.
    inputBinding:
      position: 1
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose logging (DEBUG level).
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: translated_airr
    type: File
    doc: AIRR rearrangement TSV with the IgBlast amino acid translations (<input name>_translated.tsv)
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.input_file.nameroot)_translated.tsv
  - id: log
    type: ['null', File]
    doc: Log file, when --log-file is given
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return {"class": "Directory", "basename": inputs.output_dir, "listing": [], "writable": true}; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
