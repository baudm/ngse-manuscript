# About
- Thesis manuscript template for the National Graduate School of Engineering (NGSE), UP Diliman.
- Loosely based on the [NGSE manuscript template](https://coe.upd.edu.ph/forms/). *Differences:* 1.5 line spacing (instead of double), bottom-centered page numbers (instead of upper-right), uses the default font sizes from the `book` document class.
- Form and structure follows the guide created by [Dr. Rowel Atienza](https://github.com/roatienza). The outlines for each chapter were directly lifted from his guide.
- Precompiled samples are available for the [proposal](https://github.com/baudm/ngse-manuscript/blob/main/samples/proposal.pdf) and [review version](https://github.com/baudm/ngse-manuscript/blob/main/samples/final_review.pdf) of the manuscript.

# Features
- Easily switch between proposal/final and review/camera-ready versions (see [lines 3-5 of `main.tex`](https://github.com/baudm/ngse-manuscript/blob/main/main.tex#L3)).
- Proposal version uses A4 paper, while final version uses letter.
- Review version enables colored links and line numbers.
- Defined macros for common abbreviations such as `\eg` for *e.g.*, `\etal` for *et al.* and so on (adapted from the CVPR 2022 template).
- Uses `biblatex` for the bibliography. Sorted `ieee` style is used by default.
- Uses a Times Roman font clone via `newtxtext` (text) and `newtxmath` (math).
- Supports cross- and back-references by default.

# Usage
1. Edit `metadata.tex` and put your details (name, student number, etc.)
2. Edit `main.tex` to add/remove chapters, appendices, packages, or switch between the camera-ready/review and proposal/final versions of the manuscript.
3. Add BibTeX references to `references.bib`.
4. Add/edit/remove chapters in the `chapters` directory.

**NOTE:** `chapters/4-methodology.tex` contains important information regarding style and formatting (e.g. cross-references, abbreviations) that were adapted from the CVPR 2022 template.
