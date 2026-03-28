![reveal.js](https://static.slid.es/reveal/logo-v1/reveal-white-text.svg)

### HTML 簡報框架

由 [Hakim El Hattab](https://twitter.com/hakimel) 與 [貢獻者們](https://github.com/hakimel/reveal.js/graphs/contributors) 開發

由 [![](https://d1835mevib0k1p.cloudfront.net/reveal-js/sponsors/slides-mono-white.png)](https://slides.com) 贊助

## 哈囉

Reveal.js 讓您能夠使用 HTML 建立精美的互動式簡報。這個範例將向您展示其功能。

## 垂直幻燈片

幻燈片可以相互嵌套。

使用 *空白* 鍵來瀏覽不同頁面

![Down arrow](https://static.slid.es/reveal/arrow.png)

## 地下一樓

嵌套幻燈片非常適合在大量資訊的母幻燈片下添加額外的細節。

## 地下二樓

就醬，該上去了

[![Up arrow](https://static.slid.es/reveal/arrow.png)](#/2)

## 簡報

不是程式設計師？不用擔心！有一個功能完整的視覺編輯器可以用來創建這些幻燈片，試試看 <https://slides.com>。

## 漂亮的程式

```
                import React, { useState } from 'react';

                function Example() {
                  const [count, setCount] = useState(0);

                  return (
                    ...
                  );
                }
```

代碼高亮使用 [highlight.js](https://highlightjs.org/usage/)。

## 更精美的動畫

```
                import React, { useState } from 'react';

                function Example() {
                  const [count, setCount] = useState(0);

                  return (
                    <div>
                      <p>You clicked {count} times</p>
                      <button onClick={() => setCount(count + 1)}>
                        Click me
                      </button>
                    </div>
                  );
                }

                function SecondExample() {
                  const [count, setCount] = useState(0);

                  return (
                    <div>
                      <p>You clicked {count} times</p>
                      <button onClick={() => setCount(count + 1)}>
                        Click me
                      </button>
                    </div>
                  );
                }
```

## 視窗

按 **ESC** 來檢視整體簡報框架。

按住 **alt** 鍵（在 Linux 中是 **ctrl** 鍵）並點擊任何元素，使用 [zoom.js](https://lab.hakim.se/zoom-js) 進行放大。再次點擊以縮小回去。

（注意：在 Linux 中使用 ctrl + 點擊。）

## 自動動畫

使用 [自動動畫](https://revealjs.com/auto-animate/) 在幻燈片之間為匹配的元素添加自動動畫。

## 自動動畫

## 自動動畫

## 支援觸控

簡報在手機和平板電腦等觸控設備上也看起來非常棒。只需用手指滑動即可切換幻燈片。

添加 class `r-fit-text` 來自動調整字體大小

## FIT TEXT

## 片段

點擊下一個箭頭...

...來逐步展示...

...一個 分段的 幻燈片。

這個幻燈片包含片段，這些片段也會在筆記窗口中逐步展示。

## 片段動畫

有不同類型的片段動畫，比如：

放大

縮小

淡出

向右淡出， 向上， 向下， 向左

先淡入再淡出

先淡入再半透明淡出

突顯 紅色 藍色 綠色

## 轉場動畫

你可以選擇不同的轉場動畫
[無](?transition=none#/transitions) - [淡入](?transition=fade#/transitions) - [滑入](?transition=slide#/transitions) - [凸出](?transition=convex#/transitions) - [凹陷](?transition=concave#/transitions) - [放大](?transition=zoom#/transitions)

## 背景

加入 `data-background="#dddddd"` 在投影片上變更背景顏色。支援所有 CSS 顏色格式。

![Down arrow](https://static.slid.es/reveal/arrow.png)

## 圖片背景

```
<section data-background="image.png">
```

## 平鋪背景

```
<section data-background="image.png" data-background-repeat="repeat" data-background-size="100px">
```

## 影片背景

```
<section data-background-video="video.mp4,video.webm">
```

## ... 還有 GIFs!

## 背景轉場

透過 backgroundTransition 參數可以實現不同的背景轉換動畫。如這就是所謂的「縮放」。

```
Reveal.configure({ backgroundTransition: 'zoom' })
```

## 背景轉場

您可以覆蓋每張投影片的背景轉換。

```
<section data-background-transition="zoom">
```

## Iframe 背景

由於 Reveal.js 在網頁中運行，因此您可以輕鬆嵌入其他網路內容。嘗試與後台頁面互動。

## 精彩的無序列表

* 這裡沒有順序
* 這裡也沒有
* 這裡也是
* 這裡同樣沒有

## 神奇的有序列表

1. 一小
2. 二小
3. 三最大！

## 表格

| 項目 | 價格 | 數量 |
| --- | --- | --- |
| 蜂蜜 | $230 | 1 |
| 檸檬 | $20 | 18 |
| 感冒藥 | $120 | 2 |

## 有道理的引言

引言有兩種呈現方式，分別是行內： "咖啡因來自咖啡果，所以咖啡果是因，咖啡因是果" ，以及區塊：

> “飲水機其實不是飲水機，它是出水機。你才是飲水機，各位飲水機們好。”

## 超連結

你可以在簡報中加入超連結來導覽至不同頁面，像是 [這個](#/2/3)。

## 簡報者檢視畫面

我們有一個 [簡報者檢視畫面](https://revealjs.com/speaker-view/)。 它包括一個計時器，下一張幻燈片的預覽以及你的演講筆記。

按下 *S* 鍵來試用。

嘿，這裡有一些筆記。它們將在你的簡報中被隱藏，但如果你打開演講者筆記窗口（在鍵盤上按 's'），你可以看到它們。

## 輸出 PDF

簡報可以被 [輸出成 PDF](https://revealjs.com/pdf-export/)， 這是一個範例：

## 全域狀態

在幻燈片上設置 `data-state="something"`，當幻燈片開啟時， `"something"` 將被添加為文檔元素的 class。這讓你可以更自由的應用畫面，如切換頁面背景。

## 狀態事件

此外，可以通過綁定到 `data-state` 名稱，在每個幻燈片的基礎上觸發自定義事件。

```
Reveal.on( 'customevent', function() {
  console.log( '"customevent" has fired' );
} );
```

## 欸等等

在鍵盤上按 B 或 . 鍵來暫停簡報。當你在台上希望聚焦觀眾的注意力時很有用。

## 更多功能

* 從右到左布局的支援
* [廣泛的 JavaScript API](https://revealjs.com/api/)
* [自動切換](https://revealjs.com/auto-slide/)
* [滾動滾動視差背景](https://revealjs.com/backgrounds/#parallax-background)
* [自訂快捷鍵](https://revealjs.com/keyboard/)

# THE END

- [試試線上編輯器](https://slides.com)
- [原始碼倉庫](https://github.com/hakimel/reveal.js)

[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/) [繁體中文](/zh-Hant/)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* 語言
  + [English](/en/)
  + [繁體中文](/zh-Hant/)
* 開始
  + [首頁](/zh-Hant/)
  + [示範](/zh-Hant/?demo)
  + [安裝](/zh-Hant/installation/)
  + [React NEW](/zh-Hant/react/)
* 支援
  + [視頻課程](/zh-Hant/course)
  + [贊助 reveal.js arrow-right](https://github.com/sponsors/hakimel)
* 內容
  + [標記](/zh-Hant/markup/)
  + [Markdown](/zh-Hant/markdown/)
  + [背景](/zh-Hant/backgrounds/)
  + [媒體](/zh-Hant/media/)
  + [Lightbox NEW](/zh-Hant/lightbox/)
  + [代碼](/zh-Hant/code/)
  + [數學](/zh-Hant/math/)
  + [片段](/zh-Hant/fragments/)
  + [鏈接](/zh-Hant/links/)
  + [布局](/zh-Hant/layout/)
  + [幻燈片可見性](/zh-Hant/slide-visibility/)
* 自訂
  + [主題](/zh-Hant/themes/)
  + [過渡](/zh-Hant/transitions/)
  + [配置選項](/zh-Hant/config/)
  + [演示大小](/zh-Hant/presentation-size/)
* 特性
  + [垂直幻燈片](/zh-Hant/vertical-slides/)
  + [自動動畫](/zh-Hant/auto-animate/)
  + [自動滑動](/zh-Hant/auto-slide/)
  + [演講者視圖](/zh-Hant/speaker-view/)
  + [滾動視圖 NEW](/zh-Hant/scroll-view/)
  + [幻燈片編號](/zh-Hant/slide-numbers/)
  + [跳至幻燈片](/zh-Hant/jump-to-slide/)
  + [觸摸導航](/zh-Hant/touch-navigation/)
  + [PDF 導出](/zh-Hant/pdf-export/)
  + [總覽模式](/zh-Hant/overview/)
  + [全屏模式](/zh-Hant/fullscreen/)
* API
  + [初始化](/zh-Hant/initialization/)
  + [API 方法](/zh-Hant/api/)
  + [事件](/zh-Hant/events/)
  + [鍵盤](/zh-Hant/keyboard/)
  + [演示狀態](/zh-Hant/presentation-state/)
  + [發送消息](/zh-Hant/postmessage/)
* 插件
  + [使用插件](/zh-Hant/plugins/)
  + [內建插件](/zh-Hant/plugins/#built-in-plugins)
  + [創建插件](/zh-Hant/creating-plugins/)
  + [多工](/zh-Hant/multiplex/)
  + [第三方插件 arrow-right](https://github.com/hakimel/reveal.js/wiki/Plugins%2C-Tools-and-Hardware)
* 其他
  + [升級指南](/zh-Hant/upgrading/)
  + [變更日誌 arrow-right](https://github.com/hakimel/reveal.js/releases)
  + [React (Manual Setup)](/zh-Hant/react-legacy/)

# 在網頁上創建驚豔的簡報

reveal.js 是一個開源的 HTML 簡報框架。能讓任何有瀏覽器的人都可以免費創建功能齊全且美觀的簡報。

使用 reveal.js 製作的簡報是基於網頁技術。這意味著你在網頁上能做的任何事情，都可以在你的簡報中實現。使用 CSS 更改樣式，使用`<iframe>` 嵌入外部網頁或使用我們的 [JavaScript API](/zh-hant/api) 添加自定義行為。

這個框架集合了廣泛的功能，如[簡報子頁面](/zh-hant/vertical-slides/)、[Markdown 支持](/zh-hant/markdown/)、[自動動畫](/zh-hant/auto-animate/)、[PDF 輸出](/zh-hant/pdf-export/)、[演講者筆記](/zh-hant/speaker-view/)、[LaTeX 支持](/zh-hant/math/)以及[代碼高亮](/zh-hant/code/)等。

## 準備好開始了嗎？

只需一分鐘即可完成設置。閱讀[安裝說明](/zh-hant/installation/)來了解如何創建你的第一份簡報！

## 在線編輯器

如果你希望能享受 reveal.js 的優點而不必編寫 HTML 或 Markdown，試試 [https://slides.com](https://slides.com?ref=github)。這是為 reveal.js 設計的一個功能齊全的視覺編輯平台，由同一個作者開發。

## 支持 reveal.js

這個項目是由 [@hakimel](https://github.com/hakimel/) 發起並維護的，並得到了許多[來自社區的貢獻](https://github.com/hakimel/reveal.js/graphs/contributors)。支持這個項目的最好方式是[成為 Slides.com 的付費會員](https://slides.com/pricing) — Hakim 正在建設的 reveal.js 演示平台。

[由 @hakimel 創建](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [編輯這個頁面](https://github.com/reveal/revealjs.com/tree/master/./src/zh-Hant/index.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)