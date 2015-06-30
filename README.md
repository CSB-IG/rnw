# rnw
regulation network workflow

## Normalize script

<pre>
rgarcia@notron:~/rnw$ ./normalize_batch.R -h
usage: ./normalize_batch.R [-h] [--bgcorrect {bg.correct,mas,none,rma}]
                           [--normalize {constant,contrasts,invariantset,loess,methods,qspline,quantiles,quantiles.robust}]
                           --matrix MATRIX
                           cel [cel ...]

Normalize CEL files of a same batch.

positional arguments:
  cel                   CEL files to normalize

optional arguments:
  -h, --help            show this help message and exit
  --bgcorrect {bg.correct,mas,none,rma}
                        method for background noise correction
  --normalize {constant,contrasts,invariantset,loess,methods,qspline,quantiles,quantiles.robust}
                        normalizing method
  --matrix MATRIX       normalized expression matrix
</pre>

---
## Heatmap script

Sourcing this script will ask the user for 2 files:

1. An expression matrix: a tab separated .txt file with sample names on 1st row and genes in 1st column.
2. Differential expression genes: A tab separated .txt. file that contains in the first column the names of the selected genes.

Generating a heatmap graphic based on the expression of the sets and by performing unsupervised clustering analysis grouping the samples with a dendrogram.

Here is an example data set that can be used to test the script
[Example-Data](https://dl.dropboxusercontent.com/u/72765415/Example_expression_set.txt "Right click/save link as...")

Sourcing heatmap.R using the example data will generate this heatmap:
![Heatmap](https://dl.dropboxusercontent.com/u/72765415/example_heatmap.png)
---
