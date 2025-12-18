title: Examples
URL:
save_as: examples.html

### Examples

In the examples directory of the PreTeXt distribution there are several examples. We include output for six of them here. To see examples of actual books (and other projects), see the Gallery at the main page of this site.


### Sample Book

The sample-book is an example of how a book-length document can be authored and organized. It may have a run of chapters, or be structured into parts. The parts can be “structural”, where numbering of chapters restarts in each part, or “decorative”, where chapters are numbered consecutively throughout the book without regard for the parts.

The first version below has only chapters, and no parts.

The final chapter contains interactive exercises and programming environments. There are powered by Javascript we get from Runestone Services. A slightly modified build will make an even more interactive version when hosted at [Runestone Academy](https://runestone.academy/) on a dedicated (no-cost) server there. This work is in-progress as of 2022-05-31 and the code and markup may evolve. The source for this is the only documentation now.

Chapters Only:

- [Sample Book, Online](examples/sample-book/noparts/html)
- [Sample Book, PDF](examples/sample-book/noparts/sample-book.pdf)

Structural Parts:

- [Sample Book, Online](examples/sample-book/structural/html)
- [Sample Book, PDF](examples/sample-book/structural/sample-book.pdf)

Decorative Parts:

- [Sample Book, Online](examples/sample-book/decorative/html)
- [Sample Book, PDF](examples/sample-book/decorative/sample-book.pdf)

Chapters Only, Hosted at [Runestone Academy](https://runestone.academy/):

- [Sample Book with Interactive Questions and Programs](https://runestone.academy/ns/books/published/PTXSB/index.html?mode=browsing)  (Runestone Academy tends to update every Saturday morning, so there can be differences.)

Annotated with Source Examples, with Parts:

- [Sample Book, Annotated](examples/sample-book/annotated/)

Source:

- [Sample Book, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/sample-book)

### Sample Article

The sample-article is both a developer’s sandbox and the kitchen sink of the documentation. It is a sandbox because we frequently test new features here and sometimes also debug problems. So sometimes it contains some preliminary, or immature, examples. It is the kitchen sink because we try to add one of everything. This is both for testing, and so that you can look at output and then examine the source to see how to do something you like or need. There is even a special version of the online output that has copious "View Source" knowls that will show you the PreTeXt source for each division and many blocks

But it is cutting-edge and contains new features before they make it into the Author’s Guide. As a testing platform, we bring the least powerful version of LaTeX to bear for creating the PDF, so this is _always_ built using the pdflatex engine (in contrast to the font example below).

- [Sample Article, Online](examples/sample-article/html)
- [Sample Article, Annotated](examples/sample-article/annotated)
- [Sample Article, PDF](examples/sample-article/sample-article.pdf)
- [Sample Article, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/sample-article)

### WeBWorK Sample Chapter

The WeBWorK sample-chapter contains examples of various ways to incorporate WeBWorK automated homework problems into your text. This work was initiated with a grant from [OpenOregon](http://openoregon.org/) with a matching grant from [University of Puget Sound](http://www.pugetsound.edu/).

- [WeBWorK Sample Chapter, Online](examples/webwork/sample-chapter/html)
- [WeBWorK Sample Chapter, PDF](examples/webwork/sample-chapter/sample-chapter.pdf)
- [WeBWorK Sample Chapter, PG Problem Archive](examples/webwork/sample-chapter/archive)
- [WeBWorK Sample Chapter, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/webwork/sample-chapter)

### Sample Runestone Book

This sample material has moved, and is now incorporated as the final chapter of the Sample Book, with numerous versions posted towards the top of this page.

### Styling Development

Ongoing work to create, develop, and expand new styles.

- [Sample Article, with oscarlevin style](examples/sample-article/oscar)
- [Sample Article, with crc UI (and bluegreen\_grey colors)](examples/sample-article/crc)

### EPUB Sampler

The EPUB Sampler is designed to test and stress the conversion to EPUB. As such it is a bit of a mess. Intentionally. The actual EPUB file could be useful for testing EPUB reading systems. We build a PDF and an HTML version, just for completeness.

- [EPUB Sampler, EPUB Format](examples/epub-sampler/epub-sampler.epub)
- [EPUB Sampler, Online](examples/epub-sampler/html)
- [EPUB Sampler, PDF](examples/epub-sampler/epub-sampler.pdf)

