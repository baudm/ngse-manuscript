## Overview
- Thesis manuscript template for the National Graduate School of Engineering (NGSE), UP Diliman.
- Based on the `book` document class. Follows the general styling of the [NGSE manuscript template](https://coe.upd.edu.ph/forms/).
- Form and structure follows the guide created by [Dr. Rowel Atienza](https://github.com/roatienza). The outlines for each chapter were directly lifted from his guide.
- See precompiled samples for the [proposal](https://github.com/baudm/ngse-manuscript/blob/main/samples/proposal.pdf) (APA-style bib) and [review version](https://github.com/baudm/ngse-manuscript/blob/main/samples/final_review.pdf) (IEEE-style bib) of the manuscript.

## Features
- Clean and minimal template with sane defaults. Styling tweaks and enhancements are self-contained in the `manuscript` document class.
- Includes all required preliminary pages.
- Class options to easily toggle `review`, `proposal`, and `double`-spaced versions (see [lines 1-4 of `main.tex`](https://github.com/baudm/ngse-manuscript/blob/main/main.tex#L1-L4)).
- `review` option makes the review process easier. It enables colored links and line numbering.
- Macros for common abbreviations such as `\eg` for *e.g.*, `\etal` for *et al.* and so on (extracted from the CVPR 2022 template).
- Preconfigured with support for cross- and back-references.
- Uses modern packages: `biblatex` for the bibliography, `newtx` for the Times Roman font (text and math).

## Usage
1. Edit `metadata.tex` and put your details (name, student number, etc.)
2. Edit `main.tex` to add/remove chapters, appendices, packages, or switch between the camera-ready/review and proposal/final versions of the manuscript.
3. Add/edit/remove chapters in the `chapters` directory.
4. Add BibTeX references to `references.bib`. Use `\autocite{...}` instead of `\cite{...}`.

**NOTE:** `chapters/4-methodology.tex` contains important information regarding style and formatting (`\autocite{...}`, cross-references, abbreviations, etc.) that were adapted from the CVPR 2022 template.

## Comparison with the NGSE template
| &nbsp;           | NGSE template         | This template                       | Remarks                              |
|:----------------:|:---------------------:|:-----------------------------------:|--------------------------------------|
| **Page size**    | letter                | letter (final), A4 (proposal)       | Toggled by `proposal` option         |
| **Margins**      | 1",left=1.5"          | 1",left=1.5" (final); 1" (proposal) | Toggled by `proposal` option         |
| **Indents**      | 0.5"                  | 0.5"                                |                                      |
| **Line spacing** | double                | 1.5 (default), double               | Toggled by `double` option           |
| **Page numbers** | upper-right           | bottom-center                       |                                      |
| **Typeface**     | Times New Roman, etc. | Times Roman                         |                                      |
| **Point size**   | 12pt                  | 12pt                                |                                      |
| **Captions**     | 12pt, *italic* label  | 11pt, *italic* label                |                                      |
| **Bib style**    | APA-like              | IEEE (sorted)                       | Set via `biblatex`, e.g. `style=apa` |

**NOTE:** In the `proposal` version, a simpler title page is used (`title_proposal`) and the following preliminary pages are excluded: `univ_permission`, `approval`, and `acknowledgment`.

## License
This project is licensed under the Apache License 2.0. See `LICENSE` for details.
