* [Join/Login](https://sourceforge.net/auth/)
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

[![SourceForge logo](//a.fsdn.com/con/images/sandiego/sf-logo-full.svg)](/ "Home")

[For Vendors](/software/vendors/ "For Vendors")
[Help](/support "Help")
[Create](/create/ "Create")
[Join](/user/registration "Join")
[Login](https://sourceforge.net/auth/ "Login")

[![SourceForge logo](//a.fsdn.com/con/images/sandiego/sf-logo-full.svg)](/ "Home")

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
* [Login](https://sourceforge.net/auth/ "Login")

* [Home](/)
* [Open Source Software](/directory/)
* [Scientific/Engineering](/directory/scientific-engineering/)
* [Bio-Informatics](/directory/bio-informatics/)
* [MiModD](/projects/mimodd/)
* Files

![MiModD](//a.fsdn.com/allura/p/mimodd/icon?1690508753 "MiModD")

# MiModD Files

## Mutation Identification in Model Organism Genomes using Desktop PCs

Brought to you by:
[wm75](/u/wm75/profile/)

* [Summary](/projects/mimodd/)
* [Files](/projects/mimodd/files/)
* [Reviews](/projects/mimodd/reviews/)
* [Support](/projects/mimodd/support)
* [Wiki](/p/mimodd/wiki/)
* [Tickets](/p/mimodd/tickets/)
* [Code](/p/mimodd/source/)
* [Blog](/p/mimodd/blog/)

The interactive file manager requires Javascript. Please enable it or use [sftp or scp](https://sourceforge.net/p/forge/documentation/Release%20Files%20for%20Download#scp).

You may still *browse* the files here.

[![](//a.fsdn.com/con/images/sandiego/sf-icon-black.svg)
Download Latest Version
MiModD-0.1.9.tar.gz (4.3 MB)](/projects/mimodd/files/latest/download "/MiModD-0.1.9/MiModD-0.1.9.tar.gz:  released on 2018-03-21 16:49:52 UTC")

![Email in envelope](//a.fsdn.com/con/images/sandiego/sf_email_icon.svg)

#### Get an email when there's a new version of MiModD

Next

Home

| Name | Modified | Size | InfoDownloads / Week |
| --- | --- | --- | --- |
| [MiModD-0.1.9](/projects/mimodd/files/MiModD-0.1.9/ "Click to enter MiModD-0.1.9") | 2018-03-22 |  | [0](/projects/mimodd/files/MiModD-0.1.9/stats/timeline "449 downloads (all-time), none recently.") |
| [Preconfigured bundled distributions](/projects/mimodd/files/Preconfigured%20bundled%20distributions/ "Click to enter Preconfigured bundled distributions") | 2017-11-27 |  | [0](/projects/mimodd/files/Preconfigured%20bundled%20distributions/stats/timeline "77 downloads (all-time), none recently.") |
| [MiModD-0.1.8](/projects/mimodd/files/MiModD-0.1.8/ "Click to enter MiModD-0.1.8") | 2017-11-15 |  | [0](/projects/mimodd/files/MiModD-0.1.8/stats/timeline "105 downloads (all-time), none recently.") |
| [MiModD-0.1.7.3](/projects/mimodd/files/MiModD-0.1.7.3/ "Click to enter MiModD-0.1.7.3") | 2016-07-21 |  | [0](/projects/mimodd/files/MiModD-0.1.7.3/stats/timeline "159 downloads (all-time), none recently.") |
| [older releases](/projects/mimodd/files/older%20releases/ "Click to enter older releases") | 2016-07-21 |  | [0](/projects/mimodd/files/older%20releases/stats/timeline "100 downloads (all-time), none recently.") |
| [Galaxy Files](/projects/mimodd/files/Galaxy%20Files/ "Click to enter Galaxy Files") | 2015-09-11 |  | [0](/projects/mimodd/files/Galaxy%20Files/stats/timeline "122 downloads (all-time), none recently.") |
| [Example Datasets](/projects/mimodd/files/Example%20Datasets/ "Click to enter Example Datasets") | 2015-01-20 |  | [1 1 weekly downloads](/projects/mimodd/files/Example%20Datasets/stats/timeline "1 weekly downloads") |
| [readme.txt](https://sourceforge.net/projects/mimodd/files/readme.txt/download "Click to download readme.txt") | 2018-03-21 | 24.1 kB | [0](/projects/mimodd/files/readme.txt/stats/timeline "14 downloads (all-time), none recently.") |
|  |  |  |  |
| --- | --- | --- | --- |
| Totals: 8 Items |  | 24.1 kB | [1](/projects/mimodd/files/stats/timeline) |

```
MiModD v0.1.9 - Release Notes
=============================

changes in 0.1.9:
-----------------

Due to a switch in our versioning scheme, this is a maintenance release (, not
a feature release. It fixes compatibility issues with certain versions of
SnpEff, the latest Galaxy release and the upcoming version 3.7 of Python.

If you currently have MiModD 0.1.8 installed and working, there should be no
need for you to upgrade.

bug fixes and maintenance measures:
...................................

- fixed a bug that prevented MiModD from using SnpEff versions 4.1b-4.3i
- the MiModD.enablegalaxy command can now integrate the package into Galaxy
  instances that use a galaxy.yaml instead of a galaxy.ini file (Galaxy
  releases >= 18.01)
- ensured compatibility with the upcoming Python version 3.7 by rebuilding
  pysam with Cython 0.28 (see https://github.com/cython/cython/issues/1955);
  used the opportunity to upgrade pysam from 0.7.6 to 0.7.8
- changed MiModD versioning to follow a standard Major.Minor.Patch scheme
- it is now possible to use the --region and --no-indels/--indels-only filters
  of the vcf-filter tool on VCF input without genotype fields

changes in 0.1.8:
-----------------

This new feature release brings further enhancements to the NacreousMap engine
for linkage analysis and better support for variant annotation and reporting.

enhancements:
.............
- a new rebase tool has been added that allows variant coordinates in a vcf
  file to be ported to a different reference coordinate system based on a
  UCSC chain file-provided mapping
- the old annotate tool has been split into an annotate/varreport pair of
  tools; each new tool now has a simpler command line interface; in addition,
  there are the following advantages to this separation:
  - variant annotation can now be carried out with idempotent external tools
    like SnpEff itself or through its official Galaxy wrappers, while the
    varreport can still be used on the resulting output
  - variants can now be ported (using the new rebase tool) to a different ref
    coordinate system before reporting them
  - variants could be filtered based on annotations before reporting them
    (though MiModD currently provides no support for doing so)
- variant reports generated by the varreport tool are now much richer than
  those produced by the old annotate tool
- the annotate tool has a new option to specify a Codon Table to use in the
  annotation
- a new mapping mode, "Variant Allele Contrast Mapping" has been added to the
  map tool; in this mode, the tool lets you discover regions in the genome, in
  which two of your samples are maximally divergent; use this to map causative
  variants based on two samples, one selected for, the other against a given
  phenotype
- map tool scatter plots show tesselated data for a much improved visual
  impression
- map tool histograms feature an additional kernel density estimate (kde) that
  is independent of the user-configured bin sizes; the kde maximum is reported
  in each contig plot
- map tool histograms are now always normalized so that binned values of a
  given width add up to one across contigs
- indexing enhancements:
  the in-development index tool has been promoted to a regular tool and the old
  snap-index tool been merged into it; the new index tool can now be used to
  generate snap indices, but also samtools-style bam and fasta indices; an
  --index-files option has been added to the varcall and delcall tools to make
  use of precalculated bam indices; when used through their Galaxy tool
  wrappers these tools now make use of bam indices created and managed by
  Galaxy instead of calculating these indices again; this behavior can be
  disabled in the package configuration
- migration to samtools 1.x for internal use has been completed
- it is now possible to configure MiModD to use the runtime working directory
  as the temporary files directory
- simplified Galaxy integration: the enablegalaxy tool will try to expose the
  bundled versions of samtools/bcftools to Galaxy
- most Galaxy tool wrappers have been enhanced and updated to make use of the
  latest features offered by the Galaxy tool interface
- a first-run configuration wizard helps users to choose reasonable
  package-wide settings
- lots of documentation enhancements: improved overall structure, revised
  tutorials and updated other sections

bug fixes (selection):
......................
- the varextract --pre option now works correctly with named samples in the
  input VCF file
- a bug preventing use of the snap-batch tool with the -f option has been fixed
- the snap index -O option is now exposed in the snap-index command line
  interface and in the Galaxy SNAP tool wrapper
- varcall works now with an arbitrary number of contigs in its input files
  (previously the tool could hit the file system limit for open files if there
  was a large number of contigs)
- varcall works reliably now with more than one BAM input file
- varcall will consistently reject BAM/fasta combinations, in which sequences
  mentioned in the BAM header cannot be identified (directly or through MD5 sum
  comparison) in the reference fasta
- the --max-depth option of the varcall tool is working correctly now and got
  properly documented
- parsing of custom hyperlink formatter files finally works as advertised
- the --chr option of the annotate tool, which turned out to be completely
  dysfunctional has been removed; the --minC and --minQ options that were
  redundant with vcf-filter tool functionality and not compatible with newer
  versions of SnpEff have also been removed
- the package now compiles with gcc version 7
- the snap tool works now on the latest versions of macOS

other changes:
..............
- Python 3.2 compatibility has been dropped

changes in 0.1.7.3:
-------------------

Issues addressed in this bug-fix release revolve around better compatibility
with different platforms, compiler and Python versions. In addition, the
command line help system has been improved.

enhancements:
.............
- a new command line help system is now avalaible through:

  mimodd help [subcommand or topic]

  it is more powerful and flexible than the old mimodd [subcommand] --help
  (which is still available though) and, e.g., can provide help for
  administrative and in-development commands through the same interface.
- the upgrade tool has been made significantly more robust and should now work
  on all supported platforms, always report correctly the version upgraded to
  and, except for Python3.2, does not require pip anymore

bug fixes:
..........
see also https://sourceforge.net/p/mimodd/tickets/milestone/0.1.7.3
- incompatibilities in the snap source code that prevented installation from
  source with gcc 6.x have been fixed.
- MiModD is now compatible with Python 3.5.2
- Python 3.2 compatibility is restored (again)
- Python 3.3 compatibility fix
- the info tool can handle bcf files again (was broken in v0.1.7.2 for Python
  versions < 3.5)
- several bugs in the annotate tool have been fixed and yeast genome browser
  links generated by the tool are functional again
- the info tool and all format-specific file parsers consistently recognize and
  raise FormatParseError with empty input files
- the config tool accepts a bare --snpeff option (without a path) and
  interprets it as SnpEff not being installed
- the enablegalaxy tool has been simplified and now requires write permissions
  only for the Galaxy configuration file.
- VCF file parsing can now tolerate missing sample-specific fields
- a bug in the vcf-filter tool has been fixed that caused certain variants to
  be dropped when the tool was used to report just a subset of the samples in
  the original file
- the map tool no longer treats -i/--infer as a plotting option that requires
  rpy2

changes in 0.1.7.2:
-------------------

The major issue addressed by this second bug-fix release in the 0.1.7 series is
explicit rules for and handling of text encoding. In addition, some minor bugs
have been fixed and the sanitize tool has grown a new option.

enhancements:
.............
- throughout MiModD input/output encoding follows clearly defined rules:
  all output is UTF-8 encoded, input is expected to be UTF-8 encoded, but where
  permissible (fasta sequence titles, SAM/BAM comment lines), undecodeable lines
  will trigger a fallback to a one character per byte encoding (latin-1).
- a new -t/--truncate-at option has been added to the sanitize tool, which can
  be used to provide a string at the first occurence of which fasta sequence
  titles should be truncated.
- the config tool will warn about non-existing directories in settings and tools
  relying on the tmpfiles directory will fail with a clear error message if the
  folder does not exist.

bug fixes:
..........
- installation does not fail with ASCII-incompatible platform encoding settings
  anymore.
- fixed a typo in the map tool command line interface.
- fixed a bug in the NacreousMap engine affecting incompletely determined
  genotypes.

changes in 0.1.7.1:
-------------------

This first bug-fix release for the 0.1.7 series, mostly addresses problems
with the new map tool introduced in v0.1.7.0.

enhancements:
.............
- the map tool, when run in VAF mode, used to count only variants that appeared
  "pure" (i.e., no evidence for another allele was allowed) for the predominant
  related sample allele, but this strict behavior of discarding nearly pure
  variants caused poor performance when only few variants were available for
  mapping. The algorithm has now been changed to weigh variants by their
  pureness making it possible to use also information from not quite pure sites
  (though they contribute less to an analysis). This has hardly any effect on
  analyses with many thousands of variants, but significantly improves results
  for analyses relying on less markers.
- the map tool in VAF mode now skips plots of contigs for which there is no
  data
- improved y-axis scaling for linkage plots produced by the map tool
- in VAF mode a Loess span of zero can now be specified to indicate that no
  Loess lines should be calculated
- the varcall tool gives nicer status messages

bug-fixes:
..........
see also https://sourceforge.net/p/mimodd/tickets/milestone/0.1.7.1

- restored Python 3.2 compatibility accidentally broken in previous releases
- made MiModD compatible with OS X 10.11 El Capitan
- made from sour