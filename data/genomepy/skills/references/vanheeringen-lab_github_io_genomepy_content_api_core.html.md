[genomepy](../index.html)

* [Home](../index.html)
* [Installation](installation.html)
* [Command line documentation](command_line.html)
* Python API documentation (core)
  + [Finding genomic data](#finding-genomic-data)
  + [Installing genomic data](#installing-genomic-data)
  + [Errors](#errors)
  + [Using a genome](#using-a-genome)
  + [Using a gene annotation](#using-a-gene-annotation)
* [Python API documentation (full)](../_autosummary/genomepy.html)
* [Configuration](config.html)
* [FAQ](help_faq.html)
* [About](about.html)

[genomepy](../index.html)

* Python API documentation (core)
* [Edit on GitHub](https://github.com/vanheeringen-lab/genomepy/blob/develop/docs/content/api_core.rst)

---

# Python API documentation (core)[](#python-api-documentation-core "Permalink to this heading")

This page described the core genomepy functionality.
These classes and functions can be found on the top level of the genomepy module (e.g. `genomepy.search`),
and are made available when running `from genomepy import *` (we won’t judge you).

Additional functions that do not fit the core functionality, but we feel are still pretty cool, are also described.

## Finding genomic data[](#finding-genomic-data "Permalink to this heading")

When looking to download a new genome/gene annotation, your first step would be `genomepy.search`.
This function will check either one, or all, providers.
Advanced users may want to specify a provider for their search to speed up the process.
To see which providers are available, use `genomepy.list_providers` or `genomepy.list_online_providers`:

---

genomepy.list\_providers()
:   List of providers genomepy supports

    Returns
    :   names of providers

    Return type
    :   list

genomepy.list\_online\_providers()
:   List of providers genomepy supports *that are online right now*.

    Returns
    :   names of online providers

    Return type
    :   list

genomepy.search(*term: str*, *provider: str = None*, *exact=False*, *size=False*)
:   Search for term in genome names and descriptions (if term contains text. Case-insensitive),
    assembly accession IDs (if term starts with [GCA\_](#id1) or [GCF\_](#id3)),
    or taxonomy IDs (if term is a number).

    If provider is specified, search only that specific provider, else search all providers.

    Note: exact accession ID search on UCSC may return different patch levels.

    Parameters
    :   * **term** (*str**,* *int*) – Search term, case-insensitive, allows regex.
        * **provider** (*str* *,* *optional*) – Only search the specified provider (faster).
        * **exact** (*bool**,* *optional*) – term must be an exact match
        * **size** (*bool**,* *optional*) – Show absolute genome size.

    Yields
    :   *list* – genome name, provider and metadata

---

If you have no idea what you are looking for, you could even check out *all* available genomes.
Be warned, `genomepy.list_available_genomes` is like watching the Star Wars title crawl.

---

genomepy.list\_available\_genomes(*provider=None*, *size=False*) → list
:   List all available genomes.

    Parameters
    :   * **provider** (*str**,* *optional*) – List genomes from specific provider. Genomes from all
          providers will be returned if not specified.
        * **size** (*bool**,* *optional*) – Show absolute genome size.

    Yields
    :   *list* – tuples with genome name, provider and metadata

---

If we search for homo sapiens for instance, we find that `GRCh3.p13` and `hg38` are the latest versions.
These names describe the same genome, but different `assemblies`, with differences between them.

One of these differences is the quality of the gene annotation.
Next, we can inspect these with `genomepy.head_annotations`:

---

genomepy.head\_annotations(*name: str*, *provider=None*, *n: int = 2*)
:   Quickly inspect the metadata of each available annotation for the specified genome.

    For UCSC, up to 4 gene annotation styles are available:
    “ncbiRefSeq”, “refGene”, “ensGene”, “knownGene” (respectively).

    For NCBI, the chromosome names are not yet sanitized.

    Parameters
    :   * **name** (*str*) – genome name
        * **provider** (*str**,* *optional*) – only search the specified provider for the genome name
        * **n** (*int**,* *optional*) – number of lines to show

---

## Installing genomic data[](#installing-genomic-data "Permalink to this heading")

Now that you have seen whats available, its time to download a genome.
The default parameter for `genomepy.install_genome` are optimized for sequence alignment and gene counting,
but you have full control over them, so have a look!

genomepy won’t overwrite any files you already downloaded (unless specified),
but you can review your local genomes with `genomepy.list_installed_genomes`.

---

genomepy.install\_genome(*name: str*, *provider: Optional[str] = None*, *genomes\_dir: Optional[str] = None*, *localname: Optional[str] = None*, *mask: Optional[str] = 'soft'*, *keep\_alt: Optional[bool] = False*, *regex: Optional[str] = None*, *invert\_match: Optional[bool] = False*, *bgzip: Optional[bool] = None*, *annotation: Optional[bool] = False*, *only\_annotation: Optional[bool] = False*, *skip\_matching: Optional[bool] = False*, *skip\_filter: Optional[bool] = False*, *threads: Optional[int] = 1*, *force: Optional[bool] = False*, *\*\*kwargs: Optional[dict]*) → [Genome](../_autosummary/genomepy.genome.Genome.html#genomepy.genome.Genome "genomepy.genome.Genome")
:   Install a genome (& gene annotation).

    Parameters
    :   * **name** (*str*) – Genome name
        * **provider** (*str* *,* *optional*) – Provider name. will try Gencode, Ensembl, UCSC and NCBI (in that order) if not specified.
        * **genomes\_dir** (*str* *,* *optional*) – Where to create the output folder.
        * **localname** (*str* *,* *optional*) – Custom name for this genome.
        * **mask** (*str* *,* *optional*) – Genome masking of repetitive sequences. Options: hard/soft/none, default is soft.
        * **keep\_alt** (*bool* *,* *optional*) – Some genomes contain alternative regions. These regions cause issues with
          sequence alignment, as they are inherently duplications of the consensus regions.
          Set to true to keep these alternative regions.
        * **regex** (*str* *,* *optional*) – Regular expression to select specific chromosome / scaffold names.
        * **invert\_match** (*bool* *,* *optional*) – Set to True to select all chromosomes that *don’t* match the regex.
        * **bgzip** (*bool* *,* *optional*) – If set to True the genome FASTA file will be compressed using bgzip,
          and gene annotation will be compressed with gzip.
        * **threads** (*int* *,* *optional*) – Build genome index using multithreading (if supported). Default: lowest of 8/all threads.
        * **force** (*bool* *,* *optional*) – Set to True to overwrite existing files.
        * **annotation** (*bool* *,* *optional*) – If set to True, download gene annotation in BED and GTF format.
        * **only\_annotation** (*bool* *,* *optional*) – If set to True, only download the gene annotation files.
        * **skip\_matching** (*bool* *,* *optional*) – If set to True, contigs in the annotation not matching
          those in the genome will not be corrected.
        * **skip\_filter** (*bool* *,* *optional*) – If set to True, the gene annotations will not be filtered to match the genome contigs.
        * **kwargs** (*dict* *,* *optional*) –

          Provider specific options.

          toplevelbool , optional
          :   Ensembl only: Always download the toplevel genome. Ignores potential primary assembly.

          versionint , optional
          :   Ensembl only: Specify release version. Default is latest.

          to\_annotationtext , optional
          :   URL only: direct link to annotation file.
              Required if this is not the same directory as the fasta.

          path\_to\_annotationtext, optional
          :   Local only: path to local annotation file.
              Required if this is not the same directory as the fasta.

    Returns
    :   Genome class with the installed genome

    Return type
    :   [Genome](../_autosummary/genomepy.genome.Genome.html#genomepy.genome.Genome "genomepy.genome.Genome")

genomepy.list\_installed\_genomes(*genomes\_dir: str = None*) → list
:   List all locally available genomes.

    Parameters
    :   **genomes\_dir** (*str**,* *optional*) – Directory with genomes installed by genomepy.

    Returns
    :   genome names

    Return type
    :   list

---

If you want to download a sequence blacklist, or create an aligner index, you might wanna look at plugins!
Don’t worry, you can rerun the `genome.install_genome` command, and genomepy will only run the new parts.

---

genomepy.manage\_plugins(*command: str*, *plugin\_names: list = None*)
:   Manage genomepy plugins

    Parameters
    :   * **command** (*str*) –

          command to perform. Options:

          list
          :   show plugins and status

          enable
          :   enable plugins

          disable
          :   disable plugins
        * **plugin\_names** (*list*) – plugin names for the enable/disable command

---

The genome and gene annotations were installed in the genomes directory (unless specified otherwise).
If you have a specific location in mind, you could set this as default in the genomepy config.
To find and inspect it, use `genomepy.manage_config`:

---

genomepy.manage\_config(*command*)
:   Manage the genomepy configuration

    Parameters
    :   **command** (*str*) –

        command to perform. Options:

        file
        :   return config filepath

        show
        :   return config content

        generate
        :   create new config file

---

## Errors[](#errors "Permalink to this heading")

Did something go wrong? Oh noes!
If the problem persists, clear the genomepy cache with `genomepy.clean`, and try again.

---

genomepy.clean()
:   Remove cached data on providers.

---

## Using a genome[](#using-a-genome "Permalink to this heading")

Alright, you’ve got the goods!
You can browse the genome’s sequences and metadata with the `genomepy.Genome` class.
This class builds on the `pyfaidx.Fasta` class to also provide you with several options
to get specific sequences from your genome, and save these to file.

---

*class* genomepy.Genome(*name*, *genomes\_dir=None*, *\*args*, *\*\*kwargs*)
:   pyfaidx Fasta object of a genome with additional attributes & methods.

    Generates a genome index file, sizes file and gaps file of the genome.

    Parameters
    :   * **name** (*str*) – Genome name
        * **genomes\_dir** (*str**,* *optional*) – Genome installation directory

    Returns
    :   An object that provides a pygr compatible interface.

    Return type
    :   pyfaidx.Fasta

    Methods

    |  |  |
    | --- | --- |
    | `close`() |  |
    | `get_random_sequences`([n, length, chroms, ...]) | Return random genomic sequences. |
    | `get_seq`(name, start, end[, rc]) | Return a sequence by record name and interval [start, end]. |
    | `get_spliced_seq`(name, intervals[, rc]) | Return a sequence by record name and list of intervals |
    | `items`() |  |
    | `keys`() |  |
    | `track2fasta`(track[, fastafile, stranded, ...]) | Return a list of fasta sequences as Sequence objects as directed from the track(s). |
    | `values`() |  |

    Attributes

    |  |  |
    | --- | --- |
    | `gaps` | contigs and the number of Ns contained |
    | `plugin` | dict of all active plugins and their properties |
    | `sizes` | contigs and their lengths |
    | `genomes_dir` | path to the genomepy genomes directory |
    | `name` | genome name |
    | `genome_file` | path to the genome fasta |
    | `genome_dir` | path to the genome directory |
    | `index_file` | path to the genome index |
    | `sizes_file` | path to the chromosome sizes file |
    | `gaps_file` | path to the chromosome gaps file |
    | `annotation_gtf_file` | path to the gene annotation GTF file |
    | `annotation_bed_file` | path to the gene annotation BED file |
    | `readme_file` | path to the README file |

    annotation\_bed\_file
    :   path to the gene annotation BED file

    annotation\_gtf\_file
    :   path to the gene annotation GTF file

    assembly\_accession
    :   genome assembly accession

    gaps*: dict* *= None*
    :   contigs and the number of Ns contained

        Type
        :   contents of the gaps file

    gaps\_file
    :   path to the chromosome gaps file

    genome\_dir
    :   path to the genome directory

    genome\_file
    :   path to the genome fasta

    genomes\_dir
    :   path to the genomepy genomes directory

    get\_random\_sequences(*n=10*, *length=200*, *chroms=None*, *max\_n=0.1*, *outtype='list'*)
    :   Return random genomic sequences.

        Parameters
        :   * **n** (*int* *,* *optional*) – Number of sequences to return.
            * **length** (*int* *,* *optional*) – Length of sequences to return.
            * **chroms** (*list* *,* *optional*) – Return sequences only from these chromosomes.
            * **max\_n** (*float* *,* *optional*) – Maximum fraction of Ns.
            * **outtype** (*string* *,* *optional*) – return the output as list or string.
              Options: “list” or “string”, default: “list”.

        Returns
        :   coordinates as lists or strings:
            List with [chrom, start, end] genomic coordinates.
            String with “chrom:start-end” genomic coordinates
            (can be used as input for track2fasta).

        Return type
        :   list

    get\_seq(*name*, *start*, *end*, *rc=False*)
    :   Return a sequence by record name and interval [start, end].

        Coordinates are 1-based, closed interval.
        If rc is set, reverse complement will be returned.

    get\_spliced\_seq(*name*, *intervals*, *rc=False*)
    :   Return a sequence by record name and list of intervals

        Interval list is an iterable of [start, end].
        Coordinates are 1-based, end-exclusive.
        If rc is set, reverse complement will be returned.

    index\_file
    :   path to the genome index

    name
    :   genome name

    *property* plugin
    :   dict of all active plugins and their properties

    readme\_file
    :   path to the README file

    sizes*: dict* *= None*
    :   contigs and their lengths

        Type
        :   contents of the sizes file

    sizes\_file
    :   path to the chromosome sizes file

    tax\_id
    :   genome taxonomy identifier

    track2fasta(*track*, *fastafile=None*, *stranded=False*, *extend\_up=0*, *extend\_down=0*)
    :   Return a list of fasta sequences as Sequence objects
        as directed from the track(s).

        Parameters
        :   * **track** (*list/region file/bed file*) – region(s) you wish to translate to fasta.
              Example input files can be found in genomepy/tests/dat