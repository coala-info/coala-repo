[ ]
[ ]

[Skip to content](#primalbedtools.scheme)

primalbedtools

API

[GitHub](https://github.com/ChrisgKent/primalbedtools "Go to repository")

primalbedtools

[GitHub](https://github.com/ChrisgKent/primalbedtools "Go to repository")

* [Quick Start](..)
* [How To Guides](../how-to-guides/)
* [Command Line Interface](../cli/)
* [ ]

  API

  [API](./)

  Table of contents
  + [Scheme](#primalbedtools.scheme)
  + [Scheme](#primalbedtools.scheme.Scheme)

    - [contains\_probes](#primalbedtools.scheme.Scheme.contains_probes)
    - [header\_dict](#primalbedtools.scheme.Scheme.header_dict)
    - [\_\_init\_\_](#primalbedtools.scheme.Scheme.__init__)
    - [from\_file](#primalbedtools.scheme.Scheme.from_file)
    - [from\_str](#primalbedtools.scheme.Scheme.from_str)
    - [merge\_primers](#primalbedtools.scheme.Scheme.merge_primers)
    - [sort\_bedlines](#primalbedtools.scheme.Scheme.sort_bedlines)
    - [to\_file](#primalbedtools.scheme.Scheme.to_file)
    - [to\_str](#primalbedtools.scheme.Scheme.to_str)
    - [update\_primernames](#primalbedtools.scheme.Scheme.update_primernames)
  + [to\_delim\_str](#primalbedtools.scheme.to_delim_str)
  + [Bedfiles](#primalbedtools.bedfiles)
  + [BedFileModifier](#primalbedtools.bedfiles.BedFileModifier)

    - [downgrade\_primernames](#primalbedtools.bedfiles.BedFileModifier.downgrade_primernames)
    - [merge\_primers](#primalbedtools.bedfiles.BedFileModifier.merge_primers)
    - [sort\_bedlines](#primalbedtools.bedfiles.BedFileModifier.sort_bedlines)
    - [update\_primernames](#primalbedtools.bedfiles.BedFileModifier.update_primernames)
  + [BedLine](#primalbedtools.bedfiles.BedLine)

    - [amplicon\_name](#primalbedtools.bedfiles.BedLine.amplicon_name)
    - [amplicon\_number](#primalbedtools.bedfiles.BedLine.amplicon_number)
    - [amplicon\_prefix](#primalbedtools.bedfiles.BedLine.amplicon_prefix)
    - [attributes](#primalbedtools.bedfiles.BedLine.attributes)
    - [chrom](#primalbedtools.bedfiles.BedLine.chrom)
    - [direction\_str](#primalbedtools.bedfiles.BedLine.direction_str)
    - [ipool](#primalbedtools.bedfiles.BedLine.ipool)
    - [length](#primalbedtools.bedfiles.BedLine.length)
    - [pool](#primalbedtools.bedfiles.BedLine.pool)
    - [primer\_class](#primalbedtools.bedfiles.BedLine.primer_class)
    - [primer\_class\_str](#primalbedtools.bedfiles.BedLine.primer_class_str)
    - [primer\_suffix](#primalbedtools.bedfiles.BedLine.primer_suffix)
    - [primername](#primalbedtools.bedfiles.BedLine.primername)
    - [sequence](#primalbedtools.bedfiles.BedLine.sequence)
    - [start](#primalbedtools.bedfiles.BedLine.start)
    - [strand](#primalbedtools.bedfiles.BedLine.strand)
    - [strand\_class](#primalbedtools.bedfiles.BedLine.strand_class)
    - [weight](#primalbedtools.bedfiles.BedLine.weight)
    - [force\_change](#primalbedtools.bedfiles.BedLine.force_change)
    - [to\_bed](#primalbedtools.bedfiles.BedLine.to_bed)
    - [to\_fasta](#primalbedtools.bedfiles.BedLine.to_fasta)
  + [BedLineParser](#primalbedtools.bedfiles.BedLineParser)

    - [from\_file](#primalbedtools.bedfiles.BedLineParser.from_file)
    - [from\_str](#primalbedtools.bedfiles.BedLineParser.from_str)
    - [to\_file](#primalbedtools.bedfiles.BedLineParser.to_file)
    - [to\_str](#primalbedtools.bedfiles.BedLineParser.to_str)
  + [bedline\_from\_str](#primalbedtools.bedfiles.bedline_from_str)
  + [check\_amplicon\_prefix](#primalbedtools.bedfiles.check_amplicon_prefix)
  + [check\_valid\_class\_and\_strand](#primalbedtools.bedfiles.check_valid_class_and_strand)
  + [create\_bedline](#primalbedtools.bedfiles.create_bedline)
  + [create\_primer\_attributes\_str](#primalbedtools.bedfiles.create_primer_attributes_str)
  + [create\_primername](#primalbedtools.bedfiles.create_primername)
  + [downgrade\_primernames](#primalbedtools.bedfiles.downgrade_primernames)
  + [expand\_bedlines](#primalbedtools.bedfiles.expand_bedlines)
  + [group\_amplicons](#primalbedtools.bedfiles.group_amplicons)
  + [group\_by\_amplicon\_number](#primalbedtools.bedfiles.group_by_amplicon_number)
  + [group\_by\_chrom](#primalbedtools.bedfiles.group_by_chrom)
  + [group\_by\_class](#primalbedtools.bedfiles.group_by_class)
  + [group\_by\_pool](#primalbedtools.bedfiles.group_by_pool)
  + [group\_by\_strand](#primalbedtools.bedfiles.group_by_strand)
  + [group\_primer\_pairs](#primalbedtools.bedfiles.group_primer_pairs)
  + [lr\_string\_to\_strand\_char](#primalbedtools.bedfiles.lr_string_to_strand_char)
  + [merge\_primers](#primalbedtools.bedfiles.merge_primers)
  + [parse\_headers\_to\_dict](#primalbedtools.bedfiles.parse_headers_to_dict)
  + [sort\_bedlines](#primalbedtools.bedfiles.sort_bedlines)
  + [update\_primernames](#primalbedtools.bedfiles.update_primernames)
  + [validate\_amplicon\_prefix](#primalbedtools.bedfiles.validate_amplicon_prefix)
  + [validate\_primer\_name](#primalbedtools.bedfiles.validate_primer_name)
  + [validate\_strand](#primalbedtools.bedfiles.validate_strand)
  + [version\_primername](#primalbedtools.bedfiles.version_primername)
  + [Amplicons](#primalbedtools.amplicons)
  + [Amplicon](#primalbedtools.amplicons.Amplicon)

    - [amplicon\_end](#primalbedtools.amplicons.Amplicon.amplicon_end)
    - [amplicon\_name](#primalbedtools.amplicons.Amplicon.amplicon_name)
    - [amplicon\_start](#primalbedtools.amplicons.Amplicon.amplicon_start)
    - [coverage\_end](#primalbedtools.amplicons.Amplicon.coverage_end)
    - [coverage\_start](#primalbedtools.amplicons.Amplicon.coverage_start)
    - [ipool](#primalbedtools.amplicons.Amplicon.ipool)
    - [is\_circular](#primalbedtools.amplicons.Amplicon.is_circular)
    - [left\_region](#primalbedtools.amplicons.Amplicon.left_region)
    - [probe\_region](#primalbedtools.amplicons.Amplicon.probe_region)
    - [right\_region](#primalbedtools.amplicons.Amplicon.right_region)
    - [\_\_hash\_\_](#primalbedtools.amplicons.Amplicon.__hash__)
    - [\_\_init\_\_](#primalbedtools.amplicons.Amplicon.__init__)
    - [to\_amplicon\_str](#primalbedtools.amplicons.Amplicon.to_amplicon_str)
    - [to\_primertrim\_str](#primalbedtools.amplicons.Amplicon.to_primertrim_str)
  + [create\_amplicons](#primalbedtools.amplicons.create_amplicons)
  + [do\_pp\_ol](#primalbedtools.amplicons.do_pp_ol)

Table of contents

* [Scheme](#primalbedtools.scheme)
* [Scheme](#primalbedtools.scheme.Scheme)

  + [contains\_probes](#primalbedtools.scheme.Scheme.contains_probes)
  + [header\_dict](#primalbedtools.scheme.Scheme.header_dict)
  + [\_\_init\_\_](#primalbedtools.scheme.Scheme.__init__)
  + [from\_file](#primalbedtools.scheme.Scheme.from_file)
  + [from\_str](#primalbedtools.scheme.Scheme.from_str)
  + [merge\_primers](#primalbedtools.scheme.Scheme.merge_primers)
  + [sort\_bedlines](#primalbedtools.scheme.Scheme.sort_bedlines)
  + [to\_file](#primalbedtools.scheme.Scheme.to_file)
  + [to\_str](#primalbedtools.scheme.Scheme.to_str)
  + [update\_primernames](#primalbedtools.scheme.Scheme.update_primernames)
* [to\_delim\_str](#primalbedtools.scheme.to_delim_str)
* [Bedfiles](#primalbedtools.bedfiles)
* [BedFileModifier](#primalbedtools.bedfiles.BedFileModifier)

  + [downgrade\_primernames](#primalbedtools.bedfiles.BedFileModifier.downgrade_primernames)
  + [merge\_primers](#primalbedtools.bedfiles.BedFileModifier.merge_primers)
  + [sort\_bedlines](#primalbedtools.bedfiles.BedFileModifier.sort_bedlines)
  + [update\_primernames](#primalbedtools.bedfiles.BedFileModifier.update_primernames)
* [BedLine](#primalbedtools.bedfiles.BedLine)

  + [amplicon\_name](#primalbedtools.bedfiles.BedLine.amplicon_name)
  + [amplicon\_number](#primalbedtools.bedfiles.BedLine.amplicon_number)
  + [amplicon\_prefix](#primalbedtools.bedfiles.BedLine.amplicon_prefix)
  + [attributes](#primalbedtools.bedfiles.BedLine.attributes)
  + [chrom](#primalbedtools.bedfiles.BedLine.chrom)
  + [direction\_str](#primalbedtools.bedfiles.BedLine.direction_str)
  + [ipool](#primalbedtools.bedfiles.BedLine.ipool)
  + [length](#primalbedtools.bedfiles.BedLine.length)
  + [pool](#primalbedtools.bedfiles.BedLine.pool)
  + [primer\_class](#primalbedtools.bedfiles.BedLine.primer_class)
  + [primer\_class\_str](#primalbedtools.bedfiles.BedLine.primer_class_str)
  + [primer\_suffix](#primalbedtools.bedfiles.BedLine.primer_suffix)
  + [primername](#primalbedtools.bedfiles.BedLine.primername)
  + [sequence](#primalbedtools.bedfiles.BedLine.sequence)
  + [start](#primalbedtools.bedfiles.BedLine.start)
  + [strand](#primalbedtools.bedfiles.BedLine.strand)
  + [strand\_class](#primalbedtools.bedfiles.BedLine.strand_class)
  + [weight](#primalbedtools.bedfiles.BedLine.weight)
  + [force\_change](#primalbedtools.bedfiles.BedLine.force_change)
  + [to\_bed](#primalbedtools.bedfiles.BedLine.to_bed)
  + [to\_fasta](#primalbedtools.bedfiles.BedLine.to_fasta)
* [BedLineParser](#primalbedtools.bedfiles.BedLineParser)

  + [from\_file](#primalbedtools.bedfiles.BedLineParser.from_file)
  + [from\_str](#primalbedtools.bedfiles.BedLineParser.from_str)
  + [to\_file](#primalbedtools.bedfiles.BedLineParser.to_file)
  + [to\_str](#primalbedtools.bedfiles.BedLineParser.to_str)
* [bedline\_from\_str](#primalbedtools.bedfiles.bedline_from_str)
* [check\_amplicon\_prefix](#primalbedtools.bedfiles.check_amplicon_prefix)
* [check\_valid\_class\_and\_strand](#primalbedtools.bedfiles.check_valid_class_and_strand)
* [create\_bedline](#primalbedtools.bedfiles.create_bedline)
* [create\_primer\_attributes\_str](#primalbedtools.bedfiles.create_primer_attributes_str)
* [create\_primername](#primalbedtools.bedfiles.create_primername)
* [downgrade\_primernames](#primalbedtools.bedfiles.downgrade_primernames)
* [expand\_bedlines](#primalbedtools.bedfiles.expand_bedlines)
* [group\_amplicons](#primalbedtools.bedfiles.group_amplicons)
* [group\_by\_amplicon\_number](#primalbedtools.bedfiles.group_by_amplicon_number)
* [group\_by\_chrom](#primalbedtools.bedfiles.group_by_chrom)
* [group\_by\_class](#primalbedtools.bedfiles.group_by_class)
* [group\_by\_pool](#primalbedtools.bedfiles.group_by_pool)
* [group\_by\_strand](#primalbedtools.bedfiles.group_by_strand)
* [group\_primer\_pairs](#primalbedtools.bedfiles.group_primer_pairs)
* [lr\_string\_to\_strand\_char](#primalbedtools.bedfiles.lr_string_to_strand_char)
* [merge\_primers](#primalbedtools.bedfiles.merge_primers)
* [parse\_headers\_to\_dict](#primalbedtools.bedfiles.parse_headers_to_dict)
* [sort\_bedlines](#primalbedtools.bedfiles.sort_bedlines)
* [update\_primernames](#primalbedtools.bedfiles.update_primernames)
* [validate\_amplicon\_prefix](#primalbedtools.bedfiles.validate_amplicon_prefix)
* [validate\_primer\_name](#primalbedtools.bedfiles.validate_primer_name)
* [validate\_strand](#primalbedtools.bedfiles.validate_strand)
* [version\_primername](#primalbedtools.bedfiles.version_primername)
* [Amplicons](#primalbedtools.amplicons)
* [Amplicon](#primalbedtools.amplicons.Amplicon)

  + [amplicon\_end](#primalbedtools.amplicons.Amplicon.amplicon_end)
  + [amplicon\_name](#primalbedtools.amplicons.Amplicon.amplicon_name)
  + [amplicon\_start](#primalbedtools.amplicons.Amplicon.amplicon_start)
  + [coverage\_end](#primalbedtools.amplicons.Amplicon.coverage_end)
  + [coverage\_start](#primalbedtools.amplicons.Amplicon.coverage_start)
  + [ipool](#primalbedtools.amplicons.Amplicon.ipool)
  + [is\_circular](#primalbedtools.amplicons.Amplicon.is_circular)
  + [left\_region](#primalbedtools.amplicons.Amplicon.left_region)
  + [probe\_region](#primalbedtools.amplicons.Amplicon.probe_region)
  + [right\_region](#primalbedtools.amplicons.Amplicon.right_region)
  + [\_\_hash\_\_](#primalbedtools.amplicons.Amplicon.__hash__)
  + [\_\_init\_\_](#primalbedtools.amplicons.Amplicon.__init__)
  + [to\_amplicon\_str](#primalbedtools.amplicons.Amplicon.to_amplicon_str)
  + [to\_primertrim\_str](#primalbedtools.amplicons.Amplicon.to_primertrim_str)
* [create\_amplicons](#primalbedtools.amplicons.create_amplicons)
* [do\_pp\_ol](#primalbedtools.amplicons.do_pp_ol)

# API

### `Scheme`

A class representing a primer scheme with headers and primer bed lines.

A Scheme contains both the header lines (comments) and the primer bed lines
that define a complete primer scheme for amplicon sequencing or qPCR.

Please use Scheme.from\_str() or Scheme.from\_file() for creation.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `headers` | `list[str]` | List of header/comment lines from the bed file |
| `bedlines` | `list[[BedLine](#primalbedtools.bedfiles.BedLine "BedLine (primalbedtools.bedfiles.BedLine)")]` | List of BedLine objects representing primers |

Source code in `primalbedtools/scheme.py`

|  |  |
| --- | --- |
| ```  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 ``` | ``` class Scheme:     """A class representing a primer scheme with headers and primer bed lines.      A Scheme contains both the header lines (comments) and the primer bed lines     that define a complete primer scheme for amplicon sequencing or qPCR.      Please use Scheme.from_str() or Scheme.from_file() for creation.      Attributes:         headers (list[str]): List of header/comment lines from the bed file         bedlines (list[BedLine]): List of BedLine objects representing primers     """      headers: list[str]     bedlines: list[BedLine]      def __init__(self, headers: Optional[list[str]], bedlines: list[BedLine]):         """Initialize a Scheme with headers and bedlines.          Please use Scheme.from_str() or Scheme.from_file() for creation.          Args:             headers: Optional list of header strings. If None, defaults to empty list.             bedlines: List of BedLine objects representing the primers in the scheme.         """         # Parse the headers         if headers is None:             headers = []          self.headers = headers         self.bedlines = bedlines      # io     @classmethod     def from_str(cls, str: str):         """Create a Scheme from a bed file string.          Args:             str: String containing bed file content with headers and primer lines.          Returns:             Scheme: A new Scheme object parsed from the string.         """         headers, bedlines = bedline_from_str(str)         return cls(headers, bedlines)      @classmethod     def from_file(cls, file: str):         """Create a Scheme from a bed file on disk.          Args:             file: Path to the bed file to read.          Returns:             Scheme: A new Scheme object loaded from the file.         """         headers, bedlines = read_bedfile(file)         return cls(he