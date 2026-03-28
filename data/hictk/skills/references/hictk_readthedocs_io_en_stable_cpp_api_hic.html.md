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

[View this page](../_sources/cpp_api/hic.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Hi-C API[¶](#hi-c-api "Link to this heading")

API to operate on .hic files. Compared to the generic API, this API provides:

* more control over how files are opened
* access to .hic-specific metadata
* control over the interaction block cache

## Common[¶](#common "Link to this heading")

enum class MatrixType[¶](#_CPPv4N5hictk3hic10MatrixTypeE "Link to this definition")
:   enumerator observed[¶](#_CPPv4N5hictk3hic10MatrixType8observedE "Link to this definition")

    enumerator oe[¶](#_CPPv4N5hictk3hic10MatrixType2oeE "Link to this definition")

    enumerator expected[¶](#_CPPv4N5hictk3hic10MatrixType8expectedE "Link to this definition")

enum class MatrixUnit[¶](#_CPPv4N5hictk3hic10MatrixUnitE "Link to this definition")
:   enumerator BP[¶](#_CPPv4N5hictk3hic10MatrixUnit2BPE "Link to this definition")

    enumerator FRAG[¶](#_CPPv4N5hictk3hic10MatrixUnit4FRAGE "Link to this definition")

enum class QUERY\_TYPE[¶](#_CPPv4N5hictk3hic10QUERY_TYPEE "Link to this definition")
:   enumerator BED[¶](#_CPPv4N5hictk3hic10QUERY_TYPE3BEDE "Link to this definition")

    enumerator UCSC[¶](#_CPPv4N5hictk3hic10QUERY_TYPE4UCSCE "Link to this definition")

## File handle[¶](#file-handle "Link to this heading")

class File[¶](#_CPPv4N5hictk3hic4FileE "Link to this definition")
:   **Constructors**

    explicit File( : std::string url\_, : std::optional<std::uint32\_t> resolution\_, : [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType") type\_ = [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType")::[observed](#_CPPv4N5hictk3hic10MatrixType8observedE "hictk::hic::MatrixType::observed"), : [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit") unit\_ = [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit")::[BP](#_CPPv4N5hictk3hic10MatrixUnit2BPE "hictk::hic::MatrixUnit::BP"), : std::uint64\_t block\_cache\_capacity = 0 );[¶](#_CPPv4N5hictk3hic4File4FileENSt6stringENSt8optionalINSt8uint32_tEEE10MatrixType10MatrixUnitNSt8uint64_tE "Link to this definition")

    **Open/close methods**

    [File](#_CPPv4N5hictk3hic4FileE "hictk::hic::File") &open( : std::string url\_, : std::optional<std::uint32\_t> resolution\_, : [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType") type\_ = [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType")::[observed](#_CPPv4N5hictk3hic10MatrixType8observedE "hictk::hic::MatrixType::observed"), : [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit") unit\_ = [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit")::[BP](#_CPPv4N5hictk3hic10MatrixUnit2BPE "hictk::hic::MatrixUnit::BP"), : std::uint64\_t block\_cache\_capacity = 0 );[¶](#_CPPv4N5hictk3hic4File4openENSt6stringENSt8optionalINSt8uint32_tEEE10MatrixType10MatrixUnitNSt8uint64_tE "Link to this definition")

    [File](#_CPPv4N5hictk3hic4FileE "hictk::hic::File") &open( : std::uint32\_t resolution\_, : [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType") type\_ = [MatrixType](#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType")::[observed](#_CPPv4N5hictk3hic10MatrixType8observedE "hictk::hic::MatrixType::observed"), : [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit") unit\_ = [MatrixUnit](#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit")::[BP](#_CPPv4N5hictk3hic10MatrixUnit2BPE "hictk::hic::MatrixUnit::BP"), : std::uint64\_t block\_cache\_capacity = 0 );[¶](#_CPPv4N5hictk3hic4File4openENSt8uint32_tE10MatrixType10MatrixUnitNSt8uint64_tE "Link to this definition")

    **Accessors**

    [[nodiscard]] bool has\_resolution(std::uint32\_t resolution) const;[¶](#_CPPv4NK5hictk3hic4File14has_resolutionENSt8uint32_tE "Link to this definition")

    [[nodiscard]] const std::string &path() const noexcept;[¶](#_CPPv4NK5hictk3hic4File4pathEv "Link to this definition")

    [[nodiscard]] const std::string &name() const noexcept;[¶](#_CPPv4NK5hictk3hic4File4nameEv "Link to this definition")

    [[nodiscard]] std::int32\_t version() const noexcept;[¶](#_CPPv4NK5hictk3hic4File7versionEv "Link to this definition")

    [[nodiscard]] const [Reference](shared.html#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chromosomes() const noexcept;[¶](#_CPPv4NK5hictk3hic4File11chromosomesEv "Link to this definition")

    [[nodiscard]] const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable") &bins() const noexcept;[¶](#_CPPv4NK5hictk3hic4File4binsEv "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> bins\_ptr() const noexcept;[¶](#_CPPv4NK5hictk3hic4File8bins_ptrEv "Link to this definition")

    [[nodiscard]] std::uint32\_t resolution() const noexcept;[¶](#_CPPv4NK5hictk3hic4File10resolutionEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nbins() const;[¶](#_CPPv4NK5hictk3hic4File5nbinsEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nchroms(bool include\_ALL = false) const;[¶](#_CPPv4NK5hictk3hic4File7nchromsEb "Link to this definition")

    [[nodiscard]] const std::string &assembly() const noexcept;[¶](#_CPPv4NK5hictk3hic4File8assemblyEv "Link to this definition")

    [[nodiscard]] const std::vector<std::uint32\_t> &avail\_resolutions() const noexcept;[¶](#_CPPv4NK5hictk3hic4File17avail_resolutionsEv "Link to this definition")

    [[nodiscard]] bool has\_normalization(std::string\_view normalization) const;[¶](#_CPPv4NK5hictk3hic4File17has_normalizationENSt11string_viewE "Link to this definition")

    [[nodiscard]] std::vector<balancing::Method> avail\_normalizations() const;[¶](#_CPPv4NK5hictk3hic4File20avail_normalizationsEv "Link to this definition")

    [[nodiscard]] const balancing::Weights &normalization( : const balancing::Method &norm, : const [Chromosome](shared.html#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom ) const;[¶](#_CPPv4NK5hictk3hic4File13normalizationERKN9balancing6MethodERK10Chromosome "Link to this definition")

    [[nodiscard]] const balancing::Weights &normalization( : std::string\_view norm, : const [Chromosome](shared.html#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom ) const;[¶](#_CPPv4NK5hictk3hic4File13normalizationENSt11string_viewERK10Chromosome "Link to this definition")

    [[nodiscard]] const balancing::Weights &normalization( : const balancing::Method &norm ) const;[¶](#_CPPv4NK5hictk3hic4File13normalizationERKN9balancing6MethodE "Link to this definition")

    [[nodiscard]] const balancing::Weights &normalization( : std::string\_view norm ) const;[¶](#_CPPv4NK5hictk3hic4File13normalizationENSt11string_viewE "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const balancing::Weights> normalization\_ptr( : const balancing::Method &norm, : const [Chromosome](shared.html#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom ) const;[¶](#_CPPv4NK5hictk3hic4File17normalization_ptrERKN9balancing6MethodERK10Chromosome "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const balancing::Weights> normalization\_ptr( : std::string\_view norm, : const [Chromosome](shared.html#_CPPv4N5hictk10ChromosomeE "hictk::Chromosome") &chrom ) const;[¶](#_CPPv4NK5hictk3hic4File17normalization_ptrENSt11string_viewERK10Chromosome "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const balancing::Weights> normalization\_ptr( : const balancing::Method &norm ) const;[¶](#_CPPv4NK5hictk3hic4File17normalization_ptrERKN9balancing6MethodE "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const balancing::Weights> normalization\_ptr( : std::string\_view norm ) const;[¶](#_CPPv4NK5hictk3hic4File17normalization_ptrENSt11string_viewE "Link to this definition")

    **Fetch methods (1D queries)**

    [[nodiscard]] PixelSelectorAll fetch( : const balancing::Method &norm = balancing::Method::NONE(), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchERKN9balancing6MethodENSt8optionalINSt8uint64_tEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::string\_view range, : const balancing::Method &norm = balancing::Method::NONE(), : [QUERY\_TYPE](#_CPPv4N5hictk3hic10QUERY_TYPEE "hictk::hic::QUERY_TYPE") query\_type = [QUERY\_TYPE](#_CPPv4N5hictk3hic10QUERY_TYPEE "hictk::hic::QUERY_TYPE")::[UCSC](#_CPPv4N5hictk3hic10QUERY_TYPE4UCSCE "hictk::hic::QUERY_TYPE::UCSC"), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt11string_viewERKN9balancing6MethodE10QUERY_TYPENSt8optionalINSt8uint64_tEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::string\_view chrom\_name, : std::uint32\_t start, : std::uint32\_t end, : const balancing::Method &norm = balancing::Method::NONE(), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tERKN9balancing6MethodENSt8optionalINSt8uint64_tEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::uint64\_t first\_bin, : std::uint64\_t last\_bin, : const balancing::Method &norm = balancing::Method::NONE(), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt8uint64_tENSt8uint64_tERKN9balancing6MethodENSt8optionalINSt8uint64_tEEE "Link to this definition")

    **Fetch methods (2D queries)**

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::string\_view range1, : std::string\_view range2, : const balancing::Method &norm = balancing::Method::NONE(), : [QUERY\_TYPE](#_CPPv4N5hictk3hic10QUERY_TYPEE "hictk::hic::QUERY_TYPE") query\_type = [QUERY\_TYPE](#_CPPv4N5hictk3hic10QUERY_TYPEE "hictk::hic::QUERY_TYPE")::[UCSC](#_CPPv4N5hictk3hic10QUERY_TYPE4UCSCE "hictk::hic::QUERY_TYPE::UCSC"), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt11string_viewENSt11string_viewERKN9balancing6MethodE10QUERY_TYPENSt8optionalINSt8uint64_tEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::string\_view chrom1\_name, : std::uint32\_t start1, : std::uint32\_t end1, : std::string\_view chrom2\_name, : std::uint32\_t start2, : std::uint32\_t end2, : const balancing::Method &norm = balancing::Method::NONE(), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tENSt11string_viewENSt8uint32_tENSt8uint32_tERKN9balancing6MethodENSt8optionalINSt8uint64_tEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") fetch( : std::uint64\_t first\_bin1, : std::uint64\_t last\_bin1, : std::uint64\_t first\_bin2, : std::uint64\_t last\_bin2, : const balancing::Method &norm = balancing::Method::NONE(), : std::optional<std::uint64\_t> diagonal\_band\_width = {} ) const;[¶](#_CPPv4NK5hictk3hic4File5fetchENSt8uint64_tENSt8uint64_tENSt8uint64_tENSt8uint64_tERKN9balancing6MethodENSt8optionalINSt8uint64_tEEE "Link to this definition")

    **Caching**

    [[nodiscard]] std::size\_t num\_cached\_footers() const noexcept;[¶](#_CPPv4NK5hictk3hic4File18num_cached_footersEv "Link to this definition")

    void purge\_footer\_cache();[¶](#_CPPv4N5hictk3hic4File18purge_footer_cacheEv "Link to this definition")

    [[nodiscard]] double block\_cache\_hit\_rate() const noexcept;[¶](#_CPPv4NK5hictk3hic4File20block_cache_hit_rateEv "Link to this definition")

    void reset\_cache\_stats() const noexcept;[¶](#_CPPv4NK5hictk3hic4File17reset_cache_statsEv "Link to this definition")

    void clear\_cache() noexcept;[¶](#_CPPv4N5hictk3hic4File11clear_cacheEv "Link to this definition")

    void optimize\_cache\_size( : std::size\_t upper\_bound = (std::numeric\_limits<std::size\_t>::max)() );[¶](#_CPPv4N5hictk3hic4File19optimize_cache_sizeENSt6size_tE "Link to this definition")

    void optimize\_cache\_size\_for\_iteration( : std::size\_t upper\_bound = (std::numeric\_limits<std::size\_t>::max)() );[¶](#_CPPv4N5hictk3hic4File33optimize_cache_size_for_iterationENSt6size_tE "Link to this definition")

    void optimize\_cache\_size\_for\_random\_access( : std::size\_t upper\_bound = (std::numeric\_limits<std::size\_t>::max)() );[¶](#_CPPv4N5hictk3hic4File37optimize_cache_size_for_random_accessENSt6size_tE "Link to this definition")

    [[nodiscard]] std::size\_t cache\_capacity() const noexcept;[¶](#_CPPv4NK5hictk3hic4File14cache_capacityEv "Link to this definition")

## Pixel selector[¶](#pixel-selector "Link to this heading")

class PixelSelector[¶](#_CPPv4N5hictk3hic13PixelSelectorE "Link to this definition")
:   **Operators**

    [[nodiscard]] bool operator==(const [PixelSelector](#_CPPv4N5hictk3hic13PixelSelectorE "hictk::hic::PixelSelector") &other) const noexcept;[¶](#_CPPv4NK5hictk3hic13PixelSelectoreqERK13PixelSelector "Link