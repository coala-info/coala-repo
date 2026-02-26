cwlVersion: v1.2
class: CommandLineTool
baseCommand: pepnovo
label: pepnovo_PepNovo_bin
doc: "PepNovo+ - de Novo peptide sequencing and MS-Filter - spectal quality scoring,
  precursor mass correction and chage determination.\n\nTool homepage: https://github.com/jmchilton/pepnovo"
inputs:
  - id: correct_pm
    type:
      - 'null'
      - boolean
    doc: finds optimal precursor mass and charge values.
    inputBinding:
      position: 101
      prefix: -correct_pm
  - id: digest
    type:
      - 'null'
      - string
    doc: default TRYPSIN
    default: TRYPSIN
    inputBinding:
      position: 101
      prefix: -digest
  - id: filter_spectra
    type:
      - 'null'
      - type: array
        items: string
    doc: 'outputs MGF files for spectra that have a minimal qulaity score above *thresh*
      (it is recomended to use a value of 0.05-0.1). These MGF files will be sent
      to the directory given in out_dir and have a name with the prefix given in the
      third argument. NOTE: this option must be used in conjuction with  "-pmcsqs_only"
      the latter option will also correct the m/z value and assign a charge to the
      spectrum.'
    inputBinding:
      position: 101
      prefix: -filter_spectra
  - id: fragment_tolerance
    type:
      - 'null'
      - float
    doc: the fragment tolerance (each model has a default setting)
    inputBinding:
      position: 101
      prefix: -fragment_tolerance
  - id: input_file
    type: File
    doc: PepNovo can analyze dta,mgf and mzXML files
    inputBinding:
      position: 101
      prefix: -file
  - id: list
    type: File
    doc: path to text file listing input files
    inputBinding:
      position: 101
      prefix: -list
  - id: max_pm
    type:
      - 'null'
      - string
    doc: X is the maximal precursor mass to be considered (good for shorty 
      searhces).
    inputBinding:
      position: 101
      prefix: -max_pm
  - id: min_filter_prob
    type:
      - 'null'
      - float
    doc: filter out spectra from denovo/tag/prm run with a quality probability 
      less than x (e.g., x=0.1)
    inputBinding:
      position: 101
      prefix: -min_filter_prob
  - id: model
    type: string
    doc: model name
    inputBinding:
      position: 101
      prefix: -model
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: directory where model files are kept (default ./Models)
    default: ./Models
    inputBinding:
      position: 101
      prefix: -model_dir
  - id: msb_generate_query
    type:
      - 'null'
      - boolean
    doc: performs denovo sequencing and generates a BLAST query.
    inputBinding:
      position: 101
      prefix: -msb_generate_query
  - id: msb_merge_queries
    type:
      - 'null'
      - boolean
    doc: takes a list of PepNovo "_full.txt" files, merges them and creates 
      queries(list should be given with -list flag).
    inputBinding:
      position: 101
      prefix: -msb_merge_queries
  - id: msb_min_score
    type:
      - 'null'
      - float
    doc: the minimal MS-Blast score to be included in the query, default X=4.0 .
    default: 4.0
    inputBinding:
      position: 101
      prefix: -msb_min_score
  - id: msb_num_solutions
    type:
      - 'null'
      - int
    doc: number of sequences to generate per spectrum (default X=7).
    default: 7
    inputBinding:
      position: 101
      prefix: -msb_num_solutions
  - id: msb_query_name
    type:
      - 'null'
      - string
    doc: the name to be given to the main output file.
    inputBinding:
      position: 101
      prefix: -msb_query_name
  - id: msb_query_size
    type:
      - 'null'
      - int
    doc: max size of MSB query allowed (default X=1000000).
    default: 1000000
    inputBinding:
      position: 101
      prefix: -msb_query_size
  - id: no_quality_filter
    type:
      - 'null'
      - boolean
    doc: does not remove low quality spectra.
    inputBinding:
      position: 101
      prefix: -no_quality_filter
  - id: num_peaks
    type:
      - 'null'
      - int
    doc: N is the maximal number of fragment peaks to predict
    inputBinding:
      position: 101
      prefix: -num_peaks
  - id: num_solutions
    type:
      - 'null'
      - int
    doc: default 20
    default: 2000
    inputBinding:
      position: 101
      prefix: -num_solutions
  - id: output_aa_probs
    type:
      - 'null'
      - boolean
    doc: calculates the probabilities of individual amino acids.
    inputBinding:
      position: 101
      prefix: -output_aa_probs
  - id: output_cum_probs
    type:
      - 'null'
      - boolean
    doc: calculates the cumulative probabilities (that at least one sequence 
      upto rank X is correct).
    inputBinding:
      position: 101
      prefix: -output_cum_probs
  - id: pm_tolerance
    type:
      - 'null'
      - float
    doc: the precursor masss tolerance (each model has a default setting)
    inputBinding:
      position: 101
      prefix: -pm_tolerance
  - id: pmcsqs_and_prm
    type:
      - 'null'
      - float
    doc: print spectrum graph nodes for spectra that have an SQS probability 
      score of at least <min prob> (typically should have a value 0-0.2)
    inputBinding:
      position: 101
      prefix: -pmcsqs_and_prm
  - id: pmcsqs_only
    type:
      - 'null'
      - boolean
    doc: only output the corrected precursor mass, charge and filtering values
    inputBinding:
      position: 101
      prefix: -pmcsqs_only
  - id: predict_fragmentation
    type:
      - 'null'
      - File
    doc: X is the input file with a list of peptides and charges (one per line)
    inputBinding:
      position: 101
      prefix: -predict_fragmentation
  - id: print_normalized_scores
    type:
      - 'null'
      - boolean
    doc: prints spectrum graph scores after normalization and removal of 
      negative scores.
    inputBinding:
      position: 101
      prefix: -prm_norm
  - id: print_spectrum_graph_nodes
    type:
      - 'null'
      - boolean
    doc: only print spectrum graph nodes with scores.
    inputBinding:
      position: 101
      prefix: -prm
  - id: ptms
    type:
      - 'null'
      - string
    doc: seprated  by a colons (no spaces) e.g., M+16:S+80:N+1
    inputBinding:
      position: 101
      prefix: -PTMs
  - id: tag_length
    type:
      - 'null'
      - int
    doc: returns peptide sequence of the specified length (only lengths 3-6 are 
      allowed).
    inputBinding:
      position: 101
      prefix: -tag_length
  - id: use_spectrum_charge
    type:
      - 'null'
      - boolean
    doc: does not correct charge.
    inputBinding:
      position: 101
      prefix: -use_spectrum_charge
  - id: use_spectrum_mz
    type:
      - 'null'
      - boolean
    doc: does not correct the precursor m/z value that appears in the file.
    inputBinding:
      position: 101
      prefix: -use_spectrum_mz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pepnovo:v20120423_cv3
stdout: pepnovo_PepNovo_bin.out
