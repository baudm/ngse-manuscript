## Overview
- Thesis manuscript template for the National Graduate School of Engineering (NGSE), UP Diliman.
- Based on the `book` document class. Follows the general styling of the [NGSE manuscript template](https://coe.upd.edu.ph/forms/).
- Form and structure follows the guide created by [Dr. Rowel Atienza](https://github.com/roatienza). The outlines for each chapter were directly lifted from his guide.
- See precompiled samples for the [proposal](https://github.com/baudm/ngse-manuscript/blob/main/samples/proposal.pdf) (APA-style bib) and [review version](https://github.com/baudm/ngse-manuscript/blob/main/samples/final_review.pdf) (IEEE-style bib) of the manuscript.

## Features
- Clean and minimal template with sane defaults. Styling tweaks and enhancements are self-contained in the `manuscript` document class.
- Includes all required preliminary pages.
- Class options to easily toggle proposal version, line numbering, etc. (see [lines 1-9 of `main.tex`](https://github.com/baudm/ngse-manuscript/blob/main/main.tex#L1-L9)).
- `lineno` option makes the review process easier. It enables line numbering.
- *Enhanced* IEEE and APA styles for `biblatex`. See `ieee` and `apa` options.
- Macros for common abbreviations such as `\eg` for *e.g.*, `\etal` for *et al.* and so on (extracted from the CVPR 2022 template).
- Preconfigured with support for cross- and back-references.
- Uses modern packages: `biblatex` for the bibliography, `newtx` for the Times Roman font (text and math).

## Usage
1. Edit `metadata.tex` and put your details (name, student number, etc.)
2. Edit `main.tex` to add/remove chapters, appendices, packages, or switch between the camera-ready/review and proposal/final versions of the manuscript.
3. Add/edit/remove chapters in the `chapters` directory.
4. Add BibTeX references to `references.bib`. Use `\autocite{...}` instead of `\cite{...}`.

**NOTE:** `chapters/4-methodology.tex` contains important information regarding style and formatting (`\autocite{...}`, cross-references, abbreviations, etc.) that were adapted from the CVPR 2022 template.

## Class Options
| Option           | Description                        |  Remarks                                                                                                   |
|:----------------:|------------------------------------|------------------------------------------------------------------------------------------------------------|
| `onehalfspacing` | Set line spacing to 1.5            | Double-spacing is the default                                                                              |
| `lineno`         | Enable line numbering              | Enables reviewers to reference exact lines from the manuscript.                                            |
| `proposal`       | Proposal version of the manuscript | Uses a simpler title page and excludes `univ_permission`, `approval`, and `acknowledgments`.               |
| `ieee`           | Use IEEE-style bibliography        | Customized `ieee` style. Sorts by authors, citations are combined in brackets, disables dashed bib etries. |
| `apa`            | Use APA-style bibliography         | Essentially the `apa` style with increased spacing between bib items                                       |
| `draft`          | `draft` option of the `book` class | Faster typesetting. Figures are not loaded, etc. Globally affects some packages too (e.g. `hyperref`)      |
| `fleqn`          | `fleqn` option of the `book` class | Left-align formulas                                                                                        |
| `leqno`          | `leqno` option of the `book` class | Label formulas on the left-hand side instead of the right.                                                 |

## Comparison with the NGSE template
| &nbsp;           | NGSE template<sup>1</sup> | This template                             | Remarks                      |
|:----------------:|:-------------------------:|:-----------------------------------------:|------------------------------|
| **Page size**    | letter                    | letter (default), A4                      | See `proposal` option        |
| **Margins**      | 1",left=1.5"              | 1",left=1.5" (default); 1"                | See `proposal` option        |
| **Indents**      | 0.5"                      | 0.5"                                      |                              |
| **Line spacing** | double                    | double (default), 1.5                     | See `onehalfspacing` option  |
| **Page numbers** | upper-right               | bottom-center                             |                              |
| **Typeface**     | Times New Roman, 12pt     | Times Roman, 12pt                         |                              |
| **Captions**     | 12pt, *italic* label      | 11pt, *italic* label                      |                              |
| **Bib style**    | APA-like                  | `numeric` (`biblatex` default), APA, IEEE | See `ieee` and `apa` options |

**<sup>1</sup>** There are different versions of the template. One version uses a sans serif font, while another uses Times New Roman. Other than the base point size of 12pt, the sizes used for section headings are inconsistent.

## License
This project is licensed under the Apache License 2.0. See `LICENSE` for details.
