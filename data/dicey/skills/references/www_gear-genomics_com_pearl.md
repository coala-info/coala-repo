# Pearl

Patching references via trace assemblies.

 [Get help](https://www.gear-genomics.com/contact)  ·  [Citation](https://www.gear-genomics.com/citation)  ·  [Source](https://github.com/gear-genomics/pearl)

* [Input](#input-tab)
* [Results](#result-tab)
* [Help](#help-tab)

Chromatogram files (`.scf`, `.abi`, `.ab1`, `.ab!` or `.ab`)

Optional reference FASTA file (single sequence, `.fa`)

[ ] Treat secondary peaks as conflicts.

   Launch Analysis    Show Example

Load multiple alignment file (`.json`)

Save multiple alignment file (JSON)

Save user sequence (FA)

Analysis is running, please be patient.

#### Application Description

Pearl is a tool to patch a DNA references with several sanger trace files. It has two main applications: (Parts) of a reference sequence (fasta file, \*.fa) can be sequenced and Pearl highlights the conflicts and mismatches between reference and the trace files. If no reference is provided, a consensus sequence is assembled and used instead.

 Pearl provides a color-coded overview:
 light green - consensus: all traces agree on same base
 red - mismatch: traces agree on different base then reference
 orange - conflict: conflict, some traces suggest other bases
 green - edited: the base was entered manually by the user
 grey - no information: only reference data available

 By design, Pearl focuses only on one location, the position given below the overview. A position can be selected by clicking at a position in the overview, by changing the number in the position field or by navigating the trace windows.

 The available traces can be reviewed by the user at the given position and set to a certain base. Once all mismatches and conflicts are edited by the user, the sequence can be exported as fasta. The entire dataset including the traces can be saved as JSON file and uploaded in the result section later.

#### Accepted Input

The trace files can be provided in abi or scf trace format (\*.scf, \*.abi, \*.ab1, \*.ab! and \*.ab). The reference must be a fasta file (\*.fa).

#### Sample Data

The "Show Example" button loads nine sample trace files (click to download file [1,](static/bin/sample_1.abi) [2,](static/bin/sample_2.abi) [3,](static/bin/sample_3.abi) [4,](static/bin/sample_4.abi) [5,](static/bin/sample_5.abi) [6,](static/bin/sample_6.abi) [7,](static/bin/sample_7.abi) [8,](static/bin/sample_8.abi) [9](static/bin/sample_9.abi) ) and aligns it to a sample reference fasta file [(click to download file)](static/bin/sample.fa).

[GEAR ~](https://www.gear-genomics.com)  ·  ·  [Terms of Use](https://www.gear-genomics.com/terms)  ·  [Contact Us](https://www.gear-genomics.com/contact)

Supported by  [![EMBL logo](embl.fe35cb76.svg)](https://www.embl.de/)