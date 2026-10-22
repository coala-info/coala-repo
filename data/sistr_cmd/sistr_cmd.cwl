cwlVersion: v1.2
class: CommandLineTool
baseCommand: sistr
label: sistr_cmd
doc: "Salmonella In Silico Typing Resource (SISTR) command line tool for serovar prediction
  from whole-genome sequence data.\n\nTool homepage: https://github.com/phac-nml/sistr_cmd/"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: named_fasta
        type: record
        fields:
          - name: fasta_path
            type: File
            inputBinding:
              position: 1
          - name: genome_name
            type: string
            inputBinding:
              position: 2
inputs:
  - id: input_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: Input genome FASTA file(s)
    inputBinding:
      position: 101
  - id: input_fasta_genome_name
    type:
      - 'null'
      - named_fasta
    doc: Fasta file path and genome name pair
    inputBinding:
      position: 1
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (json, csv, tab, pickle)
    inputBinding:
      position: 1
      prefix: --output-format
  - id: more_results
    type:
      - 'null'
      - boolean
    doc: Output more detailed results (-M) and all antigen search blastn results (-MM)
    inputBinding:
      position: 1
      prefix: --more-results
  - id: cgmlst_profiles_path
    type:
      - 'null'
      - string
    doc: Output CSV file destination for cgMLST allelic profiles
    inputBinding:
      position: 1
      prefix: --cgmlst-profiles
  - id: novel_alleles_path
    type:
      - 'null'
      - string
    doc: Output FASTA file destination of novel cgMLST alleles from input genomes
    inputBinding:
      position: 1
      prefix: --novel-alleles
  - id: alleles_output_path
    type:
      - 'null'
      - string
    doc: Output path of allele sequences and info to JSON
    inputBinding:
      position: 1
      prefix: --alleles-output
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Base temporary working directory for intermediate analysis files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary analysis files.
    inputBinding:
      position: 1
      prefix: --keep-tmp
  - id: use_full_cgmlst_db
    type:
      - 'null'
      - boolean
    doc: Use the full set of cgMLST alleles which can include highly similar alleles. By default the smaller centroid alleles are used for each marker.
    inputBinding:
      position: 1
      prefix: --use-full-cgmlst-db
  - id: no_cgmlst
    type:
      - 'null'
      - boolean
    doc: Do not run cgMLST serovar prediction
    inputBinding:
      position: 1
      prefix: --no-cgmlst
  - id: run_mash
    type:
      - 'null'
      - boolean
    doc: Determine Mash MinHash genomic distances to Salmonella genomes with trusted serovar designations.
    inputBinding:
      position: 1
      prefix: --run-mash
  - id: qc
    type:
      - 'null'
      - boolean
    doc: Perform basic QC to provide level of confidence in serovar prediction results.
    inputBinding:
      position: 1
      prefix: --qc
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to run sistr_cmd analysis.
    inputBinding:
      position: 1
      prefix: --threads
  - id: list_of_serovars
    type:
      - 'null'
      - File
    doc: A single column text file containing a list of serovars to check the SISTR serovar prediction against.
    inputBinding:
      position: 1
      prefix: --list-of-serovars
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Logging verbosity level (-v shows warnings)
    inputBinding:
      position: 1
      prefix: --verbose
  - id: output_prediction_path
    type: string
    doc: SISTR serovar prediction output path
    inputBinding:
      position: 1
      prefix: --output-prediction
outputs:
  - id: output_prediction
    type: File
    doc: Output file for prediction results (the tool appends the output format as extension, e.g. .json, unless the path already contains it).
    outputBinding:
      glob: $(inputs.output_prediction_path)*
  - id: cgmlst_profiles
    type:
      - 'null'
      - File
    doc: cgMLST allelic profiles
    outputBinding:
      glob: $(inputs.cgmlst_profiles_path)
  - id: novel_alleles
    type:
      - 'null'
      - File
    doc: Novel cgMLST alleles from input genomes
    outputBinding:
      glob: $(inputs.novel_alleles_path)
  - id: alleles_output
    type:
      - 'null'
      - File
    doc: Allele sequences and info in JSON
    outputBinding:
      glob: $(inputs.alleles_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sistr_cmd:1.1.3--pyhdc42f0e_2
