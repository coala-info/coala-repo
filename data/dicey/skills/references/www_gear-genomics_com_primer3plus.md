| Primer3Plus  pick primers from a DNA sequence | [More...](primer3plusPackage.html) | [Source Code](https://github.com/primer3-org/primer3plus) |
| [Help](primer3plusHelp.html) | [About](primer3plusAbout.html) |

| Load server settings:    Default     Task:   generic pick cloning primers pick discriminative primers pick sequencing primers pick primer list check primers | Select primer pairs to detect the given template sequence. Optionally targets and included/excluded regions can be specified.  Mark an included region to pick primers 5' fixed at its the boundaries. The quality of the primers might be low.  Mark an target to pick primers 3' fixed at its the boundaries. The quality of the primers might be low.  Pick a series of primers on both strands for sequencing. Optionally the regions of interest can be marked using targets.  Returns a list of all possible primers the can be designed on the template sequence. Optionally targets and included/exlcuded regions can be specified.  Evaluate a primer of known sequence with the given settings. | |  |  | | --- | --- | |  |  | |

Fatal Error: Primer3Plus requires JavaScript. JavaScript is not enabled, please enable JavaScript and refresh the browser..

|  |  |

|  |  |

|  |  |

* Main
* General Settings
* Advanced Settings
* Internal Oligo
* Penalties
* Advanced Seq.
* D
* Results

Sequence Id:

 Paste template sequence below or upload sequence file:

| Mark selected region: |  |  |  |  |  |  |

|  |  |  | Primer oligos may not overlap any region specified in this tag. The associated value must be a space-separated list of start,length. E.g. 401,7 68,3 forbids selection of primers in the 7 bases starting at 401 and the 3 bases at 68.  Or mark the template sequence with < and >:  e.g. ...ATCT<CCCC>TCAT.. forbids primers in the central CCCC.  If one or more Targets is specified then a primer pair must flank at least one of them. The value should be a space-separated list of start,length pairs. E.g. 50,2 requires primers to surround the 2 bases at positions 50 and 51.  Or mark the template sequence with [ and ]: e.g. ...ATCT[CCCC]TCAT..  means that primers must flank CCCC.  A sub-region of the given sequence in which to pick primers. The value for this parameter has the form start,length. E.g. 20,400: only pick primers in the 400 base region starting at position 20.  Or use { and } in the template sequence to mark the beginning and end of the included  region: e.g. in ATC{TTC...TCT}AT the included region is TTC...TCT.  A list of positions in the given sequence. The value for this parameter has the form position. E.g. 120: only pick primers overlaping the position 120.  Or use - in the template sequence to mark the position. Primer3 tries to pick primer pairs were the forward or the reverse primer overlaps one of these positions.  This tag allows detailed specification of possible locations of left and right primers in primer pairs. The associated value must be a semicolon-separated list of <left\_start>,<left\_length>,<right\_start>,<right\_length>  quadruples.  Please consult the help for detailed instructions. |  |
| Excluded Regions: | < | > |
| Targets: | [ | ] |
| Included Region: | { | } |
| Primer overlap positions: | - |  |
| Pair OK Region List: |  |  |

| [ ]  Pick left primer | [ ]  Pick hybridization probe | [ ]  Pick right primer |
| or use left primer below. | (internal oligo) or use oligo below. | or use right primer  below (5'->3' on opposite strand). |
|  |  |  |
| 5' Overhang: |  | 5' Overhang: |

Product Size Ranges

| Primer Size | Min: | Opt: | Max: |  |
| Primer Tm | Min: | Opt: | Max: | Max Tm Difference: |
| Primer Bound% | Min: | Opt: | Max: | Annealing Temp: |
| Primer GC% | Min: | Opt: | Max: |  |

| Concentration of monovalent cations: |  | ANNEALING Oligo Concentration: |  | Not the concentration of oligos in the reaction mix! |
| Concentration of divalent cations: |  | Concentration of dNTPs: |  |  |
| DMSO Concentration: |  | Formamide Concentration: |  |  |
| DMSO Factor: |  |  |  |  |

Mispriming/Repeat Library:  NONE

**Load and Save**

To upload or save a settings file from your local computer, choose here:

Load only Settings from file:

| Max Poly-X: |  | Table of thermodynamic parameters: | Breslauer et al. 1986 SantaLucia 1998 |
| Max #N's: |  | Salt correction formula: | Schildkraut and Lifson 1965 SantaLucia 1998 Owczarzy et. 2004 |
| CG Clamp: |  | Use Thermodynamic Primer Alignment: | [ ]  Activates Settings Starting with TH: |
| Max End GC: |  | Use Thermodynamic Template Alignment: | [ ]  Activates TH: Settings-VERY SLOW |
| Number To Return: |  | Max End Stability: |  |
| 5 Prime Junction Overlap: |  | 3 Prime Junction Overlap: |  |
| Min Left Primer End Distance: |  | Min Right Primer End Distance: |  |
| Max Self Complementarity: |  | Max Pair Complementarity: |  |
| TH: Max Self Complementarity: |  | TH: Max Pair Complementarity: |  |
| Max End Self Complementarity: |  | Max Pair End Complementarity: |  |
| TH: Max End Self Compl.: |  | TH: Max Pair End Complementarity: |  |
| TH: Max Hairpin: |  |  |  |
| Max Template Mispriming: |  | Pair Max Template Mispriming: |  |
| TH: Max Template Mispriming: |  | TH: Pair Max Template Mispriming: |  |
| Max Library Mispriming: |  | Pair Max Library Mispriming: |  |
| Primer Must Match 5 Prime: |  | Primer Must Match 3 Prime: |  |
| Left Primer Acronym: |  | Internal Oligo Acronym: |  |
| Right Primer Acronym: |  | Primer Name Spacer: |  |

| Product Tm | Min: | Opt: | Max: | [ ]  Show Secondary Structures |
| Product Size | Min: | Opt: | Max: | [ ]  Debug Information |

[ ]  Pick Anyway     [ ]  Liberal Base     [ ]  Do not treat ambiguity codes in libraries as consensus     [ ]  Use Lowercase Masking

**Sequencing**

| Lead |  | primer to readable sequence | Spacing |  | fw-primer to fw-primer |
| Accuracy |  | flexibility of primer position | Interval |  | fw-primer to rv-primer |

| Excluded Regions for Internal Oligo: |  |
| Internal Oligo Overlap Positions: |  |

| Hyb Oligo Size: | Min: | Opt: | Max: |  |
| Hyb Oligo Tm: | Min: | Opt: | Max: |  |
| Hyb Oligo Bound%: | Min: | Opt: | Max: |  |
| Hyb Oligo GC% | Min: | Opt: | Max: |  |

| Hyb Oligo Monovalent Cations Concentration: |  | Hyb Oligo DNA Concentration: |  |
| Hyb Oligo Divalent Cations Concentration: |  | Hyb Oligo dNTP Concentration: |  |
| Hyb Oligo DMSO Concentration: |  | Hyb Oligo Formamide Concentration: |  |
| Hyb Oligo DMSO Factor: |  |  |  |
| Max #Ns: |  | Hyb Oligo Max Poly-X: |  |
| Hyb Oligo 5 Prime Junction Overlap: |  | Hyb Oligo 3 Prime Junction Overlap: |  |
| Min Hyb Oligo End Distance: |  |  |  |
| Hyb Oligo Self Complementarity: |  | Hyb Oligo Max End Self Complementarity: |  |
| TH: Hyb Oligo Self Complementarity: |  | TH: Hyb Oligo Max End Self Complementarity: |  |
| TH: Hyb Oligo Max Hairpin: |  | Max Library Mishyb: |  |
| Must Match 5 Prime: |  | Must Match 3 Prime: |  |
| Hyb Oligo Mishyb Library: | NONE | | |
| Hyb Oligo Min Sequence Quality: |  |  |  |

| For Primers | For Internal Oligos | For Primer Pairs |

| Size | Lt: |  | Gt: |  | Size | Lt: |  | Gt: |  | Product Size | Lt: |  | Gt: |  |
| Tm | Lt: |  | Gt: |  | Tm | Lt: |  | Gt: |  | Tm Difference |  |  |  |  |
| Bound | Lt: |  | Gt: |  | Bound | Lt: |  | Gt: |  |  |  |  |  |  |
| GC% | Lt: |  | Gt: |  | GC% | Lt: |  | Gt: |  | Product Tm | Lt: |  | Gt: |  |

| Template Mispriming |  |  |  | Template Mispriming |  |
| TH: Template Mispriming |  |  |  | TH: Template Mispriming |  |
| Library Mispriming |  | Library Mishyb |  | Library Mispriming |  |
| Self Complementarity |  | Self Complementarity |  | Pair Complementarity |  |
| TH: Self Complementarity |  | TH: Self Complementarity |  | TH: Pair Complementarity |  |
| End Self Complementarity |  | End Self Complementarity |  | Pair End Complementarity |  |
| TH: End Self Complementarity |  | TH: End Self Complementarity |  | TH: Pair End Complementarity |  |
| TH: Hairpin |  | TH: Hairpin |  |  |  |
| #N's |  | Hyb Oligo #N's |  |  |  |
| Sequence Quality |  | Sequence Quality |  |  |  |
| End Sequence Quality |  | End Sequence Quality |  |  |  |
| Position Penalty |  |  |  |  |  |
| End Stability |  |  |  | Primer Penalty Weight |  |
| Inside Target Penalty: |  |  |  | Hyb Oligo Penalty Weight |  |
| Outside Target Penalty: |  |  |  |  |  |
| Set Inside Target Penalty to allow primers inside a target. | |  |  |  |  |

| Force Left Primer Start: |  | Force Right Primer Start: |  |  |
| Force Left Primer End: |  | Force Right Primer End: |  |  |
| First Base Index: |  | Sequence Quality: | | |
| Start Codon Position: |  |  | | |
| Start Codon Sequence: |  |
| Min Sequence Quality: |  |
| Min End Sequence Quality: |  |
| Sequence Quality Range Min: |  |
| Sequence Quality Range Max: |  |

## Primer3 Debug Information

### Primer3 Input:

### Primer3 Output:

**Primer3 is running, please be patient. It may take up to one minute to calculate the results.**

**The page will update automatically, do not reload.**

GEAR + Primer3 ~  [Home](https://www.gear-genomics.com)  ·  [GEAR-GitHub](https://github.com/gear-genomics)  ·  [Primer3-GitHub](https://github.com/primer3-org)  ·  [Terms of Use](https://www.gear-genomics.com/terms)  ·  [Contact Us](https://www.gear-genomics.com/contact)

Supported by [EMBL](https://www.embl.de)