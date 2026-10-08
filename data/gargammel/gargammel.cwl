cwlVersion: v1.2
class: CommandLineTool
baseCommand: gargammel
label: gargammel
doc: "This script is a wrapper to run the different programs to create a set of Illumina
  reads for ancient DNA from a set of fasta files representing the endogenous, the
  contaminant from the same species and the bacterial contamination.\n\nTool homepage:
  https://github.com/grenaud/gargammel"
inputs:
  - id: matrix_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Matrix files of substitutions (<prefix>5.dat and <prefix>3.dat) staged in the working directory so the matrix file prefixes resolve
  - id: input_directory
    type: Directory
    doc: Directory with fasta directories (bact/, cont/, endo/). It is staged writable because the tool writes fasta indexes next to the fasta files.
    inputBinding:
      position: 200
      valueFrom: $(self.basename)/
  - id: briggs_parameters
    type:
      - 'null'
      - string
    doc: 'For the Briggs et al. 2007 model. The parameters must be comma-separated
      e.g.: -damage 0.03,0.4,0.01,0.3 (v,l,d,s)'
    inputBinding:
      position: 102
      prefix: -damage
  - id: briggs_parameters_bacterial
    type:
      - 'null'
      - string
    doc: Bacterial Briggs parameters (v,l,d,s)
    inputBinding:
      position: 102
      prefix: -damageb
  - id: briggs_parameters_contaminant
    type:
      - 'null'
      - string
    doc: Human contaminant Briggs parameters (v,l,d,s). The help names this option -damagecd, but the tool only accepts -damagec.
    inputBinding:
      position: 102
      prefix: -damagec
  - id: briggs_parameters_endogenous
    type:
      - 'null'
      - string
    doc: Endogenous Briggs parameters (v,l,d,s)
    inputBinding:
      position: 102
      prefix: -damagee
  - id: composition
    type:
      - 'null'
      - string
    doc: Composition of the final set in fraction (bacterial, contaminant, 
      endogenous)
    inputBinding:
      position: 102
      prefix: --comp
  - id: desired_read_length
    type:
      - 'null'
      - int
    doc: Desired read length
    inputBinding:
      position: 102
      prefix: -rl
  - id: endogenous_coverage
    type:
      - 'null'
      - string
    doc: Endogenous coverage
    inputBinding:
      position: 102
      prefix: -c
  - id: fixed_length
    type:
      - 'null'
      - int
    doc: Generate fragments of fixed length
    inputBinding:
      position: 102
      prefix: -l
  - id: forward_adapter_sequence
    type:
      - 'null'
      - string
    doc: Adapter that is observed after the forward read
    inputBinding:
      position: 102
      prefix: -fa
  - id: lognormal_location_file
    type:
      - 'null'
      - File
    doc: Location for lognormal distribution
    inputBinding:
      position: 102
      prefix: --loc
  - id: lognormal_scale_file
    type:
      - 'null'
      - File
    doc: Scale for lognormal distribution
    inputBinding:
      position: 102
      prefix: --scale
  - id: mapdamage_bacterial
    type:
      - 'null'
      - File
    doc: Bacterial mapDamage misincorporation file (mis.txt); give the protocol in mapdamage_bacterial_protocol
    inputBinding:
      position: 102
      prefix: -mapdamageb
  - id: mapdamage_bacterial_protocol
    type:
      - 'null'
      - string
    doc: Protocol for -mapdamageb, either single or double (single has C->T damage on both ends, double has C->T at the 5' end and G->A at the 3' end)
    inputBinding:
      position: 102
  - id: mapdamage_contaminant
    type:
      - 'null'
      - File
    doc: Human contaminant mapDamage misincorporation file (mis.txt); give the protocol in mapdamage_contaminant_protocol
    inputBinding:
      position: 102
      prefix: -mapdamagec
  - id: mapdamage_contaminant_protocol
    type:
      - 'null'
      - string
    doc: Protocol for -mapdamagec, either single or double (single has C->T damage on both ends, double has C->T at the 5' end and G->A at the 3' end)
    inputBinding:
      position: 102
  - id: mapdamage_endogenous
    type:
      - 'null'
      - File
    doc: Endogenous mapDamage misincorporation file (mis.txt); give the protocol in mapdamage_endogenous_protocol
    inputBinding:
      position: 102
      prefix: -mapdamagee
  - id: mapdamage_endogenous_protocol
    type:
      - 'null'
      - string
    doc: Protocol for -mapdamagee, either single or double (single has C->T damage on both ends, double has C->T at the 5' end and G->A at the 3' end)
    inputBinding:
      position: 102
  - id: mapdamage_file
    type:
      - 'null'
      - File
    doc: Read the miscorporation file produced by mapDamage (mis.txt); give the protocol in mapdamage_file_protocol
    inputBinding:
      position: 102
      prefix: -mapdamage
  - id: mapdamage_file_protocol
    type:
      - 'null'
      - string
    doc: Protocol for -mapdamage, either single or double (single has C->T damage on both ends, double has C->T at the 5' end and G->A at the 3' end)
    inputBinding:
      position: 102
  - id: matrix_file_prefix
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions. Provide the prefix only, both 
      files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfile
  - id: matrix_file_prefix_bacterial
    type:
      - 'null'
      - string
    doc: Bacterial matrix file of substitutions. Provide the prefix only, both 
      files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfileb
  - id: matrix_file_prefix_contaminant
    type:
      - 'null'
      - string
    doc: Human contaminant matrix file of substitutions. Provide the prefix 
      only, both files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfilec
  - id: matrix_file_prefix_endogenous
    type:
      - 'null'
      - string
    doc: Endogenous matrix file of substitutions. Provide the prefix only, both 
      files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfilee
  - id: matrix_file_prefix_methylated
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions for methylated Cs. Provide the 
      prefix only, both files must end with 5.dat and 3.data
    inputBinding:
      position: 102
      prefix: -matfilemeth
  - id: matrix_file_prefix_nonmethylated
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions for non-methylated Cs. Provide 
      the prefix only, both files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfilenonmeth
  - id: max_fragment_size
    type:
      - 'null'
      - int
    doc: Maximum fragments length
    inputBinding:
      position: 102
      prefix: --maxsize
  - id: methylated_cytosines
    type:
      - 'null'
      - boolean
    doc: Allow for lowercase C and G to denote methylated cytosines on the + and
      - strand respectively
    inputBinding:
      position: 102
      prefix: --methyl
  - id: min_fragment_size
    type:
      - 'null'
      - int
    doc: Minimum fragments length
    inputBinding:
      position: 102
      prefix: --minsize
  - id: misincorporation_bacterial
    type:
      - 'null'
      - File
    doc: Base misincorporation for the bacterial fragments
    inputBinding:
      position: 102
      prefix: --misincb
  - id: misincorporation_contaminant
    type:
      - 'null'
      - File
    doc: Base misincorporation for the contaminant fragments
    inputBinding:
      position: 102
      prefix: --misincc
  - id: misincorporation_distance
    type:
      - 'null'
      - int
    doc: Distance to consider for base misincorporation
    inputBinding:
      position: 102
      prefix: --distmis
  - id: misincorporation_endogenous
    type:
      - 'null'
      - File
    doc: Base misincorporation for the endogenous fragments
    inputBinding:
      position: 102
      prefix: --misince
  - id: mock
    type:
      - 'null'
      - boolean
    doc: Do nothing, just print the commands that will be run
    inputBinding:
      position: 102
      prefix: --mock
  - id: num_fragments
    type:
      - 'null'
      - int
    doc: Generate number of fragments
    inputBinding:
      position: 102
      prefix: -n
  - id: output_prefix
    type: string
    doc: Output prefix (the tool default [input dir]/simadna is inside the input directory, so a prefix is required here)
    inputBinding:
      position: 102
      prefix: -o
  - id: quality_score_factor
    type:
      - 'null'
      - int
    doc: Increase error rate for forward reads by a factor of 
      1/(10^([factor]/10))
    inputBinding:
      position: 102
      prefix: -qs
  - id: quality_score_factor_reverse
    type:
      - 'null'
      - int
    doc: Increase error rate for reverse reads by a factor of 
      1/(10^([factor]/10))
    inputBinding:
      position: 102
      prefix: -qs2
  - id: reverse_adapter_sequence
    type:
      - 'null'
      - string
    doc: Adapter that is observed after the reverse read
    inputBinding:
      position: 102
      prefix: -sa
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: Illumina platform to use (GA2, HS20, HS25, HSXt, MSv1, MSv3)
    inputBinding:
      position: 102
      prefix: -ss
  - id: single_end_sequencing
    type:
      - 'null'
      - boolean
    doc: Use single-end sequencing
    inputBinding:
      position: 102
      prefix: -se
  - id: size_distribution_file
    type:
      - 'null'
      - File
    doc: Open file with size distribution (one fragment length per line)
    inputBinding:
      position: 102
      prefix: -s
  - id: size_frequency_file
    type:
      - 'null'
      - File
    doc: 'Open file with size frequency in the following format: length[TAB]freq'
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_directory)
        writable: true
      - $(inputs.matrix_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel:1.1.4--hb66fcc3_0
stdout: gargammel.out
