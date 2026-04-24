cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -Xmx2G
  - -jar
  - pepquery.jar
label: pepquery
doc: "A tool for peptide-centric identification and validation of proteomics data.\n
  \nTool homepage: https://github.com/bzhanglab/PepQuery"
inputs:
  - id: aa_substitution
    type:
      - 'null'
      - boolean
    doc: Whether or not to consider aa substitution modifications when perform modification
      filtering.
    inputBinding:
      position: 101
      prefix: -aa
  - id: annotation_folder
    type:
      - 'null'
      - Directory
    doc: Annotation files folder for VCF/BED/GTF.
    inputBinding:
      position: 101
      prefix: -anno
  - id: cpu
    type:
      - 'null'
      - int
    doc: The number of cpus used.
    inputBinding:
      position: 101
      prefix: -cpu
  - id: data_converter_path
    type:
      - 'null'
      - File
    doc: Tool path for Raw MS/MS data conversion.
    inputBinding:
      position: 101
      prefix: -dc
  - id: dataset_id
    type:
      - 'null'
      - string
    doc: MS/MS dataset ID(s) from PepQueryDB or public repositories (PRIDE, MassIVE,
      etc.).
    inputBinding:
      position: 101
      prefix: -b
  - id: decoy
    type:
      - 'null'
      - boolean
    doc: In known protein identification mode, try to identity the decoy version of
      the selected target protein.
    inputBinding:
      position: 101
      prefix: -decoy
  - id: enzyme
    type:
      - 'null'
      - int
    doc: Enzyme used for protein digestion (0:Non enzyme, 1:Trypsin, etc.).
    inputBinding:
      position: 101
      prefix: -e
  - id: extra_score
    type:
      - 'null'
      - boolean
    doc: Add extra score validation (use two scoring algorithms).
    inputBinding:
      position: 101
      prefix: -x
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: Choose to use the fast mode for searching or not.
    inputBinding:
      position: 101
      prefix: -fast
  - id: fixed_mod
    type:
      - 'null'
      - string
    doc: Fixed modification format (e.g., 1,2,3).
    inputBinding:
      position: 101
      prefix: -fixMod
  - id: fragment_method
    type:
      - 'null'
      - int
    doc: '1: CID/HCD, 2: ETD.'
    inputBinding:
      position: 101
      prefix: -fragmentMethod
  - id: fragment_tolerance
    type:
      - 'null'
      - float
    doc: Fragment ion m/z tolerance in Da.
    inputBinding:
      position: 101
      prefix: -itol
  - id: frame
    type:
      - 'null'
      - string
    doc: The frame to translate DNA sequence to protein (e.g., '1,2,3').
    inputBinding:
      position: 101
      prefix: -frame
  - id: index_type
    type:
      - 'null'
      - int
    doc: 'Index type for MGF: 1 => index (1-based), 2 => spectrum title.'
    inputBinding:
      position: 101
      prefix: -indexType
  - id: input
    type: string
    doc: 'Input value: peptide sequence(s), file of sequences, protein sequence/ID,
      DNA sequence, VCF, BED, or GTF file.'
    inputBinding:
      position: 101
      prefix: -i
  - id: input_type
    type:
      - 'null'
      - string
    doc: 'Input type for parameter -i: peptide (pep), protein (pro), DNA (dna), VCF
      (vcf), BED (bed), or GTF (gtf).'
    inputBinding:
      position: 101
      prefix: -t
  - id: isotope_error_range
    type:
      - 'null'
      - string
    doc: Range of allowed isotope peak errors, such as '0,1'.
    inputBinding:
      position: 101
      prefix: -ti
  - id: max_charge
    type:
      - 'null'
      - int
    doc: The maximum charge to consider if the charge state is not available.
    inputBinding:
      position: 101
      prefix: -maxCharge
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum length of peptide to consider.
    inputBinding:
      position: 101
      prefix: -maxLength
  - id: max_missed_cleavages
    type:
      - 'null'
      - int
    doc: The max missed cleavages.
    inputBinding:
      position: 101
      prefix: -c
  - id: max_variable_mods
    type:
      - 'null'
      - int
    doc: Max number of variable modifications.
    inputBinding:
      position: 101
      prefix: -maxVar
  - id: min_charge
    type:
      - 'null'
      - int
    doc: The minimum charge to consider if the charge state is not available.
    inputBinding:
      position: 101
      prefix: -minCharge
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of peptide to consider.
    inputBinding:
      position: 101
      prefix: -minLength
  - id: min_peaks
    type:
      - 'null'
      - int
    doc: Min peaks in spectrum.
    inputBinding:
      position: 101
      prefix: -minPeaks
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score to consider for peptide searching.
    inputBinding:
      position: 101
      prefix: -minScore
  - id: ms_data
    type:
      - 'null'
      - File
    doc: MS/MS data used for identification (MGF, mzML, mzXML, raw, etc. or USI).
    inputBinding:
      position: 101
      prefix: -ms
  - id: parameter_set
    type:
      - 'null'
      - string
    doc: MS/MS searching parameter set name.
    inputBinding:
      position: 101
      prefix: -p
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate PSM annotation data for plot.
    inputBinding:
      position: 101
      prefix: -plot
  - id: print_ptm
    type:
      - 'null'
      - boolean
    doc: Print PTMs
    inputBinding:
      position: 101
      prefix: -printPTM
  - id: protein_db
    type:
      - 'null'
      - string
    doc: Protein reference database in FASTA format or online database string (e.g.,
      swissprot:human).
    inputBinding:
      position: 101
      prefix: -db
  - id: random_peptides
    type:
      - 'null'
      - int
    doc: The number of random peptides generated for p-value calculation.
    inputBinding:
      position: 101
      prefix: -n
  - id: scoring_method
    type:
      - 'null'
      - int
    doc: 'Scoring method: 1=HyperScore, 2=MVH.'
    inputBinding:
      position: 101
      prefix: -m
  - id: task_type
    type:
      - 'null'
      - int
    doc: 'Task type: 1 => novel peptide/protein validation, 2 => known peptide/protein
      validation.'
    inputBinding:
      position: 101
      prefix: -s
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Precursor ion m/z tolerance.
    inputBinding:
      position: 101
      prefix: -tol
  - id: tolerance_unit
    type:
      - 'null'
      - string
    doc: The unit of precursor ion m/z tolerance.
    inputBinding:
      position: 101
      prefix: -tolu
  - id: ums_stringent
    type:
      - 'null'
      - boolean
    doc: When perform validation with unrestricted modification searching (UMS), whether
      or not to use more stringent criterion.
    inputBinding:
      position: 101
      prefix: -hc
  - id: variable_mod
    type:
      - 'null'
      - string
    doc: Variable modification format.
    inputBinding:
      position: 101
      prefix: -varMod
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepquery:2.0.2--hdfd78af_0
