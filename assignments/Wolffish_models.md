Wolffish Models
================

\#Examining the Split

After having split the data into training and testing data, here is a
spacial image of the training and testing data.
![](Wolffish_models_files/figure-gfm/initial_split_plot-1.png)<!-- -->

We then split the training data into different mini-datasets for
training shown here:
![](Wolffish_models_files/figure-gfm/cv_training-1.png)<!-- -->

\#Planning the Analysis

Now that we have the data all split up, we are going to create a recipe
that defines what the different variables signify (predictor,
coordinates, and outcomes).

    ## # A tibble: 12 × 4
    ##    variable type      role      source  
    ##    <chr>    <list>    <chr>     <chr>   
    ##  1 depth    <chr [2]> predictor original
    ##  2 month    <chr [2]> predictor original
    ##  3 SSS      <chr [2]> predictor original
    ##  4 U        <chr [2]> predictor original
    ##  5 Sbtm     <chr [2]> predictor original
    ##  6 V        <chr [2]> predictor original
    ##  7 Tbtm     <chr [2]> predictor original
    ##  8 MLD      <chr [2]> predictor original
    ##  9 SST      <chr [2]> predictor original
    ## 10 X        <chr [2]> coords    original
    ## 11 Y        <chr [2]> coords    original
    ## 12 class    <chr [3]> outcome   original

With our variables all defined, we can begin preparing the analysis by
defining the workflows for the different models: - Logistic Regression -
Random Forest - Boosted Tree - Max Entropy

And also our different success metrics: - Accuracy - Boyce Continuous -
Area Under the Curve - TSS

These metrics will help the models determine the accuracy and attempt to
maximize their correctness, allowing them to adjust their
hyperparameters.

\#Picking the Best

The results of the different models and there successes across the
different metrics are shown here:
![](Wolffish_models_files/figure-gfm/plot_wflow-1.png)<!-- -->

We then select the best configuration of hyperparameters for each model
so we can better analyze the models success. From this we can pull
summary statistics:

    ## # A tibble: 4 × 5
    ##   wflow_id       accuracy boyce_cont roc_auc tss_max
    ##   <chr>             <dbl>      <dbl>   <dbl>   <dbl>
    ## 1 default_glm       0.687      0.696   0.740   0.403
    ## 2 default_rf        0.73       0.761   0.791   0.532
    ## 3 default_btree     0.72       0.505   0.782   0.507
    ## 4 default_maxent    0.73       0.768   0.804   0.534

Confusion Matrices:
![](Wolffish_models_files/figure-gfm/confusion_matrix-1.png)<!-- -->

And AUC Plots:
![](Wolffish_models_files/figure-gfm/auc_plot-1.png)<!-- -->

``` r
model_fit_varimp_plot(model_fits)
```

![](Wolffish_models_files/figure-gfm/model_fit_vip-1.png)<!-- -->

\#Examining the Random Forest Using the same testing and training data
from earlier:
![](Wolffish_models_files/figure-gfm/random_forest-1.png)<!-- -->

The random forest used the metrics we set to tune for the best
hyperparameters, which had these metrics associated with them:

    ## # A tibble: 4 × 4
    ##   .metric    .estimator .estimate .config        
    ##   <chr>      <chr>          <dbl> <chr>          
    ## 1 accuracy   binary         0.73  pre0_mod0_post0
    ## 2 boyce_cont binary         0.761 pre0_mod0_post0
    ## 3 roc_auc    binary         0.791 pre0_mod0_post0
    ## 4 tss_max    binary         0.532 pre0_mod0_post0

And then created these predictions:

    ## # A tibble: 300 × 6
    ##    class      .pred_class .pred_presence .pred_background  .row .config        
    ##    <fct>      <fct>                <dbl>            <dbl> <int> <chr>          
    ##  1 presence   background          0.427             0.573     8 pre0_mod0_post0
    ##  2 background background          0.0607            0.939    14 pre0_mod0_post0
    ##  3 background background          0.0606            0.939    26 pre0_mod0_post0
    ##  4 background background          0.248             0.752    27 pre0_mod0_post0
    ##  5 background background          0.152             0.848    68 pre0_mod0_post0
    ##  6 background background          0.373             0.627    89 pre0_mod0_post0
    ##  7 background background          0.0557            0.944    93 pre0_mod0_post0
    ##  8 background background          0.174             0.826    95 pre0_mod0_post0
    ##  9 background background          0.0824            0.918    96 pre0_mod0_post0
    ## 10 background background          0.105             0.895   107 pre0_mod0_post0
    ## # ℹ 290 more rows

Here is the overall workflow for the random forest model:

    ## ══ Workflow [trained] ══════════════════════════════════════════════════════════
    ## Preprocessor: Recipe
    ## Model: rand_forest()
    ## 
    ## ── Preprocessor ────────────────────────────────────────────────────────────────
    ## 0 Recipe Steps
    ## 
    ## ── Model ───────────────────────────────────────────────────────────────────────
    ## Ranger result
    ## 
    ## Call:
    ##  ranger::ranger(x = maybe_data_frame(x), y = y, mtry = min_cols(~1L,      x), num.trees = ~2000L, importance = ~"impurity", num.threads = 1,      verbose = FALSE, seed = sample.int(10^5, 1), probability = TRUE) 
    ## 
    ## Type:                             Probability estimation 
    ## Number of trees:                  2000 
    ## Sample size:                      1803 
    ## Number of independent variables:  9 
    ## Mtry:                             1 
    ## Target node size:                 10 
    ## Variable importance mode:         impurity 
    ## Splitrule:                        gini 
    ## OOB prediction error (Brier s.):  0.223057

\#Partial Dependence Plot

We then created a partial dependence plot for the best performing model…
the random forest model
![](Wolffish_models_files/figure-gfm/pd_plot-1.png)<!-- -->
