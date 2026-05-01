* [![FFmpeg](img/ffmpeg3d_white_20.png)
  FFmpeg](.)
* [About](about.html)
* [News](index.html#news)
* [Download](download.html)
* [Documentation](documentation.html)
* [Community](community.html)
  + [Code of Conduct](community.html#Code-of-Conduct)
  + [Mailing Lists](contact.html#MailingLists)
  + [IRC](contact.html#IRCChannels)
  + [Forums](contact.html#Forums)
  + [Bug Reports](bugreports.html)
  + [Wiki](https://trac.ffmpeg.org)
  + [Conferences](https://trac.ffmpeg.org/wiki/Conferences)
* [Developers](developer.html)
  + [Source Code](download.html#get-sources)+ [Contribute](developer.html#Introduction)
    + [FATE](http://fate.ffmpeg.org)
    + [Code Coverage](http://coverage.ffmpeg.org)
    + [Funding through SPI](spi.html)
* More
  + [Donate](donations.html)
  + [Hire Developers](consulting.html)
  + [Contact](contact.html)
  + [Security](security.html)
  + [Legal](legal.html)

# FFmpeg Security

### Reporting vulnerabilities

Note, we have recently seen a spike in AI generated, false positives. Make sure that what you report are real issues by careful human verification. And they are issues reproducible with prior existing applications.
And that you provide a easy to use testcase. Automated submissions are not accepted. Please report vulnerabilities to ffmpeg-security@ffmpeg.org

Please include the following:

1. Name(s) or alias(es) of the human reviewer(s) who verified the report.
2. Name(s) or alias(es) of the human(s) to credit for finding the vulnerability, if different from the reviewer(s).
3. A reproducible testcase, ideally something we can copy and paste directly, such as an `ffmpeg` command line together with an attached multimedia input file. Please give attached files unique names.
4. An unambiguous source identifier (git commit hash). If you think it replicates with any, dont hesitate to add that information
5. Stack trace(s) with line numbers.
6. A analysis / description of the issue.
7. The commit that introduced the vulnerability, if known.
8. A script generating the input, if available.
9. A git-formatted patch with a proposed fix, if available.
10. Any CVE identifier or other related identifier, if available.

## FFmpeg git master

Fixes following vulnerabilities:

```
CVE-2025-59733, 0469d68acb52081ca8385b844b9650398242be0f, BIGSLEEP-436511754
CVE-2025-59734, d311382c38df9c2237b33a9e8e860a5da7d2895d, BIGSLEEP-440183164
CVE-2025-59734, c41a70b6bb79707e1e3a4b0e31950cd986b9f50e, BIGSLEEP-440183164
CVE-2025-63757, 0c6b7f9483a38657c9be824572b4c0c45d4d9fef
```

## FFmpeg 8.0

### 8.0.1

Fixes following vulnerabilities:

```
CVE-2025-63757, 716cf25eb8616e8e068a7c2a5d23ae107bd117b4 / 0c6b7f9483a38657c9be824572b4c0c45d4d9fef
```

### 8.0

Fixes following vulnerabilities:

```
CVE-2023-6602,  91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6604,  91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6605,  4c96d6bf75357ab13808efc9f08c1b41b1bf5bdf
CVE-2025-0518,  b5b6391d64807578ab872dc58fb8aa621dcfc38a
CVE-2025-1373,  43be8d07281caca2e88bfd8ee2333633e1fb1a13, ticket/11460 never affected a release
CVE-2025-1594,  bedfb6eca402037f5cbb115fa767d106b8c14f1c, ticket/11418
CVE-2025-1816,  0526535cd58444dd264e810b2f3348b4d96cff3b, ticket/11475,
CVE-2025-9951,  104d6846c1be0cb757dc95d5801a416f4d7c687d
CVE-2025-9951,  01a292c7e36545ddeb3c7f79cd02e2611cd37d73
CVE-2025-22919, 1446e37d3d032e1452844778b3e6ba2c20f0c322, ticket/11385,
CVE-2025-22920, 4bf784c0e5615c3f934e677d5de093a8be7da7ae, ticket/11389 never affected a release
CVE-2025-25471, fd1772b7475d0d5673a5dd314ee78443d0be4cf1, ticket/11417 never affected a release
CVE-2025-59728, ce0a655f85c1144d19a4acad59afbb92e4997e30, BIGSLEEP-433502298
CVE-2025-59729, 33ae6cda71e6d34c9081a612abae00e2c7d39f72, BIGSLEEP-433513232
CVE-2025-59730, 3ccd7d8c8e85aaae0c6d6cc88ea6cb5309d56cdc, BIGSLEEP-434637586
CVE-2025-59731, 0d9c003d76383e82b57b6d5aa33776709d0cda2c, BIGSLEEP-436510153
CVE-2025-59732, f45da79b2c336c5f8f3e563d72b8a22fecdcde0c, BIGSLEEP-436510316
CVE-2025-59733, de76fb27a6e6da0431154ce9093933281a38a889 / 0469d68acb52081ca8385b844b9650398242be0f, BIGSLEEP-436511754
CVE-2025-59734, af310e68db0791b94753a9670c9a9ef0d717e32a / d311382c38df9c2237b33a9e8e860a5da7d2895d, BIGSLEEP-440183164
CVE-2025-59734, c3747e011e7c7107ad6ef4c9e0a1c26490e2c30f / c41a70b6bb79707e1e3a4b0e31950cd986b9f50e, BIGSLEEP-440183164
```

## FFmpeg 7.1

### 7.1.2

Fixes following vulnerabilities:

```
CVE-2025-1594,  c2184b65d214d60f2d3df86a11ca502567a3d134, ticket/11418
CVE-2025-9951,  4c036ec307040469783bab0b7223006c0facec1d / 104d6846c1be0cb757dc95d5801a416f4d7c687d
CVE-2025-9951,  d141e864f73152e94e0c45cc4abb8c329275c265 / 01a292c7e36545ddeb3c7f79cd02e2611cd37d73
CVE-2025-59728, 342ea86330ae388baf686fa220892833d55a1c3f / ce0a655f85c1144d19a4acad59afbb92e4997e30, BIGSLEEP-433502298,
CVE-2025-59731, d7e188f33f638d85a1ab70943bde70359454b05c / 0d9c003d76383e82b57b6d5aa33776709d0cda2c, BIGSLEEP-436510153,
CVE-2025-59732, 97932677dbc29c1173f3361886022426ac74197e / f45da79b2c336c5f8f3e563d72b8a22fecdcde0c, BIGSLEEP-436510316,
CVE-2025-59733, a9ec8317498b62192cc3df95ef2523eae8ec0294 / 0469d68acb52081ca8385b844b9650398242be0f, BIGSLEEP-436511754,
```

### 7.1.1

Fixes following vulnerabilities:

```
CVE-2023-6602, b753bac08f6881b2d3dea8f1ab84c81550f35897 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6604, b753bac08f6881b2d3dea8f1ab84c81550f35897 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6605, c3c7ecfe48d464a0b06564f2e92504b1d9c91d69 / 4c96d6bf75357ab13808efc9f08c1b41b1bf5bdf
CVE-2025-0518, b827ac49b770635fc666f8543cb9585e1bc6308b / b5b6391d64807578ab872dc58fb8aa621dcfc38a
CVE-2025-1816, b06845c6727a7c4391a7d5f607ae078aa0073c43 / 0526535cd58444dd264e810b2f3348b4d96cff3b, ticket/11475
CVE-2025-22919, 145a3a84550a1c3a3b848c12a64b53c3c41d2888 / 1446e37d3d032e1452844778b3e6ba2c20f0c322, ticket/11385
```

### 7.1

Fixes following vulnerabilities:

```
CVE-2024-7055 3faadbe2a27e74ff5bb5f7904ec27bb1f5287dc8
CVE-2024-35368, 4513300989502090c4fd6560544dce399a8cd53c (specific to builds with --enable-rkmpp)
CVE-2024-36619, 28c7094b25b689185155a6833caf2747b94774a4
```

## FFmpeg 7.0

### 7.0.3

Fixes following vulnerabilities:

```
CVE-2023-6602,  8e95a9177eb95c260b16e154c71c35767a14ed10 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6604,  8e95a9177eb95c260b16e154c71c35767a14ed10 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6605,  7dd232e5876f5144a53389aa744c2614a5a3151d / 4c96d6bf75357ab13808efc9f08c1b41b1bf5bdf
CVE-2024-35368, 26737680d3f3f5b27cd0c0a7049d8330a2746172 / 4513300989502090c4fd6560544dce399a8cd53c
CVE-2025-0518,  1e3b60a916c3d6f7e1e0642f8bd50639c14a07c8 / b5b6391d64807578ab872dc58fb8aa621dcfc38a
CVE-2025-1594,  f98f142da571653436596ccad2d09c7e39bfd4fb, ticket/11418
CVE-2025-1816,  695dcf29c21911db19cc41722af94ece131303d8 / 0526535cd58444dd264e810b2f3348b4d96cff3b, ticket/11475,
CVE-2025-22919, ab650a52845bd8df25fbd4710b2c25c676461438 / 1446e37d3d032e1452844778b3e6ba2c20f0c322, ticket/11385
CVE-2025-59728, cc6371d48d10f90571b40eb9680ce7198c4b4532 / ce0a655f85c1144d19a4acad59afbb92e4997e30, BIGSLEEP-433502298
```

### 7.0.2

Fixes following vulnerabilities:

```
CVE-2024-7055, 587acd0d4020859e67d1f07aeff2c885797ebcce / 3faadbe2a27e74ff5bb5f7904ec27bb1f5287dc8
```

### 7.0

Fixes following vulnerabilities:

```
CVE-2023-49501, 4adb93dff05dd947878c67784d98c9a4e13b57a7, ticket/10686
CVE-2023-49502, 737ede405b11a37fdd61d19cf25df296a0cb0b75, ticket/10688
CVE-2023-50007, b1942734c7cbcdc9034034373abcc9ecb9644c47, ticket/10700
CVE-2023-50008, 5f87a68cf70dafeab2fb89b42e41a4c29053b89b, ticket/10701
CVE-2024-28661, 66b50445cb36cf6adb49c2397362509aedb42c71
CVE-2024-31578, 3bb00c0a420c3ce83c6fafee30270d69622ccad7
CVE-2024-31582, 99debe5f823f45a482e1dc08de35879aa9c74bd2
CVE-2024-35365, ced5c5fdb8634d39ca9472a2026b2d2fea16c4e5
CVE-2024-35366, 0bed22d597b78999151e3bde0768b7fe763fc2a6
CVE-2024-35367, 09e6840cf7a3ee07a73c3ae88a020bf27ca1a667 (specific to builds for ppc with altivec)
CVE-2024-36613, 50d8e4f27398fd5778485a827d7a2817921f8540
CVE-2024-36616, 86f73277bf014e2ce36dd2594f1e0fb8b3bd6661
CVE-2024-36617, d973fcbcc2f944752ff10e6a76b0b2d9329937a7
CVE-2024-36618, 7a089ed8e049e3bfcb22de1250b86f2106060857
```

## FFmpeg 6.1

### 6.1.3

Fixes following vulnerabilities:

```
CVE-2023-49501, efedc1d1b6aef2481cf613a11992b1dce6320055 / 4adb93dff05dd947878c67784d98c9a4e13b57a7, ticket/10686
CVE-2023-49502, c104119c6b5e00496c5ff14071c85f95c98b7ae5 / 737ede405b11a37fdd61d19cf25df296a0cb0b75, ticket/10688
CVE-2023-50007, dcf34f13f516aa0e214384f3185aff306feba01d / b1942734c7cbcdc9034034373abcc9ecb9644c47, ticket/10700
CVE-2023-50008, a4b6e37ad5f50454974fa22cc8f19d83cdaff0eb / 5f87a68cf70dafeab2fb89b42e41a4c29053b89b, ticket/10701
CVE-2023-6602,  c599745377199fa75fffb30058fb2a6f39d64ab7 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6604,  c599745377199fa75fffb30058fb2a6f39d64ab7 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6605,  ceacc83011a0a5057769626faf14b9256bd3baa7 / 4c96d6bf75357ab13808efc9f08c1b41b1bf5bdf
CVE-2024-31578, 7d79d0a43b5533ff584249332bc1db7fedbab1d2 / 3bb00c0a420c3ce83c6fafee30270d69622ccad7
CVE-2024-31582, a279a8620e2d630648d6b9d87a11682a7c6b35d4 / 99debe5f823f45a482e1dc08de35879aa9c74bd2
CVE-2024-35367, bed04417b4d38af7a1b477b24ea6e26547e32373 / 09e6840cf7a3ee07a73c3ae88a020bf27ca1a667
CVE-2024-35368, b43a12363c1fef0efa7eac15b6b830417656db15 / 4513300989502090c4fd6560544dce399a8cd53c
CVE-2025-0518,  43f64690ad9df72976bcbd6ea9e41b2542db2464 / b5b6391d64807578ab872dc58fb8aa621dcfc38a
CVE-2025-22919, e2b20632b8c71a4e174511f8ff6e8342e0c63bd3 / 1446e37d3d032e1452844778b3e6ba2c20f0c322, ticket/11385
CVE-2025-59728, 01c3093510a5b69d3c7ac3a976eb6a58c2510cfd / ce0a655f85c1144d19a4acad59afbb92e4997e30, BIGSLEEP-433502298
CVE-2025-59731, be682029ae18b80fa9b27f0715ca77323409379c / 0d9c003d76383e82b57b6d5aa33776709d0cda2c, BIGSLEEP-436510153
CVE-2025-59732, fa543b33f63478090137d124c20ff97f76251254 / f45da79b2c336c5f8f3e563d72b8a22fecdcde0c, BIGSLEEP-436510316
CVE-2025-59733, a2e8dc01c0a50d2ec8c85d836bda8eaef6891e50 / 0469d68acb52081ca8385b844b9650398242be0f, BIGSLEEP-436511754
```

### 6.1.2

Fixes following vulnerabilities:

```
CVE-2024-7055, d0ce252930357406a0435d0d783db4b1467345aa / 3faadbe2a27e74ff5bb5f7904ec27bb1f5287dc8
CVE-2024-36617, d66b1af8df7902a3b6226f13410112d9ff27bfc4 / d973fcbcc2f944752ff10e6a76b0b2d9329937a7
```

### 6.1

Fixes following vulnerabilities:

```
CVE-2023-6601,  d09f50c0f5f045dec35f0ca22c2212fae2378dba
CVE-2023-47342, e4d5ac8d7d2a08658b3db7dd821246fe6b35381f
CVE-2023-47344, f7ac3512f5b5cb8eb149f37300b43461d8e93af3
CVE-2024-22860, d2e8974699a9e35cc1a926bf74a972300d629cd5
CVE-2024-22861, 87b8c1081959e45ffdcbabb3d53ac9882ef2b5ce
CVE-2024-22862, ca09d8a0dcd82e3128e62463231296aaf63ae6f7
```

## FFmpeg 6.0

### 6.0.1

Fixes following vulnerabilities:

```
CVE-2023-47342, 07e3223dd0213cc5f0b65e98a6e1b1500d09ece0 / e4d5ac8d7d2a08658b3db7dd821246fe6b35381f
```

### 6.0

Fixes following vulnerabilities:

```
CVE-2022-2566, c953baa084607dd1d84c3bfcce3cf6a87c3e6e05
CVE-2022-3964, 92f9b28ed84a77138105475beba16c146bdaf984
CVE-2022-3965, 13c13109759090b7f7182480d075e13b36ed8edd
CVE-2022-48434, cc867f2c09d2b69cee8a0eccd62aff002cbbfe11
CVE-2024-7272, 9903ba28c28ab18dc7b7b6fb8571cc8b5caae1a6, ticket/9908
```

## FFmpeg 5.1

### 5.1.7

Fixes following vulnerabilities:

```
CVE-2023-49502, 8e6c82cefb45372dee069236f08d272117d81421 / 737ede405b11a37fdd61d19cf25df296a0cb0b75, ticket/10688
CVE-2023-50007, 3a8f94cf7b29ed4b8531306f11a6bb94fbbaf936 / b1942734c7cbcdc9034034373abcc9ecb9644c47, ticket/10700
CVE-2023-50008, 28a7db723971c73f02ab5ad5f0a45fa288775e0a / 5f87a68cf70dafeab2fb89b42e41a4c29053b89b, ticket/10701
CVE-2023-6602,  9803800e0e8cd8e1e7695f77cfbf4e0db0abfe57 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6604,  9803800e0e8cd8e1e7695f77cfbf4e0db0abfe57 / 91d96dc8ddaebe0b6cb393f672085e6bfaf15a31
CVE-2023-6605,  097131a6474bd6294ff337fa92025df60dff907a / 4c96d6bf75357ab13808efc9f08c1b41b1bf5bdf
CVE-2024-31582, 785a6df0e477f408c3e939a043b8608acf071964 / 99debe5f823f45a482e1dc08de35879aa9c74bd2
CVE-2024-35367, 1a874e645d4a0adef9b494482fc67d12d35395cd / 09e6840cf7a3ee07a73c3ae88a020bf27ca1a667
CVE-2024-35368, d45964ac04a83f02cb6ddc63af6d0b646c7d9082 / 4513300989502090c4fd6560544dce399a8cd53c
CVE-2025-0518,  edfcade702b41de4417e2597ba2aff6ecbdead0e / b5b6391d64807578ab872dc58fb8aa621dcfc38a
CVE-2025-9951,  eaf748ec88ada50d40ff533d9f2d9515b583b839 / 104d6846c1be0cb757dc95d5801a416f4d7c687d
CVE-2025-9951,  1f03c050e4e37f96968d1ffa4d720ed20810fdf6 / 01a292c7e36545ddeb3c7f79cd02e2611cd37d73
CVE-2025-22919, a01eaecf6325cefab5b26e0d905df6662db37be1 / 1446e37d3d032e1452844778b3e6ba2c20f0c322, ticket/11385
CVE-2025-59728, 6e9758a4e7f983d67a63218021c5b9002264355e / ce0a655f85c1144d19a4acad59afbb92e4997e30, BIGSLEEP-433502298
CVE-2025-59731, ec959281897aa29076f3083edbc2306357342d7c / 0d9c003d76383e82b57b6d5aa33776709d0cda2c, BIGSLEEP-436510153
CVE-2025-59732, 20708b957e8d4d57801c0b7ac52131988b093a49 / f45da79b2c336c5f8f3e563d72b8a22fecdcde0c, BIGSLEEP-436510316
CVE-2025-59733, 1080d0e3cded6d8e177c2ce8b6649bc238be2ff6 / 0469d68acb52081ca8385b844b9650398242be0f, BIGSLEEP-436511754
```

### 5.1.6

Fixes following vulnerabilities:

```
CVE-2024-7055, 5372bfe01e4a04357ab4465c1426cf8c6412dfd5 / 3faadbe2a27e74ff5bb5f7904ec27bb1f5287dc8
CVE-2024-7272, a937b3c58babae893fb46b286a4792cd24a01d3d / 9903ba28c28ab18dc7b7b6fb8571cc8b5caae1a6, ticket/9908
```

### 5.1.5

Fixes following vulnerabilities:

```
CVE-2024-35366, 4db0eb4653efad967ddcf71f564fd2f1169bafcb / 0bed22d597b78999151e3bde0768b7fe763fc2a6
CVE-2024-36613, 1f6fcc64179377114b4ecc3b9f63bd5774a64edf / 50d8e4f27398fd5778485a827d7a2817921f8540
CVE-2024-36616, a8beef67993aa267de87599007143d9f0ba67c23 / 86f73277bf014e2ce36dd2594f1e0fb8b3bd6661
CVE-2024-36617, f0e780370cc1c437d64f10d326b1d656ef490b5f / d973fcbcc2f944752ff10e6a76b0b2d9329937a7
```

### 5.1.4

Fixes following vulnerabilities:

```
CVE-2023-47342, 5e71da4ef9636966b7ec5f8910cf0e6dd4e941e6 / e4d5ac8d7d2a08658b3db7dd821246fe6b35381f
```

### 5.1.3

Fixes following vulnerabilities:

```
CVE-2022-3964, 7c234248f859baa35e55c3dbbb7a359eae1c5257 / 92f9b28ed84a77138105475beba16c146bdaf984
CVE-2022-3965, 9886e4c3b0880b167dbfdad722fb654c58cdc977 / 13c13109759090b7f7182480d075e13b36ed8edd
```

### 5.1.2

Fixes following vulnerabilities:

```
CVE-2022-48434, 35aa7e70e7ec350319e7634a30d8d8aa1e6ecdda / cc867f2c09d2b69cee8a0eccd62aff002cbbfe11
```

### 5.1.1

Fixes following vulnerabilities:

```
CVE-2022-2566, 6f53f0d09ea4c9c7f7354f018a87ef840315207d / c953baa084607dd1d84c3bfcce3cf6a87c3e6e05
```

### 5.1

Fixes following vulnerabilities:

```
CVE-2022-1475, 757da974b21833529cc41bdcc9684c29660cdfa8, ticket/9651
CVE-2022-3109, 656cb0450aeb73b25d7d26980af342b37ac4c568
CVE-2022-3341, 9cf652cef49d74afe3d454f27d49eb1a1394951e
```

## FFmpeg 5.0

### 5.0.3

Fixes following vulnerabilities:

```
CVE-2022-3109, 2cdddcd6ec90c7a248ffe792d85faa4d89eab9f7 / 656cb0450aeb73b25d7d26980af342b37