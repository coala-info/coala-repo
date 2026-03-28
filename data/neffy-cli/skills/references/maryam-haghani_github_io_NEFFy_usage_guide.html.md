NEFFy

NEFF Calculator and MSA File Converter

[Edit on GitHub](https://github.com/Maryam-Haghani/Neffy)

Loading...

Searching...

No Matches

How to Use

## Table of Contents

* [C++ Executable File](#executable)
  + [NEFF Computation](#neff_computation)
    - [Usage](#neff_usage)
    - [Parameters](#neff_parameters)
    - [Examples](#neff_example)
  + [MSA File Conversion](#converter)
    - [Usage](#converter_usage)
    - [Parameters](#converter_parameters)
    - [Example](#converter_example)
* [Python Library](#python)
  + [NEFF Computation](#python_neff_main)
    - [compute\_neff: NEFF Computation](#python_neff)
      * [Parameters](#python_neff_params)
      * [Example](#python_neff_example)
    - [compute\_multimer\_neff: NEFF Computation for Multimer MSA](#python_neff_multimer)
      * [Parameters](#python_neff_multimer_params)
      * [Example](#python_neff_multimer_example)
    - [compute\_residue\_neff: Per-Residue (Column-Wise) NEFF Computation](#python_neff_residue)
      * [Parameters](#python_neff_residue_params)
      * [Example](#python_neff_residue_example)
  + [convert\_msa: MSA File Conversion](#python_converter)
    - [Parameters](#python_convert_msa_params)
    - [Example](#python_convert_msa_example)

# C++ Executable File

## NEFF Computation

### Usage:

./neff --file=<input\_file> [options]

To calculate NEFF, provide an MSA file and indicate the desired parameters. NEFF will be computed and presented as the result.

### Parameters:

The code accepts the following command-line flags:

| Flag | Description | Required | Default Value | Example |
| --- | --- | --- | --- | --- |
| `--file=<list of filenames>` | Input files (comma-separated, no spaces) containing multiple sequence alignments | Yes | N/A | `--file=my_alignment.fasta` |
| `--alphabet=<value>` | Alphabet of MSA   **0**: Protein   **1**: RNA   **2**: DNA | No | 0 | `--alphabet=1` |
| `--check_validation=[true/false]` | Validate the input MSA file based on alphabet or not | No | false | `--check_validation=true` |
| `--threshold=<value>` | Similarity threshold for sequence weighting, must be between 0 and 1. | No | 0.8 | `--threshold=0.7` |
| `--norm=<value>` | Normalization option for NEFF   **0**: Normalize by the square root of sequence length   **1**: Normalize by the sequence length   **2**: No Normalization | No | 0 | `--norm=2` |
| `--omit_query_gaps=[true/false]` | Omit gap positions of query sequence from all sequences for NEFF computation | No | true | `--omit_query_gaps=true` |
| `--is_symmetric =true/false]` | Consider gaps in number of differences when computing sequence similarity cutoff (asymmetric) or not (symmetric) | No | true | `--is_symmetric=false` |
| `--non_standard_option=<value>` | Options for handling non-standard letters of the specified alphabet   **0**: Treat them the same as standard letters   **1**: Consider them as gaps when computing similarity cutoff of sequences (only used in asymmetryc version)   **2**: Consider them as gaps in computing similarity cutoff and checking position of match/mismatch | No | 0 | `--non_standard_option=1` |
| `--depth=<value>` | Depth of MSA to be used in NEFF computation (starting from the first sequence) | No | inf (consider the whole sequence) | `--depth=10`   (if given value is greater than original depth, it considers the original depth) |
| `--gap_cutoff=<value>` | Threshold for considering a position as gappy and removing that (between 0 and 1) | No | 1 (no gappy position) | `--gap_cutoff=0.7` |
| `--pos_start=<value>` | Start position of each sequence to be considered in NEFF (inclusive) | No | 1 (the first position) | `--pos_start=10` |
| `--pos_end=<value>` | Last position of each sequence to be considered in NEFF (inclusive) | No | inf (consider the whole sequence) | `--pos_end=50` (if given value is greater than the length of the MSA sequences, consider length of sequences in the MSA) |
| `--only_weights=[true/false]` | Return only sequence weights, rather than the final NEFF | No | false | `--only_weights=true` |
| `--multimer_MSA=[true/false]` | Compute NEFF for MSA of a multimer | No | false | `--multimer_MSA=true` |
| `--stoichiom=<value>` | Stochiometry of the multimer | when *multimer\_MSA*=true |  | `--stoichiom=A2B1` |
| `--chain_length=<list of values>` | Length of the chains in a heteromer | when *multimer\_MSA*=true and multimer is a heteromer | 0 | `--chain_length=17 45` |
| `--residue_neff=[true/false]` | Compute per-residue (column-wise) NEFF | No | false | `--residue_neff=true` |

### Examples:

* **Compute Symmetric NEFF for protein MSA (No Normalization):**

  ./neff --file=../MSAs/example.a2m --norm=2

   Result:
  > ‍MSA sequence length: 56
  > MSA depth: 5
  > NEFF: 5

* **Compute NEFF for RNA MSA with Default Normalization (sqrt(L)) using 50% Gap Cutoff:**

  ./neff --file=../MSAs/rna.fasta --gap\_cutoff=0.5 --alphabet=1

   Result:
  > ‍MSA sequence length: 28
  > MSA depth: 1176
  > NEFF: 5.08477

* **Compute [Sequence](struct_sequence.html) Weights for protein MSA with Default Normalization (sqrt(L)):**

  ./neff --file=../MSAs/example.a2m --only\_weights=true --threshold=0.2

   Result:
  > ‍MSA sequence length: 56
  > MSA depth: 5
  > [Sequence](struct_sequence.html) weights:
  > 1 0.333333 0.25 0.333333 0.25

* **Compute per-residue (column-wise) NEFF:**

  ./neff --file=../MSAs/example.a2m --check\_validation=true --residue\_neff=true

   Result:
  > ‍MSA sequence length: 56
  > MSA depth: 5
  > Per-residue (column-wise) NEFF:
  > 0.668153 0.534522 0.668153 0.534522 0.668153 0.668153 0.668153 0.668153 0.534522 0.534522 0.534522 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.534522 0.534522 0.534522 0.668153 0.400892 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.668153 0.534522 0.534522 0.534522 0.534522 0.534522 0.400892 0.534522 0.534522 0.534522 0.400892 0.133631 0.133631 0.133631 0.133631 0.133631 0.133631 0.133631 0.133631
  > Median of per-residue (column-wise) NEFF: 0.668153

* **Compute Asymmetric NEFF for an Integration of MSAs with Default Normalization (sqrt(L)):**

  ./neff --file=../MSAs/uniref90\_hits.sto,../MSAs/bfd\_uniclust\_hits.a3m,../MSAs/mgnify\_hits.sto --depth=2048 --is\_symmetric=false

   Result:
  > ‍MSA length: 338
  > MSA depth: 2048
  > NEFF: 106.067

The tool will integrate MSAs from the list of files in the specified order and compute the NEFF value for the integrated MSA up to a depth of 2048. If the tool reaches the specified depth before all files are integrated, it will stop processing the remaining files.
This process is akin to how AlphaFold2.3 produces the final MSA for a protein by combining three distinct MSAs.

* **Compute NEFF for MSA of a Homomer (Default Normalization):**

  ./neff --file=../MSAs/homomer.aln --multimer\_MSA=true --stoichiom=A2

   Result:
  > ‍MSA sequence length: 102
  > MSA depth: 2048
  > NEff of entire MSA: 34.8453
  > Neff of individual MSA: 49.2787

The tool will detect a single repetition of the individual MSA of the chain within the given MSA file and report the NEFF value for it. If the provided MSA is not in the format of a multimer MSA of a homomer (i.e., the same MSA file repeated 'n' times, where here n=2), the tool will raise an error.

* **Compute NEFF for MSA of a Heteromer (L Normalization):**

  ./neff --file=../MSAs/heteromer.aln --multimer\_MSA=true --stoichiom=A2B1 --chain\_length=51,73 --norm=1

   Result:
  > ‍MSA sequence length: 175
  > MSA depth: 3072
  > NEFF of entire MSA:3.2836
  > NEFF of Paired MSA (depth=1024): 3.02721
  > NEFF of Individual MSA for Chain A (depth=1024): 4.37843
  > NEFF of Individual MSA for Chain B (depth=1024): 3.0194

The tool will identify paired MSA sequences and the sequences for each individual MSA of chains in the given MSA file, assuming the first monomer has a length of 51 residues and the second has a length of 73. It will report NEFF values for the paired MSA as well as for the MSAs corresponding to unpaired sequences. If the provided MSA is not in the format of a multimer MSA of a heteromer, the tool will raise an error.

## MSA File Conversion

To convert an MSA file, specify the input file, output file, and the desired input and output formats. The tool will read the input file, perform the conversion, and write the resulting MSA to the output file in the specified format.

### Usage:

./converter --in\_file=<input\_file> --out\_file=<input\_file> [options]

### Parameters:

The code accepts the following command-line flags:

| Flag | Description | Required | Default Value | Example |
| --- | --- | --- | --- | --- |
| `--in_file=<filename>` | Specifies the input MSA file to be converted.  Replace `<filename>` with the path and name of the input file | Yes | N/A | `--in_file=input.fasta` |
| `--out_file=<filename>` | Specifies the output file where the converted MSA will be saved.  Replace `<filename>` with the desired path and name of the output file | Yes | N/A | `--out_file=output.a2m` |
| `--alphabet=<value>` | Alphabet of MSA   **0**: Protein   **1**: RNA   **2**: DNA | No | 0 | `--alphabet=1` |
| `--check_validation=[true/false]` | Validate the input MSA file based on alphabet or not | No | true | `--check_validation=true` |

Please note that the conversion is performed based on the specified input and output file extensions.

### Examples:

* **Convert an A3M file to Stockholm format with RNA alphabet:**

  ./converter --in\_file=../MSAs/example.a2m --out\_file=../MSAs/example.sto --alphabet=1
* **Convert a STO file to Clustal format without validation:**

  ./converter --in\_file=../MSAs/example.sto --out\_file=../MSAs/example.clustal --check\_validation=false
* **Convert an FASTA file to ALN format with RNA alphabet:**

  ./converter --in\_file=../MSAs/rna.fasta --out\_file=../MSAs/rna.aln --alphabet=1

---

# Python Library

## NEFF Computation

## `compute_neff`

### Parameters:

The method accepts the following parameters:

| Parameter | Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| `file` | list [string] | Yes | N/A | Path to the input file containing the multiple sequence alignment (MSA) |
| `only_weights` | bool | No | False | Return only sequence weights, rather than the final NEFF |
| `alphabet` | Alphabet (Enum) | No | Alphabet.Protein | Enum to specify the type of sequences in the MSA (**Protein**, **RNA**, or **DNA**) |
| `check_validation` | bool | No | False | Validate the input MSA file based on alphabet or not |
| `threshold` | float | No | 0.8 | Similarity threshold for sequence weighting, must be between 0 and 1 |
| `norm` | Normalization (Enum) | No | Normalization.Sqrt\_Length | Enum to specify normalization method for NEFF (**Sqrt\_Length**, **Length**, or **No\_Normalization**) |
| `omit_query_gaps` | bool | No | True | Omit gap positions of query sequence from all sequences for NEFF computation |
| `is_symmetric` | bool | No | True | Consider gaps in number of differences when computing sequence similarity cutoff (asymmetric) or not (symmetric) |
| `non_standard_option` | NonStandardOption (Enum) | No | NonStandardOption.AsStandard | Enum to handle non-standard residues of the specified alphabet (**AsStandard**, **ConsiderGapInCutoff**, **ConsiderGap**) |
| `depth` | int | No | inf (consider the whole sequence) | Depth of MSA to be used in NEFF computation (starting from the first sequence) |
| `gap_cutoff` | float | No | 1 (no gappy position) | Threshold for considering a position as gappy and removing that (between 0 and 1) |
| `pos_start` | int | No | 1 (the first position) | Start position of each sequence to be considered in NEFF (inclusive) |
| `pos_end` | int | No | inf (consider the whole sequence) | Last position of each sequence to be considered in NEFF (inclusive) |

### Examples:

* **Compute Symmetric NEFF for protein MSA with No Normalization:**

  import neffy

  def main():

  try:

  msa\_length, msa\_depth, neff = neffy.compute\_neff(

  file='../MSAs/example.a2m',

  norm=neffy.Normalization.No\_Normalization

  )

  print(f"MSA length: {msa\_length}")

  print(f"MSA depth: {msa\_depth}")

  print(f"NEFF: {neff}")

  except RuntimeError as e:

  print(e)

  if \_\_name\_\_ == "\_\_main\_\_":

  main()

   Result:
  > ‍MSA length: 56
  > MSA depth: 5
  > NEFF: 5.0

* **Compute NEFF for RNA MSA with Default Normalization (sqrt(L)) using 50% Gap Cutoff:**

  import neffy

  def main():

  try:

  msa\_length, msa\_depth, neff = neffy.compute\_neff(

  file='../MSAs/rna.fasta',

  alphabet=neffy.Alphabet.RNA,

  gap\_cutoff=0.5)

  print(f"MSA length: {msa\_length}")

  print(f"MSA depth: {msa\_depth}")

  print(f"NEFF: {neff}")

  except RuntimeError as e:

  print(e)

  if \_\_name\_\_ == "\_\_main\_\_":

  main()

   Result:
  > ‍MSA length: 28
  > MSA depth: 1176
  > NEFF: 5.08477

* **Compute [Sequence](struct_sequence.html) Weights for protein MSA with Default Normalization (sqrt(L)):**

  import neffy

  def main():

  try:

  msa\_length, msa\_depth, weights = neffy.compute\_neff(

  file='../MSAs/example.a2m',

  only\_weights=True,

  threshold=0.2)

  print(f"MSA length: {msa\_length}")

  print(f"MSA depth: {msa\_depth}")

  print(f"Sequence weights: {weights}")

  except RuntimeError as e:

  print(e)

  if \_\_name\_\_ == "\_\_main\_\_":

  main()

   Result:
  > ‍MSA length: 56
  > MSA depth: 5
  > [Sequence](struct_sequence.html) weights: [1.0, 0.333333, 0.25, 0.333333, 0.25]

* **Compute Asymmetric NEFF for an Integration of MSAs with Default Normalization (sqrt(L)):**

  import neffy

  def main():

  try:

  msa\_length, msa\_depth, neff = neffy.compute\_neff(

  file=['../MSAs/uniref90\_hits.sto', '../MSAs/bfd\_uniclust\_hits.a3m', '../MSAs/mgnify\_hits.sto'],

  is\_symmetric = False,

  depth=2048)

  print(f"MSA length: {msa\_length}")

  print(f"MSA depth: {msa\_depth}")

  print(f"NEFF: {neff}")

  except RuntimeError as e:

  print(e)

  if \_\_name\_\_ == "\_\_main\_\_":

  main()

   Result:
  > ‍MSA length: 338
  > MSA depth: 2048
  > NEFF: 106.067

The tool will integrate MSAs from the list of files in the specified order and compute the NEFF value for the integrated MSA up to the gievn depth. If the tool reaches the specified depth before all files are integrated, it will stop processing the remaining files.
This process is akin to how AlphaFold2.3 produces the final MSA for a protein by combining three distinct MSAs.

## `compute_multimer_neff`

### Parameters:

The method accepts the following parameters:

| Parameter | Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| `file` | string | Yes | N/A | Path to the input file containing the multiple sequence alignment (MSA) |
| `stoichiom` | string | Yes | - | Stochiometry of the multimer |
| `chain_length` | list [int] | when multimer is a heteromer | 0 | Length of the chains in a heteromer |
| `alphabet` | Alphabet (E