cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - make_html2.pl
label: mirdeep2_make_html2.pl
doc: "Create the miRDeep2 expression html page of the quantifier module (variant of make_html.pl that reports the expression of known miRNAs)\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: time_stamp
    type: string
    doc: Timestamp of this run, used in all output names
    inputBinding:
      position: 101
      prefix: -y
  - id: quantifier_mrd
    type:
      - 'null'
      - File
    doc: miRBase.mrd file produced by the quantifier module
    inputBinding:
      position: 102
      prefix: -q
  - id: known_mirnas
    type:
      - 'null'
      - File
    doc: File with known miRNAs
    inputBinding:
      position: 103
      prefix: -k
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism the sequencing data come from (UCSC name such as worm or C.elegans)
    inputBinding:
      position: 104
      prefix: -t
  - id: mapped_arf
    type:
      - 'null'
      - File
    doc: Mature miRNAs mapped to precursors (arf file)
    inputBinding:
      position: 105
      prefix: -i
  - id: star_mapped_arf
    type:
      - 'null'
      - File
    doc: Star sequences mapped to mature sequences (arf file)
    inputBinding:
      position: 106
      prefix: -j
  - id: species_pattern
    type:
      - 'null'
      - string
    doc: Species prefix of the miRNA ids to report, for example cel
    inputBinding:
      position: 107
      prefix: -m
  - id: expression_files
    type:
      - 'null'
      - type: array
        items: File
    doc: miRNA expression files of the samples (miRNAs_expressed_all_samples_<time>.csv); staged in the working directory and passed as a comma separated list
    inputBinding:
      position: 108
      prefix: -M
      valueFrom: "$(self.map(function(f){return f.basename}).join(\",\"))"
  - id: mirdeep_output
    type:
      - 'null'
      - File
    doc: miRDeep2 output file (output.mrd)
    inputBinding:
      position: 109
      prefix: -f
  - id: min_score
    type:
      - 'null'
      - int
    doc: Only output hairpins with a score above this value
    inputBinding:
      position: 110
      prefix: -v
  - id: excel_overview
    type:
      - 'null'
      - boolean
    doc: Also create an overview in csv format
    inputBinding:
      position: 111
      prefix: -c
  - id: survey_file
    type:
      - 'null'
      - File
    doc: Survey file, used when a score cutoff is given
    inputBinding:
      position: 112
      prefix: -s
  - id: complete_survey
    type:
      - 'null'
      - boolean
    doc: Report the complete survey file
    inputBinding:
      position: 113
      prefix: -e
  - id: survey_for_cutoff
    type:
      - 'null'
      - string
    doc: Report the survey for the current score cutoff; the script reads a value after -g, any non-empty value switches it on
    inputBinding:
      position: 114
      prefix: -g
  - id: rfam_file
    type:
      - 'null'
      - File
    doc: Rfam file to check for already reported small RNA sequences
    inputBinding:
      position: 115
      prefix: -r
  - id: signature_arf
    type:
      - 'null'
      - File
    doc: signature.arf file with reads mapped to precursors (needs quantifier_mrd)
    inputBinding:
      position: 116
      prefix: -x
  - id: list_organisms
    type:
      - 'null'
      - boolean
    doc: Print all available UCSC organisms
    inputBinding:
      position: 117
      prefix: -u
  - id: sort_by_sample
    type:
      - 'null'
      - boolean
    doc: Sort the signature by sample in the pdf file
    inputBinding:
      position: 118
      prefix: -o
  - id: no_pdfs
    type:
      - 'null'
      - boolean
    doc: Do not generate pdfs
    inputBinding:
      position: 119
      prefix: -d
  - id: mature_coordinates
    type:
      - 'null'
      - boolean
    doc: Print genomic coordinates of the mature sequence (still testing)
    inputBinding:
      position: 120
      prefix: -a
  - id: confidence_file
    type:
      - 'null'
      - File
    doc: File with confident ids
    inputBinding:
      position: 121
      prefix: -b
  - id: stringent_ids
    type:
      - 'null'
      - boolean
    doc: Be stringent when assigning miRNA-precursor connections, for example mmu-mir is only assigned to mmu-precursor
    inputBinding:
      position: 122
      prefix: -l
  - id: pdf_link_path
    type:
      - 'null'
      - string
    doc: Path used for the pdf links when running on a cluster
    inputBinding:
      position: 123
      prefix: -w
  - id: mirbase_v18_ids
    type:
      - 'null'
      - boolean
    doc: Report 5p and 3p counts of miRBase v18 style ids together
    inputBinding:
      position: 124
      prefix: -P
  - id: weights_file
    type:
      - 'null'
      - File
    doc: File with a weight for each read id; read counts are divided by it
    inputBinding:
      position: 125
      prefix: -W
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
  - id: expression_analyses_out
    type:
      - 'null'
      - Directory
    doc: The staged expression_analyses folder, including the files written by the script (expression_<time_stamp>.html)
    outputBinding:
      glob: expression_analyses
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
    doc: Read signature pdfs (without no_pdfs)
    outputBinding:
      glob: pdfs_$(inputs.time_stamp)
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
        if (inputs.expression_files) {
          for (var i = 0; i < inputs.expression_files.length; i++) { l.push(inputs.expression_files[i]); }
        }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stderr: make_html2.err
