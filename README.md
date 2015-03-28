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
