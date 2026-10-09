cwlVersion: v1.2
class: CommandLineTool
baseCommand: luciphor2
label: luciphor2
doc: "JAVA-based version of Luciphor (LucXor): scores the localization of post-translational modifications (such as phosphorylation) on peptide-spectrum matches and estimates the false localization rate.\n\nThe tool reads one input (configuration) file. Paths inside it (SPECTRUM_PATH, INPUT_DATA, OUTPUT_FILE) are relative to the working directory, so list the spectra and PSM files in data_files; they are staged beside the working directory (use SPECTRUM_PATH = . and INPUT_DATA = <file name>). Make a template with generate_template.\n\nTool homepage: http://luciphor2.sourceforge.net/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.data_files ? inputs.data_files : [])"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Luciphor2 input (configuration) file
    inputBinding:
      position: 1
  - id: generate_template
    type:
      - 'null'
      - boolean
    doc: Generate a luciphor2 input file template (luciphor2_input_template.txt)
    inputBinding:
      position: 0
      prefix: -t
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Spectrum files (MGF, mzML or mzXML) and PSM files (pepXML or tab-delimited) named in the input file; staged in the working directory
  - id: output_file
    type:
      - 'null'
      - string
    doc: Name given to OUTPUT_FILE in the input file, used to collect the result (default result name luciphor_results.<timestamp>.tsv is collected when unset)
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: Luciphor2 result table(s)
    outputBinding:
      glob: "$(inputs.output_file ? inputs.output_file : 'luciphor_results.*.tsv')"
  - id: matched_peaks
    type:
      type: array
      items: File
    doc: Matched peaks tables (written when WRITE_MATCHED_PEAKS_FILE = 1)
    outputBinding:
      glob: luciphor_matchedPks.*.tsv
  - id: input_template
    type:
      - 'null'
      - File
    doc: Input file template written by generate_template
    outputBinding:
      glob: luciphor2_input_template.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/luciphor2:2020_04_03--hdfd78af_1
stdout: luciphor2.out
