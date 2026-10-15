cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqboot
label: phylip_seqboot
doc: "Bootstrap, jackknife or permutation resampling of molecular sequences, characters, restriction sites or gene frequencies. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: D data type, J bootstrap, jackknife, permute or rewrite, % sampling fraction, B block size, R number of replicates, W read weights, C read categories, S write data sets or only weights, I interleaved input. After Y the program asks for an odd random number seed of the form 4n+1, so the last default answer is the seed.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Sequences, characters, restriction sites or gene frequencies in PHYLIP format (staged as 'infile')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Character or site weights, one digit per site (read when the menu option W is chosen) (staged as 'weights')"
  - id: categories
    type:
      - 'null'
      - File
    doc: "Site rate categories, one digit 1-9 per site (read when the menu option C is chosen) (staged as 'categories')"
  - id: ancestors
    type:
      - 'null'
      - File
    doc: "Ancestral states, one per character (read when the menu option A is chosen) (staged as 'ancestors')"
  - id: factors
    type:
      - 'null'
      - File
    doc: "Factors file that groups characters into multistate factors (read when the menu option F is chosen) (staged as 'factors')"
  - id: mixture
    type:
      - 'null'
      - File
    doc: "Mixture file that assigns Wagner or Camin-Sokal parsimony to each character (read when the menu option X is chosen) (staged as 'mixture')"
  - id: menu_answers
    type:
      type: array
      items: string
    doc: "Answers typed at the program menu and at later prompts, one per line"
    default:
      - 'Y'
      - "4333"
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Resampled data sets"
    outputBinding:
      glob: outfile
  - id: outweights
    type:
      - 'null'
      - File
    doc: "Resampled weights (written when only weights are requested)"
    outputBinding:
      glob: outweights
  - id: outcategories
    type:
      - 'null'
      - File
    doc: "Resampled site categories (written when categories are read)"
    outputBinding:
      glob: outcategories
  - id: outancestors
    type:
      - 'null'
      - File
    doc: "Resampled ancestral states (discrete characters)"
    outputBinding:
      glob: outancestors
  - id: outmixture
    type:
      - 'null'
      - File
    doc: "Resampled mixture file (discrete characters)"
    outputBinding:
      glob: outmixture
  - id: outfactors
    type:
      - 'null'
      - File
    doc: "Resampled factors file (discrete characters)"
    outputBinding:
      glob: outfactors
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: infile
        entry: $(inputs.infile)
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: categories
        entry: $(inputs.categories)
      - entryname: ancestors
        entry: $(inputs.ancestors)
      - entryname: factors
        entry: $(inputs.factors)
      - entryname: mixture
        entry: $(inputs.mixture)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_seqboot.out
