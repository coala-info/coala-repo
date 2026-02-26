cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl knotinframe
label: knotinframe
doc: "predict ribosomal -1 frameshift sites with a simple pseudoknot as secondary
  structure in DNA and RNA sequences. The prediction is based on a comparison between
  the minimal free energy (mfe) structure calculated by an RNAfold [1] like program
  and the mfe-structure computed by a modified version of pKiss, called pknotsRG-frameshift
  [2].\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/knotinframe"
inputs:
  - id: input
    type: string
    doc: fasta file name or RNA sequence
    inputBinding:
      position: 1
  - id: bin_path
    type:
      - 'null'
      - string
    doc: knotinframe expects that according Bellman's GAP compiled binaries are 
      located in the same directory as the Perl wrapper is. Should you moved 
      them into another directory, you must set --binPath to this new location!
    inputBinding:
      position: 102
      prefix: --binPath
  - id: bin_prefix
    type:
      - 'null'
      - string
    doc: "knotinframe expects a special naming schema for the according Bellman's
      GAP compiled binaries. The binary name is composed of two components: 1) the
      program prefix (on default \"knotinframe_\"), 2) the folding mode, i.e. \"knotted\"\
      \ or \"nested\". . With --binPrefix you can change the prefix into some arbitary
      one."
    inputBinding:
      position: 102
      prefix: --binPrefix
  - id: min_energy_difference
    type:
      - 'null'
      - float
    doc: The candidate sub-sequence should be more likely fold a pseudoknot than
      a nested structure. Thus, candidates where (nested energy + 
      --minEnergyDifference < knotted energy) are ruled out. Theis et al. [5] 
      call this the "energy difference filter (EDF)" and the according parameter
      "beta". Default is -8.71 kcal/mol.
    default: -8.71
    inputBinding:
      position: 102
      prefix: --minEnergyDifference
  - id: min_knotted_energy
    type:
      - 'null'
      - float
    doc: The pseudoknot structure induces the ribosomal frame shift, thus it 
      should have a stability of at least -7.4 kcal/mol. Theis et al. [5] call 
      this the "low energy filter (LEF)" and the parameter "alpha".
    inputBinding:
      position: 102
      prefix: --minKnottedEnergy
  - id: number_outputs
    type:
      - 'null'
      - int
    doc: Some sequences have a high amount of possible slippery site candidates,
      thus output is cut off after printing the best --numberOutputs results, 
      which is 10 by default.
    default: 10
    inputBinding:
      position: 102
      prefix: --numberOutputs
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default 
      parameter set. See the RNAlib (Vienna RNA package) documentation for 
      details on the file format. Default are parameters released by the Turner 
      group in 2004 (see [4] and [3]).
    inputBinding:
      position: 102
      prefix: --param
  - id: temperature
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. <float> must be a
      floating point number. Default is 37 C.
    default: 37.0
    inputBinding:
      position: 102
      prefix: --temperature
  - id: verbose
    type:
      - 'null'
      - int
    doc: Prints the actual command for Bellman's GAP binary.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_increment
    type:
      - 'null'
      - int
    doc: The --windowSize bp long sub-string, downstream to the slippery site, 
      is analysed in different chunks sizes. These chunks grow with 
      --windowIncrement bp. Maximal size if --windowSize. Default value is 20.
    default: 20
    inputBinding:
      position: 102
      prefix: --windowIncrement
  - id: window_size
    type:
      - 'null'
      - int
    doc: If a slippery site is detected a sub-string downstream is analysed. 
      --windowSize sets the maximal length of this sub-string, which is 120 by 
      default. Must be a multiple of --windowIncrement!
    default: 120
    inputBinding:
      position: 102
      prefix: --windowSize
outputs:
  - id: varna_output_file
    type:
      - 'null'
      - File
    doc: Provide a file name to which a HTML formatted version of the output 
      should be saved in.
    outputBinding:
      glob: $(inputs.varna_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knotinframe:2.3.2--h9948957_2
