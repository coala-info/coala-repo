[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
  + [fpcat](fpcat_command.html)
  + [cdk2fps](cdk2fps_command.html)
  + [ob2fps](ob2fps_command.html)
  + [oe2fps](oe2fps_command.html)
  + rdkit2fps
    - [rdkit2fps command-line options](#rdkit2fps-command-line-options)
    - [Supported rdkit2fps formats](#supported-rdkit2fps-formats)
  + [sdf2fps](sdf2fps_command.html)
  + [simsearch](simsearch_command.html)
  + [chemfp](chemfp_command.html)
  + [chemfp butina](chemfp_butina_command.html)
  + [chemfp csv2fps](chemfp_csv2fps_command.html)
  + [chemfp fpc2fps](chemfp_fpc2fps_command.html)
  + [chemfp fpb\_text](chemfp_fpb_text_command.html)
  + [chemfp fps2fpc](chemfp_fps2fpc_command.html)
  + [chemfp heapsweep](chemfp_heapsweep_command.html)
  + [chemfp license](chemfp_license_command.html)
  + [chemfp maxmin](chemfp_maxmin_command.html)
  + [chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html)
  + [chemfp report](chemfp_report_command.html)
  + [chemfp shardsearch](chemfp_shardsearch_command.html)
  + [chemfp simarray](chemfp_simarray_command.html)
  + [chemfp simhistogram](chemfp_simhistogram_command.html)
  + [chemfp spherex](chemfp_spherex_command.html)
  + [chemfp toolkits](chemfp_toolkits_command.html)
  + [chemfp translate](chemfp_translate_command.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1b1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* [The chemfp command-line tools](tool_help.html)
* rdkit2fps

---

# rdkit2fps[](#rdkit2fps "Link to this heading")

The “rdkit2fps” command (also available as the “chemfp rdkit2fps”
subcommand) uses the RDKit toolkit to [generate binary RDKit
fingerprints](tools.html#chemfp-rdkit2fps-intro) from structure files.

The following reads the ChEMBL 36 SDF, generates the RDKit
Daylight-like fingerprints, and saves them to an FPB file. It then
does a similiarity search using query structures in SMILES format.

```
% rdkit2fps --RDK chembl_36.sdf.gz -o chembl_36_rdk.fpb
% simsearch -k 10 --queries queries.smi chembl_36_rdk.fpb --out csv
```

For more examples see [Generate fingerprints with RDKit](tools.html#chemfp-rdkit2fps-intro).

This functionality is also available from Python using the high-level
[`chemfp.rdkit2fps()`](chemfp_toplevel.html#chemfp.rdkit2fps "chemfp.rdkit2fps") function, following chemfp’s [“\*2fps”](getting_started_api.html#to-fps-api) API.

The rest of this chapter contains the output from [rdkit2fps
--help](#rdkit2fps-help) and [rdkit2fps
--help-formats](#rdkit2fps-help-formats). The latter describes
the supported input formats and reader options.

## rdkit2fps command-line options[](#rdkit2fps-command-line-options "Link to this heading")

The following comes from `rdkit2fps --help`:

```
Usage: rdkit2fps [OPTIONS] [FILENAMES]...

  Generate fingerprints from a structure file using RDKit.

  If specified, process the filenames, otherwise read from stdin.

Fingerprint types:
  --RDK, --RDK/3                  Generate RDK/3 fingerprints.
  --RDK/2                         Generate RDK/2 fingerprints.
  --morgan1, --morgan1/2          Generate Morgan/2 fingerprints (radius=1).
  --morgan2, --morgan2/2          Generate Morgan/2 fingerprints (radius=2).
  --morgan, --morgan/2, --morgan3, --morgan3/2
                                  Generate Morgan/2 fingerprints (radius=3)
                                  (--morgan is the default fingerprint type).
  --morgan4, --morgan4/2          Generate Morgan/2 fingerprints (radius=4).
  --morgan1/1                     Generate Morgan/1 fingerprints (radius=1).
  --morgan/1, --morgan2/1         Generate Morgan/1 fingerprints (radius=2).
  --morgan3/1                     Generate Morgan/1 fingerprints (radius=3).
  --morgan4/1                     Generate Morgan/1 fingerprints (radius=4).
  --torsion, --torsions, --torsion/4
                                  Generate Topological Torsion/4 fingerprints.
  --torsion/3                     Generate Topological Torsion/3 fingerprints.
  --pair, --pairs, --pair/3       Generate AtomPair/3 fingerprints.
  --pair/2                        Generate AtomPair/2 fingerprints.
  --maccs166, --maccs             Generate MACCS fingerprints.
  --avalon                        Generate Avalon fingerprints.
  --pattern                       Generate (substructure) pattern
                                  fingerprints.
  --secfp                         Generate SECFP fingerprints, a circular
                                  fingerprint based on fragment SMILES instead
                                  of hashing.
  --KlekotaRoth                   Generate the 4860-bit Klekota-Roth
                                  privileged substructure fingerprints.
  --substruct                     Generate chemfp's PubChem-like substructure
                                  fingerprints.
  --rdmaccs, --rdmaccs/2          Generate chemfp's MACCS fingerprints,
                                  version 2.
  --rdmaccs/1                     Generate chemfp's MACCS fingerprints,
                                  version 1.
  --type TYPE_STR                 Specify a chemfp type string
  --using FILENAME                Get the fingerprint type from the metadata
                                  of a fingerprint file

Fingerprint options:
  --fpSize INT                    number of bits in the fingerprint
                                  [AtomPair/2, AtomPair/3, Avalon, Morgan/1,
                                  Morgan/2, Pattern, RDKit/2, RDKit/3, SECFP,
                                  Torsion/3, Torsion/4]
  --minPath INT                   Minimum number of bonds to include in the
                                  subgraph (default=1) [RDKit/2, RDKit/3]
  --maxPath INT                   Maximum number of bonds to include in the
                                  subgraph (default=7) [RDKit/2, RDKit/3]
  --nBitsPerHash INT              Number of bits to set per path (default=2)
                                  [RDKit/2]
  --useHs 0|1                     Include information about the number of
                                  hydrogens on each atom (default=1) [RDKit/2,
                                  RDKit/3]
  --branchedPaths 0|1             If 1, both branched and unbranched paths
                                  will be used in the fingerprint (default=1)
                                  [RDKit/2, RDKit/3]
  --useBondOrder 0|1              If 1, both bond orders will be used in the
                                  path hashes (default=1) [RDKit/2, RDKit/3]
  --fromAtoms, --from-atoms INT,INT,...
                                  List of atom indices to use (default=None)
                                  [AtomPair/2, AtomPair/3, Morgan/1, Morgan/2,
                                  RDKit/2, RDKit/3, Torsion/3, Torsion/4]
  --countSimulation 0|1|rdkit|superimposed
                                  if 'superimpose', simulate count
                                  fingerprints with random superimposed
                                  coding, if '1' use RDKit's countsim method,
                                  otherwise ignore count. (default=1 for
                                  AtomPair/3, otherwise 0) [AtomPair/3,
                                  Morgan/2, RDKit/3, Torsion/4]
  --countBounds INT,INT,...       list of minimum counts needed to set the
                                  corresponding bit during count simulation,
                                  eg, '1,2,4,8' (default=None) [AtomPair/3,
                                  Morgan/2, RDKit/3, Torsion/4]
  --numBitsPerFeature INT         Number of bits to set per path (default=2)
                                  [RDKit/3]
  --radius INT                    radius for the Morgan or SECFP fingerprints
                                  [Morgan/1, Morgan/2, SECFP]
  --useFeatures 0|1               if 1, use chemical-feature invariants
                                  (default=0) [Morgan/1, Morgan/2]
  --useChirality 0|1              if 1, include chirality information
                                  (default=0) [Morgan/1]
  --useBondTypes 0|1              if 1, include bond type information
                                  (default=1) [Morgan/1, Morgan/2]
  --includeRedundantEnvironments 0|1
                                  if 1, include redundant environments in the
                                  fingerprint (default=0) [Morgan/1, Morgan/2]
  --includeChirality 0|1          include chirality information [AtomPair/2,
                                  AtomPair/3, Morgan/2, Torsion/3, Torsion/4]
  --includeRingMembership 0|1     if 1, include ring membership in the atom
                                  invariants (default=1) [Morgan/2]
  --minLength INT                 Minimum bond count for a pair (default=1)
                                  [AtomPair/2]
  --maxLength INT                 Maximum bond count for a pair (default=30)
                                  [AtomPair/2]
  --nBitsPerEntry INT             Number of bits per entry (default=4)
                                  [AtomPair/2, Torsion/3]
  --use2D 0|1                     If 1, use 2D instead of 3D distance matrix
                                  (default=1) [AtomPair/2, AtomPair/3]
  --minDistance INT               minimum bond distance for two atoms to be
                                  considered a pair (default=1) [AtomPair/3]
  --maxDistance INT               maximum bond distance for two atoms to be
                                  considered a pair (default=30) [AtomPair/3]
  --targetSize INT                Number of bonds per torsion (default=4)
                                  [Torsion/3]
  --torsionAtomCount INT          the number of atoms to include in the
                                  'torsions' (default=4) [Torsion/4]
  --onlyShortestPaths 0|1         if 1, only include the shortest paths
                                  between the start and end atoms, not all
                                  paths (default=0) [Torsion/4]
  --isQuery 0|1                   Is the fingerprint for a query structure? (1
                                  if yes, 0 if no) (default=0) [Avalon]
  --bitFlags INT                  Bit flags, SSSBits are 32767 and similarity
                                  bits are 15761407 (default=15761407)
                                  [Avalon]
  --rings 0|1                     If 1, add SSSR ring to the fingerprint
                                  (default=1) [SECFP]
  --isomeric 0|1                  If 1, use isomeric SMILES instead of non-
                                  isomeric SMILES (default=0) [SECFP]
  --kekulize 0|1                  If 1, use Kekule SMILES instead of aromatic
                                  SMILES (default=0) [SECFP]
  --min_radius, --min-radius INT  Minimum radius used to extract n-grams
                                  (default=1) [SECFP]

Options:
  --id-tag TAG                    Tag name containing the record id (SD files
                                  only)
  --delimiter VALUE               Delimiter style for SMILES and InChI files.
                                  Forces '-R delimiter=VALUE'.
  --has-header                    Skip the first line of a SMILES or InChI
                                  file. Forces '-R has_header=1'.
  -R NAME=VALUE                   Specify a reader argument
  --cxsmiles / --no-cxsmiles      Use --no-cxsmiles to disable the default
                                  support for CXSMILES extensions. Forces '-R
                                  cxsmiles=1' or '-R cxsmiles=0'.
  --in FORMAT                     Input structure format (default guesses from
                                  filename)
  -o, --output FILENAME           Save the fingerprints to FILENAME
                                  (default=stdout)
  --out FORMAT                    Output structure format (default guesses
                                  from output filename, or is 'fps')
  --include-metadata / --no-metadata
                                  With --no-metadata, do not include the
                                  header metadata for FPS output.
  --no-date                       Do not include the 'date' metadata in the
                                  output header
  --date STR                      An ISO 8601 date (like
                                  '2025-02-07T11:10:15') to use for the 'date'
                                  metadata in the output header
  --errors [strict|report|ignore]
                                  How should structure parse errors be
                                  handled? (default=ignore)
  --progress / --no-progress      Show a progress bar (default: show unless
                                  the output is a terminal)
  --help-formats                  List the available formats and reader
                                  arguments
  --version                       Show the version and exit.
  --license-check                 Check the license and report results to
                                  stdout.
  --help                          Show this message and exit.

  This program guesses the input structure format and the compression based on
  the filename extension. If the guess fails then it assumes the input is an
  uncompressed SMILES file.

  If the data comes from stdin, or the guess based on extension name is wrong,
  then use "--in" to change the default input format.

  Use the '-R' reader arguments option to pass in format-specific structure
  reader arguments. The details depend on the specific format.

  Use the command-line option `--help-formats` to display a list of available
  formats and reader arguments.

  NOTE: The --RDK/2, --morgan/1 and --pair/2 fingerprints types use RDKit's
  older function API to generate fingerprints while --RDK/3, --morgan/2, and
  --pair/3 use the newer generator API. While the core approaches are the
  same, parameter names have changed, as well as some of the generation
  details, so the resulting fingerprints may have changed.

  In particular, the default --morgan radius is now 3 instead of 2!
```

## Supported rdkit2fps formats[](#supported-rdkit2fps-formats "Link to this heading")

The following comes from `rdkit2fps --help-formats`:

```
These are the structure file 