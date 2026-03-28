[ ]
[ ]

![HyPhy Logo](../../images/header-logo.svg)
HyPhy
Hypothesis Testing using Phylogenies

![HyPhy Logo](../../images/header-logo.svg)
HyPhy

[![](../../images/logo.svg)](../..)

* [Home](../.. "Home")
* [News and Releases](../../news/ "News and Releases")
* [About](../../about/ "About")
* [Installation](../../installation/ "Installation")
* [Getting Started](../../getting-started/ "Getting Started")
* [Methods](../../methods/general/ "Methods")
* [Selection](../../methods/selection-methods/ "Selection")
* Tutorials

  + [CLI Tutorial](./ "CLI Tutorial")
  + [CL Prompt Tutorial](../CL-prompt-tutorial/ "CL Prompt Tutorial")
* Batch Language

  + [Reference](../../hbl-reference/ "Reference")
  + [Library](../../hbl-reference/libv3/ "Library")
* [Resources](../../resources/ "Resources")

# Using HyPhy as a standard command line tool[#](#using-hyphy-as-a-standard-command-line-tool "Permanent link")

As of version 2.4.0 HyPhy is a bona fide command line tool.
An executable with key-word arguments, relative paths to files and sane defaults.
The interactive command line prompt is still available if you prefer that (simply run `hyphy -i`).
This page provides some general information about using HyPhy as a command line tool; the older [command line prompt tutorial](../CL-prompt-tutorial/) provides more details about each method.

Like any command line tool, to see the available options simply run `hyphy --help`.

Once you've [installed hyphy](../../installation/) run the method of your choice like so (we'll use SLAC for demonstration purposes):

`hyphy slac --alignment CD2.nex`

If your tree is in a separate file (not the same file as the alignment) add a `--tree` flag.

`hyphy slac --alignment CD2.fasta --tree CD2.newick`

Most methods require only an alignment and a tree.
Default values are used for any other option.
To see a list of the available options for a method run `hyphy <method_name> --help` (`hyphy slac --help` in our example).

Key word arguments and interactive prompts can be mixed by including `-i` before any key word arguments.
For example:
`hyphy -i slac --alignment CD2.fasta --code Universal`
Will begin a slac analysis with CD2.fasta using the universal genetic code and prompt you for all the non-specified options: a tree file, branch selection, number of samples for ancestral state reconstruction, p-value.

Markdown-formatted status indicators will be printed to stdout as the analysis runs.
Final results will be saved in a JSON-formatted file (saved in the same directory as the alignment file unless a `--output` argument is provided). This JSON results file can be uploaded at [vision.hyphy.org](http://vision.hyphy.org) for an interactive visualization of the results.

To see a list of the methods that can be run with a command line invocation run `hyphy --help`.

HyPhy development has received support from the NIH ([R01GM151683](https://projectreporter.nih.gov/project_info_details.cfm?aid=10729148),
[U01GM110749](https://projectreporter.nih.gov/project_info_details.cfm?aid=9102131),
[U24AI183870](https://reporter.nih.gov/project-details/10914501),
[R01GM093939](https://reporter.nih.gov/project-details/10914501)), and the NSF ([2027196](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2027196),
[2419522](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2419522)).