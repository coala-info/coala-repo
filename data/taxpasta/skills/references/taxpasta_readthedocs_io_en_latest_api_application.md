[ ]
[ ]

[Skip to content](#taxpasta.application)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Application

Initializing search

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")
TAXPASTA

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

* [Home](../..)
* [ ]

  Tutorials

  Tutorials
  + [Getting Started](../../tutorials/getting-started/)
  + [Deep Dive](../../tutorials/deepdive/)
* [ ]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../../how-tos/how-to-add-names/)
  + [How-to Customise Sample Names](../../how-tos/how-to-customise-sample-names/)
  + [How-to Merge Across Profilers](../../how-tos/how-to-merge-across-profilers/)
* [ ]

  [Commands](../../commands/)

  Commands
  + [standardise](../../commands/standardise/)
  + [merge](../../commands/merge/)
* [ ]

  [Quick reference](../../quick_reference/)

  Quick reference
  + [standardise](../../quick_reference/standardise/)
  + [merge](../../quick_reference/merge/)
* [ ]

  [Supported profilers](../../supported_profilers/)

  Supported profilers
  + [Terminology](../../supported_profilers/terminology/)
  + [Bracken](../../supported_profilers/bracken/)
  + [Centrifuge](../../supported_profilers/centrifuge/)
  + [DIAMOND](../../supported_profilers/diamond/)
  + [ganon](../../supported_profilers/ganon/)
  + [Kaiju](../../supported_profilers/kaiju/)
  + [KMCP](../../supported_profilers/kmcp/)
  + [Kraken2](../../supported_profilers/kraken2/)
  + [KrakenUniq](../../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../../supported_profilers/megan6/)
  + [MetaPhlAn](../../supported_profilers/metaphlan/)
  + [mOTUs](../../supported_profilers/motus/)
* [FAQ](../../faq/)
* [ ]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../../adr/0001-record-architecture-decisions/)
  + [2. Use Integer Taxonomy Identifiers](../../adr/0002-use-integer-taxonomy-identifiers/)
* [x]

  API Reference

  API Reference
  + [ ]

    Application

    [Application](./)

    Table of contents
    - [application](#taxpasta.application)
    - [Classes](#taxpasta.application-classes)
    - [Modules](#taxpasta.application-modules)

      * [add\_tax\_info\_command](#taxpasta.application.add_tax_info_command)

        + [Attributes](#taxpasta.application.add_tax_info_command-attributes)

          - [Table](#taxpasta.application.add_tax_info_command.Table)
        + [Classes](#taxpasta.application.add_tax_info_command-classes)

          - [AddTaxInfoCommand](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand)

            * [Attributes](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand-attributes)
            * [Functions](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand-functions)
      * [consensus\_application](#taxpasta.application.consensus_application)

        + [Classes](#taxpasta.application.consensus_application-classes)

          - [ConsensusApplication](#taxpasta.application.consensus_application.ConsensusApplication)

            * [Functions](#taxpasta.application.consensus_application.ConsensusApplication-functions)
      * [error](#taxpasta.application.error)

        + [Classes](#taxpasta.application.error-classes)
        + [Modules](#taxpasta.application.error-modules)

          - [standardisation\_error](#taxpasta.application.error.standardisation_error)

            * [Classes](#taxpasta.application.error.standardisation_error-classes)
          - [taxpasta\_error](#taxpasta.application.error.taxpasta_error)

            * [Classes](#taxpasta.application.error.taxpasta_error-classes)
      * [sample\_handling\_application](#taxpasta.application.sample_handling_application)

        + [Attributes](#taxpasta.application.sample_handling_application-attributes)

          - [logger](#taxpasta.application.sample_handling_application.logger)
        + [Classes](#taxpasta.application.sample_handling_application-classes)

          - [SampleHandlingApplication](#taxpasta.application.sample_handling_application.SampleHandlingApplication)

            * [Attributes](#taxpasta.application.sample_handling_application.SampleHandlingApplication-attributes)
            * [Functions](#taxpasta.application.sample_handling_application.SampleHandlingApplication-functions)
      * [service](#taxpasta.application.service)

        + [Attributes](#taxpasta.application.service-attributes)
        + [Classes](#taxpasta.application.service-classes)
        + [Modules](#taxpasta.application.service-modules)

          - [profile\_reader](#taxpasta.application.service.profile_reader)

            * [Attributes](#taxpasta.application.service.profile_reader-attributes)
            * [Classes](#taxpasta.application.service.profile_reader-classes)
          - [profile\_standardisation\_service](#taxpasta.application.service.profile_standardisation_service)

            * [Classes](#taxpasta.application.service.profile_standardisation_service-classes)
          - [standard\_profile\_writer](#taxpasta.application.service.standard_profile_writer)

            * [Attributes](#taxpasta.application.service.standard_profile_writer-attributes)
            * [Classes](#taxpasta.application.service.standard_profile_writer-classes)
          - [table\_reader](#taxpasta.application.service.table_reader)

            * [Attributes](#taxpasta.application.service.table_reader-attributes)
            * [Classes](#taxpasta.application.service.table_reader-classes)
          - [tidy\_observation\_table\_writer](#taxpasta.application.service.tidy_observation_table_writer)

            * [Attributes](#taxpasta.application.service.tidy_observation_table_writer-attributes)
            * [Classes](#taxpasta.application.service.tidy_observation_table_writer-classes)
          - [wide\_observation\_table\_writer](#taxpasta.application.service.wide_observation_table_writer)

            * [Attributes](#taxpasta.application.service.wide_observation_table_writer-attributes)
            * [Classes](#taxpasta.application.service.wide_observation_table_writer-classes)
  + [Domain](../domain/)
  + [Infrastructure](../infrastructure/)
* [ ]

  [Contributing](../../contributing/)

  Contributing
  + [Supporting New Taxonomic Profilers](../../contributing/supporting_new_profiler/)

Table of contents

* [application](#taxpasta.application)
* [Classes](#taxpasta.application-classes)
* [Modules](#taxpasta.application-modules)

  + [add\_tax\_info\_command](#taxpasta.application.add_tax_info_command)

    - [Attributes](#taxpasta.application.add_tax_info_command-attributes)

      * [Table](#taxpasta.application.add_tax_info_command.Table)
    - [Classes](#taxpasta.application.add_tax_info_command-classes)

      * [AddTaxInfoCommand](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand)

        + [Attributes](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand-attributes)
        + [Functions](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand-functions)
  + [consensus\_application](#taxpasta.application.consensus_application)

    - [Classes](#taxpasta.application.consensus_application-classes)

      * [ConsensusApplication](#taxpasta.application.consensus_application.ConsensusApplication)

        + [Functions](#taxpasta.application.consensus_application.ConsensusApplication-functions)
  + [error](#taxpasta.application.error)

    - [Classes](#taxpasta.application.error-classes)
    - [Modules](#taxpasta.application.error-modules)

      * [standardisation\_error](#taxpasta.application.error.standardisation_error)

        + [Classes](#taxpasta.application.error.standardisation_error-classes)
      * [taxpasta\_error](#taxpasta.application.error.taxpasta_error)

        + [Classes](#taxpasta.application.error.taxpasta_error-classes)
  + [sample\_handling\_application](#taxpasta.application.sample_handling_application)

    - [Attributes](#taxpasta.application.sample_handling_application-attributes)

      * [logger](#taxpasta.application.sample_handling_application.logger)
    - [Classes](#taxpasta.application.sample_handling_application-classes)

      * [SampleHandlingApplication](#taxpasta.application.sample_handling_application.SampleHandlingApplication)

        + [Attributes](#taxpasta.application.sample_handling_application.SampleHandlingApplication-attributes)
        + [Functions](#taxpasta.application.sample_handling_application.SampleHandlingApplication-functions)
  + [service](#taxpasta.application.service)

    - [Attributes](#taxpasta.application.service-attributes)
    - [Classes](#taxpasta.application.service-classes)
    - [Modules](#taxpasta.application.service-modules)

      * [profile\_reader](#taxpasta.application.service.profile_reader)

        + [Attributes](#taxpasta.application.service.profile_reader-attributes)
        + [Classes](#taxpasta.application.service.profile_reader-classes)
      * [profile\_standardisation\_service](#taxpasta.application.service.profile_standardisation_service)

        + [Classes](#taxpasta.application.service.profile_standardisation_service-classes)
      * [standard\_profile\_writer](#taxpasta.application.service.standard_profile_writer)

        + [Attributes](#taxpasta.application.service.standard_profile_writer-attributes)
        + [Classes](#taxpasta.application.service.standard_profile_writer-classes)
      * [table\_reader](#taxpasta.application.service.table_reader)

        + [Attributes](#taxpasta.application.service.table_reader-attributes)
        + [Classes](#taxpasta.application.service.table_reader-classes)
      * [tidy\_observation\_table\_writer](#taxpasta.application.service.tidy_observation_table_writer)

        + [Attributes](#taxpasta.application.service.tidy_observation_table_writer-attributes)
        + [Classes](#taxpasta.application.service.tidy_observation_table_writer-classes)
      * [wide\_observation\_table\_writer](#taxpasta.application.service.wide_observation_table_writer)

        + [Attributes](#taxpasta.application.service.wide_observation_table_writer-attributes)
        + [Classes](#taxpasta.application.service.wide_observation_table_writer-classes)

# Application

## Classes[¶](#taxpasta.application-classes "Permanent link")

## Modules[¶](#taxpasta.application-modules "Permanent link")

### `add_tax_info_command` [¶](#taxpasta.application.add_tax_info_command "Permanent link")

Provide a command object for adding taxonomy information.

#### Attributes[¶](#taxpasta.application.add_tax_info_command-attributes "Permanent link")

##### `Table = TypeVar('Table', DataFrame[TidyObservationTable], DataFrame[WideObservationTable], DataFrame[StandardProfile])` `module-attribute` [¶](#taxpasta.application.add_tax_info_command.Table "Permanent link")

#### Classes[¶](#taxpasta.application.add_tax_info_command-classes "Permanent link")

##### `AddTaxInfoCommand` `dataclass` [¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand "Permanent link")

Define the command object for adding taxonomy information.

Source code in `src/taxpasta/application/add_tax_info_command.py`

|  |  |
| --- | --- |
| ``` 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 ``` | ``` @dataclass(frozen=True) class AddTaxInfoCommand:     """Define the command object for adding taxonomy information."""      taxonomy_service: Optional[TaxonomyService] = None     summarise_at: Optional[str] = None     add_name: bool = False     add_rank: bool = False     add_lineage: bool = False     add_id_lineage: bool = False     add_rank_lineage: bool = False      def execute(self, table: Table) -> Table:         """Execute the command to add taxonomy information."""         if self.taxonomy_service is None:             return table         # The order of the following conditions is chosen specifically to yield a         # pleasant final output format.         result = table         if self.add_rank_lineage:             result = self.taxonomy_service.add_rank_lineage(result)         if self.add_id_lineage:             result = self.taxonomy_service.add_identifier_lineage(result)         if self.add_lineage:             result = self.taxonomy_service.add_name_lineage(result)         if self.add_rank:             result = self.taxonomy_service.add_rank(result)         if self.add_name:             result = self.taxonomy_service.add_name(result)         return result      def __post_init__(self) -> None:         """Perform post initialization validation."""         no_taxonomy = self.taxonomy_service is None         if self.summarise_at is not None and no_taxonomy:             raise ValueError(                 "The summarising feature '--summarise-at' requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             )         if self.add_name and no_taxonomy:             raise ValueError(                 "The '--add-name' option requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             )         if self.add_rank and no_taxonomy:             raise ValueError(                 "The '--add-rank' option requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             )         if self.add_lineage and no_taxonomy:             raise ValueError(                 "The '--add-lineage' option requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             )         if self.add_id_lineage and no_taxonomy:             raise ValueError(                 "The '--add-id-lineage' option requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             )         if self.add_rank_lineage and no_taxonomy:             raise ValueError(                 "The '--add-rank-lineage' option requires a taxonomy. Please "                 "provide one using the option '--taxonomy'."             ) ``` |

###### Attributes[¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand-attributes "Permanent link")

###### `add_id_lineage: bool = False` `class-attribute` `instance-attribute` [¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand.add_id_lineage "Permanent link")

###### `add_lineage: bool = False` `class-attribute` `instance-attribute` [¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand.add_lineage "Permanent link")

###### `add_name: bool = False` `class-attribute` `instance-attribute` [¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand.add_name "Permanent link")

###### `add_rank: bool = False` `class-attribute` `instance-attribute` [¶](#taxpasta.application.add_tax_info_command.AddTaxInfoCommand.add_rank "Permanent link")

######