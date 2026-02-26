cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotcritic
label: plotcritic
doc: "Deploy a website for image curation\n\nTool homepage: https://github.com/jbelyeu/PlotCritic"
inputs:
  - id: curation_answers
    type:
      type: array
      items: string
    doc: "colon-separated key,values pairs of 1-letter codes and associated curation
      answers for the curation question (i.e: 'key1','value1' 'key2','value2')."
    default: None
    inputBinding:
      position: 101
      prefix: --curation_answers
  - id: curation_question
    type: string
    doc: The curation question to show in the PlotCritic website.
    default: None
    inputBinding:
      position: 101
      prefix: --curation_question
  - id: images_dir
    type: Directory
    doc: directory of images and metadata files for curation
    default: None
    inputBinding:
      position: 101
      prefix: --images_dir
  - id: project
    type: string
    doc: Unique name for the project
    default: None
    inputBinding:
      position: 101
      prefix: --project
  - id: report_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: space-separated list of info fields about the image. If omitted, only 
      the image name will be included in report
    default: None
    inputBinding:
      position: 101
      prefix: --report_fields
  - id: summary_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: subset of the report fields that will be shown in the web report after 
      scoring.Space-separated. If omitted, only the image name will be included 
      in report
    default: None
    inputBinding:
      position: 101
      prefix: --summary_fields
  - id: use_samplot_defaults
    type:
      - 'null'
      - boolean
    doc: "Use samplot-oriented default reporting_fields and summary_fields. Ignores
      `--summary_fields` and `--reporting_fields`. Default reporting fields: Image,
      chrom, start, end, sv_type, reference, bams, titles, output_file, transcript_file,
      window, max_depth\n                        Default summary fields: Image, chrom,
      start, end, sv_type"
    default: false
    inputBinding:
      position: 101
      prefix: --use_samplot_defaults
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotcritic:1.0.1--pyh5e36f6f_0
stdout: plotcritic.out
