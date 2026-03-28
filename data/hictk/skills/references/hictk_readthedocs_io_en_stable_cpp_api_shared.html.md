Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[hictk documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](../index.html)

Installation

* [Installation](../installation.html)
* [Installation (source)](../installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](../faq.html)

Getting Started

* [Quickstart (CLI)](../quickstart_cli.html)
* [Quickstart (API)](../quickstart_api.html)
* [Downloading test datasets](../downloading_test_datasets.html)
* [File validation](../file_validation.html)
* [File metadata](../file_metadata.html)
* [Format conversion](../format_conversion.html)
* [Reading interactions](../reading_interactions.html)
* [Creating .cool and .hic files](../creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](../creating_multires_files.html)
* [Balancing Hi-C matrices](../balancing_matrices.html)

How-Tos

* [Reorder chromosomes](../tutorials/reordering_chromosomes.html)
* [Dump interactions to .cool or .hic file](../tutorials/dump_interactions_to_cool_hic_file.html)

CLI and API Reference

* [CLI Reference](../cli_reference.html)
* [C++ API Reference](index.html)[x]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](../telemetry.html)

Back to top

[View this page](../_sources/cpp_api/shared.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Shared Types[¶](#shared-types "Link to this heading")

Types documented in this page are used throughout hictk code-base to model various concepts such as genomic intervals, reference genomes, bins and pixels.

## Chromosome[¶](#chromosome "Link to this heading")

class Chromosome[¶](#_CPPv4N5hictk10ChromosomeE "Link to this definition")
:   This class models chromosomes as triplets consisting of:

    * A numeric identifier
    * The chromosome name
    * The chromosome size

    [`Chromosome`](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome")s are compared by ID.

    **Constructors**

    Chromosome() = default;[¶](#_CPPv4N5hictk10Chromosome10ChromosomeEv "Link to this definition")

    Chromosome(std::uint32\_t id\_, std::string name\_, std::uint32\_t size\_) noexcept;[¶](#_CPPv4N5hictk10Chromosome10ChromosomeENSt8uint32_tENSt6stringENSt8uint32_tE "Link to this definition")

    **Operators**

    [[nodiscard]] explicit constexpr operator bool() const noexcept;[¶](#_CPPv4NK5hictk10ChromosomecvbEv "Link to this definition")

    **Accessors**

    [[nodiscard]] constexpr std::uint32\_t id() const noexcept;[¶](#_CPPv4NK5hictk10Chromosome2idEv "Link to this definition")

    [[nodiscard]] std::string\_view name() const noexcept;[¶](#_CPPv4NK5hictk10Chromosome4nameEv "Link to this definition")

    [[nodiscard]] constexpr std::uint32\_t size() const noexcept;[¶](#_CPPv4NK5hictk10Chromosome4sizeEv "Link to this definition")

    [[nodiscard]] bool is\_all() const noexcept;[¶](#_CPPv4NK5hictk10Chromosome6is_allEv "Link to this definition")

    **Comparison operators**

    [[nodiscard]] constexpr bool operator<(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomeltERK10Chromosome "Link to this definition")

    [[nodiscard]] constexpr bool operator>(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomegtERK10Chromosome "Link to this definition")

    [[nodiscard]] constexpr bool operator<=(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomeleERK10Chromosome "Link to this definition")

    [[nodiscard]] constexpr bool operator>=(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomegeERK10Chromosome "Link to this definition")

    [[nodiscard]] bool operator==(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomeeqERK10Chromosome "Link to this definition")

    [[nodiscard]] bool operator!=(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &other) const noexcept;[¶](#_CPPv4NK5hictk10ChromosomeneERK10Chromosome "Link to this definition")

    friend bool operator==(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, std::string\_view b\_name) noexcept;[¶](#_CPPv4N5hictk10ChromosomeeqERK10ChromosomeNSt11string_viewE "Link to this definition")

    friend bool operator!=(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, std::string\_view b\_name) noexcept;[¶](#_CPPv4N5hictk10ChromosomeneERK10ChromosomeNSt11string_viewE "Link to this definition")

    friend bool operator==(std::string\_view a\_name, const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b) noexcept;[¶](#_CPPv4N5hictk10ChromosomeeqENSt11string_viewERK10Chromosome "Link to this definition")

    friend bool operator!=(std::string\_view a\_name, const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b) noexcept;[¶](#_CPPv4N5hictk10ChromosomeneENSt11string_viewERK10Chromosome "Link to this definition")

    friend constexpr bool operator<( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeltERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator>( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomegtERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator<=( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeleERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator>=( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomegeERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator==( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeeqERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator!=( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &a, : std::uint32\_t b\_id ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeneERK10ChromosomeNSt8uint32_tE "Link to this definition")

    friend constexpr bool operator<( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeltENSt8uint32_tERK10Chromosome "Link to this definition")

    friend constexpr bool operator>( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomegtENSt8uint32_tERK10Chromosome "Link to this definition")

    friend constexpr bool operator<=( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeleENSt8uint32_tERK10Chromosome "Link to this definition")

    friend constexpr bool operator>=( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomegeENSt8uint32_tERK10Chromosome "Link to this definition")

    friend constexpr bool operator==( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeeqENSt8uint32_tERK10Chromosome "Link to this definition")

    friend constexpr bool operator!=( : std::uint32\_t a\_id, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &b ) noexcept;[¶](#_CPPv4N5hictk10ChromosomeneENSt8uint32_tERK10Chromosome "Link to this definition")

## Genomic intervals[¶](#genomic-intervals "Link to this heading")

class GenomicInterval[¶](#_CPPv4N5hictk15GenomicIntervalE "Link to this definition")
:   Class to represent 1D genomic intervals.

    This class has two main purposes:

    * Storing information regarding genomic intervals
    * Simplifying comparison of genomic intervals (e.g. is interval A upstream of interval B)

    enum class QUERY\_TYPE[¶](#_CPPv4N5hictk15GenomicInterval10QUERY_TYPEE "Link to this definition")
    :   enumerator BED[¶](#_CPPv4N5hictk15GenomicInterval10QUERY_TYPE3BEDE "Link to this definition")

        enumerator UCSC[¶](#_CPPv4N5hictk15GenomicInterval10QUERY_TYPE4UCSCE "Link to this definition")

    **Constructors**

    constexpr GenomicInterval() = default;[¶](#_CPPv4N5hictk15GenomicInterval15GenomicIntervalEv "Link to this definition")

    explicit GenomicInterval(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom\_) noexcept;[¶](#_CPPv4N5hictk15GenomicInterval15GenomicIntervalERK10Chromosome "Link to this definition")

    GenomicInterval( : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom\_, : std::uint32\_t start\_, : std::uint32\_t end ) noexcept;[¶](#_CPPv4N5hictk15GenomicInterval15GenomicIntervalERK10ChromosomeNSt8uint32_tENSt8uint32_tE "Link to this definition")

    **Factory methods**

    [[nodiscard]] static [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") parse( : const [Reference](#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chroms, : const std::string &query, : Type type = Type::UCSC );[¶](#_CPPv4N5hictk15GenomicInterval5parseERK9ReferenceRKNSt6stringE4Type "Link to this definition")

    [[nodiscard]] static [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") parse\_ucsc( : const [Reference](#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chroms, : std::string query );[¶](#_CPPv4N5hictk15GenomicInterval10parse_ucscERK9ReferenceNSt6stringE "Link to this definition")

    [[nodiscard]] static [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") parse\_bed( : const [Reference](#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chroms, : std::string\_view query, : char sep = '\t' );[¶](#_CPPv4N5hictk15GenomicInterval9parse_bedERK9ReferenceNSt11string_viewEc "Link to this definition")

    [[nodiscard]] static std::tuple<std::string, std::uint32\_t, std::uint32\_t> parse( : const std::string &query, : Type type = Type::UCSC );[¶](#_CPPv4N5hictk15GenomicInterval5parseERKNSt6stringE4Type "Link to this definition")

    [[nodiscard]] static std::tuple<std::string, std::uint32\_t, std::uint32\_t> parse\_ucsc( : std::string buffer );[¶](#_CPPv4N5hictk15GenomicInterval10parse_ucscENSt6stringE "Link to this definition")

    [[nodiscard]] static std::tuple<std::string, std::uint32\_t, std::uint32\_t> parse\_bed( : std::string\_view buffer, : char sep = '\t' );[¶](#_CPPv4N5hictk15GenomicInterval9parse_bedENSt11string_viewEc "Link to this definition")

    **Operators**

    [[nodiscard]] explicit operator bool() const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalcvbEv "Link to this definition")

    [[nodiscard]] bool operator==(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervaleqERK15GenomicInterval "Link to this definition")

    [[nodiscard]] bool operator!=(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalneERK15GenomicInterval "Link to this definition")

    [[nodiscard]] bool operator<(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalltERK15GenomicInterval "Link to this definition")

    [[nodiscard]] bool operator<=(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalleERK15GenomicInterval "Link to this definition")

    [[nodiscard]] bool operator>(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalgtERK15GenomicInterval "Link to this definition")

    [[nodiscard]] bool operator>=(const [GenomicInterval](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") &other) const noexcept;[¶](#_CPPv4NK5hictk15GenomicIntervalgeERK15GenomicInterval "Link to this definition")

    **Accessors**

    [[nodiscard]] const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom() const noexcept;[¶](#_CPPv4NK5hictk15GenomicInterval5chromEv "Link to this definition")

    [[nodiscard]] constexpr std::uint32\_t start() const noexcept;[¶](#_CPPv4NK5hictk15GenomicInterval5startEv "Link to this definition")

    [[nodiscard]] constexpr std::uint32\_t end() const noexcept;[¶](#_CPPv4NK5hictk15GenomicInterval3endEv "Link to this definition")

    [[nodiscard]] constexpr std::uint32\_t size() const noexcept;[¶](#_CPPv4NK5hictk15GenomicInterval4sizeEv "Link to this definition")

## Genomic bins[¶](#genomic-bins "Link to this heading")

class Bin[¶](#_CPPv4N5hictk3BinE "Link to this definition")
:   Class modeling genomic bins.

    The class is implemented as a thin wrapper around [`GenomicInterval`](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval")s. The main difference between [`Bin`](#_CPPv4N5hictk3BinE "hictk::Bin") and [`GenomicInterval`](#_CPPv4N5hictk15GenomicIntervalE "hictk::GenomicInterval") objects is that in addition to genomic coordinates, the [`Bin`](#_CPPv4N5hictk3BinE "hictk::Bin") object also store two identifiers:

    * A unique identifier that can be used to refer [`Bin`](#_CPPv4N5hictk3BinE "hictk::Bin")s in a [`Reference`](#_CPPv4N5hictk9ReferenceE "hictk::Reference").
    * A relative identifier that can be used to refer to [`Bin`](#_CPPv4N5hictk3BinE "hictk::Bin")s in a [`Chromosome`](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome").

    constexpr Bin() = default;[¶](#_CPPv4N5hictk3Bin3BinEv "Link to this definition")

    Bin(const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom\_, std::uint32\_t start\_, std::uint32\_t end) noexcept;[¶](#_CPPv4N5hictk3Bin3BinERK10ChromosomeNSt8uint32_tENSt8uint32_tE "Link to this definition")

    Bin( : std::uint64\_t id\_, : std::uint32\_t rel\_id\_, : const [Chromosome](#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom\_, : std::uint32\_t start\_, : std::uint32\_t end\_ ) noexcept;[¶](#_CPPv4N5hictk3Bin3BinENSt8uint64_tENSt8uint32_tERK10ChromosomeNSt8uint32_tENSt8uint32_tE "Link