cwlVersion: v1.2
class: CommandLineTool
baseCommand: treekin
label: treekin
doc: "Compute biopolymer macrostate dynamics\n\nTool homepage: https://www.tbi.univie.ac.at/RNA/Barriers/"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional input files
    inputBinding:
      position: 1
  - id: absorb
    type:
      - 'null'
      - string
    doc: Make a state absorbing
    inputBinding:
      position: 102
      prefix: --absorb
  - id: bar
    type:
      - 'null'
      - string
    doc: Read barriers input from file instead of standard input. Required in 
      case "-m I" (rates kinetics) AND "-a" (absorbing state) is given
    inputBinding:
      position: 102
      prefix: --bar
  - id: bin
    type:
      - 'null'
      - boolean
    doc: Assume binary rates input
    inputBinding:
      position: 102
      prefix: --bin
  - id: degeneracy
    type:
      - 'null'
      - boolean
    doc: Consider degeneracy in transition rates
    inputBinding:
      position: 102
      prefix: --degeneracy
  - id: dumpE
    type:
      - 'null'
      - boolean
    doc: Dump eigenvalues and eigenvectors to a binary recovery file and 
      continue with iteration
    inputBinding:
      position: 102
      prefix: --dumpE
  - id: dumpU
    type:
      - 'null'
      - boolean
    doc: Dump transition matrix U to file mx.txt (and to binary mx.bin - not 
      fixed yet)
    inputBinding:
      position: 102
      prefix: --dumpU
  - id: dumpX
    type:
      - 'null'
      - boolean
    doc: Dump eigenvalues to ASCII file and exit (do not iterate)
    inputBinding:
      position: 102
      prefix: --dumpX
  - id: equil_file
    type:
      - 'null'
      - string
    doc: Write equilibrium distribution into a file.
    inputBinding:
      position: 102
      prefix: --equil-file
  - id: exponent
    type:
      - 'null'
      - boolean
    doc: Use matrix-expontent routines, rather than diagonalization
    inputBinding:
      position: 102
      prefix: --exponent
  - id: feps
    type:
      - 'null'
      - float
    doc: Machine precision used by LAPACK routines (and matrix aritmetic) -- if 
      set to negative number, the lapack suggested value is used (2*DLAMCH("S") 
      )
    inputBinding:
      position: 102
      prefix: --feps
  - id: fpt
    type:
      - 'null'
      - string
    doc: 'Compute first passage times (FPT). Arguments: all => compute all FPT (slow),
      <num> - compute FPT to state <num> from all states'
    inputBinding:
      position: 102
      prefix: --fpt
  - id: fptfile
    type:
      - 'null'
      - string
    doc: Filename of FPT file (provided -t option given)
    inputBinding:
      position: 102
      prefix: --fptfile
  - id: hard_rescale
    type:
      - 'null'
      - float
    doc: 'Rescale all rates by a hard exponent (usually 0.0<HR<1.0). Formula: "rate
      -> rate^(hard-rescale)". Overrides --minimal-rate argument.'
    inputBinding:
      position: 102
      prefix: --hard-rescale
  - id: info
    type:
      - 'null'
      - boolean
    doc: Show settings
    inputBinding:
      position: 102
      prefix: --info
  - id: just_shorten
    type:
      - 'null'
      - boolean
    doc: Do not diagonalize and iterate, just shorten input (meaningfull only 
      with -n X option or -fpt option or --visualize option)
    inputBinding:
      position: 102
      prefix: --just-shorten
  - id: mathematicamatrix
    type:
      - 'null'
      - boolean
    doc: Dump transition matrix U to Mathematica-readable file mxMat.txt
    inputBinding:
      position: 102
      prefix: --mathematicamatrix
  - id: max_decrease
    type:
      - 'null'
      - int
    doc: Maximal decrease in dimension in one step
    inputBinding:
      position: 102
      prefix: --max-decrease
  - id: method
    type:
      - 'null'
      - string
    doc: 'Select method to build transition matrix: A ==> Arrhenius-like kinetics,
      I ==> use input as a rate matrix'
    inputBinding:
      position: 102
      prefix: --method
  - id: minimal_rate
    type:
      - 'null'
      - float
    doc: Rescale all rates to be higher than the minimal rate using formula 
      "rate -> rate^(ln(desired_minimal_rate)/ln(minimal_rate))", where 
      desired_minimal_rate is from input, minimal_rate is the lowest from all 
      rates in rate matrix.
    inputBinding:
      position: 102
      prefix: --minimal-rate
  - id: mlapack_method
    type:
      - 'null'
      - string
    doc: The mlapack precision method. "LD", "QD", "DD", "DOUBLE", "GMP", 
      "MPFR", "FLOAT128". You have to set mlapack-precision if "GMP", "MPFR" is 
      selected! "LD" is the standard long double with 80 bit.
    inputBinding:
      position: 102
      prefix: --mlapack-method
  - id: mlapack_precision
    type:
      - 'null'
      - int
    doc: Number of bits for the eigenvalue method of the mlapack library. A 
      value > 64 is recommended, otherwise the standard lapack method would be 
      faster.
    inputBinding:
      position: 102
      prefix: --mlapack-precision
  - id: nstates
    type:
      - 'null'
      - int
    doc: Read only first <int> states (assume quasi-stationary distribution 
      (derivation of others is = 0))
    inputBinding:
      position: 102
      prefix: --nstates
  - id: num_err
    type:
      - 'null'
      - string
    doc: 'Specify how to treat issues with numerical errors in probability: I ==>
      Ignore, H ==> Halt the program, R ==> Rescale the probability'
    inputBinding:
      position: 102
      prefix: --num-err
  - id: p0
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Set initial population of state <int> to <double>. Can be given multiple
      times. (NOTE: sum of <double> must equal 1)'
    inputBinding:
      position: 102
      prefix: --p0
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be silent (do not print out the output)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: ratesfile
    type:
      - 'null'
      - string
    doc: Read transition rates from file instead of standard input.
    inputBinding:
      position: 102
      prefix: --ratesfile
  - id: recoverE
    type:
      - 'null'
      - boolean
    doc: Recover from pre-ccomputes eigenvalues and eigenvectors
    inputBinding:
      position: 102
      prefix: --recoverE
  - id: t0
    type:
      - 'null'
      - float
    doc: Start time
    inputBinding:
      position: 102
      prefix: --t0
  - id: t8
    type:
      - 'null'
      - float
    doc: Stop time
    inputBinding:
      position: 102
      prefix: --t8
  - id: temp
    type:
      - 'null'
      - float
    doc: Temperature in Celsius
    inputBinding:
      position: 102
      prefix: --Temp
  - id: times
    type:
      - 'null'
      - float
    doc: Multiply rates with a constant number.
    inputBinding:
      position: 102
      prefix: --times
  - id: tinc
    type:
      - 'null'
      - float
    doc: Time scaling factor (for log time-scale)
    inputBinding:
      position: 102
      prefix: --tinc
  - id: useplusI
    type:
      - 'null'
      - boolean
    doc: Use old treekin computation where we add identity matrix to transition 
      matrix. Sometimes less precise (maybe sometimes also more precise), in 
      normal case it should not affect results at all.
    inputBinding:
      position: 102
      prefix: --useplusI
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: visualize
    type:
      - 'null'
      - string
    doc: 'Filename where to print a visualization of rate graph (without file subscript,
      two files will be generated: .dot and .eps with text and visual representation
      of graph)'
    inputBinding:
      position: 102
      prefix: --visualize
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Turn all the warnings about underflow on.
    inputBinding:
      position: 102
      prefix: --warnings
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treekin:0.5.1--hf3d7b6d_4
stdout: treekin.out
