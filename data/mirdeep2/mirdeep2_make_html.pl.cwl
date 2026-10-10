cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - make_html.pl
label: mirdeep2_make_html.pl
doc: "Create the miRDeep2 result html and csv files (and the read signature pdfs) from a miRDeep2 output.mrd file\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: time_stamp
    type: string
    doc: Timestamp of this run, used in all output names
    inputBinding:
      position: 101
      prefix: -y
  - id: mirdeep_output
    type:
      - 'null'
      - File
    doc: miRDeep2 output file (output.mrd)
    inputBinding:
      position: 102
      prefix: -f
  - id: min_score
    type:
      - 'null'
      - int
    doc: Only output hairpins with a score above this value
    inputBinding:
      position: 103
      prefix: -v
  - id: excel_overview
    type:
      - 'null'
      - boolean
    doc: Also create an overview in csv format
    inputBinding:
      position: 104
      prefix: -c
  - id: known_mirnas
    type:
      - 'null'
      - File
    doc: File with known miRNAs
    inputBinding:
      position: 105
      prefix: -k
  - id: survey_file
    type:
      - 'null'
      - File
    doc: Survey file, used when a score cutoff is given, to report how confident the resulting reads are
    inputBinding:
      position: 106
      prefix: -s
  - id: complete_survey
    type:
      - 'null'
      - boolean
    doc: Report the complete survey file
    inputBinding:
      position: 107
      prefix: -e
  - id: survey_for_cutoff
    type:
      - 'null'
      - string
    doc: Report the survey for the current score cutoff; the script reads a value after -g, any non-empty value switches it on
    inputBinding:
      position: 108
      prefix: -g
  - id: rfam_file
    type:
      - 'null'
      - File
    doc: Rfam file to check for already reported small RNA sequences (builds a bowtie index in the script folder)
    inputBinding:
      position: 109
      prefix: -r
  - id: quantifier_mrd
    type:
      - 'null'
      - File
    doc: miRBase.mrd file produced by the quantifier module
    inputBinding:
      position: 110
      prefix: -q
  - id: signature_arf
    type:
      - 'null'
      - File
    doc: signature.arf file with reads mapped to precursors (needs quantifier_mrd)
    inputBinding:
      position: 111
      prefix: -x
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism the sequencing data come from (UCSC name such as C.elegans)
    inputBinding:
      position: 112
      prefix: -t
  - id: list_organisms
    type:
      - 'null'
      - boolean
    doc: Print all available UCSC organisms
    inputBinding:
      position: 113
      prefix: -u
  - id: sort_by_sample
    type:
      - 'null'
      - boolean
    doc: Sort the signature by sample in the pdf file; default is by beginning position
    inputBinding:
      position: 114
      prefix: -o
  - id: no_pdfs
    type:
      - 'null'
      - boolean
    doc: Do not generate pdfs
    inputBinding:
      position: 115
      prefix: -d
  - id: mature_coordinates
    type:
      - 'null'
      - boolean
    doc: Print genomic coordinates of the mature sequence (still testing)
    inputBinding:
      position: 116
      prefix: -a
  - id: confidence_file
    type:
      - 'null'
      - File
    doc: File with confident ids
    inputBinding:
      position: 117
      prefix: -b
  - id: precursor_coords
    type:
      - 'null'
      - File
    doc: Precursor coordinates file written by the excise_precursors scripts
    inputBinding:
      position: 118
      prefix: -p
  - id: version
    type:
      - 'null'
      - string
    doc: miRDeep2 version shown in the report
    inputBinding:
      position: 119
      prefix: -V
  - id: quantifier_only
    type:
      - 'null'
      - boolean
    doc: Quantifier module was used alone
    inputBinding:
      position: 120
      prefix: -z
  - id: read_error_messages
    type:
      - 'null'
      - boolean
    doc: Read error messages of the miRDeep2 run (error.output.mrd next to the survey file)
    inputBinding:
      position: 121
      prefix: -E
  - id: expression_analyses
    type:
      - 'null'
      - Directory
    doc: The expression_analyses folder written by quantifier.pl (holds expression_analyses_<time_stamp>); it is staged writable in the working directory
  - id: run_directory
    type:
      - 'null'
      - Directory
    doc: Run folder of miRDeep2 (mirdeep_runs/run_<time_stamp>), staged writable under that name
outputs:
  - id: result_html
    type:
      - 'null'
      - File
    doc: miRDeep2 result page
    outputBinding:
      glob: result_$(inputs.time_stamp).html
  - id: result_csv
    type:
      - 'null'
      - File
    doc: miRDeep2 result table
    outputBinding:
      glob: result_$(inputs.time_stamp).csv
  - id: pdf_directory
    type:
      - 'null'
      - Directory
    doc: Structure and read signature pdfs (without no_pdfs)
    outputBinding:
      glob: pdfs_$(inputs.time_stamp)
  - id: expression_analyses_out
    type:
      - 'null'
      - Directory
    doc: The staged expression_analyses folder, including the files written by the script (expression_<time_stamp>.html)
    outputBinding:
      glob: expression_analyses
  - id: stderr
    type: stderr
    doc: Progress messages
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.expression_analyses) {
          l.push({entry: inputs.expression_analyses, entryname: "expression_analyses", writable: true});
        }
        if (inputs.run_directory) {
          l.push({entry: inputs.run_directory, entryname: "mirdeep_runs/run_" + inputs.time_stamp, writable: true});
        }

        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stderr: make_html.err
