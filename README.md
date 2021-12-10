# BMB2021
This is a repository for supplementary materials and scripts for data analysis in the paper "Improving identification of animal secretory proteins" presented in the 7th International Conference on Biochemistry and Molecular Biology 2021, Bangkok, Thailand.


* Proceeding
Nuanpirom, J., & Sangket, U. (2021). Improving identification of animal secretory proteins ([crossref](http://www.scisoc.or.th/BMBThailand/images/Proceedings/S4/S4-P-05.pdf) | [google scholar](https://scholar.google.co.th/scholar?q=Improving+identification+of+animal+secretory+proteins&hl=en&as_sdt=0&as_vis=1&oi=scholart)).



* Corrigendum to "Improving identification of animal secretory proteins"

We have found a mistyping of the MCC calculation formula on page 3, equation 5. The correct equation is <img src="https://latex.codecogs.com/gif.latex?MCC&space;=&space;\frac{TP\times&space;TN-FP\times&space;FN}{\sqrt{(TP&plus;FP)\times&space;(TP&plus;FN)\times&space;(TN&plus;FP)\times&space;(TN&plus;FN)}}" />. 

This error did not affect to the evaluation result of the secretory protein predictors since the calculation was done by R package `mccr` referred to in lines 26-30 of [calc_confusion_matrix.r](https://github.com/JirathNuan/BMB2021/blob/main/src/calc_confusion_matrix.r#L26-L30) file. 

