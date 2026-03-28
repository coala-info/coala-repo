[ ]
[ ]

[Skip to content](#capcruncher.api.statistics)

CapCruncher Documentation

statistics

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](../../../..)
* [Installation](../../../../installation/)
* [Pipeline](../../../../pipeline/)
* [Cluster Setup](../../../../cluster_config/)
* [Hints and Tips](../../../../tips/)
* [Plotting CapCruncher output](../../../../plotting/)
* [CLI Reference](../../../../cli/)
* [x]

  API Reference

  API Reference
  + [x]

    capcruncher

    capcruncher
    - [x]

      api

      api
      * [annotate](../annotate/)
      * [deduplicate](../deduplicate/)
      * [filter](../filter/)
      * [io](../io/)
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [ ]

        statistics

        [statistics](./)

        Table of contents
        + [statistics](#capcruncher.api.statistics)
        + [FastqDeduplicationStatistics](#capcruncher.api.statistics.FastqDeduplicationStatistics)
        + [FastqTrimmingStatistics](#capcruncher.api.statistics.FastqTrimmingStatistics)
      * [storage](../storage/)

Table of contents

* [statistics](#capcruncher.api.statistics)
* [FastqDeduplicationStatistics](#capcruncher.api.statistics.FastqDeduplicationStatistics)
* [FastqTrimmingStatistics](#capcruncher.api.statistics.FastqTrimmingStatistics)

# statistics

## `FastqDeduplicationStatistics` [¶](#capcruncher.api.statistics.FastqDeduplicationStatistics "Permanent link")

Bases: `BaseModel`

Statistics for Fastq deduplication

Source code in `capcruncher/api/statistics.py`

|  |  |
| --- | --- |
| ``` 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 ``` | ``` class FastqDeduplicationStatistics(BaseModel):     """Statistics for Fastq deduplication"""      sample: str = "unknown_sample"     total: int     duplicates: int      @computed_field     @property     def percentage(self) -> float:         return self.duplicates / self.total * 100      @computed_field     @property     def unique(self) -> int:         return self.total - self.duplicates ``` |

## `FastqTrimmingStatistics` [¶](#capcruncher.api.statistics.FastqTrimmingStatistics "Permanent link")

Bases: `BaseModel`

Statistics for Fastq trimming

Source code in `capcruncher/api/statistics.py`

|  |  |
| --- | --- |
| ``` 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 ``` | ``` class FastqTrimmingStatistics(BaseModel):     """Statistics for Fastq trimming"""      sample: str = "unknown_sample"     read_number: Union[int, float]     reads_input: int     reads_output: int     reads_with_adapter_identified: int      @computed_field     @property     def percentage_trimmed(self) -> float:         return self.reads_with_adapter_identified / self.reads_input * 100      @computed_field     @property     def percentage_passing_quality_filter(self) -> float:         return self.reads_output / self.reads_input * 100      @classmethod     def from_multiqc_entry(cls, entry: pd.Series) -> "FastqTrimmingStatistics":         return cls(             sample=entry["sample"],             read_number=entry["read_number"],             reads_input=entry["r_processed"],             reads_output=entry["r_written"],             reads_with_adapter_identified=entry["r_with_adapters"],         )      def __add__(self, other: "FastqTrimmingStatistics"):         return FastqTrimmingStatistics(             sample=self.sample,             reads_input=self.reads_input + other.reads_input,             reads_output=self.reads_output + other.reads_output,             reads_with_adapter_identified=self.reads_with_adapter_identified             + other.reads_with_adapter_identified,         ) ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)