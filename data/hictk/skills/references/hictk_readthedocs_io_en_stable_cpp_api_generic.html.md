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

[View this page](../_sources/cpp_api/generic.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Generic API[¶](#generic-api "Link to this heading")

hictk generic API allows users to transparently operate on .hic .cool files.
There is virtually no runtime overhead when using the [`File`](#_CPPv4N5hictk4FileE "hictk::File") and [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") classes. However iterating over [`Pixel`](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")s using this API is slightly slower than using the format-specific APIs.

Refer to examples in the [Quickstart (API)](../quickstart_api.html) section for how to use the generic API without incurring into any overhead when iterating over [`Pixel`](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")s overlapping queries.

## Common[¶](#common "Link to this heading")

enum class QUERY\_TYPE[¶](#_CPPv4N5hictk10QUERY_TYPEE "Link to this definition")
:   enumerator BED[¶](#_CPPv4N5hictk10QUERY_TYPE3BEDE "Link to this definition")

    enumerator UCSC[¶](#_CPPv4N5hictk10QUERY_TYPE4UCSCE "Link to this definition")

## File handle[¶](#file-handle "Link to this heading")

class File[¶](#_CPPv4N5hictk4FileE "Link to this definition")
:   This class implements a generic file handle capable of transparently operating on .cool and .hic files.

    **Constructors**

    File(cooler::[File](cooler.html#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") clr);[¶](#_CPPv4N5hictk4File4FileEN6cooler4FileE "Link to this definition")

    File(hic::[File](hic.html#_CPPv4N5hictk3hic4FileE "hictk::hic::File") hf);[¶](#_CPPv4N5hictk4File4FileEN3hic4FileE "Link to this definition")

    File( : std::string\_view uri, : std::optional<std::uint32\_t> resolution = {}, : hic::[MatrixType](hic.html#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType") type = hic::[MatrixType](hic.html#_CPPv4N5hictk3hic10MatrixTypeE "hictk::hic::MatrixType")::[observed](hic.html#_CPPv4N5hictk3hic10MatrixType8observedE "hictk::hic::MatrixType::observed"), : hic::[MatrixUnit](hic.html#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit") unit = hic::[MatrixUnit](hic.html#_CPPv4N5hictk3hic10MatrixUnitE "hictk::hic::MatrixUnit")::[BP](hic.html#_CPPv4N5hictk3hic10MatrixUnit2BPE "hictk::hic::MatrixUnit::BP") );[¶](#_CPPv4N5hictk4File4FileENSt11string_viewENSt8optionalINSt8uint32_tEEEN3hic10MatrixTypeEN3hic10MatrixUnitE "Link to this definition")
    :   Constructors for [`File`](#_CPPv4N5hictk4FileE "hictk::File") class.
        `resolution` is a mandatory argument when opening .hic files.
        Matrix `type` and `unit` are ignored when operating on .cool files.

    **Accessors**

    [[nodiscard]] std::string uri() const;[¶](#_CPPv4NK5hictk4File3uriEv "Link to this definition")

    Returns the URI of the open file. Always returns the file path when file is .hic.

    [[nodiscard]] std::string path() const;[¶](#_CPPv4NK5hictk4File4pathEv "Link to this definition")

    Returns the path to the open file.

    [[nodiscard]] constexpr bool is\_hic() const noexcept;[¶](#_CPPv4NK5hictk4File6is_hicEv "Link to this definition")

    [[nodiscard]] constexpr bool is\_cooler() const noexcept;[¶](#_CPPv4NK5hictk4File9is_coolerEv "Link to this definition")

    Test whether the open file is in .hic or .cool format.

    [[nodiscard]] auto chromosomes() const -> const [Reference](shared.html#_CPPv4N5hictk9ReferenceE "hictk::Reference")&;[¶](#_CPPv4NK5hictk4File11chromosomesEv "Link to this definition")

    [[nodiscard]] auto bins() const -> const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")&;[¶](#_CPPv4NK5hictk4File4binsEv "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> bins\_ptr() const;[¶](#_CPPv4NK5hictk4File8bins_ptrEv "Link to this definition")

    Accessors to the chromosomes and bin table of the open file.

    [[nodiscard]] std::uint32\_t resolution() const;[¶](#_CPPv4NK5hictk4File10resolutionEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nbins() const;[¶](#_CPPv4NK5hictk4File5nbinsEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nchroms(bool include\_ALL = false) const;[¶](#_CPPv4NK5hictk4File7nchromsEb "Link to this definition")

    Accessors for common attributes.
    Calling any of these accessors does not involve any computation.

    [[nodiscard]] bool has\_normalization(std::string\_view normalization) const;[¶](#_CPPv4NK5hictk4File17has_normalizationENSt11string_viewE "Link to this definition")

    [[nodiscard]] const balancing::Weights &normalization( : std::string\_view normalization\_ ) const;[¶](#_CPPv4NK5hictk4File13normalizationENSt11string_viewE "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const balancing::Weights> normalization\_ptr( : std::string\_view normalization\_ ) const;[¶](#_CPPv4NK5hictk4File17normalization_ptrENSt11string_viewE "Link to this definition")

    Accessors for normalization methods/vectors.

    **Fetch methods (1D queries)**

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") fetch( : const balancing::Method &normalization = balancing::Method::NONE() ) const;[¶](#_CPPv4NK5hictk4File5fetchERKN9balancing6MethodE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") fetch( : std::string\_view range, : const balancing::Method &normalization = balancing::Method::NONE(), : [QUERY\_TYPE](#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE") query\_type = [QUERY\_TYPE](#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE")::[UCSC](#_CPPv4N5hictk10QUERY_TYPE4UCSCE "hictk::QUERY_TYPE::UCSC") ) const;[¶](#_CPPv4NK5hictk4File5fetchENSt11string_viewERKN9balancing6MethodE10QUERY_TYPE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") fetch( : std::string\_view chrom\_name, : std::uint32\_t start, : std::uint32\_t end, : const balancing::Method &normalization = balancing::Method::NONE() ) const;[¶](#_CPPv4NK5hictk4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tERKN9balancing6MethodE "Link to this definition")
    :   Return a [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") object that can be used to fetch pixels overlapping 1D (symmetric) queries.

        **Example usage:**

        ```
        hictk::File f{"myfile.hic", 1'000};

        // Fetch all pixels
        const auto sel1 = f.fetch();

        // Fetch all pixels (normalized with VC);
        const auto sel2 = f.fetch(balancing::Method::VC());

        // Fetch pixels overlapping chr1
        const auto sel3 = f.fetch("chr1");

        // Fetch pixels overlapping a region of interest
        const auto sel4 = f.fetch("chr1:10,000,000-20,000,000");
        const auto sel5 = f.fetch("chr1", 10'000'000, 20'000'000");

        // Fetch pixels using a BED query
        const auto sel6 = f.fetch("chr1\t10000000\t20000000",
                                  balancing::Method::NONE(),
                                  QUERY_TYPE::BED);
        ```

    **Fetch methods (2D queries)**

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") fetch( : std::string\_view range1, : std::string\_view range2, : const balancing::Method &normalization = balancing::Method::NONE(), : [QUERY\_TYPE](#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE") query\_type = [QUERY\_TYPE](#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE")::[UCSC](#_CPPv4N5hictk10QUERY_TYPE4UCSCE "hictk::QUERY_TYPE::UCSC") ) const;[¶](#_CPPv4NK5hictk4File5fetchENSt11string_viewENSt11string_viewERKN9balancing6MethodE10QUERY_TYPE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") fetch( : std::string\_view chrom1\_name, : std::uint32\_t start1, : std::uint32\_t end1, : std::string\_view chrom2\_name, : std::uint32\_t start2, : std::uint32\_t end2, : const balancing::Method &normalization = balancing::Method::NONE() ) const;[¶](#_CPPv4NK5hictk4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tENSt11string_viewENSt8uint32_tENSt8uint32_tERKN9balancing6MethodE "Link to this definition")

    Return a [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") object that can be used to fetch pixels overlapping 2D (asymmetric) queries.

    > **Example usage:**
    >
    > ```
    > hictk::File f{"myfile.hic", 1'000};
    >
    > // Fetch pixels overlapping chr1:chr2
    > const auto sel1 = f.fetch("chr1", "chr2");
    >
    > // Fetch pixels overlapping a region of interest
    > const auto sel2 = f.fetch("chr1:10,000,000-20,000,000",
    >                           "chr2:10,000,000-20,000,000");
    > const auto sel3 = f.fetch("chr1", 10'000'000, 20'000'000,
    >                           "chr2", 10'000'000, 20'000'000);
    > ```

    **Advanced**

    template<typename FileT> [[nodiscard]] constexpr const [FileT](#_CPPv4I0ENK5hictk4File3getERK5FileTv "hictk::File::get::FileT") &get() const;[¶](#_CPPv4I0ENK5hictk4File3getERK5FileTv "Link to this definition")

    template<typename FileT> [[nodiscard]] constexpr [FileT](#_CPPv4I0EN5hictk4File3getER5FileTv "hictk::File::get::FileT") &get();[¶](#_CPPv4I0EN5hictk4File3getER5FileTv "Link to this definition")

    [[nodiscard]] constexpr auto get() const noexcept -> const FileVar&;[¶](#_CPPv4NK5hictk4File3getEv "Link to this definition")

    [[nodiscard]] constexpr auto get() noexcept -> FileVar&;[¶](#_CPPv4N5hictk4File3getEv "Link to this definition")
    :   Methods to get the underlying [`hic::File`](hic.html#_CPPv4N5hictk3hic4FileE "hictk::hic::File") or [`cooler::File`](cooler.html#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") file handle or a `std::variant` of thereof.

        **Example usage:**

        ```
        hictk::File f{"myfile.hic", 1'000};

        assert(f.get<hic::File>().path() == "myfile.hic");
        assert(f.get<cooler::File>().path() == "myfile.hic");  // Throws an exception

        const auto fvar = f.get();
        std::visit([](const auto& f) {
          assert(f.path() == "myfile.hic");
        }, fvar);
        ```

## Pixel selector[¶](#pixel-selector "Link to this heading")

class PixelSelector[¶](#_CPPv4N5hictk13PixelSelectorE "Link to this definition")
:   This class implements a generic, lightweight pixel selector object.

    [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") objects are constructed and returned by [`File::fetch()`](#_CPPv4NK5hictk4File5fetchERKN9balancing6MethodE "hictk::File::fetch") methods.
    Users are **not** supposed to construct [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") objects themselves.

    **Iteration**

    template<typename N> [[nodiscard]] auto begin( : bool sorted = true ) const -> iterator<[N](#_CPPv4I0ENK5hictk13PixelSelector5beginE8iteratorI1NEb "hictk::PixelSelector::begin::N")>;[¶](#_CPPv4I0ENK5hictk13PixelSelector5beginE8iteratorI1NEb "Link to this definition")

    template<typename N> [[nodiscard]] auto end() const -> iterator<[N](#_CPPv4I0ENK5hictk13PixelSelector3endE8iteratorI1NEv "hictk::PixelSelector::end::N")>;[¶](#_CPPv4I0ENK5hictk13PixelSelector3endE8iteratorI1NEv "Link to this definition")

    template<typename N> [[nodiscard]] auto cbegin( : bool sorted = true ) const -> iterator<[N](#_CPPv4I0ENK5hictk13PixelSelector6cbeginE8iteratorI1NEb "hictk::PixelSelector::cbegin::N")>;[¶](#_CPPv4I0ENK5hictk13PixelSelector6cbeginE8iteratorI1NEb "Link to this definition")

    template<typename N> [[nodiscard]] auto cend() const -> iterator<[N](#_CPPv4I0ENK5hictk13PixelSelector4cendE8iteratorI1NEv "hictk::PixelSelector::cend::N")>;[¶](#_CPPv4I0ENK5hictk13PixelSelector4cendE8iteratorI1NEv "Link to this definition")

    Return an [InputIterator](https://en.cppreference.com/w/cpp/named_req/InputIterator) to traverse pixels
    overlapping the genomic coordinates used to create the [`PixelSelector`](#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector").

    Specifying `sorted = false` will improve throughput for queries over .hic files.

    When operating on .cool files, pixels are always returned sorted by genomic coordinates.

    > **Example usage:**
    >
    > ```
    > hictk::File f{"myfile.hic", 1'000};
    > const auto sel = f.fetch();
    >
    > std::for_each(sel.begin<std::int32_t>(), sel.end<std::int32_t>(),
    >               [&](const auto& pixel) { fmt::print("{}\n", pixel); });
    >
    > // STDOUT
    > // 0  0 12
    > // 0  2 7
    > // 0  4 1
    > // ...
    > ```

    **Fetch at once**

    template<typename N> [[nodiscard]] std::vector<[Pixel](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")<[N](#_CPPv4I0ENK5hictk13PixelSelector8read_allENSt6vectorI5PixelI1NEEEv "hictk::PixelSelector::read_all::N")>> read\_all() const;[¶](#_CPPv4I0ENK5hictk13PixelSelector8read_allENSt6vectorI5PixelI1NEEEv "Link to this definition")

    Read and return all [`Pixel`](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")s at once using a `std::vector`.

    **Accessors**

    [[nodiscard]] const [PixelCoordinates](shared.html#_CPPv4N5hictk16PixelCoordinatesE "hictk::PixelCoordinates") &coord1() const noexcept;[¶](#_CPPv4NK5hictk13PixelSelector6coord1Ev "Link to this definition")

 