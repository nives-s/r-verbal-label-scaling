# Verbal label scaling

R scripts from my master's thesis *Scaling of verbal labels on rating scales*
(University of Ljubljana, 2025), which tested whether verbal labels on rating
scales (e.g. "often", "sometimes") are perceived as equally spaced in selected
Slovenian questionnaires.

The study used two approaches: participants rated 25 verbal labels directly on
a 0–100 line (direct assessment), and responses to existing questionnaires were
analysed with optimal scaling (indirect assessment). The original data is not
included for privacy reasons.

## Requirements

- R (version 4.x)
- Packages: Gifi, psych, lsr, DescTools

## Indirect assessment

### `Optimal_scaling.R`

A reusable template for analysing one questionnaire. Set the parameters at the
top (number of categories, number of items, reverse-scored items, label names),
then run it. The code:

1. runs optimal scaling (PRINCALS, Gifi package),
2. compiles the category values for all items into one table,
3. corrects reverse-scored items and centres each item,
4. calculates mean label positions, variability and distances between labels,
5. plots the results and rescales them to 0–100.

**Input:** one row per participant, one column per item, containing response
categories 1–k.

## Direct assessment

### `Graphs.R`

Calculates the mean, SD and 95% confidence interval for each verbal label and
draws a dot chart for one group of labels at a time (frequency, intensity 1,
intensity 2), showing confidence intervals and SD ranges. Choose the group with
`marker` and `group_name`.

### `Statistical_significance.R`

Compares psychology students with students of other fields on each label:
Mann-Whitney U test and Cohen's d in a loop, Holm correction for multiple
comparisons, and a results table with group means, W, p-values, corrected
p-values and effect sizes.

### Input for both direct-assessment scripts

One row per participant; the first three columns are gender, age and group
number, followed by the 25 verbal labels (ratings 0–100).
`Statistical_significance.R` also uses the variable `studij` (field of study:
1 = psychology, 2 = other).
