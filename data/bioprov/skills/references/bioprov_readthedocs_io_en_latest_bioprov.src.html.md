[BioProv](index.html)

latest

Contents:

* [BioProv - W3C-PROV provenance documents for bioinformatics](readme.html)
* [Quickstart](readme.html#quickstart)
* [Installation](readme.html#installation)
* [Dependencies](readme.html#dependencies)
* [Source API](modules.html)
  + [bioprov package](bioprov.html)
    - [Subpackages](bioprov.html#subpackages)
      * [bioprov.data package](bioprov.data.html)
      * [bioprov.programs package](bioprov.programs.html)
      * bioprov.src package
      * [bioprov.tests package](bioprov.tests.html)
      * [bioprov.workflows package](bioprov.workflows.html)
    - [Submodules](bioprov.html#submodules)
    - [bioprov.bioprov module](bioprov.html#module-bioprov.bioprov)
    - [bioprov.utils module](bioprov.html#module-bioprov.utils)
    - [Module contents](bioprov.html#module-bioprov)

[BioProv](index.html)

* [Docs](index.html) »
* [bioprov](modules.html) »
* [bioprov package](bioprov.html) »
* bioprov.src package
* [Edit on GitHub](https://github.com/vinisalazar/BioProv/blob/dev/docs/source/bioprov.src.rst)

---

# bioprov.src package[¶](#bioprov-src-package "Permalink to this headline")

## Submodules[¶](#submodules "Permalink to this headline")

## bioprov.src.config module[¶](#module-bioprov.src.config "Permalink to this headline")

Contains the Config class and other package-level settings.

Define your configurations in the ‘config’ variable at the end of the module.

*class* bioprov.src.config.BioProvDB(*path*)[¶](#bioprov.src.config.BioProvDB "Permalink to this definition")
:   Bases: `tinydb.database.TinyDB`

    Inherits from tinydb.TinyDB

    Class to hold database configuration and methods.

    \_\_init\_\_(*path*)[¶](#bioprov.src.config.BioProvDB.__init__ "Permalink to this definition")
    :   Create a new instance of TinyDB.

    clear\_db(*confirm=False*)[¶](#bioprov.src.config.BioProvDB.clear_db "Permalink to this definition")
    :   Deletes the local BioProv database.
        :param confirm:
        :return:

*class* bioprov.src.config.Config(*db\_path=None*, *threads=0*)[¶](#bioprov.src.config.Config "Permalink to this definition")
:   Bases: `object`

    Class to define package level variables and settings.

    \_\_init\_\_(*db\_path=None*, *threads=0*)[¶](#bioprov.src.config.Config.__init__ "Permalink to this definition")
    :   Parameters
        :   * **db\_path** – Path to database file. Default is bioprov\_directory/db.json
            * **threads** – Number of threads. Default is half of processors.

    clear\_db(*confirm=False*)[¶](#bioprov.src.config.Config.clear_db "Permalink to this definition")
    :   Deletes the local BioProv database.
        :param confirm:
        :return:

    create\_provstore\_file(*user=None*, *token=None*)[¶](#bioprov.src.config.Config.create_provstore_file "Permalink to this definition")

    *property* db[¶](#bioprov.src.config.Config.db "Permalink to this definition")

    db\_all()[¶](#bioprov.src.config.Config.db_all "Permalink to this definition")
    :   Returns
        :   List all items in BioProv database.

    *property* db\_path[¶](#bioprov.src.config.Config.db_path "Permalink to this definition")

    *property* logger[¶](#bioprov.src.config.Config.logger "Permalink to this definition")

    *property* provstore\_api[¶](#bioprov.src.config.Config.provstore_api "Permalink to this definition")

    *property* provstore\_file[¶](#bioprov.src.config.Config.provstore_file "Permalink to this definition")

    *property* provstore\_token[¶](#bioprov.src.config.Config.provstore_token "Permalink to this definition")

    *property* provstore\_user[¶](#bioprov.src.config.Config.provstore_user "Permalink to this definition")

    read\_provstore\_file()[¶](#bioprov.src.config.Config.read_provstore_file "Permalink to this definition")
    :   Attempts to read self.provstore\_file.
        Will prompt to create one if unable to retrieve credentials.

        Returns
        :   Updates self.provstore\_user and self.provstore\_token.

    serializer()[¶](#bioprov.src.config.Config.serializer "Permalink to this definition")

*class* bioprov.src.config.Environment[¶](#bioprov.src.config.Environment "Permalink to this definition")
:   Bases: `object`

    Class containing provenance information about the current environment.

    \_\_init\_\_()[¶](#bioprov.src.config.Environment.__init__ "Permalink to this definition")
    :   Class constructor. All attributes are empty and are initialized with self.update()

    *property* actedOnBehalfOf[¶](#bioprov.src.config.Environment.actedOnBehalfOf "Permalink to this definition")

    serializer()[¶](#bioprov.src.config.Environment.serializer "Permalink to this definition")

    update()[¶](#bioprov.src.config.Environment.update "Permalink to this definition")
    :   Checks current environment and updates attributes using the os.environ module.
        :return: Sets attributes to self.

## bioprov.src.files module[¶](#module-bioprov.src.files "Permalink to this headline")

Contains the File and SeqFile classes and related functions.

*class* bioprov.src.files.Directory(*path*, *tag=None*)[¶](#bioprov.src.files.Directory "Permalink to this definition")
:   Bases: `object`

    Class for holding information about directories.

    \_\_init\_\_(*path*, *tag=None*)[¶](#bioprov.src.files.Directory.__init__ "Permalink to this definition")

    add\_files\_to\_object(*object\_*, *kind='files'*)[¶](#bioprov.src.files.Directory.add_files_to_object "Permalink to this definition")
    :   Add files or subdirs in self to [object\_](#id1), can be either a Sample or Project.
        :param [object\_](#id3): bioprov.Project or bioprov.Sample
        :param kind: Whether to add files or subdirectories.
        :return: Updates [object\_](#id5).files

    *property* exists[¶](#bioprov.src.files.Directory.exists "Permalink to this definition")

    get\_files()[¶](#bioprov.src.files.Directory.get_files "Permalink to this definition")

    get\_subdirs()[¶](#bioprov.src.files.Directory.get_subdirs "Permalink to this definition")

    replace\_path(*old\_terms*, *new*, *warnings=False*)[¶](#bioprov.src.files.Directory.replace_path "Permalink to this definition")
    :   Replace the current File path.

        Usually used for switching between users.

        Parameters
        :   * **old\_terms** – Terms to be replaced in the path.
            * **new** – New term.
            * **warnings** – Whether to warn if sha256 checksum differs or file does not exist.

        Returns
        :   Updates self.

    serializer()[¶](#bioprov.src.files.Directory.serializer "Permalink to this definition")

*class* bioprov.src.files.File(*path*, *tag=None*, *attributes=None*, *\_get\_hash=True*)[¶](#bioprov.src.files.File "Permalink to this definition")
:   Bases: `object`

    Class for holding files and file information.

    \_\_init\_\_(*path*, *tag=None*, *attributes=None*, *\_get\_hash=True*)[¶](#bioprov.src.files.File.__init__ "Permalink to this definition")
    :   Parameters
        :   * **path** – A UNIX-like file \_path.
            * **tag** – optional tag describing the file.
            * **attributes** – Miscellaneous attributes.

    *property* entity[¶](#bioprov.src.files.File.entity "Permalink to this definition")

    *property* exists[¶](#bioprov.src.files.File.exists "Permalink to this definition")

    *property* raw\_size[¶](#bioprov.src.files.File.raw_size "Permalink to this definition")

    replace\_path(*old\_terms*, *new*, *warnings=False*)[¶](#bioprov.src.files.File.replace_path "Permalink to this definition")
    :   Replace the current File path.

        Usually used for switching between users.

        Parameters
        :   * **old\_terms** – Terms to be replaced in the path.
            * **new** – New term.
            * **warnings** – Whether to warn if sha256 checksum differs or file does not exist.

        Returns
        :   Updates self.

    serializer()[¶](#bioprov.src.files.File.serializer "Permalink to this definition")

    *property* sha256[¶](#bioprov.src.files.File.sha256 "Permalink to this definition")

    *property* size[¶](#bioprov.src.files.File.size "Permalink to this definition")

*class* bioprov.src.files.SeqFile(*path*, *tag=None*, *format='fasta'*, *parser='seq'*, *document=None*, *import\_records=False*, *calculate\_seqstats=False*)[¶](#bioprov.src.files.SeqFile "Permalink to this definition")
:   Bases: [`bioprov.src.files.File`](#bioprov.src.files.File "bioprov.src.files.File")

    Class for holding sequence file and sequence information. Inherits from File.

    This class support records parsed with the BioPython.SeqIO module.

    \_\_init\_\_(*path*, *tag=None*, *format='fasta'*, *parser='seq'*, *document=None*, *import\_records=False*, *calculate\_seqstats=False*)[¶](#bioprov.src.files.SeqFile.__init__ "Permalink to this definition")
    :   Parameters
        :   * **path** – A UNIX-like file \_path.
            * **tag** – optional tag describing the file.
            * **format** – Format to be parsed by SeqIO.parse()
            * **parser** – Bio parser to be used. Can be ‘seq’ (default) to be parsed by SeqIO or ‘align’
              to be parsed with AlignIO.
            * **document** – prov.model.ProvDocument.
            * **import\_records** – Whether to import sequence data as Bio objects
            * **calculate\_seqstats** – Whether to calculate SeqStats

    *property* generator[¶](#bioprov.src.files.SeqFile.generator "Permalink to this definition")

    import\_records(*\*\*kwargs*)[¶](#bioprov.src.files.SeqFile.import_records "Permalink to this definition")
    :   Parameters
        :   **kwargs** – Parameters to pass to the SeqFile.\_calculate\_seqstats() function.

        Returns
        :   Import records into self.

    *property* max\_seq[¶](#bioprov.src.files.SeqFile.max_seq "Permalink to this definition")

    *property* min\_seq[¶](#bioprov.src.files.SeqFile.min_seq "Permalink to this definition")

    seqfile\_formats *= ('fasta', 'clustal', 'fastq', 'fastq-sanger', 'fastq-solexa', 'fastq-illumina', 'genbank', 'gb', 'nexus', 'stockholm', 'swiss', 'tab', 'qual')*[¶](#bioprov.src.files.SeqFile.seqfile_formats "Permalink to this definition")

    *property* seqstats[¶](#bioprov.src.files.SeqFile.seqstats "Permalink to this definition")

    serializer()[¶](#bioprov.src.files.SeqFile.serializer "Permalink to this definition")

*class* bioprov.src.files.SeqStats(*number\_seqs: int*, *total\_bps: int*, *mean\_bp: float*, *min\_bp: int*, *max\_bp: int*, *N50: int*, *GC: float*)[¶](#bioprov.src.files.SeqStats "Permalink to this definition")
:   Bases: `object`

    Dataclass to describe sequence statistics.

    GC*: float*[¶](#bioprov.src.files.SeqStats.GC "Permalink to this definition")

    N50*: int*[¶](#bioprov.src.files.SeqStats.N50 "Permalink to this definition")

    \_\_init\_\_(*number\_seqs: int*, *total\_bps: int*, *mean\_bp: float*, *min\_bp: int*, *max\_bp: int*, *N50: int*, *GC: float*) → None[¶](#bioprov.src.files.SeqStats.__init__ "Permalink to this definition")

    max\_bp*: int*[¶](#bioprov.src.files.SeqStats.max_bp "Permalink to this definition")

    mean\_bp*: float*[¶](#bioprov.src.files.SeqStats.mean_bp "Permalink to this definition")

    min\_bp*: int*[¶](#bioprov.src.files.SeqStats.min_bp "Permalink to this definition")

    number\_seqs*: int*[¶](#bioprov.src.files.SeqStats.number_seqs "Permalink to this definition")

    total\_bps*: int*[¶](#bioprov.src.files.SeqStats.total_bps "Permalink to this definition")

bioprov.src.files.calculate\_N50(*array*)[¶](#bioprov.src.files.calculate_N50 "Permalink to this definition")
:   Calculate N50 from an array of contig lengths.
    <https://github.com/vikas0633/python/blob/master/N50.py>

    Based on the Broad Institute definition:
    <https://www.broad.harvard.edu/crd/wiki/index.php/N50>
    :param array: list of contig lengths
    :return: N50 value

bioprov.src.files.deserialize\_files\_dict(*files\_dict*)[¶](#bioprov.src.files.deserialize_files_dict "Permalink to this definition")
:   Deserialize a dictionary of files in JSON format.
    :param files\_dict: dict of dicts.
    :return: dict of File instances.

bioprov.src.files.seqrecordgenerator(*path*, *format*, *parser='seq'*, *warnings=False*)[¶](#bioprov.src.files.seqrecordgenerator "Permalink to this definition")
:   Parameters
    :   * **path** – Path to file.
        * **format** – format to pass to SeqIO.parse().
        * **parser** – Whether to import records with SeqIO (default) or AlignIO
        * **warnings** – Whether to warn if sha256 checksum differs or file does not exist.

    Returns
    :   A generator of SeqRecords.

## bioprov.src.main module[¶](#module-bioprov.src.main "Permalink to this headline")

Main source module. Contains the main BioProv classes.

Activity classes:
:   * Program
    * Parameter
    * Run

Entity classes:
:   * Project
    * Sample

This class also contains functions to read and write objects in JSON and tab-delimited formats.

*class* bioprov.src.main.Parameter(*key=None*, *value=''*, *tag=None*, *cmd\_string=None*, *description=None*, *kind=None*, *keyword\_argument=True*, *position=- 1*)[¶](#bioprov.src.main.Parameter "Permalink to this definition")
:   Bases: `object`

    Class holding information for parameters.

    \_\_init\_\_(*key=None*, *value=''*, *tag=None*, *cmd\_string=None*, *description=None*, *kind=None*, *keyword\_argument=True*, *position=- 1*)[¶](#bioprov.src.main.Parameter.__init__ "Permalink to this definition")
    :   Parameters
        :   * **key** – Key of the parameter, e.g. ‘-h’ for help command.
            * **value** – Value of the parameter.
            * **tag** – A tag of the parameter.
            * **cmd\_string** – String representation of the parameter in a command.
            * **description** – description of the parameter.
            * **kind** – Kind of parameter. May be ‘input’, ‘output’, ‘misc’, or None.
            * **keyword\_argument** – Whether the parameter is a keyword argument.
              Keyword arguments have a key, which is used to build
              the program’s command. If this is false, it is assumed
              that the parameter is a positional argument, and ‘position’
              will indicate it’s index if the command line was split as a list.
            * **position** – Index of insertion of parameter in command-line if it is a positional argument.

    serializer()[¶](#bioprov.src.main.Parameter.serializer "Permalink to this definition")

*class* bioprov.src.main.PresetProgram(*name=None*, *params=None*, *sample=None*, *input\_files=None*, *output\_files=None*, *preffix\_tag=None*, *extra\_flags=None*)[¶](#bioprov.src.main.PresetProgram "Permalink to this definition")
:   Bases: [`bioprov.src.main.Program`](#bioprov.src.main.Program "bioprov.src.main.Program")

    Class for holding a preset program and related functions.

    A WorkflowStep instance inherits from P