* [Join/Login](/auth/)
* [Business Software](/software/)
* [Open Source Software](/directory/)
* [For Vendors](/software/vendors/ "For Vendors")
* [Blog](/blog/ "Blog")
* [About](/about)
* More
* + [Articles](/articles/)
  + [Create](/create)
  + [SourceForge Podcast](https://sourceforge.net/articles/category/sourceforge-podcast/)
  + [Site Documentation](https://sourceforge.net/p/forge/documentation/Docs%20Home/)
  + [Subscribe to our Newsletter](/user/newsletters)
  + [Support Request](/support)

[![SourceForge logo](https://a.fsdn.com/con/images/sandiego/sf-logo-full.svg)](/ "Home")

[For Vendors](/software/vendors/ "For Vendors")
[Help](/support "Help")
[Create](/create/ "Create")
[Join](/user/registration "Join")
[Login](/auth/ "Login")

[![SourceForge logo](https://a.fsdn.com/con/images/sandiego/sf-logo-full.svg)](/ "Home")

[Business Software](/software/)

[Open Source Software](/directory/ "Browse")

[SourceForge Podcast](https://sourceforge.net/articles/category/sourceforge-podcast/)

Resources

* [Articles](/articles/)
* [Case Studies](/software/case-studies/)
* [Blog](/blog/)

Menu

* [Help](/support)
* [Create](/create)
* [Join](/user/registration/ "Join")
* [Login](/auth/ "Login")

* [Home](/)
* [Browse](/directory/)
* [CFM-ID](/p/cfm-id/)
* Wiki

# CFM-ID Wiki

## Competitive Fragmentation Modeling for Metabolite Identification

Brought to you by:
[felicityallen](/u/felicityallen/profile/)

* [Summary](/projects/cfm-id/)
* [Files](/projects/cfm-id/files/)
* [Reviews](/projects/cfm-id/reviews/)
* [Support](/projects/cfm-id/support)
* [Wiki](/p/cfm-id/wiki/)
* [Tickets](/p/cfm-id/tickets/)
* [Code](/p/cfm-id/code/)

Menu
▾
▴

* [Wiki Home](/p/cfm-id/wiki/)
* [Browse Pages](/p/cfm-id/wiki/browse_pages/)
* [Browse Labels](/p/cfm-id/wiki/browse_tags/)

* [Formatting Help](/nf/markdown_syntax)

## Home

Authors:
[![Felicity Allen](https://a.fsdn.com/con/images/sandiego/icons/default-avatar.png "Felicity Allen")](/u/felicityallen/profile/)

Welcome to the CFM-ID wiki! Here you can find documentation for this project.

Further information can be found in the following publication:

Allen, F., Greiner, R., Wishart, D., *Competitive Fragmentation Modeling of ESI-MS/MS spectra for putative metabolite identification*, Metabolomics, 11:1, pp 98-110, 2015.

* [Running the Command Line Utilities](#h-running-the-command-line-utilities)
  + [fraggraph-gen](#h-fraggraph-gen)
  + [cfm-predict](#h-cfm-predict)
  + [cfm-id](#h-cfm-id)
  + [cfm-id-precomputed](#h-cfm-id-precomputed)
  + [cfm-annotate](#h-cfm-annotate)
  + [cfm-train](#h-cfm-train)
* [Installing the Windows Binaries](#h-installing-the-windows-binaries)
* [Compiling the Source Code](#h-compiling-the-source-code)
  + [On Windows](#h-on-windows)
  + [On Linux](#h-on-linux)
  + [On MacOS](#h-on-macos)
* [Frequently Asked Questions](#h-frequently-asked-questions)
* [Related Publications](#h-related-publications)
* [CFM-ID 3.0](#h-cfm-id-30)

## Running the Command Line Utilities

The following sections describe the command line utilities that are available in this project with examples of how to use them. Usage details can also be obtained by running each program with no input arguments.

### fraggraph-gen

This program produces a complete fragmentation graph or list of feasible fragments for an input molecule. It systematically breaks bonds within the molecule and checks for valid resulting fragments as described in section 2.1.1 of the above publication.

**Usage**

```
fraggraph-gen.exe <smiles or inchi> <max depth> <ionization mode> <fullgraph or fragonly> <output file>
```

*smiles or inchi:* The smiles or inchi strings for the input molecule to fragment. Note that inchi inputs are expected to start with "InChI=" and will be identifed accordingly. The input molecule is not expected to have any charge - an additional H+ will be added.

*max depth:* The depth to which the program should recurse when computing the tree. e.g. depth 1 would be just the original molecule and its immediate descendants, depth 2 would allow those descendants to break one more time, etc.

*ionization mode:* Whether to generate fragments using positive ESI or EI, or negative ESI ionization. + for positive mode ESI [[M+H]](./M%2BH), - for negative mode ESI [[M-H]](./M-H), \* for positive mode EI [[M+]](./M%2B).

*fullgraph or fragonly:* (optional) This specifies the type of output. **fragonly** will return a list of unique feasible fragments with their masses. **fullgraph** (default) will also return a list of the connections between fragments and their corresponding neutral losses.

*output file:* (optional) The name and path of a file to write the output to. If this argument is not provided, the program will write to stdout.

**Examples**

```
fraggraph-gen.exe CC 2 + fullgraph

4                            //The number of fragments
0 31.05422664 C[CH4+]        //id mass smiles  - the fragments
1 15.02292652 [CH3+]         //id mass smiles
2 29.03912516 C=[CH3+]       //id mass smiles
3 27.02292652 C#[CH2+]       //id mass smiles

0 1 C                        //from to neutral_loss - the transitions
0 2 [HH]                     //from to neutral_loss
2 3 [HH]                     //from to neutral_loss
```

```
fraggraph-gen.exe CC 2 * fragonly

0 30.04640161 C[CH3+]        //id mass smiles  - the fragments
1 15.02292652 [CH3+]         //id mass smiles
2 28.03075155 [CH2][CH2+]    //...etc
3 26.01510148 [CH]=[CH+]
4 27.02292652 C#[CH2+]
5 29.03857658 C=[CH3+]
```

### cfm-predict

This program predicts spectra for an input molecule given a pre-trained CFM model. It can also work in batch mode, predicting spectra for a list of molecules in an input file.

**Usage**

```
cfm-predict.exe <smiles_or_inchi_or_file> <prob_thresh> <param_file> <config_file> <annotate_fragments> <output_file_or_dir> <apply_postproc> <suppress_exceptions>
```

*smiles\_or\_inchi\_or\_file:* The smiles or inchi string of the structure whose spectra you want to predict. Or alternatively a .txt file containing a list of space-separated (id, smiles\_or\_inchi) pairs one per line. e.g.

```
Molecule1 CCCNNNC(O)O
Molecule2 InChI=1S/C8H10N4O2/c1-10-4-9-6-5(10)7(13)12(3)8(14)11(6)2/h4H,1-3H3
... etc
```

*prob\_thresh:* (optional) The probability below which to prune unlikely fragmentations during fragmentation graph generation (default 0.001).

*param\_file:* (optional) The filename where the parameters of a trained cfm model can be found (if not given, assumes param\_output.log in current directory). This file is the output of cfm-train. Pre-trained models as used in the above publication can be found in the supplementary data for that paper stored within the source tree of this project. Please see *Which model should I use?* in the FAQ at the bottom of this page.

*config\_file:* (optional) The filename where the configuration parameters of the cfm model can be found (if not given, assumes param\_config.txt in current directory). This needs to match the file passed to cfm-train during training. See cfm-train documentation below for further details. Please see *Which model should I use?* in the FAQ at the bottom of this page.

*annotate\_fragments:*(optional) Whether to include fragment information in the output spectra (0 = NO (DEFAULT), 1 = YES). Note: ignored for msp/mfg output.

*output\_file\_or\_dir:* (optional) The filename of the output spectra file to write to (if not given, prints to stdout). In case of batch mode using file input above, this is used to specify the name of a directory where the output files (<id>.log) will be written (if not given, uses current directory), OR an msp or mgf file.</id>

*apply\_postproc:* (optional) Whether or not to post-process predicted spectra to take the top 80% of energy (at least 5 peaks), or the highest 30 peaks (whichever comes first) (0 = OFF, 1 = ON (default)). If turned off, will output a peak for every possible fragment of the input molecule, as long as the prob\_thresh argument above is set to 0.0.

*suppress\_exceptions:* (optional) Suppress most exceptions so that the program returns normally even when it fails to produce a result (0 = OFF (default), 1 = ON).

**Example**

```
cfm-predict.exe CCCC 0.001 metab_ce_cfm/param_output0.log metab_ce_cfm/param_config.txt

energy0
15.02292652 0.03877135094
27.02292652 0.0004516638069
29.03857658 0.1823948415
31.05422664 0.1285812238
43.05422664 0.54978044
59.08552677 99.10002048
energy1
15.02292652 0.2014284022
27.02292652 0.006349994177
29.03857658 0.9254281728
31.05422664 0.3201026529
43.05422664 1.755347781
59.08552677 96.791343
energy2
15.02292652 0.6774027078
27.02292652 0.2170199999
29.03857658 2.333980325
31.05422664 0.9058884643
43.05422664 27.56483288
59.08552677 68.30087562
```

### cfm-id

Given an input spectrum and a list of candidate smiles (or inchi) strings, this program computes the predicted spectrum for each candidate and compares it to the input spectrum. It returns a ranking of the candidates according to how closely they match. The spectrum prediction is done using a pre-trained CFM model.

**Usage**

```
cfm-id.exe <spectrum_file> <id> <candidate_file> <num_highest> <ppm_mass_tol> <abs_mass_tol>
<prob_thresh> <param_file> <config_file> <score_type> <apply_postprocessing> <output_file> <output_msp_or_mgf>
```

*spectrum\_file:* The filename where the input spectra can be found. This can be a .msp file in which the desired spectrum is listed under a corresponding id (next arg). Or it could be a single file with a list of peaks 'mass intensity' delimited by lines, with either 'low','med' and 'high' lines beginning spectra of different energy levels, or 'energy0', 'energy1', etc. e.g.

```
energy0
65.02 40.0
86.11 60.0
energy1
65.02 100.0 ... etc
```

NOTE: If using a model with three energies (e.g. the trained metab\_se\_cfm or metab\_ce\_cfm in the supplementary data), and you only have one input spectrum, you can either input it at the energy level of closest match to those in the model, or replicate it for all three energies (if unsure, the latter is recommended).

*id:* An identifier for the target molecule (Used to retrieve input spectrum from msp (if used). Otherwise not used but printed to output, in case of multiple concatenated results)

*candidate\_file:* The filename where the input list of candidate structures can be found as line separated 'id smiles\_or\_inchi' pairs.

*num\_highest (optional):* The number of (ranked) candidates to return or -1 for all (if not given, returns all in ranked order).

*ppm\_mass\_tol:* (optional) The mass tolerance in ppm to use when matching peaks within the dot product comparison - will use higher resulting tolerance of ppm and abs (if not given defaults to 10ppm).

*abs\_mass\_tol:* (optional) The mass tolerance in abs Da to use when matching peaks within the dot product comparison - will use higher resulting tolerance of ppm and abs ( if not given defaults to 0.01Da).

*prob\_thresh:* (optional) The probability below which to prune unlikely fragmentations (default 0.001)

*param\_file:* (optional) The filename where the parameters of a trained cfm model can be found (if not given, assumes param\_output.log in current directory). This file is the output of cfm-train. Pre-trained models as used in the above publication can be found in the supplementary data for that paper stored within the source tree of this project. Please see *Which model should I use?* in the FAQ at the bottom of this page.

*config\_file:* (optional) The filename where the configuration parameters of the cfm model can be found (if not given, assumes param\_config.txt in current directory). This needs to match the file passed to cfm-train during training. See cfm-train documentation below for further details. Please see *Which model should I use?* in the FAQ at the bottom of this page.

*score\_type:* (optional) The type of scoring function to use when comparing spectra. Options: Jaccard (default), DotProduct.

*apply\_postprocessing:* (optional) Whether or not to post-process predicted spectra to take the top 80% of energy (at least 5 peaks), or the highest 30 peaks (whichever comes first) (0 = OFF (default for EI-MS), 1 = ON (default for ESI-MS/MS)).

*output\_file:* (optional) The filename of the output spectra file to write to (if not given, prints to stdout)

*output\_msp\_or\_mgf:* (optional) The filename for an output msp or mgf file to record predicted candidate spectra (if not given, doesn't save predicted spectra)

**Example**

```
cfm-id.exe example_spec.txt AN_ID example_candidates.txt 5 10.0 0.01 0.001 metab_ce_cfm/param_output0.log metab_ce_cfm/param_config.txt DotProduct

TARGET ID: NO_ID
1 0.38798085 18232127 NC(Cc1ccc(O)cc1)C(=O)NC(CO)C(=O)NC(CC(=O)O)C(=O)O    //Rank, Score, Id, Smiles
2 0.37921759 18224136 NC(CO)C(=O)NC(Cc1ccc(O)cc1)C(=O)NC(CC(=O)O)C(=O)O
3 0.20393876 18231916 NC(Cc1ccc(O)cc1)C(=O)NC(CC(=O)O)C(=O)NC(CO)C(=O)O
4 0.16378009 59444507 Cc1cc(CN(CC(=O)O)CC(=O)O)nc(CN(CC(=O)O)CC(=O)O)c1
5 0.13664102 18219720 NC(CC(=O)O)C(=O)NC(Cc1ccc(O)cc1)C(=O)NC(CO)C(=O)O
```

### cfm-id-precomputed

As for cfm-id, but the spectra for candidate molecules are read from file.

**Usage**

```
cfm-id-precomputed.exe <spectrum_file> <id> <candidate_file> <num_highest> <ppm_mass_tol> <abs_mass_tol>
<score_type> <output_file>
```

All as for cfm-id, except:

*candidate\_file:* The filename where the input list of candidate structures can be found as line separated 'id smiles\_or\_inchi spectrum\_file' triples. i.e. each entry also specifies a file where the precomputed spectrum should be read from.

*Not needed:* <param\_file>, <config\_file>, <prob\_thresh>, <apply\_postprocessing> are all used to predict the spectra in cfm-id. Since this utility uses precomputed spectra, these arguments are not required here.</apply\_postprocessing></prob\_thresh></config\_file></param\_file>

### cfm-annotate

This program annotates the peaks in a provided set of spectra given a known molecule. It computes the complete fragmentation graph for the provided molecule, and then performs inference within a CFM model to determine the reduced graph that likely occurred. Each peak in the spectrum is then assigned the ids of any fragments in that graph with corresponding mass, and these are listed in order from most likely to least likely.

The output contains the original spectra in the input format, but with fragment id values appended to any annotated peaks. Following an empty line, the reduced fragment graph is then printed in the same format as used in the fullgraph setting for fraggraph-gen, as described above.

**Usage**

```
cfm-annotate.exe <smiles_or_inchi> <spectrum_file> **<id>** <ppm_mass_tol> <abs_mass_tol>
<param_file> <config_file> <output_file>
```

*smiles\_or\_inchi:* The smiles or Inchi string for the input molecule

*spectrum\_file:* The filename where the input spectra can be found. This can be a .msp file in which the desired spectrum is listed under a corresponding id (ne